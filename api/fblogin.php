<?php

require_once("../include/init.php");
require_once("../include/facebook.php");
 
$facebook = new Facebook(array(
    'appId'  => FB_APP_ID,
    'secret' => FB_APP_SECRET,
));
 
// Get User ID
$user = $facebook->getUser();

if ($user) {
  try {
    // Proceed knowing you have a logged in user who's authenticated.
    $profile = $facebook->api('/me');
  } catch (FacebookApiException $e) {
    error_log($e);
    $user = null;
  }
}

//if not logged in, send them to facebook to get permissions
if(empty($user)) {
	header("Location: " . $facebook->getLoginUrl(array('scope' => 'email')));
	die();
}

//find facebook user in database
$DB = new DB();
$query = "SELECT user_id FROM users WHERE facebook_id = '" . $profile['id'] . "' AND account_status = 1";
$userid = $DB->getDBValue($query, 'user_id');

if($userid > 0) {
	$user = new User($userid);
} else {
	//check for email address
	$query = "SELECT user_id FROM users WHERE email = '" . $profile['email'] . "' AND account_status = 1";
	$userid = $DB->getDBValue($query, 'user_id');
	
	if($userid > 0) {
		$query = "UPDATE users 
					SET facebook_id = '" . $profile['id'] . "', email = '" . $profile['email'] . "' 
				  WHERE user_id = $userid";
		$DB->doDBQuery($query);
	} else {
		$gender = '';
		if($profile['gender'] == "male") $gender = 'M';
		else if($profile['gender'] == "female") $gender = 'F';
		$query = "INSERT INTO users (
					facebook_id, username, first_name, last_name, gender,
					account_status, profile_picture_url, date_created)
				  VALUES (
				  	'" . $profile['id'] . "', '" . $profile['username'] . "', '" . $profile['first_name'] . "',
				  	'" . $profile['last_name'] . "', '" . $gender . "', 1, 
				  	'https://graph.facebook.com/" . $profile['id'] . "/picture?type=normal', now())";
		$userid = $DB->doDBQuery($query, true);
	
		if(empty($userid)) login_error("Could not create User Account");
	}
	
	//load user record
	$user = new User($userid);
}

//handle no user found
if(!$user->loggedIn) login_error("Error logging in User");

//save to session
$_SESSION['login_user'] = serialize($user);

//disconnect from database
$DB->disconnect();

//redirect user
header("Location: /main.php");

function login_error($error) {
	$_SESSION['login_errors'] = $error;
	header("Location: /index.php");
	die();
}
?>
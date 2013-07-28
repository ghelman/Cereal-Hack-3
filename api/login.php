<?php

require_once("../include/init.php");

$email = !empty($_REQUEST['email']) ? trim($_REQUEST['email']) : '';
$password = !empty($_REQUEST['password']) ? trim($_REQUEST['password']) : '';
$redirect = !empty($_REQUEST['redirect']) ? trim($_REQUEST['redirect']) : '';

//validate 
if(empty($email)) login_error("Please enter an Email Address");
if(empty($password)) login_error("Please enter an Password");
if(!Validate::email($email)) login_error("Invalid Email or Password");

//clean errors
$_SESSION['login_errors'] = '';
unset($_SESSION['login_errors']);

//clean data
$DB = new DB();

$email = $DB->escape($email);
$password = md5($DB->escape($password));

//find user account
$query = "SELECT user_id FROM users WHERE email = '$email' AND password = '$password' AND account_status = 1";
$userid = $DB->getDBValue($query, 'user_id');

$user = new User($userid);

//handle no user found
if(!$user->loggedIn) login_error("Error logging in User");

//save to session
$_SESSION['login_user'] = serialize($user);

//disconnect from database
$DB->disconnect();

//redirect user
header("Location: /$redirect");


function login_error($error) {
	$_SESSION['login_errors'] = $error;
	header("Location: /index.php");
	die();
}
?>
<?php

require_once("../include/init.php");

//get current user
$user = new User(-1);
if(empty($user) || !$user->loggedIn)
	report_error("You must be logged in to make a Recommendation");

//get submitted values
$title = !empty($_REQUEST['title']) ? urldecode(trim($_REQUEST['title'])) : '';
$type = !empty($_REQUEST['media_type']) ? intval($_REQUEST['media_type']) : 0;
$url = !empty($_REQUEST['link_url']) ? urldecode(trim($_REQUEST['link_url'])) : '';
$description = !empty($_REQUEST['description']) ? urldecode(trim($_REQUEST['description'])) : '';
//$target = !empty($_REQUEST['target']) ? trim($_REQUEST['target']) : '';
$targetid = !empty($_REQUEST['targetid']) ? intval($_REQUEST['targetid']) : 0;

//validate values
$errors = array();
if(empty($title)) $errors[] = "Please enter a Title";
if(empty($type)) $errors[] = "Please enter a Media Type";
if(!empty($url) && !Validate::url($url)) $errors[] = "Invalid URL";
if(empty($targetid)) $errors[] = "Please select a Recipient";

//return any errors
if(!empty($errors)) 
	report_error(implode("<br />", $errors));

//connect to DB
$DB = new DB();

//clean values
$title = $DB->escape($title);
$url = $DB->escape($url);
$description = $DB->escape($description);



//save recommendation
$query = "INSERT INTO recommendations (
			sender_id, receiver_id, status_id, media_type_id, title, description,
			primary_url, date_created)
		  VALUES(" . $user->id . ", $targetid, 1, $type, '$title', '$description', '$url', now())";

$newid = $DB->doDBQuery($query, true);

if(!empty($newid)) {
	//fetch and save first image from google images
	$q = urlencode($title);
	$jsonurl = "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=".$q;
	$result = json_decode(file_get_contents($jsonurl), true);
	if(!empty($result)) {
		$img = imagecreatefromjpeg($result['responseData']['results'][0]['tbUrl']);
		$imageURL = 'images/recs/' . $newid . '.jpg';
 		imagejpeg($img, '../' . $imageURL);
		imagedestroy($img);
		
		$DB->doDBQuery("UPDATE recommendations SET thumbnail_url = '$imageURL' WHERE recommendation_id = $newid");
	}

	//update queue
	$order = $DB->getDBValue("SELECT max(listing_order)+1 FROM user_queue WHERE user_id = $targetid", "max");
	if(empty($order)) $order = 1;
	$DB->doDBQuery("INSERT INTO user_queue(user_id, recommendation_id, listing_order)
				    VALUES ($targetid, $newid, $order)");
	$DB->doDBQuery("UPDATE users SET date_last_recommendation = now() WHERE user_id = $targetid");
	
	//send text message
	if(mail("9167651629@txt.att.net", "", "Check this out!!"))
		print "TEXTED";
	else print "FAILED :(";
}

include("../sources/recommend_success.php");

$DB->disconnect();
?>
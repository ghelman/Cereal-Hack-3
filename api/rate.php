<?php

require_once("../include/init.php");

//get current user
$user = new User(-1);
if(empty($user) || !$user->loggedIn)
	report_error("You must be logged in to make a Recommendation");
	
//get values
$recid = !empty($_REQUEST['id']) ? intval($_REQUEST['id']) : 0;
$rating = !empty($_REQUEST['rating']) && is_numeric($_REQUEST['rating']) ? $_REQUEST['rating'] : 0;

if(empty($recid)) report_error("No Recommendation Found");

$DB = new DB();
if($DB->doDBQuery("UPDATE recommendations SET status_id = " . STATUS_COMPLETE . ", rating = $rating
					WHERE recommendation_id = $recid")) {
	foreach($user->queue as $r => $item) {
		if($item->id != $recid) continue;
		$item->details['rating'] = $rating;
		$user->queue[$r] = $item;
		break;
	}
					
	print "Rating set";
}
else
	print "Could not set Rating";
	
$DB->disconnect();
?>
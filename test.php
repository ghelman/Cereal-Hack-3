<?php require_once("include/init.php"); ?>
<?php
	if(mail("7078322099@txt.att.net", "test", "Check this out!!"))
		print "TEXTED";
	else print "FAILED :(";
	die();
require('include/tropo/tropo.class.php');
require('include/tropo/tropo-rest.class.php');


$session = new Session();
$from_info = $session->getFrom();
echo $from_info['channel'];
die();

$url = "http://api.tropo.com/1.0/sessions?action=create&token=" . TROPO_KEY;
//$url = 'https://tropo.developergarden.com/api/sessions?action=create&token=' . TROPO_KEY;
//You can pass more parameters just as shown in the Quickstart guide.
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_USERPWD, "friendq:recommendme");
	$xmlResponse = curl_exec($ch);
	curl_close ($ch);
	echo $xmlResponse; //So you can see the results from your browser when you access this script
die();
?>
<!DOCTYPE html> 
<html> 
<head> 
	<title>My Page</title> 
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.1/jquery.mobile-1.2.1.min.css" />
	<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.2.1/jquery.mobile-1.2.1.min.js"></script>
</head> 
<body> 

<div data-role="page">

	<div data-role="header">
		<h1>My Title</h1>
	</div><!-- /header -->

	<div data-role="content">	
		<p>Hello world</p>		
	</div><!-- /content -->
	
<?php
$user = new User(-1);
//print_r($user->queue);

if(!$user->loggedIn) 
	print "Not logged in";
else
	print "Hello, " . $user->name;



$DB = new DB();
$users = $DB->getDBResults("SELECT user_id, username FROM users ORDER BY username");
?>
<ul data-role="listview" data-inset="false" data-filter="false">
<?php foreach($users as $id => $userinfo) { ?>
	<li><a href="#"><?php print $userinfo['username']; ?></a></li>
<?php } ?>
</ul>


<!--
<a href="#" data-role="button" data-icon="star">Star button</a>
-->

</div><!-- /page -->

</body>
</html>
<?php require_once("include/init.php"); ?>
<?php
	
	$user = new User(-1);
	
	?>
<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!--meta name="apple-mobile-web-app-capable" content="yes"-->
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
	<title>FriendQ</title>
	<link rel="stylesheet" href="themes/FriendQ.min.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
		<script src="friendq.js"></script>
</head>
	<body>
	
	<div data-role="page" data-theme="a" style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
	
	<div data-role="content" data-theme="a" style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
	
			<img style="width: 320px; height: 150px" src="https://s3.amazonaws.com/assets.codiqa.com/eP9ECXF6QCqxv3Plg5Fg_App Logo_text only.png">
			<p><em>...Remember that thing I told you about?</em></p>
			
			<!--div data-role="collapsible" data-collapsed="true" data-theme="a">
				<h3>Tell Me More</h3>
				<p>Someone should write something here?</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
			</div-->
			
			
			<!--a href="welcome.html" data-role="button">User Auth is Hard</a-->
			
			
			<form action="api/login.php" method="post" data-ajax="false">
			
			
			<div data-role="fieldcontain">
				<label for="name">User Name</label>
				<input type="email" name="email" id="name" value=""  />
			</div>
			
			<div data-role="fieldcontain">
				<label for="name">Password</label>
				<input type="password" name="password" id="pwd" value=""  />
			</div>
			
			<button type="submit" data-theme="a" name="submit" value="submit-value">Come on In</button>
			<input  type="hidden" name="redirect" value="main.php" />
			
			</form>
			
			<a href="api/fblogin.php" data-role="button" data-ajax="false" >Log in With Facebook</a>
			
	</div>
	
	</div>
	
	
	</body>
</html>

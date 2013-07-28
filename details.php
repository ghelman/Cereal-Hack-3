<?php require_once("include/init.php"); ?>
<!DOCTYPE html> 
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"> 
	<title>FriendQ</title>
	<link rel="stylesheet" href="themes/FriendQ.min.css" />
		<link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.2/jquery.mobile.structure-1.3.2.min.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://code.jquery.com/mobile/1.3.2/jquery.mobile-1.3.2.min.js"></script>
		<script src="friendq.js"></script>
	
<script type="text/javascript">
    $("#newPageId").on("pageshow", onPageShow);
    function onPageShow(e,data)
    {
        //loadDetails();
    }
    
    
   $(document).ready(function() {
   
    //loadDetails();
  });
    
  </script>
  
  	
	
</head> 

<body>

<div data-role="page" data-add-back-btn="true" data-theme="a">

	<div data-role="header">
		<h1>$ITEMNAME</h1>
	</div><!-- /header -->

	<div data-role="content"  data-theme="a">
	
	<p>this is where we talk about <span><?=$_GET["item"]?></span> </p>
	
	
	</div>
	
</div>



</body>
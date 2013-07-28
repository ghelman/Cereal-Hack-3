<?php require_once("include/init.php"); ?>
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

<div data-role="page" data-add-back-btn="true" data-theme="a" id="mainqueue">

	<div data-role="header">
	<a href="main.php" data-ajax="false" class="ui-btn-left ui-btn ui-shadow ui-btn-corner-all ui-btn-icon-left ui-btn-up-a" data-rel="back" data-icon="arrow-l" data-theme="a" data-corners="true" data-shadow="true" data-iconshadow="true" data-wrapperels="span"><span class="ui-btn-inner"><span class="ui-btn-text">Back</span><span class="ui-icon ui-icon-arrow-l ui-icon-shadow">&nbsp;</span></span></a>
	
		<h1>My FriendQ</h1>
	</div><!-- /header -->

	<div data-role="content"  data-theme="a" >	
		
	
	<ul data-role="listview" data-filter="true" id="sortable">
	
	<?php
	
	$user = new User(-1);
	
	
	//for ($i=1; $i<=5; $i++)
	foreach ($user->queue as $value)
	  {
	  ?>
	  
	  
		<li>
		<a href="#rec_<?=$value->id?>" data-transition="slide">
		<!--img src="images/FriendQ_logo_ios.png"/-->
		<img src="<?= $value->sender_picture_url ?>"/>
		<img src="images/<?= $value->media_type ?> Icon.png" style="height: 1.3em;"/>
		
		<em>Something to <?=$value->media_type?>...</em>
		<h3><?=$value->title?></h3>
		<p><?=$value->description?></p>
		<p><?=$value->post_date?></p>
		</a>
		
		</li>
		
	
	  
	  <?php
	  }
	?>		
	</ul>	
	</div><!-- /content -->
	
	
	
	
</div><!-- /page -->



<?php 
foreach ($user->queue as $value){
?>

<div data-role="page" data-control-title="My Q: <?= $value->title ?>" data-theme="a" id="rec_<?=$value->id?>" data-add-back-btn="true"
  style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
	<div data-role="header">
		<h1>My Q: <?= $value->title ?></h1>
	</div><!-- /header -->

	<div data-role="content" data-theme="a" style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
	
	<div style="margin-left:auto;margin-right:auto; display: block;" >	
	<img  style="margin-left:auto;margin-right:auto; display: block;" src="<?= $value->thumbnail_url ?>" /><br>
	</div>
	
	<p><?= $value->description ?></p>
	<ul >
	<li>Recommended by: <?=$value->sender_name?></li>
	<li><img src="images/<?= $value->media_type ?> Icon.png" style="height: 1.3em;"/> It's something to <?=$value->media_type?>!</li>
	
	<?php if($value->url) { ?>
	<li>Find it here: <a target="_blank" href="<?=$value->url?>"><?=$value->url?></a></li>
	<?php } ?>
	
	
	<li><span id="currentrating_<?=$value->id?>">
	<?php
	if($value->rating > 0){
		echo "You liked it.";
	} elseif ($value->rating < 0){
		echo "You didn't like it.";
	} else {
		echo "You haven't rated this yet.";
	} 
	?><span>
	</li>
	</ul>
	
	
	<!-- ?php var_dump($value) ? -->
	
	<a href="#" data-role="button" onclick='{rated("<?= $value->id?>","1")}' >Like it!</a>
	<a href="#" data-role="button" onclick='{rated("<?= $value->id?>","-1")}' >Not so much</a>
	
	</div>
	
</div>

<?php 
}
?>


</body>
</html>




<!-- ?php phpinfo(); ? -->
						
<?php require_once("include/init.php"); ?>
<?php
	
	$user = new User(-1);
	
	?>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
  <!--meta name="apple-mobile-web-app-capable" content="yes"-->
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <title>FriendQ</title>
  
  
  <link rel="stylesheet" href="https://d10ajoocuyu32n.cloudfront.net/mobile/1.3.1/jquery.mobile.theme-1.3.1.min.css">
  <link rel="stylesheet" href="https://codiqa.com/view/9b60265f/themecss">
  <link rel="stylesheet" href="https://d10ajoocuyu32n.cloudfront.net/mobile/1.3.1/jquery.mobile.structure-1.3.1.min.css">
  
  
  <!-- Extra Codiqa features -->
  <link rel="stylesheet" href="codiqa.ext.css">
  
  <link rel="stylesheet" href="https://codiqa.com/view/9b60265f/css">
  
  <!-- jQuery and jQuery Mobile -->
  <script src="https://d10ajoocuyu32n.cloudfront.net/jquery-1.9.1.min.js"></script>
  <script src="https://d10ajoocuyu32n.cloudfront.net/mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>

  <!-- Extra Codiqa features -->
  <script src="https://d10ajoocuyu32n.cloudfront.net/codiqa.ext.js"></script>
   
  <script src="https://codiqa.com/view/9b60265f/js"></script>
  
</head>
<body>

  <div data-role="page" data-control-title="Home" data-theme="a" id="page1"
  style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
      <div data-theme="a" data-role="header">
          <h3>
              FriendQ
          </h3>
      </div>
      
      <div data-role="content" style="margin-left:auto;margin-right:auto; ">
      	
          <div style="margin-left:auto;margin-right:auto; display: block;" >
              <img style="width: 320px; height: 150px; margin-left:auto;margin-right:auto; display: block;" src="https://s3.amazonaws.com/assets.codiqa.com/eP9ECXF6QCqxv3Plg5Fg_App Logo_text only.png">
          </div>
          
          <div style="margin-left:auto;margin-right:auto;" >    
              <img style="width: 100px; height: 100px; margin-left:auto;margin-right:auto; display: block;" src="<?=$user->profile_picture_url?>" />
          </div>
          <!--hr style="height:5px; background-color:#ccc; border:0; margin-top:12px; margin-bottom:12px;"-->
          <a data-role="button" data-theme="a" href="theq.php" data-ajax="false">
              MY Q
          </a>
          <a data-role="button" href="#page2">
              SEND Q
          </a>
      </div>
      
  </div>
  
  <div data-role="page" data-control-title="Send Q" data-theme="a" id="page2" data-add-back-btn="true"
  style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
      <div data-theme="a" data-role="header">
          <h1>
          	
              SEND Q
          </h1>
      </div>
      <div data-role="content">
      <form action="api/recommend.php" method="get">
      <!--img src="images/FriendQ_App logo.png"/ -->
          <div data-role="fieldcontain" data-controltype="textinput">
              <label for="textinput1">
                  I think you'd really like...
              </label>
              <input name="title" id="textinput1" placeholder="that one show or book or whatever" value="" type="text">
          </div>
          
          
          <div data-role="fieldcontain" data-controltype="textinput">
              <label for="textinput2">
                  Find it Here
              </label>
              <input name="link_url" id="textinput2" placeholder="www.friendqapp.com" value="" type="text">
          </div>
          
          <div data-role="fieldcontain">
		   <label for="media_type" class="select">It's something to...</label>
		   <select name="media_type" id="media_type">
		   <!--
		      <option value="6">Un-catagorizable</option>
		      <option value="1">Movies</option>
		      <option value="2">TV Shows</option>
		      <option value="3">Music</option>
		      <option value="4">Books</option>
		      <option value="5">Food</option>
		      <option value="7">Games</option>
		   -->   
		      
		      <option value="6">Enjoy</option>
		      <option value="1">Watch</option>
		      <option value="3">Hear</option>
		      <option value="4">Read</option>
		      <option value="5">Eat</option>
		      <option value="7">Play</option>
		      <option value="8">Do</option>
		      
		      
		   </select>
		</div>
          
          <div data-role="fieldcontain">
              <label for="textinput2">
                  This is fantastic because...
              </label>
              <textarea name="description" id="textarea"></textarea>
          </div>
          
          <!--div data-role="fieldcontain" data-controltype="textarea">
              <label for="textarea1">
                  Reciepient
              </label>
              <textarea name="" id="textarea1" placeholder="friends@friendqapp.com"></textarea>
          </div-->
          
          <div data-role="fieldcontain">
		   <label for="targetid" class="select">Send to...</label>
		   <select name="targetid" id="targetid">
		   
		   <?php
		   $DB = new DB();
		   $users = $DB->getDBResults("SELECT user_id, username FROM users ORDER BY username"); 
		   
		    foreach($users as $id => $userinfo) { ?>
		   
		      <option value="<?=$userinfo['user_id']?>"><?php print $userinfo['username']; ?></option>

		    <?php } ?>
		      
		   </select>
		   

		</div>

          
          <input type="submit" value="PUSH TO Q" />
      </form>
      </div>
      
      <!--div data-role="tabbar" data-iconpos="top" data-theme="a">
          <ul>
              <li>
                  <a href="#page3" data-transition="fade" data-theme="" data-icon="home">
                      Home
                  </a>
              </li>
              <li>
                  <a href="#page2" data-transition="fade" data-theme="" data-icon="star">
                      My Q
                  </a>
              </li>
          </ul>
      </div-->
  </div>
  
  <!--
  <div data-role="page" data-control-title="Success" data-theme="a" id="page5" data-add-back-btn="true"
  style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
      <div data-theme="a" data-role="header">
          <h1>
              ADDED TO Q
          </h1>
      </div>
      <div data-role="content">
          <div data-controltype="textblock">
              <p>
                  <b>
                      now you can...
                  </b>
              </p>
          </div>
          <a data-role="button" href="#page5">
              Save for later
          </a>
          <a data-role="button" href="#page5">
              Sent to Someone Else
          </a>
          <a data-role="button" href="#page2">
              Push Another Thing
          </a>
          <hr style="height:3px; background-color:#000; border:0; margin-top:12px; margin-bottom:12px;">
          <div style=" text-align:center" data-controltype="image">
              <img style="width: 113px; height: 129px" src="https://s3.amazonaws.com/assets.codiqa.com/PbQJi4uzRECxWcPDqmIQ_success.png">
          </div>
      </div>
      <div data-role="tabbar" data-iconpos="top" data-theme="a">
          <ul>
              <li>
                  <a href="#page3" data-transition="fade" data-theme="" data-icon="home">
                      Home
                  </a>
              </li>
              <li>
                  <a href="#page2" data-transition="fade" data-theme="" data-icon="star">
                      My Q
                  </a>
              </li>
          </ul>
      </div>
  </div>
  
  
  <div data-role="page" data-control-title="My Q" data-theme="a" id="page3" data-add-back-btn="true"
  style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
      <div data-theme="a" data-role="header">
          <h3>
              My Q
          </h3>
      </div>
      <div data-role="content">
      
      
      
          <div data-controltype="textblock">
              <p>
                  <b>
                      Your friends recommend this stuff.
                  </b>
              </p>
          </div>
          <div class="ui-grid-a">
              <div class="ui-block-a">
                  <div style="" data-controltype="image" id="UserIcon_URL">
                      <img style="width: 50%; height: 50%" src="https://s3.amazonaws.com/assets.codiqa.com/PkHAc1r7S5T9Ltypz03z_user_icon.png">
                  </div>
                  <div id="sender" data-controltype="textblock">
                      <p>
                          <span style="font-size: x-small;">
                              Tiny Egg-Head recommends...
                          </span>
                      </p>
                  </div>
              </div>
              <div class="ui-block-b">
                  <div>
                      <a href="http://www.hulu.com/watch/4569" target="_blank" data-transition="fade">
                          Epsiode 1 of Firefly
                      </a>
                  </div>
              </div>
          </div>
          <a data-role="button" data-theme="a" href="#page3" data-icon="check" data-iconpos="left">
              Fulfilled
          </a>
          <hr style="height:3px; background-color:#ccc; border:0; margin-top:12px; margin-bottom:12px;">

      </div>
      <div data-role="tabbar" data-iconpos="top" data-theme="a">
          <ul>
              <li>
                  <a href="#page3" data-transition="fade" data-theme="" data-icon="home">
                      Home
                  </a>
              </li>
              <li>
                  <a href="#page2" data-transition="fade" data-theme="" data-icon="star">
                      Send Q
                  </a>
              </li>
          </ul>
      </div>
  </div>
  
  
  <div data-role="page" data-control-title="My Q Copy" data-theme="a" id="page6" data-add-back-btn="true"
  style="background: url('https://s3.amazonaws.com/assets.codiqa.com/LzWvZaZnRWGiwLRHudHB_App Background.png') no-repeat">
      <div data-theme="a" data-role="header">
          <h3>
              My Q
          </h3>
      </div>
      <div data-role="content">
          <div data-controltype="textblock">
              <p>
                  <b>
                      You fulfilled your friend's recommendation - what did you think?
                  </b>
              </p>
          </div>
          <div class="ui-grid-a">
              <div class="ui-block-a">
                  <div style="" data-controltype="image">
                      <img style="width: 50%; height: 50%" src="https://s3.amazonaws.com/assets.codiqa.com/PkHAc1r7S5T9Ltypz03z_user_icon.png">
                  </div>
                  <div data-controltype="textblock">
                      <p>
                          <span style="font-size: x-small;">
                              Tiny Egg-Head recommends...
                          </span>
                      </p>
                  </div>
              </div>
              <div class="ui-block-b">
                  <div>
                      <a href="http://www.hulu.com/watch/4569" target="_blank" data-transition="fade">
                          Epsiode 1 of Firefly
                      </a>
                  </div>
              </div>
          </div>
          <hr style="height:3px; background-color:#ccc; border:0; margin-top:12px; margin-bottom:12px;">
          <div data-role="fieldcontain" data-controltype="radiobuttons">
              <fieldset data-role="controlgroup" data-type="vertical">
                  <legend>
                      Rate the recommendation
                  </legend>
                  <input id="radio1" name="" value="radio1" type="radio">
                  <label for="radio1">
                      Awesome, loved it!
                  </label>
                  <input id="radio2" name="" value="radio2" type="radio">
                  <label for="radio2">
                      Egh, it was ok
                  </label>
                  <input id="radio3" name="" value="radio3" type="radio">
                  <label for="radio3">
                      Yuck, hated it!
                  </label>
              </fieldset>
          </div>
      </div>
      <div data-role="tabbar" data-iconpos="top" data-theme="a">
          <ul>
              <li>
                  <a href="#page3" data-transition="fade" data-theme="" data-icon="home">
                      Home
                  </a>
              </li>
              <li>
                  <a href="#page2" data-transition="fade" data-theme="" data-icon="star">
                      Send Q
                  </a>
              </li>
          </ul>
      </div>
  </div>
  
  -->
  
</body>
</html>

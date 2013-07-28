<?php
session_start();

$_SESSION['login_user'] = null;
unset($_SESSION['login_user']);

$_SESSION = array();
unset($_SESSION);

header("Location: /index.php");

?>
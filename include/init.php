<?php
@session_start();

function __autoload($class_name) {
    include "class." . strtolower($class_name) . '.php';
}

require_once("settings.php");


function report_error($error) {
	print "<!--ERROR-->1";
	die($error);
}

?>
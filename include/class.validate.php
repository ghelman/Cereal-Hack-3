<?php

class Validate {

	function __construct() { }
	
	public static function email($value) {
		if(preg_match("/^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)+$/",
               $value))
        	return true;
    
    	return false;  
    }
    
    public static function url($value) {
		if (preg_match("/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i", $value))
        	return true;
    
    	return false; 
    }
    
    public static function phone($value) {
    	$options = array('options' => array('regexp' => '/^\(\d{3}\) \d{3}-\d{4}$/'));
		return filter_input(INPUT_POST, 'phoneNumber', FILTER_VALIDATE_REGEXP, $options);
    }
}
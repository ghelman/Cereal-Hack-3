<?php  

define("DB_HOST", "mysql.alexrude.com");
define("DB_USER", "friendq");
define("DB_PASS", "recommendme");
define("DB_NAME", "friendq");

/************************************************
* DB
* 
* This is the Database class for the FriendQ app.
* It follows the Singleton class pattern
* to act as a global database class.
*/

class DB {
    private static $CONN = null; 
    private static $DB = null; 
    
    public $connected = false;
    public $errors = array();
    
    function __construct() { 

		//connect to the server / database                                     
		$this->CONN = mysql_connect(DB_HOST, DB_USER, DB_PASS);
		if(!$this->CONN) {
			$this->errors[] = "Could not connect to server";
			return;
		}

		$this->DB = mysql_select_db(DB_NAME);
		if(!$this->DB) { 
			$this->errors[] = "Could not connect to database";
			mysql_close($this->CONN);
			return;
		}
		
		$this->connected = true;
    }  
    
    /************************************************
    * ACCESSORS
    * 
    * The following functions are used to retreieve
    * MySQL connection objects for specified databases
    ************************************************/  
       
    /** getDB
    * @desc Returns an instance of the FriendQ Database
    * @return database resource
    */
    public function getDB() {    
        return self::$DB;
    }  
    
    /************************************************
    * DATABASE FUNCTIONS
    * 
    * The following functions are used to query the
    * FriendQ Database
    ************************************************/   
    
    /** getDBResults
    * @desc Returns an array of data from the submitted query
    * @param The query to perform
    * @param Flag determining if expecting one result versus multiple results
    * @param Identity field to use as array keys
    * @result Array of data
    */
    public function getDBResults($query, $single = false, $idfield = '') {
        $DB = self::getDB();     
        $data = array();          
        $res = @mysql_query($query);
        if(!$res) return array();
        while($row = mysql_fetch_array($res, MYSQL_ASSOC)) {
            if(!empty($idfield) && !empty($row[$idfield]))
                $data[$row[$idfield]] = $row;
            else
                $data[] = $row;
        }
        mysql_free_result($res);
        
        return (($single && isset($data[0])) ? $data[0] : $data);
    }
    
    /** getDBValue
    * @desc Returns the value for the submitted field and query
    * @param The query to perform 
    * @param The field to retrieve from the results
    * @return result
    */
    public function getDBValue($query) {
        $DB = self::getDB();
        $value = NULL;      
        $res = mysql_query($query); 
        if(!$res) print $query;
        else {
        	if(mysql_num_rows($res) > 0)
		        $value = mysql_result($res, 0);
        	mysql_free_result($res);
    	}
        
        return $value;
    }
    
    /** doDBQuery
    * @desc Performs query in DB
    * @param Query to perform in DB
    * @result Boolean result
    */
    public function doDBQuery($query, $returnID = false) {
        $DB = self::getDB();
        
        //mysql_autocommit($DB, false);
        
        //execute the query
        //print "<P>$query</p>";
        $result = @mysql_query($query); 
        //check for errors
        //if(!$result) //rollback if errors found
        //    odbc_rollback($DB);
        //else //commit if no errors
        //    odbc_commit($DB);
        
        //mysql_autocommit($DB, true);
        
        if($result && $returnID)
        	return mysql_insert_id();
        
        return ((!$result) ? false : true);
    }
    
    
    /** odbc_escape
    * @desc Cleans values for inserting into database
    */
    public function escape($string) {
        return mysql_real_escape_string($string);
    }
    
    public function __clone() {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    public function __wakeup() {
        trigger_error('Unserializing is not allowed.', E_USER_ERROR);
    }
    
    /** __destruct
    * @desc Disconnects from databases when object is unset
    */
    public function __destruct() {
        $this->disconnect();    
    }
    
    /** disconnect
    * @desc Disconnects from any active datbase connections
    */
    public function disconnect() {
        if(self::$CONN) mysql_close(self::$CONN);     
    }
        
}

?>
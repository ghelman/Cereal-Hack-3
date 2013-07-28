<?php

/************************************************
* User
* 
* This is the User class for the FriendQ app.
* It stores user data for the logged in user.
*/

class User implements Serializable {
	public $id = 0;
	public $email = '';
	public $name = '';
	public $username = '';
	
	public $loggedin = false;

	public $queue = array();
	public $details = array();
	
	function __construct($userid) {
		$this->id = $userid;
		
		$this->collectData();
	}
	
	public function collectData() {
		if(!empty($_SESSION['login_user'])) {
			$this->loadUserFromSession();
			return;
		}
		
		$DB = new DB();

		//get user details
		$query = "SELECT user_id, username, email, concat(concat(first_name, ' '), last_name) as name, gender, birthdate, 
							profile_picture_url, account_status, date_last_recommendation,
							(SELECT count(*) FROM recommendations WHERE receiver_id = user_id AND status_id = " . STATUS_NEW . ") as new_count
					FROM users WHERE user_id = " . $this->id . " AND account_status = 1";
		$data = $DB->getDBResults($query, true);
		$this->id = !empty($data['user_id']) ? $data['user_id'] : 0;
		$this->username = !empty($data['username']) ? $data['username'] : '';
		$this->email = !empty($data['email']) ? $data['email'] : '';
		$this->name = !empty($data['name']) ? $data['name'] : '';
		$this->details = $data;
		
		if(!empty($data)) {
			$this->loggedIn = true;
			//get queue
			$this->getUserQueue();
		}
	}
	
	private function getUserQueue() {
		$DB = new DB();
		/*
		$query = "SELECT r.recommendation_id, r.title, r.description, r.primary_url,
							r.link_url, r.rating, r.date_created, s.status, s.can_edit, s.display,
							m.media_type, concat(concat(u.first_name,  ' '), u.last_name) as sender_name
					FROM user_queue q INNER JOIN
							recommendations r ON r.recommendation_id = q.recommendation_id INNER JOIN 
							statuses s ON s.status_id = r.status_id INNER JOIN
							media_types m ON m.media_type_id = r.media_type_id INNER JOIN
							users u ON u.user_id = r.sender_id
					WHERE q.user_id = " . $this->id . "
					ORDER BY q.listing_order"; 
		*/
		$this->queue = array();
		$query = "SELECT recommendation_id
					FROM user_queue 
					WHERE user_id = " . $this->id . "
					ORDER BY listing_order"; 
		$recommendations = $DB->getDBResults($query);
		foreach($recommendations as $rec) {
			$new = new Recommendation($rec['recommendation_id']);
			$this->queue[] = $new;
		}
	}
	
	public function loadUserFromSession() {
		$user = unserialize($_SESSION['login_user']);

		$this->id = $user->id;
		$this->username = $user->username;
		$this->email = $user->email;
		$this->name = $user->name;
		$this->details = $user->details;
		$this->queue = $user->queue;
		$this->loggedIn = !empty($this->id) ? true : false;
		
		$DB = new DB();
		$updated = $DB->getDBValue("SELECT date_last_recommendation FROM users WHERE user_id = " . $this->id);
		$t1 = strtotime($this->details['date_last_recommendation']);
		$t2 = strtotime($updated);
		if(intval($t2) > intval($t1))
			$this->getUserQueue();
		$this->details['date_last_recommendation'] = $updated;
	}
	
    public function serialize() {
        return serialize(array(
        						'details' => $this->details,
        						'queue'   => $this->queue
        				));
    }
	
	public function __get($field) {
		if(isset($this->$field))
			return $this->$field;
		else if(isset($this->details[$field]))
			return $this->details[$field];
		
		return null;
	}
    
    public function unserialize($data) {
        $data = unserialize($data);
        $details = !empty($data['details']) ? $data['details'] : array();
        $queue = !empty($data['queue']) ? $data['queue'] : array();
        
        $this->id = !empty($details['user_id']) ? $details['user_id'] : 0;
        $this->username = !empty($details['username']) ? $details['username'] : '';
        $this->email = !empty($details['email']) ? $details['email'] : '';
        $this->name = !empty($details['name']) ? $details['name'] : '';
		$this->loggedIn = !empty($this->id) ? true : false;
        
        $this->details = $details;
        $this->queue = $queue;
    }

}
?>
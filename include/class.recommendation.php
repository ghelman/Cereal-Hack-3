<?php

class Recommendation {
	public $id = 0;
	
	/*
	public $user_id = 0;
	public $user_name = '';
	public $sender_id = 0;
	public $sender_name = '';
	
	public $statusid = 0;
	public $status = '';
	
	public $media_typeid = 0;
	public $media_type = 0;
	
	public $title = '';
	public $description = '';
	public $url = '';
	public $rating = -1;
	public $post_date = '';
	*/
	
	public $details = array();
	
	function __construct($id) {
		$this->id = $id;
		
		$this->collectData();
	}
	
	private function collectData() {
		$DB = new DB();
		
		$query = "SELECT r.sender_id, r.receiver_id, r.status_id, s.status, 
					m.media_type_id, m.media_type, title, description, primary_url, thumbnail_url,
					rating, r.date_created, u1.user_id as user_id, u2.user_id as sender_id,
					u1.username as user_name, u2.username as sender_name,
					u1.profile_picture_url as user_picture_url, u2.profile_picture_url as sender_picture_url
				  FROM recommendations r INNER JOIN
				  		statuses s ON s.status_id = r.status_id INNER JOIN
				  		media_types m ON m.media_type_id = r.media_type_id INNER JOIN
				  		users u1 ON u1.user_id = r.receiver_id INNER JOIN
				  		users u2 ON u2.user_id = r.sender_id
				  WHERE r.recommendation_id = " . $this->id;
		$data = $DB->getDBResults($query, true);
		
		$this->details = $data;
	}
	
	public function __get($field) {
		if(isset($this->$field))
			return $this->$field;
		else if(isset($this->details[$field]))
			return $this->details[$field];
		
		return null;
	}
	
}
?>
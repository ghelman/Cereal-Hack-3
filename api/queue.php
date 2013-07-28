<?php

require_once("../include/class.db.php");

$userid = !empty($_GET['userid']) && ctype_digit($_GET['userid']) ? intval($_GET['userid']) : 0;

$query = "SELECT r.recommendation_id, r.title, r.description, r.primary_url,
					r.link_url, r.rating, r.date_created, s.status, s.can_edit, s.display,
					m.media_type, concat(concat(u.first_name,  ' '), u.last_name) as sender_name
			FROM recommendations r INNER JOIN 
					statuses s ON s.status_id = r.status_id INNER JOIN
					media_types m ON m.media_type_id = r.media_type_id INNER JOIN
					users u ON u.user_id = r.sender_id
			WHERE r.receiver_id = $userid";
	
$DB = new DB();

$data = $DB->getDBResults($query);

print json_encode($data);

?>
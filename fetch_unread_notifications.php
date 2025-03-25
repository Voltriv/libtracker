<?php
include 'db_config.php';

header('Content-Type: application/json');

// Count unread notifications
$query = "SELECT COUNT(*) as unread 
          FROM notifications 
          WHERE status = 'unread'";
$result = mysqli_query($conn, $query);
$data = mysqli_fetch_assoc($result);

echo json_encode($data);
?>
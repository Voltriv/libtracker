<?php
include 'db_config.php';

header('Content-Type: application/json');

// Mark all unread notifications as read
$query = "UPDATE notifications 
          SET status = 'read' 
          WHERE status = 'unread'";
mysqli_query($conn, $query);

echo json_encode(['success' => true]);
?>
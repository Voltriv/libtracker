<?php
include 'db_config.php'; // Ensure this file connects to the database

$query = "SELECT COUNT(*) AS unread FROM notifications WHERE status = 'unread'";
$result = mysqli_query($conn, $query);
$row = mysqli_fetch_assoc($result);

echo json_encode(["unread" => $row['unread']]);
?>

<?php
include 'db_config.php';

mysqli_query($conn, "UPDATE notifications SET status = 'read' WHERE status = 'unread'");
echo json_encode(["status" => "success"]);
?>


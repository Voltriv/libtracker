<?php
include 'db_config.php';

header('Content-Type: application/json');

// Fetch the 5 most recent notifications
$query = "SELECT id, message, created_at, status 
          FROM notifications 
          ORDER BY created_at DESC 
          LIMIT 5";
$result = mysqli_query($conn, $query);

if (!$result) {
    echo json_encode(["error" => mysqli_error($conn)]); // Show SQL error
    exit;
}

$notifications = mysqli_fetch_all($result, MYSQLI_ASSOC);

// Debugging output
echo json_encode($notifications);
exit;
?>

<?php
include 'db_config.php';

$staff_id = $_GET['staff_id'];

$query = "SELECT * FROM staff WHERE staff_id = '$staff_id'";
$result = $conn->query($query);

if ($result->num_rows > 0) {
    $staff = $result->fetch_assoc();
    echo json_encode(['success' => true, 'staff' => $staff]);
} else {
    echo json_encode(['success' => false, 'message' => 'Staff not found']);
}

$conn->close();
?>
<?php
include 'db_config.php';

header('Content-Type: application/json');

$staff_id = $_POST['staff_id'];
$staff_idNum = $_POST['staff_idNum'];
$first_name = $_POST['staff_first_name'];
$last_name = $_POST['staff_last_name'];
$position = $_POST['position'];
$phinmaed_email = $_POST['phinmaed_email'];
$status = $_POST['status'];

$query = "UPDATE staff SET staff_idNum = '$staff_idNum', staff_first_name = '$first_name', staff_last_name = '$last_name', position = '$position', phinmaed_email = '$phinmaed_email', status = '$status' WHERE staff_id = '$staff_id'";

if ($conn->query($query) === TRUE) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Error updating staff: ' . $conn->error]);
}
?>
<?php
include 'db_config.php';

$attendanceData = [];
$today = date('l'); // Get the current weekday name (e.g., "Wednesday")

$query = "SELECT department, COUNT(*) as attendance_count 
          FROM attendance 
          WHERE day = '$today' 
          GROUP BY department";

$result = $conn->query($query);
while ($row = $result->fetch_assoc()) {
    $attendanceData[$row['department']] = $row['attendance_count'];
}




$conn->close();
?>
<?php
include 'db_config.php';

$query = "SELECT borrow.transaction_id, borrow.title, user.student_id, user.last_name, user.first_name, 
                 borrow.borrowed_date, borrow.status
          FROM borrow
          INNER JOIN user ON borrow.student_id = user.student_id
          ORDER BY borrow.borrowed_date DESC";

$result = $conn->query($query);

$borrowedBooks = [];

while ($row = $result->fetch_assoc()) {
    $borrowedBooks[] = $row;
}

header('Content-Type: application/json');
echo json_encode($borrowedBooks);
?>

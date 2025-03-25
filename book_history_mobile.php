<?php
header('Content-Type: application/json');

$db_server = "localhost";
$db_user = "root";
$db_pass = "";
$dbase_name = "libtrack";

try {
    $connect = mysqli_connect($db_server, $db_user, $db_pass, $dbase_name);

    if ($connect) {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            $studentId = $_GET['studentID'];

            $stmt = $connect->prepare("SELECT book_code AS bookCode, title, borrowed_date AS borrowedDate, due_date AS dueDate, return_date AS returnDate, status FROM borrow WHERE student_id = ?");
            $stmt->bind_param("s", $studentId);
            $stmt->execute();
            $result = $stmt->get_result();

            $historyData = array();
            while ($row = $result->fetch_assoc()) {
                $historyData[] = $row;
            }

            echo json_encode($historyData);

            $stmt->close();
        } else {
            echo json_encode(array("error" => "Invalid request method"));
        }
    } else {
        echo json_encode(array("error" => "Database connection failed"));
    }
} catch (Exception $e) {
    echo json_encode(array("error" => "An error occurred: " . $e->getMessage()));
} finally {
    mysqli_close($connect);
}
?>
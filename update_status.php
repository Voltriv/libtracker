<?php
include 'db_config.php';

header('Content-Type: application/json');

// Get the JSON data from the request body
$data = json_decode(file_get_contents("php://input"), true);
$transaction_id = $data['transaction_id'] ?? null;
$action = $data['action'] ?? null;
$return_date = $data['return_date'] ?? date('F j, Y h:i A'); // Use current date if not provided

if (!$transaction_id || !$action) {
    echo json_encode(["success" => false, "message" => "Missing parameters"]);
    exit;
}

try {
    if ($action === 'return' || $action === 'set_returned') {
        // Update status to 'Returned' and set return_date
        $query = "UPDATE borrow SET status = 'Returned', return_date = ? WHERE transaction_id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("si", $return_date, $transaction_id);
    } elseif ($action === 'renew') {
        // For renewals, we don't update return_date
        $query = "UPDATE borrow SET status = 'Renewed' WHERE transaction_id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $transaction_id);
    } else {
        echo json_encode(["success" => false, "message" => "Invalid action"]);
        exit;
    }

    if ($stmt->execute()) {
        if ($action === 'return' || $action === 'set_returned') {
            // Increment copies_available in the books table
            $incrementQuery = "UPDATE books 
                             SET copies_available = copies_available + 1 
                             WHERE book_code = (SELECT book_code FROM borrow WHERE transaction_id = ?)";
            $incrementStmt = $conn->prepare($incrementQuery);
            $incrementStmt->bind_param("i", $transaction_id);
            $incrementStmt->execute();
            $incrementStmt->close();
        }

        // Fetch the updated row data including return_date
        $fetchQuery = "SELECT transaction_id, status, return_date FROM borrow WHERE transaction_id = ?";
        $stmt = $conn->prepare($fetchQuery);
        $stmt->bind_param("i", $transaction_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $updatedRow = $result->fetch_assoc();

        echo json_encode([
            "success" => true, 
            "updatedRow" => $updatedRow,
            "message" => "Book successfully returned"
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Database update failed"]);
    }
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => "Error: " . $e->getMessage()]);
}

$stmt->close();
$conn->close();
?>
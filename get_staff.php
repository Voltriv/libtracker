<?php
include 'db_config.php';

if (isset($_GET['staff_id'])) {
    $staff_id = $_GET['staff_id'];
    $sql = "SELECT * FROM staff WHERE staff_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $staff_id);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($result->num_rows > 0) {
        $staff = $result->fetch_assoc();
        echo json_encode(['success' => true, 'staff' => $staff]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Staff not found']);
    }
    
    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Staff ID not provided']);
}
?>
<?php
include 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $staff_id = $_POST['staff_id'];
    $staff_idNum = $_POST['staff_idNum'];
    $staff_first_name = $_POST['staff_first_name'];
    $staff_last_name = $_POST['staff_last_name'];
    $position = $_POST['position'];
    $phinmaed_email = $_POST['phinmaed_email'];

    $sql = "UPDATE staff SET 
            staff_idNum = ?,
            staff_first_name = ?,
            staff_last_name = ?,
            position = ?,
            phinmaed_email = ?
            WHERE staff_id = ?";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssssi", 
        $staff_idNum,
        $staff_first_name,
        $staff_last_name,
        $position,
        $phinmaed_email,
        $staff_id
    );
    
    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Error updating staff: ' . $conn->error]);
    }
    
    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>
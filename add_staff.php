<?php
include 'db_config.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get form data
    $staff_idNum = $_POST['staff_idNum'];
    $staff_first_name = $_POST['staff_first_name'];
    $staff_last_name = $_POST['staff_last_name'];
    $position = $_POST['position'];
    $phinmaed_email = $_POST['phinmaed_email'];
    $status = 1; // Default to active

    // Insert into database
    $sql = "INSERT INTO staff (staff_idNum, staff_first_name, staff_last_name, position, phinmaed_email, status) 
            VALUES (?, ?, ?, ?, ?, ?)";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssssi", $staff_idNum, $staff_first_name, $staff_last_name, $position, $phinmaed_email, $status);
    
    if ($stmt->execute()) {
        $staff_id = $stmt->insert_id;
        $response = [
            'success' => true,
            'staff_id' => $staff_id,
            'staff_idNum' => $staff_idNum,
            'staff_first_name' => $staff_first_name,
            'staff_last_name' => $staff_last_name,
            'position' => $position,
            'phinmaed_email' => $phinmaed_email
        ];
    } else {
        $response = [
            'success' => false,
            'message' => 'Error adding staff: ' . $conn->error
        ];
    }
    
    $stmt->close();
    $conn->close();
    
    header('Content-Type: application/json');
    echo json_encode($response);
    exit();
}
?>
<?php
include 'db_config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $staff_idNum = $_POST['staff_idNum'];
    $first_name = $_POST['staff_first_name'];
    $last_name = $_POST['staff_last_name'];
    $position = $_POST['position'];
    $email = $_POST['phinmaed_email'];

    $sql = "INSERT INTO staff (staff_idNum, staff_first_name, staff_last_name, position, phinmaed_email, status)
            VALUES (?, ?, ?, ?, ?, 1)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssss", $staff_idNum, $first_name, $last_name, $position, $email);

    if ($stmt->execute()) {
        $staff_id = $conn->insert_id;
        $response = [
            'success' => true,
            'staff' => [
                'staff_id' => $staff_id,
                'staff_idNum' => $staff_idNum,
                'staff_first_name' => $first_name,
                'staff_last_name' => $last_name,
                'position' => $position,
                'phinmaed_email' => $email,
                'status' => 1
            ]
        ];
    } else {
        $response = ['success' => false, 'message' => 'Failed to add staff.'];
    }
    echo json_encode($response);
}
?>

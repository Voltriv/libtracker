<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

// Database connection
$host = "localhost";
$dbname = "libtrack";
$username = "root";
$password = "";

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit();
}

// Read input data
$data = json_decode(file_get_contents("php://input"), true);
$email = trim($data['email'] ?? '');
$new_password = trim($data['new_password'] ?? '');

// Validate input
if (empty($email) || empty($new_password)) {
    echo json_encode(["status" => "error", "message" => "Email and password cannot be empty"]);
    exit();
}

// Check if user exists and fetch hashed password
$stmt = $conn->prepare("SELECT password FROM user WHERE phinmaed_email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();
$stmt->close();

if (!$user) {
    echo json_encode(["status" => "error", "message" => "User not found"]);
    exit();
}

$old_hashed_password = $user['password']; // Retrieve hashed password from the database

// Verify if new password is the same as the old one
if (password_verify($new_password, $old_hashed_password)) {
    echo json_encode(["status" => "error", "message" => "New password cannot be the same as the old password"]);
    exit();
}

// Hash the new password
$hashedNewPassword = password_hash($new_password, PASSWORD_BCRYPT);

// Update password in the database
$stmt = $conn->prepare("UPDATE user SET password = ? WHERE phinmaed_email = ?");
$stmt->bind_param("ss", $hashedNewPassword, $email);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Password updated successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to update password"]);
}

$stmt->close();
$conn->close();
?>
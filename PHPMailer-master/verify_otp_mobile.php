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
    die(json_encode(["status" => "error", "message" => "Database connection failed"]));
}

// Read input
$data = json_decode(file_get_contents("php://input"), true);
$email = $data['email'] ?? '';
$otp_entered = $data['otp'] ?? '';

// Get OTP from database
$stmt = $conn->prepare("SELECT otp, expires_at FROM otp_codes WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();

if ($row) {
    $stored_otp = $row['otp'];
    $expires_at = strtotime($row['expires_at']);
    $current_time = time();

    if ($current_time > $expires_at) {
        echo json_encode(["status" => "error", "message" => "OTP expired"]);
    } elseif ($otp_entered == $stored_otp) {
        echo json_encode(["status" => "success", "message" => "OTP verified"]);
        // Delete OTP after successful verification
        $stmt = $conn->prepare("DELETE FROM otp_codes WHERE email = ?");
        $stmt->bind_param("s", $email);
        $stmt->execute();
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid OTP"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "No OTP found for this email"]);
}

$conn->close();
?>
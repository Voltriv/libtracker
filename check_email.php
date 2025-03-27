<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "libtrack";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$text = $_GET['text'];
$text = $conn->real_escape_string($text); //Important for security

$sql = "SELECT * FROM user WHERE phinmaed_email = '$text'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "true";
} else {
    echo "false";
}

$conn->close();
?>
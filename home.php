<?php 
ob_start();
include 'db_config.php'; 
date_default_timezone_set('Asia/Manila');

// Fetch all department user counts in one query
$departmentCounts = [];
$query = "SELECT department, COUNT(*) as user_count FROM user GROUP BY department";
$result = $conn->query($query);
while ($row = $result->fetch_assoc()) {
    $departmentCounts[$row['department']] = $row['user_count'];
}

// Fetch today's attendance data per department (Soft Reset)
$attendanceData = [];
$today = date('l'); // Get today's date

$query = "SELECT department, COUNT(*) as attendance_count FROM attendance WHERE day = '$today' GROUP BY department";
$result = $conn->query($query);
while ($row = $result->fetch_assoc()) {
    $attendanceData[$row['department']] = $row['attendance_count'];
}

// Fetch recent borrowed books data
$recentBorrowedBooks = [];
$query = "SELECT books.title, borrow.borrowed_date, user.first_name, user.last_name 
          FROM borrow 
          JOIN books ON borrow.book_code = books.book_code
          JOIN user ON borrow.student_id = user.student_id
          ORDER BY borrow.borrowed_date DESC 
          LIMIT 5";
$result = $conn->query($query);
while ($row = $result->fetch_assoc()) {
    $recentBorrowedBooks[] = $row;
}
// Fetch most borrowed books from 'borrow' table
$mostBorrowedBooks = $conn->query("
    SELECT title, book_code, COUNT(book_code) AS borrow_count
    FROM borrow
    GROUP BY book_code
    ORDER BY borrow_count DESC
    LIMIT 5
");

// Fetch total book inventory
$query = "SELECT COUNT(*) as total_books FROM books";
$result = $conn->query($query);
$totalBooks = ($result->fetch_assoc())['total_books'] ?? 0;

// Fetch total borrowed books where status is 'borrowed'
$query = "SELECT COUNT(*) as total_borrowed_books FROM borrow WHERE status = 'Borrowed'";
$result = $conn->query($query);
$totalBorrowedBooks = ($result->fetch_assoc())['total_borrowed_books'] ?? 0;

// Query to count overdue books where the due date has passed and the book is not returned
// Get today's date in the correct format
$today = date('Y-m-d');

// SQL query to count overdue books where due_date is before today and status is not "Returned"
$query = "SELECT COUNT(*) AS overdue_count 
          FROM borrow 
          WHERE STR_TO_DATE(due_date, '%e %b %Y, %H:%i:%s') < ? 
          AND status != 'Returned'";

$stmt = $conn->prepare($query);
$stmt->bind_param("s", $today);
$stmt->execute();
$result = $stmt->get_result();
$row = $result->fetch_assoc();
$overdueBooks = $row['overdue_count'];
$stmt->close();

// Get today's date in the correct format
$today = date('Y-m-d');

// Query to count overdue books where due_date is before today and status is not "Returned"
$query = "SELECT transaction_id, student_id, title FROM borrow 
          WHERE STR_TO_DATE(due_date, '%e %b %Y, %H:%i:%s') < ? 
          AND status != 'Returned'";

$stmt = $conn->prepare($query);
$stmt->bind_param("s", $today);
$stmt->execute();
$result = $stmt->get_result();

$overdueBooks = $result->num_rows; // Count overdue books

// Insert notifications for overdue books
while ($row = $result->fetch_assoc()) {
    $studentId = $row['student_id'];
    $bookTitle = $row['title'];

    // Fetch student name
    $student_query = "SELECT first_name, last_name FROM user WHERE student_id = ?";
    $stmt_student = $conn->prepare($student_query);
    $stmt_student->bind_param("s", $studentId);
    $stmt_student->execute();
    $student_result = $stmt_student->get_result();

    if ($student_result->num_rows > 0) {
        $student = $student_result->fetch_assoc();
        $student_name = $student['first_name'] . ' ' . $student['last_name'];

        // Notification message
        $message = "$student_name has an overdue book titled '$bookTitle'.";

        // Check if notification already exists
        $check_query = "SELECT * FROM notifications WHERE message = ?";
        $stmt_check = $conn->prepare($check_query);
        $stmt_check->bind_param("s", $message);
        $stmt_check->execute();
        $check_result = $stmt_check->get_result();

        // Insert only if notification doesn't exist
        if ($check_result->num_rows == 0) {
            $stmt_notify = $conn->prepare("INSERT INTO notifications (message) VALUES (?)");
            $stmt_notify->bind_param("s", $message);
            $stmt_notify->execute();
            $stmt_notify->close();
        }
        $stmt_check->close();
    }
    $stmt_student->close();
}


$stmt->close();





// Fetch active and deactivated users
$query = "SELECT 
            SUM(CASE WHEN status = 1 THEN 1 ELSE 0 END) as active_users,
            SUM(CASE WHEN status = 0 THEN 1 ELSE 0 END) as deactivated_users 
          FROM user";
$result = $conn->query($query);
$row = $result->fetch_assoc();
$activeUsers = $row['active_users'] ?? 0;
$deactivatedUsers = $row['deactivated_users'] ?? 0;

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="global.css">
    <link rel="stylesheet" href="home.css">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <title>Dashboard</title>
</head>
<body>
<nav class="header">
    <h1>Dashboard</h1>

    <!-- Container to keep notification and header-right together -->
    <div class="header-actions">
        <button id="notificationButton" class="notification-btn">
            <i class='bx bx-bell'></i>
            <span class="badge hidden">0</span> <!-- Badge to show unread count -->
        </button>
        <div class="header-right">
            <?php echo date('l, F j, Y g:i A'); ?>
        </div>
    </div>
</nav>
    <div class="analytics">
    <div class="dashboard-long-box">
        <h2>USER CREATED BY EACH DEPARTMENT</h2>
        <div class="department-boxes">
            <?php
            $departments = ['CAHS', 'CCJE', 'CEA', 'CELA', 'CITE', 'CMA', 'COL','SHS'];
            foreach ($departments as $department) {
                $user_count = $departmentCounts[$department] ?? 0;
                echo "<div class='department-box'>
                        <img src='images/{$department}.png' alt='{$department} Logo' class='department-logo'>
                        <div class='user-info'>
                            <div class='department-label'>{$department}</div>
                            <div class='user-count'>{$user_count}</div>
                        </div>
                      </div>";
            }
            ?>
        </div>
        
    </div>
    <div class="library-analytics">
    <h2>LIBRARY ANALYTICS</h2>
    <div class="stats-grid">
        <div class="stats-item">
            <h3>Total Books</h3>
            <p><?php echo $totalBooks; ?></p>
        </div>
        <div class="stats-item">
            <h3>Total Users</h3>
            <p><?php echo $activeUsers + $deactivatedUsers; ?></p>
        </div>
        <div class="stats-item">
            <h3>Active Users</h3>
            <p><?php echo $activeUsers; ?></p>
        </div>
        <div class="stats-item">
            <h3>Deactivated Users</h3>
            <p><?php echo $deactivatedUsers; ?></p>
        </div>
        
        <div class="stats-item">
            <h3>Total Borrowed Books</h3>
            <p><?php echo $totalBorrowedBooks; ?></p>
        </div>
        <div class="stats-item">
            <h3>Overdue Books</h3>
            <p><?php echo $overdueBooks; ?></p>
        </div>
    </div>
</div>
    </div>

    <div class="dashboard-row">
        <div class="dashboard-box">
            <h2>ATTENDANCE</h2>
            <div class="attendance-container">
                <div class="attendance-labels">
                    <?php
                    foreach ($attendanceData as $department => $count) {
                        echo "<div>{$department}: {$count}</div>";
                    }
                    ?>
                </div>
                <div class="attendance-chart">
                    <canvas id="attendanceChart"></canvas>
                </div>
            </div>
        </div>
        <div class="dashboard-box">
    <h2>MOST BORROWED BOOKS</h2>
    <div class="borrowed-books-container">
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Book Code</th>
                    <th>Times Borrowed</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($mostBorrowedBooks->num_rows > 0) {
                    while ($book = $mostBorrowedBooks->fetch_assoc()) {
                        echo "<tr>
                                <td>{$book['title']}</td>
                                <td>{$book['book_code']}</td>
                                <td>{$book['borrow_count']}</td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='3'>No borrowed books found.</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var departmentColors = {
    'CAHS': '#008000',  // Green
    'CCJE': '#808080',  // Gray
    'CEA': '#FF0000',   // Red
    'CELA': '#0000FF',  // Blue
    'CITE': '#000000',  // Black
    'CMA': '#FFFF00',   // Yellow
    'COL': '#FFA500',   // Orange 
    'SHS': '#47E0CC'    // Sky blue 
};

// Pass PHP attendance data to JavaScript
var attendanceData = <?php echo json_encode($attendanceData); ?>;

// Prepare data for the chart
var labels = Object.keys(attendanceData);
var data = Object.values(attendanceData);

// Assign colors based on department
var backgroundColors = labels.map(dept => departmentColors[dept] || '#808080'); // Default gray if missing


// Initialize Chart
var ctx = document.getElementById('attendanceChart').getContext('2d');
var attendanceChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: labels,
        datasets: [{
            label: 'Attendance Count',
            data: data,
            backgroundColor: backgroundColors,
            borderColor: '#ffffff', // White border around slices
            borderWidth: 1,
            hoverOffset: 12, // Bigger slice on hover
            cutout: '60%' // Creates a donut effect for a modern look
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: {
            animateRotate: true, 
            animateScale: true 
        },
        plugins: {
            legend: {
                position: 'right', // Moves legend to the right
                labels: {
                    font: {
                        size: 20,
                        weight: 'bold'
                    },
                    color: "white" // Darker text for better readability
                }
            },
            tooltip: {
                enabled: true,
                backgroundColor: "rgba(0, 0, 0, 0.8)",
                bodyFont: {
                    size: 14
                },
                padding: 12,
                borderColor: "#ffffff",
                borderWidth: 2,
                cornerRadius: 8
            }
        }
    },
});


    </script>
</body>
</html>

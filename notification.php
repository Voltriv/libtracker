<?php
include 'db_config.php'; 

// Fetch the latest notifications
$query = "SELECT message, created_at FROM notifications ORDER BY created_at DESC LIMIT 5";
$result = mysqli_query($conn, $query);
$notifications = mysqli_fetch_all($result, MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="global.css">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <title>Notification</title>
</head>
<body>
    <div id="notification-panel" class="hidden">
    <h4>Notifications</h4>
    <ul>
        <?php if (empty($notifications)) : ?>
            <li>No notifications</li>
        <?php else : ?>
            <?php foreach ($notifications as $notification) : ?>
                <li>
                    <strong><?= htmlspecialchars($notification['message']) ?></strong>
                    <br><small><?= date("M d, Y h:i A", strtotime($notification['created_at'])) ?></small>
                </li>
            <?php endforeach; ?>
        <?php endif; ?>
    </ul>
</div></body>

<script>
document.addEventListener("DOMContentLoaded", () => {
    const panel = document.getElementById("notification-panel");
    const buttons = document.querySelectorAll(".notification-btn");
    const badges = document.querySelectorAll(".notification-btn .badge"); // Select all badges

    // Function to fetch unread notification count
    function fetchNotificationCount() {
        fetch("fetch_unread_notifications.php")
            .then(response => response.json())
            .then(data => {
                badges.forEach(badge => { // Update all badges
                    if (data.unread > 0) {
                        badge.style.display = "block";
                        badge.textContent = data.unread;
                    } else {
                        badge.style.display = "none";
                    }
                });
            })
            .catch(error => console.error("Error fetching notifications:", error));
    }

    // Function to mark notifications as read
    function markNotificationsAsRead() {
        fetch("mark_notifications_as_read.php")
            .then(() => fetchNotificationCount()) // Refresh count after marking as read
            .catch(error => console.error("Error updating notifications:", error));
    }

    // Function to toggle the notification panel
    function togglePanel(event) {
        event.stopPropagation();
        panel.classList.toggle("hidden");

        // If panel is opened, mark notifications as read
        if (!panel.classList.contains("hidden")) {
            markNotificationsAsRead();
        }
    }

    // Attach event listener to each notification button
    buttons.forEach(button => {
        button.addEventListener("click", togglePanel);
    });

    // Hide notification panel when clicking outside
    document.addEventListener("click", (event) => {
        if (!event.target.closest(".notification-btn") && !event.target.closest("#notification-panel")) {
            panel.classList.add("hidden");
        }
    });

    // Fetch unread notifications count on load and every 5 seconds
    fetchNotificationCount();
    setInterval(fetchNotificationCount, 1000);
});


</script>

</html>

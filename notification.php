<?php
include 'db_config.php';

// Fetch the latest notifications
$query = "SELECT message, created_at, status 
          FROM notifications 
          ORDER BY created_at DESC 
          LIMIT 5";
$result = mysqli_query($conn, $query);
$notifications = mysqli_fetch_all($result, MYSQLI_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification</title>
    <link rel="stylesheet" href="global.css">

    
</head>
<body>
    <div id="notification-panel" class="hidden">
        <h4>Notifications</h4>
        <ul>
            <?php if (empty($notifications)) : ?>
                <li>No notifications</li>
            <?php else : ?>
                <?php foreach ($notifications as $notification) : ?>
                    <li class="<?= $notification['status'] === 'unread' ? 'unread' : '' ?>">
                        <strong><?= htmlspecialchars($notification['message']) ?></strong>
                        <br><small><?= date("F j, Y h:i A", strtotime($notification['created_at'])) ?></small>
                    </li>
                <?php endforeach; ?>
            <?php endif; ?>
        </ul>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", () => {
        const panel = document.getElementById("notification-panel");
        const notificationList = panel.querySelector("ul");
        const buttons = document.querySelectorAll(".notification-btn");
        const badges = document.querySelectorAll(".notification-btn .badge");

        // Function to fetch and update notification content
        function fetchNotifications() {
    fetch("fetch_notification.php")
        .then(response => response.json())
        .then(notifications => {
            console.log("Response Data:", notifications);
            notificationList.innerHTML = '';
            
            if (!Array.isArray(notifications)) {
                console.error("Unexpected data format:", notifications);
                return;
            }

            if (notifications.length === 0) {
                notificationList.innerHTML = '<li>No notifications</li>';
            } else {
                notifications.forEach(notification => {
                    console.log("Notification item:", notification);
                    const li = document.createElement('li');
                    if (notification.status === 'unread') {
                        li.classList.add('unread');
                    }
                    li.innerHTML = formatNotificationMessage(notification.message) + `
                        <br><small>
                            ${new Date(notification.created_at).toLocaleString('en-US', {
                                month: 'long',
                                day: 'numeric',
                                year: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit',
                                hour12: true
                            }) || ""}
                        </small>
                    `;

                    notificationList.appendChild(li);
                });
            }
        })
        .catch(error => console.error("Error fetching notifications:", error));
}
function formatNotificationMessage(message) {
    // Split the message at the word "borrowed"
    const parts = message.split(" borrowed");
    
    if (parts.length >= 2) {
        const name = parts[0].trim(); // Part before "borrowed"
        const rest = "borrowed" + parts[1]; // "borrowed" and the rest
        return `<strong>${name}</strong> ${rest}`; // Bold only the name part
    }
    return message; // If "borrowed" is not found, return original message
}




        // Helper functions remain the same
        function escapeHtml(text) { /* ... */ }
        function formatDate(dateString) { /* ... */ }

        // Function to fetch unread notification count
        function fetchNotificationCount() {
            fetch("fetch_unread_notifications.php")
                .then(response => response.json())
                .then(data => {
                    badges.forEach(badge => {
                        if (data.unread > 0) {
                            badge.style.display = "block";
                            badge.textContent = data.unread;
                        } else {
                            badge.style.display = "none";
                        }
                    });
                })
                .catch(error => console.error("Error fetching notification count:", error));
        }

        // Function to mark notifications as read
        function markNotificationsAsRead() {
            fetch("mark_notifications_as_read.php")
                .then(() => {
                    fetchNotificationCount();
                    fetchNotifications();
                })
                .catch(error => console.error("Error updating notifications:", error));
        }

    // Function to toggle the notification panel
    function togglePanel(event) {
        event.stopPropagation();
        panel.classList.toggle("hidden");

        // If panel is opened, mark notifications as read and refresh content
        if (!panel.classList.contains("hidden")) {
        markNotificationsAsRead();
        fetchNotifications();
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

    // Fetch initial data
    fetchNotificationCount();
    fetchNotifications();

    // Set up periodic refresh (every 5 seconds)
    setInterval(() => {
    console.log("Checking for new notifications...");
    fetchNotificationCount();
}, 5000);

setInterval(() => {
    console.log("Updating notification list...");
    fetchNotifications();
}, 5000);

});

</script>

</html>
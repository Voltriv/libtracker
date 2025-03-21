<?php
ob_start();
include 'db_config.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="staff.css">
    <link rel="stylesheet" href="global.css">
    <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
    <title>Staff Management</title>
</head>
<body>
<nav class="header">
    <h1>Library Staff</h1>

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
<div class="container5">
    <div class="search-sort">

        <button id="openStaffFormButton" class="add-btn">+ ADD STAFF</button>

        <input type="text" id="search4" placeholder="Search...">
        <select id="positionFilter" class="filter-attendance">
            <option value="">All Positions</option>
            <option value="Librarian - Periodical Section">Librarian - Periodical Section</option>
            <option value="Librarian - General Circulation Section">Librarian - General Circulation Section</option>
            <option value="Librarian - Law Library">Librarian - Law Library</option>
            <option value="Library Assistant - Dissertation Section">Library Assistant - Dissertation Section</option>
            <option value="Library Assistant - Technical Section">Library Assistant - Technical Section</option>
        </select>
    </div>
    
    <div class="table-container2">
        <table>
            <thead>
                <tr>
                    <th data-column5="staff_idNum">Staff ID<i class='bx bx-sort sort-icon'></i></th>
                    <th data-column5="staff_first_name">First Name<i class='bx bx-sort sort-icon'></i></th>
                    <th data-column5="staff_last_name">Last Name<i class='bx bx-sort sort-icon'></i></th>
                    <th data-column5="position">Position<i class='bx bx-sort sort-icon'></i></th>
                    <th data-column5="phinmaed_email">phinmaed_email<i class='bx bx-sort sort-icon'></i></th>
                    <th data-column5="status">Status<i class='bx bx-sort sort-icon'></i></th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="staffTableBody">
                <?php
                $result = $conn->query("SELECT * FROM staff ORDER BY staff_id DESC");
                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        $status = isset($row['status']) && $row['status'] == 1 ? 'Active' : 'Deactivated';
                        $toggleStatus = $row['status'] == 1 ? 'Deactivate' : 'Activate';
                        $toggleClass = $row['status'] == 1 ? 'deactivate-btn' : 'activate-btn';
                        $toggleIcon = $row['status'] == 1 ? 'bx-user-x' : 'bx-user-check';
                        $statusClass = $row['status'] == 1 ? 'status-active-staff' : 'status-deactivated';
                        echo "<tr>
                                <td>{$row['staff_idNum']}</td>
                                <td>{$row['staff_first_name']}</td>
                                <td>{$row['staff_last_name']}</td>
                                <td>{$row['position']}</td>
                                <td>{$row['phinmaed_email']}</td>
                                <td class='{$statusClass}'>{$status}</td>
                                <td>
                                    <form method='POST' class='toggle-status-form'>
                                        <input type='hidden' name='staff_id' value='{$row['staff_id']}'>
                                        <div class='actions_button'>
                                            <button type='submit' name='toggle_staff_status' class='toggle-staff-status-btn {$toggleClass}' onclick='return confirmToggleStatus(event, \"{$toggleStatus}\")'><i class='bx {$toggleIcon}'></i> {$toggleStatus}</button>
                                            <button type='button' class='edit-btn' onclick='editStaff({$row['staff_id']})'><i class='bx bx-edit ' ></i></button>
                                            <button type='button' class='three-dot-btn-staff' onclick='seeMoreStaff({$row['staff_id']})'><i class='bx bx-dots-vertical-rounded'></i></button>
                                        </div>
                                    </form>
                                </td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='8'>No Registered Staff.</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>

    <!-- Floating Table Container -->
    <div id="floatingTableContainer" class="floating-table-container">
        <span class="close-floating-table" onclick="closeFloatingTable()">×</span>
        <h2>Staff Details</h2>
        <div id="floatingTableContent"></div>
    </div>

    <!-- Edit Staff Sliding Form -->
    <div id="editStaffContainer" class="edit-staff-container">
        <h1>Edit Staff</h1>
        <form id="editStaffForm" method="POST">
            <input type="hidden" name="staff_id" id="editStaffId">
            <input type="text" name="staff_idNum" id="editStaffIdNum" placeholder="Staff ID" required>
            <input type="text" name="staff_first_name" id="editStaffFirstName" required>
            <input type="text" name="staff_last_name" id="editStaffLastName" required>
            <select name="position" id="editPosition" required>
                <option value="Librarian - Periodical Section">Librarian - Periodical Section</option>
                <option value="Librarian - General Circulation Section">Librarian - General Circulation Section</option>
                <option value="Librarian - Law Library">Librarian - Law Library</option>
                <option value="Library Assistant - Dissertation Section">Library Assistant - Dissertation Section</option>
                <option value="Library Assistant - Technical Section">Library Assistant - Technical Section</option>
            </select>
            <input type="email" name="phinmaed_email" id="editphinmaed_email" placeholder="Email" required>
            <select name="status" id="editStatus" required>
                <option value="1">Active</option>
                <option value="0">Deactivated</option>
            </select>
            <button type="submit" name="update_staff" class="update-staff-btn">Update</button>
            <button type="button" id="closeStaffFormButton" class="close-staff-form" onclick="closeEditFormStaff()">Cancel</button>
        </form>
    </div>

    <!-- SCRIPT -->
    <script>
document.getElementById('editStaffForm').addEventListener('submit', function (event) {
    event.preventDefault();

    // Format first name and last name to Title Case
    const firstNameInput = document.getElementById('editStaffFirstName');
    const lastNameInput = document.getElementById('editStaffLastName');
    firstNameInput.value = toTitleCase(firstNameInput.value);
    lastNameInput.value = toTitleCase(lastNameInput.value);

    const formData = new FormData(this);
    fetch('update_staff.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Staff updated successfully!');
            closeEditFormStaff();

            // Update UI dynamically
            const row = document.querySelector(`input[value='${formData.get("staff_id")}']`).closest('tr');
            row.cells[0].textContent = formData.get("staff_idNum");
            row.cells[1].textContent = formData.get("staff_first_name");
            row.cells[2].textContent = formData.get("staff_last_name");
            row.cells[3].textContent = formData.get("position");
            row.cells[4].textContent = formData.get("phinmaed_email");
            row.cells[5].textContent = formData.get("status") == 1 ? 'Active' : 'Deactivated';
        } else {
            alert('Error updating staff: ' + data.message);
        }
    })
    .catch(error => console.error('Error:', error));
});

function toTitleCase(str) {
    return str.replace(/\w\S*/g, function (txt) {
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    });
}

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.toggle-staff-status-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            event.preventDefault();
            const staffId = this.closest('form').querySelector('input[name="staff_id"]').value;
            const action = this.textContent.trim();
            if (confirmToggleStatus(event, action)) {
                toggleStaffStatus(staffId, action);
            }
        });
    });

    function toggleStaffStatus(staffId, action) {
        fetch('toggle_staff_status.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ staff_id: staffId })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const row = document.querySelector(`input[value='${staffId}']`).closest('tr');
                const statusCell = row.cells[5]; // Status column
                const button = row.querySelector('.toggle-staff-status-btn');
                const icon = button.querySelector('i');

                if (data.new_status === 1) {
                    statusCell.textContent = 'Active';
                    statusCell.classList.add('status-active-staff');
                    statusCell.classList.remove('status-deactivated');
                    button.innerHTML = '<i class="bx bx-user-x"></i> Deactivate';
                    button.classList.remove('activate-btn');
                    button.classList.add('deactivate-btn');
                } else {
                    statusCell.textContent = 'Deactivated';
                    statusCell.classList.add('status-deactivated');
                    statusCell.classList.remove('status-active-staff');
                    button.innerHTML = '<i class="bx bx-user-check"></i> Activate';
                    button.classList.remove('deactivate-btn');
                    button.classList.add('activate-btn');
                }
            } else {
                alert('Error toggling status: ' + data.message);
            }
        })
        .catch(error => console.error('Error:', error));
    }

    function confirmToggleStatus(event, action) {
        if (!confirm(`Are you sure you want to ${action.toLowerCase()} this staff?`)) {
            event.preventDefault();
            return false;
        }
        return true;
    }
});

document.addEventListener('DOMContentLoaded', function() { 
    const staffTableBody = document.getElementById('staffTableBody');
    const staffTableHeaders = document.querySelectorAll('th[data-column5]');

    staffTableHeaders.forEach(header => {
        header.addEventListener('click', function() {
            const column = header.getAttribute('data-column5');
            let order = header.getAttribute('data-order');

            order = order === 'asc' ? 'desc' : 'asc';
            header.setAttribute('data-order', order);

            staff_sortTable(column, order);
        });
    });

    function staff_sortTable(column, order) {
        const rows = Array.from(staffTableBody.querySelectorAll('tr'));
        const columnIndex = staff_getColumnIndex(column);

        rows.sort((a, b) => {
            const cellA = a.cells[columnIndex].textContent.trim().toLowerCase();
            const cellB = b.cells[columnIndex].textContent.trim().toLowerCase();

            if (order === 'asc') {
                return cellA.localeCompare(cellB);
            } else {
                return cellB.localeCompare(cellA);
            }
        });

        rows.forEach(row => staffTableBody.appendChild(row));
    }

    function staff_getColumnIndex(column) {
        const columnOrder = {
            'staff_idNum': 0,
            'staff_first_name': 1,
            'staff_last_name': 2,
            'position': 3,
            'phinmaed_email': 4,
            'status': 5
        };
        return columnOrder[column];
    }
});

function confirmAction() {
    return confirm('Are you sure you want to perform this action?');
}

function editStaff(staffId) {
    // Fetch staff data and populate the form
    fetch(`get_staff.php?staff_id=${staffId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.getElementById('editStaffId').value = data.staff.staff_id;
                document.getElementById('editStaffIdNum').value = data.staff.staff_idNum;
                document.getElementById('editStaffFirstName').value = data.staff.staff_first_name || '';
            document.getElementById('editStaffLastName').value = data.staff.staff_last_name || '';
            document.getElementById('editPosition').value = data.staff.position || '';
                document.getElementById('editphinmaed_email').value = data.staff.phinmaed_email;
                document.getElementById('editStatus').value = data.staff.status;

                console.log("First Name:", document.getElementById('editStaffFirstName').value);
            console.log("Last Name:", document.getElementById('editStaffLastName').value);
            console.log("Position:", document.getElementById('editPosition').value);

                // Set the selected position
                const positionSelect = document.getElementById('editPosition');
                for (let i = 0; i < positionSelect.options.length; i++) {
                    if (positionSelect.options[i].value === data.staff.position) {
                        positionSelect.selectedIndex = i;
                        break;
                    }
                }

                document.getElementById('editStaffContainer').classList.add('active');
                document.querySelector('.container5').classList.add('shifted');
            } else {
                alert('Error fetching staff details: ' + data.message);
            }
        })
        .catch(error => console.error('Error:', error));
}

function closeEditFormStaff() {
    document.getElementById('editStaffContainer').classList.remove('active');
    document.querySelector('.container5').classList.remove('shifted');
}

function filterTable() {
    const searchInput = document.getElementById('search4');
    const positionFilter = document.getElementById('positionFilter');
    const filter = searchInput.value.toLowerCase();
    const position = positionFilter.value.toLowerCase();
    const rows = document.getElementById('staffTableBody').getElementsByTagName('tr');

    Array.from(rows).forEach(row => {
        const staff_idNum = row.cells[0].textContent.toLowerCase();
        const staff_first_name = row.cells[1].textContent.toLowerCase();
        const staff_last_name = row.cells[2].textContent.toLowerCase();
        const position_text = row.cells[3].textContent.toLowerCase();
        const phinmaed_email = row.cells[4].textContent.toLowerCase();

        const matchesSearch = staff_idNum.includes(filter) || staff_first_name.includes(filter) || staff_last_name.includes(filter) || position_text.includes(filter) || phinmaed_email.includes(filter);
        const matchesPosition = position === "" || position_text === position;

        if (matchesSearch && matchesPosition) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

document.getElementById('search4').addEventListener('input', filterTable);
document.getElementById('positionFilter').addEventListener('change', filterTable);

function seeMoreStaff(staffId) {
    fetch(`get_staff_details.php?staff_id=${staffId}`)
        .then(response => response.json())
        .then(data => {
            let content = `
                <table class="staffdetail" style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <th style="text-align: left; padding: 8px;">Staff ID</th>
                        <td style="padding: 8px;">${data.staff.staff_idNum}</td>
                    </tr>
                    <tr>
                        <th style="text-align: left; padding: 8px;">Name</th>
                        <td style="padding: 8px;">${data.staff.staff_first_name} ${data.staff.staff_last_name}</td>
                    </tr>
                    <tr>
                        <th style="text-align: left; padding: 8px;">Position</th>
                        <td style="padding: 8px;">${data.staff.position}</td>
                    </tr>
                    <tr>
                        <th style="text-align: left; padding: 8px;">phinmaed_email</th>
                        <td style="padding: 8px;">${data.staff.phinmaed_email}</td>
                    </tr>
                </table>
                `;

            document.getElementById('floatingTableContent').innerHTML = content;
            document.getElementById('floatingTableContainer').classList.add('active');
        });
}

function closeFloatingTable() {
    document.getElementById('floatingTableContainer').classList.remove('active');
}
</script>
</body>
<?php
ob_end_flush();
?>
</html>

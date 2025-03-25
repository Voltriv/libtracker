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

        <button id="openStaffFormButton" class="add-btn"><i class='bx bxs-user-plus '></i>&nbsp; ADD STAFF</button>

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


    <div id="addStaffForm" class="addstaffform-container">
    <h1>Add Staff</h1>
    <form action="" method="POST" class="modal-content" id="staffForm" enctype="multipart/form-data">
        <input type="text" name="staff_idNum" id="staff_idNum" placeholder="Staff ID" required>
        <input type="text" name="staff_first_name" id="staff_first_name" placeholder="First Name" required>
        <input type="text" name="staff_last_name" id="staff_last_name" placeholder="Last Name" required>
        <select name="position" required>
            <option value="" disabled selected>Select Position</option>
            <option value="Librarian - Periodical Section">Librarian - Periodical Section</option>
            <option value="Librarian - General Circulation Section">Librarian - General Circulation Section</option>
            <option value="Librarian - Law Library">Librarian - Law Library</option>
            <option value="Library Assistant - Dissertation Section">Library Assistant - Dissertation Section</option>
            <option value="Library Assistant - Technical Section">Library Assistant - Technical Section</option>
        </select>
        <input type="email" name="phinmaed_email" id="phinmaed_email" placeholder="Email" required>
        <button type="submit">Add Staff</button>
        <button type="button" id="closeStaffFormButton">Cancel</button>
    </form>
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
        <button type="submit" name="update_staff" class="update-staff-btn">Update</button>
        <button type="button" id="closeEditStaffFormButton" class="close-staff-form">Cancel</button>
    </form>
</div>

    <!-- SCRIPT -->
    <script>

function toTitleCase(str) {
    return str.replace(/\w\S*/g, function (txt) {
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    });
}

document.getElementById('addStaffForm').addEventListener('submit', function (event) {
    event.preventDefault();
    const formData = new FormData(this);

    fetch('add_staff.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Staff added successfully!');
            closeAddFormStaff();

            // Dynamically add new row to the table
            const newRow = document.createElement('tr');
            newRow.dataset.id = data.staff_id;
            newRow.innerHTML = `
                <td>${data.staff_idNum}</td>
                <td>${data.staff_first_name}</td>
                <td>${data.staff_last_name}</td>
                <td>${data.position}</td>
                <td>${data.phinmaed_email}</td>
                <td class='status-active-staff'>Active</td>
                <td>
                    <button class='edit-btn' onclick='editStaff(${data.staff_id})'>Edit</button>
                </td>
            `;
            document.getElementById('staffTableBody').appendChild(newRow);
        } else {
            alert('Error adding staff: ' + data.message);
        }
    })
    .catch(error => console.error('Error:', error));
});

function closeAddFormStaff() {
    document.getElementById('addStaffForm').classList.remove('active');
    document.querySelector('.container5')?.classList.remove('shifted');
    document.getElementById('addStaffForm').reset();
}

// Edit Staff Form Submission
document.getElementById('editStaffForm').addEventListener('submit', function (event) {
    event.preventDefault();

    const firstNameInput = document.getElementById('editStaffFirstName');
    const lastNameInput = document.getElementById('editStaffLastName');
    firstNameInput.value = toTitleCase(firstNameInput.value);
    lastNameInput.value = toTitleCase(lastNameInput.value);

    const formData = new FormData(this);
    const staffId = formData.get('staff_id');

    fetch('update_staff.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            closeEditFormStaff();

            // Dynamically update the row
            const row = document.querySelector(`input[value='${formData.get("staff_id")}']`).closest('tr');
            row.cells[0].textContent = formData.get('staff_idNum');
            row.cells[1].textContent = formData.get('staff_first_name');
            row.cells[2].textContent = formData.get('staff_last_name');
            row.cells[3].textContent = formData.get('position');
            row.cells[4].textContent = formData.get('phinmaed_email');
        } else {
            alert('Error updating staff: ' + data.message);
        }
    })
    .catch(error => console.error('Error:', error));
});




document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.toggle-staff-status-btn').forEach(button => {
        button.addEventListener('click', function (event) {
            event.preventDefault();
            const staffId = this.closest('form').querySelector('input[name="staff_id"]').value;
            const action = this.textContent.trim();
            if (confirmToggleStatus(event, action)) {
                toggleStaffStatus(staffId, action);
                location.reload();

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
        };
        return columnOrder[column];
    }
});

function confirmAction() {
    return confirm('Are you sure you want to perform this action?');
}


// Edit Staff Function
function editStaff(staffId) {
    fetch(`get_staff.php?staff_id=${staffId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Populate form fields
                document.getElementById('editStaffId').value = data.staff.staff_id;
                document.getElementById('editStaffIdNum').value = data.staff.staff_idNum;
                document.getElementById('editStaffFirstName').value = data.staff.staff_first_name;
                document.getElementById('editStaffLastName').value = data.staff.staff_last_name;
                document.getElementById('editphinmaed_email').value = data.staff.phinmaed_email;
                
                // Set the selected position
                const positionSelect = document.getElementById('editPosition');
                for (let i = 0; i < positionSelect.options.length; i++) {
                    if (positionSelect.options[i].value === data.staff.position) {
                        positionSelect.selectedIndex = i;
                        break;
                    }
                }

                // Show the edit form
                document.getElementById('editStaffContainer').classList.add('active');
                document.querySelector('.container5').classList.add('shifted');
                document.querySelector('.header-actions').classList.add('shifted');
            } else {
                alert('Error fetching staff details: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while fetching staff details');
        });
}

// Close Edit Form
function closeEditFormStaff() {
    document.getElementById('editStaffContainer').classList.remove('active');
    document.querySelector('.container5').classList.remove('shifted');
    document.querySelector('.header-actions').classList.remove('shifted');
    document.getElementById('editStaffForm').reset();
}

// Edit Form Submission
document.getElementById('editStaffForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    // Convert names to title case
    const firstNameInput = document.getElementById('editStaffFirstName');
    const lastNameInput = document.getElementById('editStaffLastName');
    firstNameInput.value = toTitleCase(firstNameInput.value);
    lastNameInput.value = toTitleCase(lastNameInput.value);

    const form = this;
    const formData = new FormData(form);
    const staffId = formData.get('staff_id');

    fetch('update_staff.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Staff updated successfully!');
            closeEditFormStaff();
            location.reload();

            
            // Update the table row - improved selector
            const row = document.querySelector(`tr[data-id="${staffId}"]`);
            if (row) {
                // Get the updated values directly from the form elements
                row.cells[0].textContent = document.getElementById('editStaffIdNum').value;
                row.cells[1].textContent = document.getElementById('editStaffFirstName').value;
                row.cells[2].textContent = document.getElementById('editStaffLastName').value;
                row.cells[3].textContent = document.getElementById('editPosition').value;
                row.cells[4].textContent = document.getElementById('editphinmaed_email').value;
            } else {
                console.error('Row not found for staff ID:', staffId);
            }
        } else {
            alert('Error updating staff: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while updating staff');
    });
});

// Close button for edit form
document.getElementById('closeEditStaffFormButton').addEventListener('click', closeEditFormStaff);

// Click outside handling for edit form
document.addEventListener('click', function(event) {
    const editStaffContainer = document.getElementById('editStaffContainer');
    if (editStaffContainer && editStaffContainer.classList.contains('active') && 
        !editStaffContainer.contains(event.target) && 
        !event.target.classList.contains('edit-btn') && 
        !event.target.closest('.edit-btn')) {
        closeEditFormStaff();
    }
});

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




document.addEventListener('DOMContentLoaded', function() {
    const openStaffFormButton = document.getElementById('openStaffFormButton');
    const addStaffForm = document.getElementById('addStaffForm');
    const container5 = document.querySelector('.container5');
    const closeStaffFormButton = document.getElementById('closeStaffFormButton');
    const editStaffContainer = document.getElementById('editStaffContainer');
    const closeEditStaffFormButton = document.getElementById('closeEditStaffFormButton');
    const headerActions = document.querySelector('.header-actions');

    // Open staff form
    openStaffFormButton.addEventListener('click', function() {
        addStaffForm.classList.add('active');
        container5.classList.add('shifted');
        headerActions.classList.add('shifted');
    });


    // Close add staff form
    closeStaffFormButton.addEventListener('click', function() {
        addStaffForm.classList.remove('active');
        container5.classList.remove('shifted');
        headerActions.classList.remove('shifted');
    });

    // Close edit staff form button
    closeEditStaffFormButton.addEventListener('click', function() {
        closeEditFormStaff();
    });
    
    // Enhanced click outside handling
    document.addEventListener('click', function(event) {
        if (!addstaffForm.contains(event.target) && !openStaffFormButton.contains(event.target)) {
            addstaffForm.classList.remove('active');
            container5.classList.remove('shifted');
            headerActions.classList.remove('shifted');
        }
        if (!editStaffContainer.contains(event.target) && !event.target.classList.contains('edit-btn')) {
            editStaffContainer.classList.remove('active');
            container5.classList.remove('shifted');
            headerActions.classList.remove('shifted');
        }
    });

    // Prevent form clicks from closing the form
    addStaffForm.addEventListener('click', function(event) {
        event.stopPropagation();
    });
    
    if (editStaffContainer) {
        editStaffContainer.addEventListener('click', function(event) {
            event.stopPropagation();
        });
    }
});


// Add this script at the bottom of your staff.php file, before the closing </body> tag

document.addEventListener('DOMContentLoaded', function() {
    // Form elements
    const openStaffFormButton = document.getElementById('openStaffFormButton');
    const addStaffForm = document.getElementById('addStaffForm');
    const staffForm = document.getElementById('staffForm');
    const closeStaffFormButton = document.getElementById('closeStaffFormButton');
    const container = document.querySelector('.container5');
    const headerActions = document.querySelector('.header-actions');

    // Open add staff form
    openStaffFormButton.addEventListener('click', function() {
        addStaffForm.classList.add('active');
        container.classList.add('shifted');
        headerActions.classList.add('shifted');
    });

    // Close add staff form
    function closeAddStaffForm() {
        addStaffForm.classList.remove('active');
        container.classList.remove('shifted');
        headerActions.classList.remove('shifted');
        staffForm.reset();
    }

    // Close button handler
    closeStaffFormButton.addEventListener('click', closeAddStaffForm);

    // Handle form submission
    staffForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // Convert names to title case
        const firstNameInput = document.getElementById('staff_first_name');
        const lastNameInput = document.getElementById('staff_last_name');
        firstNameInput.value = toTitleCase(firstNameInput.value);
        lastNameInput.value = toTitleCase(lastNameInput.value);

        // Submit form via AJAX
        const formData = new FormData(staffForm);
        
        fetch('add_staff.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Staff added successfully!');
                closeAddStaffForm();
                
                // Add new staff to table
                const newRow = document.createElement('tr');
                newRow.innerHTML = `
                    <td>${data.staff_idNum}</td>
                    <td>${data.staff_first_name}</td>
                    <td>${data.staff_last_name}</td>
                    <td>${data.position}</td>
                    <td>${data.phinmaed_email}</td>
                    <td class="status-active-staff">Active</td>
                    <td>
                        <form method="POST" class="toggle-status-form">
                            <input type="hidden" name="staff_id" value="${data.staff_id}">
                            <div class="actions_button">
                                <button type="submit" name="toggle_staff_status" class="toggle-staff-status-btn deactivate-btn" onclick="return confirmToggleStatus(event, 'Deactivate')">
                                    <i class="bx bx-user-x"></i> Deactivate
                                </button>
                                <button type="button" class="edit-btn" onclick="editStaff(${data.staff_id})">
                                    <i class="bx bx-edit"></i>
                                </button>
                            </div>
                        </form>
                    </td>
                `;
                document.getElementById('staffTableBody').prepend(newRow);
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while adding staff');
        });
    });

    // Close form when clicking outside
    document.addEventListener('click', function(event) {
        if (addStaffForm.classList.contains('active') && 
            !addStaffForm.contains(event.target) && 
            !openStaffFormButton.contains(event.target)) {
            closeAddStaffForm();
        }
    });

    // Prevent form clicks from closing the form
    addStaffForm.addEventListener('click', function(event) {
        event.stopPropagation();
    });

});


</script>
</body>
<?php
ob_end_flush();
?>
</html>

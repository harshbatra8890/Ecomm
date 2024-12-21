<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.User" %>
<html>
<head>
    <title>All Retailer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #FF9874; 
        }

        .search-bar-container {
            text-align: center;
            margin: 20px 0;
        }

        .search-bar {
            padding: 10px;
            width: 50%; /* Adjust width */
            max-width: 400px; /* Max width for larger screens */
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            background-color: white;
        }

        th {
            background-color: #295F98; 
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .back-button {
            display: block;
            width: 200px;
            margin: 20px auto;
            text-align: center;
            padding: 10px;
            background-color: #295F98;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            position: absolute; /* Positioning */
            top: 20px; /* Distance from top */
            right: 20px; /* Distance from right */
        }

        .back-button:hover {
            background-color: #1a3a6e;
        }

        .no-customers {
            text-align: center;
            color: #555;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <a href="/superAdmin/dashboard" class="back-button">Back to Dashboard</a> <!-- Positioned at top right -->
    
    <h2>Retailer List</h2>

    <!-- Centered Search Bar -->
    <div class="search-bar-container">
        <input type="text" id="filter" class="search-bar" placeholder="Search by name or email..." />
    </div>

    <%
        List<User> subadmins = (List<User>) request.getAttribute("subadmins");
        if (subadmins != null && !subadmins.isEmpty()) {
    %>
        <table id="subadmin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Mobile No</th>
                    <th>Date of Birth</th>
                    <th>Username</th>
                </tr>
            </thead>
            <tbody>
                <% for (User subadmin : subadmins) { %>
                    <tr class="subadmin-row" data-name="<%= subadmin.getFirstName().toLowerCase() + " " + subadmin.getLastName().toLowerCase() %>" data-email="<%= subadmin.getEmailId().toLowerCase() %>">
                        <td><%=  subadmin.getUserId() %></td>
                        <td><%= subadmin.getFirstName() %></td>
                        <td><%= subadmin.getLastName() %></td>
                        <td><%= subadmin.getEmailId() %></td>
                        <td><%= subadmin.getMobileNo() %></td>
                        <td><%= subadmin.getDateOfBirth() != null ?  subadmin.getDateOfBirth().toString() : "N/A" %></td>
                        <td><%=  subadmin.getUsername() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p class="no-customers">No customers found.</p>
    <% } %>

    <script>
        function filterSubAdmins() {
            const filterValue = document.getElementById('filter').value.toLowerCase();
            const rows = document.querySelectorAll('.subadmin-row');

            rows.forEach(row => {
                const name = row.dataset.name;
                const email = row.dataset.email;
                const isMatch = name.includes(filterValue) || email.includes(filterValue);
                row.style.display = isMatch ? '' : 'none';
            });
        }

        document.getElementById('filter').addEventListener('input', filterSubAdmins);
    </script>
</body>
</html>

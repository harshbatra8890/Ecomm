<%@ page import="java.util.List"%>
<%@ page import="ecom.app.entities.User"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Requests</title>
    <style>
        body {
            background-color: #F2EED7; /* Soft background */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1, h3 {
            color: #FF9874; /* Soft orange */
            text-align: left;
            margin-bottom: 30px;
        }

        .back-button {
            background-color: #295F98; /* Dark blue */
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            position: absolute;
            top: 20px;
            right: 20px;
            text-decoration: none; /* Remove underline */
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #1a3a6e; /* Darker blue */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px; /* Add margin for spacing */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #295F98; /* Dark blue */
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9; /* Light background for even rows */
        }

        tr:hover {
            background-color: #f1f1f1; /* Light gray on hover */
        }

        button {
            background-color: #295F98; /* Dark blue */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #1a3a6e; /* Darker blue on hover */
        }

        .no-requests {
            text-align: center;
            color: #555;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <a href="/superAdmin/dashboard" class="back-button">Back to Dashboard</a>
    
    <h1>Manage Requests</h1>
    <h3>Manage Pending Retailer Requests</h3>

    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            List<User> userList = (List<User>) request.getAttribute("userList");
            if (userList != null && !userList.isEmpty()) {
                for (User user : userList) {
            %>
            <tr>
                <td><%=user.getUserId()%></td>
                <td><%=user.getFirstName()%></td>
                <td><%=user.getLastName()%></td>
                <td><%=user.getEmailId()%></td>
                <td>
                    <form action="${pageContext.request.contextPath}/superAdmin/approveUser" method="post" style="display: inline;">
                        <input type="hidden" name="userId" value="<%=user.getUserId()%>" />
                        <button type="submit">Approve</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/superAdmin/deleteUser" method="post" style="display: inline;">
                        <input type="hidden" name="userId" value="<%=user.getUserId()%>" />
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="no-requests">No pending retailer requests found.</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>

    <h3>Manage Inactive Retailer Requests</h3>

    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            List<User> inactiveUserList = (List<User>) request.getAttribute("inactiveUserList");
            if (inactiveUserList != null && !inactiveUserList.isEmpty()) {
                for (User user : inactiveUserList) {
            %>
            <tr>
                <td><%=user.getUserId()%></td>
                <td><%=user.getFirstName()%></td>
                <td><%=user.getLastName()%></td>
                <td><%=user.getEmailId()%></td>
                <td>
                    <form action="${pageContext.request.contextPath}/superAdmin/approveUser" method="post" style="display: inline;">
                        <input type="hidden" name="userId" value="<%=user.getUserId()%>" />
                        <button type="submit">Activate</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="no-requests">No inactive retailer requests found.</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>

    <h3>Active Retailers</h3>

    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            List<User> activeUserList = (List<User>) request.getAttribute("activeUserList");
            if (activeUserList != null && !activeUserList.isEmpty()) {
                for (User user : activeUserList) {
            %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getFirstName() %></td>
                <td><%= user.getLastName() %></td>
                <td><%= user.getEmailId() %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/superAdmin/deleteUser" method="post" style="display:inline;">
                        <input type="hidden" name="userId" value="<%= user.getUserId() %>"/>
                        <button type="submit">Revoke Access</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="no-requests">No active retailer found.</td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
</body>
</html>

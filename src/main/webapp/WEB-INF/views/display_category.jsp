<%@ page contentType="text/html;charset=UTF-8" language="java" %>  
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.Category" %>
<html>
<head>
    <title>View All Categories</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EEDE;
            margin: 0;
            padding: 20px;
        }
 
        h1 {
            text-align: center;
            color: #295F98;
        }
 
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
 
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
 
        th {
            background-color: #295F98;
            color: white;
        }
 
        img {
            width: 100px; /* Increased width */
            height: auto; /* Maintain aspect ratio */
            border-radius: 4px; /* Optional: rounded corners */
        }
 
        tr:hover {
            background-color: #f1f1f1; /* Highlight row on hover */
        }
 
        .back-button {
            display: block;
            width: 150px; /* Width of the button */
            margin: 20px auto; /* Center the button */
            padding: 10px;
            text-align: center;
            background-color: #295F98; /* Button background color */
            color: white; /* Text color */
            text-decoration: none; /* Remove underline */
            border-radius: 4px; /* Rounded corners */
            transition: background-color 0.3s; /* Transition effect */
        }
 
        .back-button:hover {
            background-color: #1a3a6d; /* Darker color on hover */
        }
    </style>
</head>
<body>
    <h1>View All Categories</h1>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Category Name</th>
                <th>Image</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Category> categoryList = (List<Category>) request.getAttribute("categories");
                for (Category category : categoryList) {
            %>
                <tr>
                    <td><%= category.getCategory_id() %></td> <!-- Display Category ID -->
                    <td><%= category.getCategory_name() %></td> <!-- Display Category Name -->
                    <td>
                        <img src="data:image/jpeg;base64,<%= category.getBase64CategoryImage() %>" alt="<%= category.getCategory_name() %>">
                    </td> <!-- Display Category Image -->
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <a class="back-button" href="${pageContext.request.contextPath}/superAdmin/dashboard">Back to Dashboard</a>
</body>
</html>
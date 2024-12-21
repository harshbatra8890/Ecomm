<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.Order" %>
 
<html>
<head>
    <title>Order Commissions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EEDE; /* Light beige background */
            margin: 0;
            padding: 20px;
        }
 
        h2 {
            text-align: center;
            color: #295F98; /* Dark blue color */
        }
 
        form {
            margin-bottom: 20px;
            text-align: center;
        }
 
        label {
            margin-right: 10px;
            font-weight: bold;
            color: #295F98; /* Dark blue for labels */
        }
 
        input[type="date"] {
            padding: 5px;
            margin-right: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
 
        input[type="submit"] {
            background-color: #295F98; /* Dark blue for the button */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
 
        input[type="submit"]:hover {
            background-color: #1a3a6d; /* Darker blue on hover */
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
            background-color: #295F98; /* Dark blue header */
            color: white;
        }
 
        tr:hover {
            background-color: #f1f1f1; /* Highlight row on hover */
        }
 
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
 
        h3 {
            margin-top: 20px;
            text-align: center;
            color: #295F98; /* Dark blue */
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

    </style>
</head>
<body>
    <h2>Order Commissions</h2>
    
        <a href="/superAdmin/dashboard" class="back-button">Back to Dashboard</a>
    
    <form action="/superAdmin/commissions/getCommissionsData" method="post">
        <label for="startDate">Start Date:</label>
        <input type="date" id="startDate" name="startDate" required>
        
        <label for="endDate">End Date:</label>
        <input type="date" id="endDate" name="endDate" required>
        
        <input type="submit" value="Filter">
    </form>
 
    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>User ID</th>
                <th>Total Amount</th>
                <th>Commission (1%)</th>
                <th>Payment Method</th>
                <th>Order Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Order> orders = (List<Order>) request.getAttribute("orders");
                for (Order order : orders) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getUserId() %></td>
                    <td><%= order.getTotalAmount() %></td>
                    <td><%= order.getTotalAmount() * 0.01 %></td> <!-- Calculate commission directly -->
                    <td><%= order.getPaymentMethod() %></td>
                    <td><%= order.getOrderDate() %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
 
    <%
        Double totalCommissions = (Double) request.getAttribute("totalCommissions");
        if (totalCommissions != null) {
    %>
        <h3>Total Commissions: <%= totalCommissions %></h3>
    <%
        }
    %>
 
</body>
</html>
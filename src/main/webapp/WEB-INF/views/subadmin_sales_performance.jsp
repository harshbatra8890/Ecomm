<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ecom.app.entities.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Retailer Sales Performance</title>
    <!-- Styles -->
     <style>
		body {
		    background-color: #F2EED7; /* Soft background color */
		    font-family: 'Arial', sans-serif;
		    padding: 40px; /* Increased padding for better layout */
		}

		.report-container {
		    background: linear-gradient(135deg, #ffffff, #f9f9f9); /* Subtle gradient */
		    border-radius: 20px; /* More rounded corners */
		    padding: 30px;
		    margin: 0 auto;
		    max-width: 800px; /* Wider container */
		    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2); /* Deeper shadow */
		    transition: transform 0.3s ease; /* Smooth scale effect */
		}

		.report-container:hover {
		    transform: scale(1.02); /* Slight zoom effect on hover */
		}

		h2 {
		    color: #FF9874; /* Soft orange */
		    margin-bottom: 30px;
		    text-align: center;
		    font-size: 28px; /* Increased font size */
		    text-transform: uppercase; /* Uppercase for emphasis */
		}

		.form-group {
		    margin-bottom: 20px; /* Spacing between form groups */
		}

		label {
		    display: block; /* Block display for labels */
		    margin-bottom: 8px; /* Space below labels */
		    color: #295F98; /* Dark blue for labels */
		    font-weight: bold; /* Bold labels */
		}

		input[type="date"] {
		    width: 97%; /* Full width */
		    padding: 12px; /* Padding for inputs */
		    border: 1px solid #ccc; /* Light border */
		    border-radius: 5px; /* Rounded edges */
		    transition: border-color 0.3s; /* Smooth transition */
		}

		input[type="date"]:focus {
		    border-color: #FF9874; /* Highlight border on focus */
		    outline: none; /* Remove outline */
		}

		.btn-submit {
		    background-color: #295F98; /* Dark blue */
		    border: none; /* No border */
		    color: white; /* White text */
		    font-size: 18px; /* Larger font size */
		    width: 20%;
		    border-radius: 5px;
		    padding: 12px; /* Padding for a better click area */
		    cursor: pointer;
		    transition: background-color 0.3s, transform 0.2s; /* Smooth transitions */
		}

		.btn-submit:hover {
		    background-color: #1a3a6e; /* Darker blue on hover */
		    transform: translateY(-2px); /* Lift effect */
		}

		table {
		    width: 100%;
		    border-collapse: collapse; /* Removes gaps between cells */
		    margin-top: 30px; /* Space above the table */
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Shadow for table */
		}

		th, td {
		    padding: 15px; /* More padding for cells */
		    text-align: left;
		    border-bottom: 2px solid #ddd; /* Bottom border for cells */
		}

		th {
		    background-color: #295F98; /* Dark blue for header */
		    color: white; /* White text */
		    font-weight: bold; /* Bold text for header */
		    text-transform: uppercase; /* Uppercase for header */
		}

		tbody tr {
		    transition: background-color 0.3s; /* Smooth transition for row hover */
		}

		tbody tr:hover {
		    background-color: #FFFCF2; /* Soft highlight color on row hover */
		}

		td {
		    color: #333; /* Dark text color */
		}

		.footer {
		    text-align: center;
		    margin-top: 40px; /* Space above footer */
		    font-size: 14px;
		    color: #295F98; /* Dark blue text */
		    padding: 10px; /* Padding for the footer */
		    border-top: 1px solid #ddd; /* Light grey top border */
		}
		
		.btn-back {
		            background-color: #295F98; /* Dark blue */
		            border: none;
		            color: white; /* White text */
		            font-size: 16px; /* Font size */
		            border-radius: 5px; /* Rounded edges */
		            padding: 10px 15px; /* Padding for button */
		            cursor: pointer;
		            position: absolute; /* Absolute positioning */
		            top: 20px; /* Distance from the top */
		            right: 40px; /* Distance from the right */
		            transition: background-color 0.3s; /* Smooth transition */
		        }
 
		        .btn-back:hover {
		            background-color: #1a3a6e; /* Darker blue on hover */
		        }

	
    </style>
</head>
<body>

<button class="btn-back" onclick="window.location.href='/subadmin'">Back to Dashboard</button>
    <div class="report-container">
        <h2>Retailer Sales Performance Report</h2>

        <form action="/user/salesPerformance/subAdmin/${subAdminId}/getSalesData" method="post">
            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <input type="date" name="startDate" id="startDate" required 
                       value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">
            </div>
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <input type="date" name="endDate" id="endDate" required 
                       value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">
            </div>
            <button type="submit" class="btn-submit">Get Sales Data</button>
        </form>

        <%
            List<Order> salesData = (List<Order>) request.getAttribute("orders");
            Double totalSales = (Double) request.getAttribute("totalSales");
        %>

        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Total Amount</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Order Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (salesData != null && !salesData.isEmpty()) {
                        for (Order order : salesData) {
                %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getUserId() %></td>
                        <td><%= order.getTotalAmount() %></td>
                        <td><%= order.getPaymentMethod() %></td>
                        <td><%= order.getStatus() %></td>
                        <td><%= order.getOrderDate().toLocalDate() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6">No sales data found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <%
            if (totalSales != null) {
        %>
        <h3>Total Sales: <%= totalSales %></h3>
        <%
            }
        %>
    </div>

   

</body>
</html>

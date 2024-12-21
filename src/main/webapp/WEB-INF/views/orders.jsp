<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.Order" %>
<%@ page import="ecom.app.entities.CartItems" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <style>
		body {
		    background-color: #F2EED7; /* Soft background */
		    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		    margin: 0;
		    padding: 40px;
		}

		.orders-container {
		    margin: 20px auto;
		    max-width: 800px;
		    padding: 20px;
		    background-color: white;
		    border-radius: 10px;
		    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
		}

		h1 {
		    color: #FF9874; /* Soft orange for headings */
		    margin-bottom: 30px;
		    text-align: center;
		    font-size: 2.5em;
		    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.1);
		}

		.order {
		    border: 1px solid #ddd;
		    border-radius: 10px;
		    padding: 15px;
		    margin-bottom: 20px;
		    background-color: #f9f9f9;
		    transition: transform 0.2s, box-shadow 0.2s;
		}

		.order:hover {
		    transform: translateY(-5px);
		    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
		}

		.order h2 {
		    color: #295F98; /* Dark blue for order titles */
		    font-size: 1.5em;
		}

		.order-item {
		    padding: 10px;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		    margin-top: 10px;
		    background-color: #fff;
		    transition: background-color 0.2s;
		}

		.order-item:hover {
		    background-color: #f1f1f1; /* Light gray on hover */
		}

		.order-total {
		    font-weight: bold;
		    margin-top: 10px;
		    color: #295F98; /* Dark blue for total */
		    font-size: 1.2em;
		}

		.message, .error {
		    margin: 15px 0;
		    text-align: center;
		    padding: 10px;
		    border-radius: 5px;
		}

		.error {
		    color: 	#ff0000;
		    background-color: #d9534f; /* Bootstrap danger color */
		}

		.message {
		    color: 	#ff0000;
		    background-color: #5cb85c; /* Bootstrap success color */
		}
		
		.back-button {
            position: absolute; /* Position it in the top right */
            right: 20px;
            top: 20px;
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            background-color: #295F98; /* Soft orange */
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #1a3a6e; /* Darker orange on hover */
        }
		

    </style>
</head>
<body>

<%
    // Display messages from RedirectAttributes
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");

    if (error != null) {
%>
        <div class="error"><%= error %></div>
<%
    }
    if (message != null) {
%>
        <div class="message"><%= message %></div>
<%
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders"); // Retrieve orders from request
%>

<div class="orders-container">
    <h1>My Orders</h1>
        <a href="/homepageuser" class="back-button">Back to Dashboard</a>


<%
    if (orders != null && !orders.isEmpty()) {
        for (Order order : orders) {
%>
            <div class="order">
                <h2>Order #<%= order.getOrderId() %></h2>
                <p>Date: <%= order.getOrderDate() %></p>
                <%
                    List<CartItems> orderItems = order.getOrderItems();
                    for (CartItems item : orderItems) {
                %>
                    <div class="order-item">
                        <div class="item-details">
                            <h3><%= item.getProductName() %></h3>
                            <p>Price: ₹<%= item.getPrice() %></p>
                            <p>Quantity: <%= item.getQuantity() %></p>
                        </div>
                    </div>
                <%
                    }
                %>
                <div class="order-total">
                    Total: ₹<%= order.getTotalAmount() %>
                </div>
            </div>
<%
        }
    } else {
%>
        <p>You have no orders yet.</p>
<%
    }
%>
</div>

</body>
</html>
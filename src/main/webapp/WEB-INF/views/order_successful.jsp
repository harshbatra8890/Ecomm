<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e0f7fa; /* Light background */
            text-align: center;
            padding: 50px;
        }
        h1 {
            color: #00796b; /* Teal color */
            margin-bottom: 20px;
        }
        .success-message {
            font-size: 1.5em;
            margin-bottom: 30px;
        }
        img {
            max-width: 500px; 
            height: auto;
        }
        .back-button {
            position: absolute; /* Position it at the top left */
            top: 20px;
            left: 20px;
            background-color: #295F98; /* Dark blue */
            color: white; /* Text color */
            border: none; /* No border */
            padding: 10px 15px; /* Padding for the button */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Pointer on hover */
            transition: background-color 0.3s; /* Smooth background transition */
        }
        .back-button:hover {
            background-color: #1a3a6e; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/homepageuser'">Back to Dashboard</button>
    <h1>Order Successful!</h1>
    <div class="success-message">
        Thank you for your order! Your products will be delivered soon.
    </div>
    <img src="${pageContext.request.contextPath}/assets/ordersuccess.png" alt="Delivery Scooter">
</body>
</html>

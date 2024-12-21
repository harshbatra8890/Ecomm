<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            background-color: #F2EED7; 
            color: #295F98; 
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative; /* Added for button positioning */
        }

        .container {
            background-color: #FFFFFF; 
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 300px;
            text-align: left;
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #FF9874;
        }

        .form-group {
            margin-bottom: 15px;
            margin-right: 20px;
        }

        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 10px;
            border: 2px solid #295F98; 
            border-radius: 5px;
            background-color: white;
            color: #295F98; 
            transition: background-color 0.3s, border-color 0.3s;
        }

        input[type="text"]:hover, input[type="password"]:hover, select:hover {
            background-color: #e0f0e0; 
            border-color: #1a3a6e; 
        }

        .form-group:last-child {
            margin-bottom: 30px;
        }

        .login-button {
            background-color: #295F98; 
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%; 
            font-size: 16px;
            margin-top: 20px; 
        }

        .login-button:hover {
            background-color: #1a3a6e; 
        }

        .register-link {
            margin-top: 15px;
            text-align: center;
        }

        .register-link a {
            color: #FF9874;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
            color: #d9745e; 
        }

        .role-select select {
            width: 110%; 
            padding: 10px; 
            font-size: 16px; 
            border: 2px solid #295F98; 
            border-radius: 5px;
            background-color: white;
            color: #295F98; 
            transition: background-color 0.3s, border-color 0.3s;
        }

        .role-select select:hover {
            background-color: #e0f0e0; 
            border-color: #1a3a6e; 
        }

       
        .back-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #295F98;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #1a3a6e;
        }
    </style>
</head>
<body>
    <button class="back-button" onclick="window.location.href='/'">Back to home</button>
    <div class="container">
        <h2>Login</h2>
        
        <form action="/user/login" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group role-select">
                <label for="role">Select Role:</label>
                <select id="role" name="role">
                    <option value="">Select a role</option>
                    <option value="customer">Customer</option>
                    <option value="retailer">Retailer</option>
                </select>
            </div>
            <div>
                <button type="submit" class="login-button">Login</button>
            </div>
        </form>
        
        <p class="register-link">Don't have an account? <a href="/user/openRegistrationPage">Register here</a></p>
        <p class="register-link">Forgot Password? <a href="/user/forgotpassword1">Click here</a></p>
        
        <%@include file="message.jsp" %>
    </div>
</body>
</html>

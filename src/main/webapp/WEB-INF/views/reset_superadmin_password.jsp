<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="../css/styles.css" rel="stylesheet"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 90%;
            max-width: 500px;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #FF9874;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #295F98;
        }
        input {
            width: 95%;
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid #295F98; /* Border color */
            border-radius: 4px;
        }
        input::placeholder {
            color: #aaa; /* Placeholder text color */
        }
        .button-group {
            display: flex;
            justify-content: space-between;
        }
        button {
            width: 48%;
            padding: 10px;
            background-color: #295F98;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #1a3a6e;
        }
        .back-button {
            background-color: #295F98;
        }
        .back-button:hover {
            background-color: #1a3a6e;
        }
        .success, .error {
            text-align: center;
            margin-top: 20px;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
        .alert {
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reset Password</h1>
        <form method="POST" action="/superAdmin/resetPassword">
            <div>
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" required placeholder="Enter your username"/>
            </div>
            <div>
                <label for="newPassword">New Password:</label>
                <input type="password" name="newPassword" id="newPassword" required placeholder="Enter new password"/>
            </div>
            <div>
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" name="confirmPassword" id="confirmPassword" required placeholder="Confirm new password"/>
            </div>
            <div class="button-group">
                <button type="submit">Reset Password</button>
                <button type="button" class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/superAdmin/dashboard'">Back to Dashboard</button>
            </div>
        </form>

        <c:if test="${not empty message}">
            <div class="alert success">
                ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert error">
                ${error}
            </div>
        </c:if>
    </div>
</body>
</html>

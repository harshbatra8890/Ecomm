<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7; 
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(41, 95, 152, 0.5); 
            width: 300px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #FF9874; 
        }
        .input-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #295F98; 
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #295F98;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #295F98;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #1a3a6e;
        }
        .error {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Password</h2>

        <% if (request.getAttribute("error1") != null) { %>
            <div class="error"><%= request.getAttribute("error1") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/superAdmin/resetpassword" method="post">
            <input type="hidden" name="email" value="${email}" />
            <div class="input-group">
                <label for="newPassword"><b>New Password</b></label>
                <input type="password" id="newPassword" name="newPassword" required placeholder="Enter new password">
            </div>
            <div class="input-group">
                <label for="confirmPassword"><b>Confirm Password</b></label>
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm new password">
            </div>
            <button type="submit">Reset Password</button>
        </form>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - Enter Email</title>
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

        .login-container {
            color: #295F98; 
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(41, 95, 152, 0.5); 
            width: 300px;
            text-align: center;
            background-color: #FFFFFF; 
        }

        h2 {
            margin-bottom: 20px;
            color: #FF9874; 
        }

        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 5px;
            color: #295F98;
        }

        .input-group input {
            width: 100%;
            padding: 8px;
            border: 2px solid #295F98; 
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #295F98; 
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
			margin-top:20px;
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
    <div class="login-container">
        <h2>Forgot Password?</h2>

   

       <form action="${pageContext.request.contextPath}/user/verifyemail" method="post">
    <div>
        <label for="email">Enter your email:</label>
        <input type="email" id="email" name="email" required placeholder="example@gmail.com">
    </div>
    <button type="submit">Verify Email</button>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
</form>

    </div>
</body>
</html>

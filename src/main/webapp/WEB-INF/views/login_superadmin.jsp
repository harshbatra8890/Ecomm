<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7; 
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 85vh; 
            padding-top: 80px; 
        }

        .navbar {
            background-color: #295F98; 
            color: white;
            padding: 30px;
            text-align: center;
            position: fixed; 
            top: 0;
            width: 100%; 
            z-index: 1000; 
        }

        .navbar h1 {
            margin: 0; 
            font-size: 24px; 
        }

        .back-button {
            width: 320px; /* Same width as the login-container */
            background-color: #295F98;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
            text-align: center;
        }

        .back-button:hover {
            background-color: #1a3a6e;
        }

        .login-container {
            color: #295F98; 
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(41, 95, 152, 0.5); 
            width: 320px;
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
            margin-right: 20px;
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
            background-color: #FFF; 
            color: #295F98; 
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
            margin-top: 15px;
        }

        button:hover {
            background-color: #1a3a6e; 
        }

        .reset_password a,
        .register_link a {
            color: #FF9874; 
            text-decoration: none;
            transition: color 0.3s;
        }

        .reset_password a:hover,
        .register_link a:hover {
            color: #d9745e; 
            text-decoration: underline;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="navbar">
        <h1>Owner Login</h1>
    </div>
   
    <div class="login-container">
        <h2>Login</h2>

        <div class="error">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
        </div>

        <form action="/superAdmin/login" method="post" autocomplete="off">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autocomplete="off">
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required autocomplete="off">
            </div>
            <button type="submit">Login</button>
        </form>
        <p class="reset_password">Forgot Password? <a href="/superAdmin/forgotpassword">Click here</a></p>
    </div>

    <button class="back-button" onclick="window.location.href='/'">Back to Home</button>

</body>
</html>

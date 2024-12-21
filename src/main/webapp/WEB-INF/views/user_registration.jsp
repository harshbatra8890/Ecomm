<%@page import="ecom.app.entities.Role"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Page</title>
    <script>
        function validateFirstName() {
            const firstName = document.getElementById('firstname');
            if (firstName.value.length < 3 || firstName.value.length > 20 || !/^[A-Za-z]+$/.test(firstName.value)) {
                document.getElementById('firstNameError').textContent = 'First Name must be 3-20 characters long and contain only alphabets.';
            } else {
                document.getElementById('firstNameError').textContent = '';
            }
        }

        function validateLastName() {
            const lastName = document.getElementById('lastname');
            if (lastName.value.length < 3 || lastName.value.length > 20 || !/^[A-Za-z]+$/.test(lastName.value)) {
                document.getElementById('lastNameError').textContent = 'Last Name must be 3-20 characters long and contain only alphabets.';
            } else {
                document.getElementById('lastNameError').textContent = '';
            }
        }

        function validateMobileNo() {
	           const mobileNo = document.getElementById('mobileNo');
	           const mobilePattern = /^[6-9]\d{9}$/;  // Regex for mobile starting with 6-9 and exactly 10 digits

	           if (!mobilePattern.test(mobileNo.value)) {
	               document.getElementById('mobileError').textContent = 'Mobile Number must start with 6, 7, 8, or 9 and should be exactly 10 digits.';
	           } else {
	               document.getElementById('mobileError').textContent = '';
	           }
	       }

<<<<<<< HEAD
=======

>>>>>>> 010b90837201d30d0f501ddf6f4ce75c5c278560
        function validateEmail() {
            const email = document.getElementById('email');
            const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
            if (!emailRegex.test(email.value)) {
                document.getElementById('emailError').textContent = 'Email must be a valid format.';
            } else {
                document.getElementById('emailError').textContent = '';
            }
        }

        function validateDOB() {
            const dob = document.getElementById('dob');
            const birthDate = new Date(dob.value);
            const today = new Date();
            const age = today.getFullYear() - birthDate.getFullYear();
            const m = today.getMonth() - birthDate.getMonth();

            if (age < 13 || (age === 13 && m < 0)) {
                document.getElementById('dobError').textContent = 'You must be at least 13 years old.';
            } else if (age > 100 || (age === 100 && m > 0)) {
                document.getElementById('dobError').textContent = 'You must be at most 100 years old.';
            } else {
                document.getElementById('dobError').textContent = '';
            }
        }

        function validateUsername() {
            const username = document.getElementById('username');
            if (username.value.length < 7 || username.value.length > 15 || !/^[A-Za-z0-9]+$/.test(username.value)) {
                document.getElementById('usernameError').textContent = 'Username must be 7-15 characters long and can contain only alphabets and numbers.';
            } else {
                document.getElementById('usernameError').textContent = '';
            }
        }

        function validatePassword() {
            const password = document.getElementById('password');
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$/;
            if (!passwordRegex.test(password.value)) {
                document.getElementById('passwordError').textContent = 'Password must be 8-15 characters long and include at least one letter, one number, and one special character.';
            } else {
                document.getElementById('passwordError').textContent = '';
            }
        }

        function validateProfileImage() {
            const profileImage = document.getElementById('profileImage');
            const validExtensions = /(.jpg|.jpeg|.png)$/i;
            if (!validExtensions.exec(profileImage.value)) {
                document.getElementById('imageError').textContent = 'Profile image must be in .jpg, .jpeg, or .png format.';
            } else {
                document.getElementById('imageError').textContent = '';
            }
        }
    </script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #F2EED7;
            color: #295F98;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            overflow-y: auto;
        }

        .container {
            background-color: #FFFFFF;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 370px;
            text-align: left;
            display: flex;
            flex-direction: column;
            height: 600px;
        }

        h2 {
            margin-bottom: 15px;
            text-align: center;
            color: #FF9874;
        }

        .form-group {
            margin-bottom: 10px;
            margin-right: 20px;
        }

        input[type="text"],
        input[type="tel"],
        input[type="email"],
        input[type="date"],
        input[type="password"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            border: 2px solid #295F98;
            border-radius: 5px;
            background-color: white;
            color: black;
        }

        .error-message {
            color: red;
            font-size: 12px;
        }

        .radio-group {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            margin-top: 15px;
        }

        .radio-group label {
            display: flex;
            align-items: center;
            margin: 0 10px;
            cursor: pointer;
        }

        input[type="radio"] {
            appearance: none;
            width: 20px;
            height: 20px;
            border: 2px solid #295F98;
            border-radius: 50%;
            outline: none;
            cursor: pointer;
            margin-right: 5px;
            transition: background-color 0.3s, border-color 0.3s;
        }

        input[type="radio"]:checked {
            background-color: #295F98;
            border-color: #1a3a6e;
        }

        input[type="radio"]:hover {
            border-color: #1a3a6e;
        }

        .register-button {
            background-color: #295F98;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .register-button:hover {
            background-color: #1a3a6e;
        }
    </style>
</head>
<body>
    <%
        List<Role> rolesList = (List<Role>) request.getAttribute("listOfRoles");
    %>

    <div class="container">
        <h2>Registration</h2>
        <form action="/user/register" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstname" name="firstName" required oninput="validateFirstName()">
                <div id="firstNameError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastname" name="lastName" required oninput="validateLastName()">
                <div id="lastNameError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="mobile">Mobile No:</label>
                <input type="tel" id="mobileNo" name="mobileNo" required oninput="validateMobileNo()">
                <div id="mobileError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="emailId" required oninput="validateEmail()">
                <div id="emailError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dateOfBirth" required oninput="validateDOB()">
                <div id="dobError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required oninput="validateUsername()">
                <div id="usernameError" class="error-message"></div>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required oninput="validatePassword()">
                <div id="passwordError" class="error-message"></div>
            </div>
            <div class="file-input-group">
                <label for="profileImage">Profile Image:</label>
                <input type="file" id="profileImage" name="profileImage" accept=".jpg, .jpeg, .png" required onchange="validateProfileImage()">
                <div id="imageError" class="error-message"></div>
            </div>
            <div class="radio-group">
                <label>Select Role:</label>
                <% for (Role role : rolesList) { %>
                    <label>
                        <input type="radio" name="roleId" value="<%=role.getRoleId()%>" required />
                        <%= role.getRoleName() %>
                    </label>
                <% } %>
            </div>
            <button type="submit" class="register-button">Register</button>
            <%@include file="message.jsp" %>
        </form>
    </div>
</body>
</html>
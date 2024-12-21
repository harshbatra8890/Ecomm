<%@page import="ecom.app.entities.SuperAdmin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@page import="java.util.List"%>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner Profile</title>
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
	            position: relative; /* Allow positioning of button */
	        }
	        h1 {
	            text-align: center;
	            margin-top: 20px;
	            color: #FF9874;
	        }
	        .back-button {
	            background-color: #295F98; /* Dark blue */
	            color: white;
	            border: none;
	            padding: 10px 15px;
	            border-radius: 5px;
	            cursor: pointer;
	            position: absolute;
	            top: 20px;
	            right: 20px;
	            text-decoration: none; /* Remove underline */
	            transition: background-color 0.3s;
	        }
	        .back-button:hover {
	            background-color: #1a3a6e; /* Darker blue */
	        }
	        .container {
	            width: 100%;
	            max-width: 480px;
	            height: auto;
	            background: white;
	            padding: 20px;
	            border-radius: 8px;
	            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	            display: flex;
	            flex-direction: column;
	            align-items: left;
	            justify-content: center;
	            margin-top: 50px;
	        }
	        table {
	            width: 100%;
	            margin-top: 20px;
	        }
	        td {
	            padding: 10px;
	            vertical-align: top;
	        }
	        .form-group {
	            margin-bottom: 15px;
	            width: 100%;
	            margin-right: 20px;
	        }
	        label {
	            font-weight: bold;
	            color: #295F98;
	        }
	        input[type="text"],
	        input[type="email"] {
	            width: 93%;
	            padding: 10px;
	            border: 2px solid #295F98;
	            border-radius: 4px;
	            color: black;
	        }
	        button {
	            width: 94%;
	            padding: 10px;
	            background-color: #295F98;
	            color: white;
	            border: none;
	            border-radius: 4px;
	            cursor: pointer;
	            font-size: 16px;
	            transition: background-color 0.3s;
	            margin-top: 20px;
	            margin-left: 10px;
	        }
	        button:hover {
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
	            margin-top: 0px;
	        }
	        .alert.error {
	            color: #ff0000;
	        }
	        .alert.success {
	            color: #008000;
	        }
	    </style>
</head>
<body>
 
    <a href="/superAdmin/dashboard" class="back-button">Back to Dashboard</a>
 
    <div class="container">
        <h1>Owner Profile</h1>
 
        <form:form method="POST" action="/superAdmin/updateProfile" modelAttribute="superAdmin">
            <form:hidden path="id" />
            <table>
                <tr>
                    <td class="form-group">
                        <label for="firstName">First Name:</label>
                        <form:input path="firstName" cssClass="form-control" id="firstName"/>
                    </td>
                </tr>
                <tr>
                    <td class="form-group">
                        <label for="lastName">Last Name:</label>
                        <form:input path="lastName" cssClass="form-control" id="lastName"/>
                    </td>
                </tr>
                <tr>
                    <td class="form-group">
                        <label for="emailId">Email ID:</label>
                        <form:input path="emailId" cssClass="form-control" id="emailId"/>
                    </td>
                </tr>
                <tr>
                    <td class="form-group">
                        <label for="mobileNo">Mobile No:</label>
                        <form:input path="mobileNo" cssClass="form-control" id="mobileNo"/>
                    </td>
                </tr>
                <tr>
                    <td class="form-group">
                        <label for="username">Username</label>
                        <form:input path="username" cssClass="form-control" id="username"/>
                    </td>
                </tr>
            </table>
            <button type="submit">Save Changes</button>
        </form:form>
 
        <!-- Display error messages without JSTL -->
        <%
            List<String> errors = (List<String>) request.getAttribute("errors");
            if (errors != null && !errors.isEmpty()) {
        %>
            <div class="alert error">
                <ul>
                    <%
                        for (String error : errors) {
                    %>
                        <li><%= error %></li>
                    <%
                        }
                    %>
                </ul>
            </div>
        <%
            }
        %>
 
        <!-- Display success message -->
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <div class="alert success">
                <%= message %>
            </div>
        <%
            }
        %>
 
    </div>
	
	<!-- JavaScript to display alert box -->
	   <script type="text/javascript">
	       <% if (request.getAttribute("noChangesMade") != null) { %>
	           alert("No changes were made to the profile.");
	       <% } %>
	   </script>
 
</body>
</html>
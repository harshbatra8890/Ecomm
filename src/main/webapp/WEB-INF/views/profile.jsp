<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="ecom.app.entities.User"%>
 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Profile</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #F2EED7;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	position: relative; /* Added for button positioning */
}
 
.logo {
	font-size: 1.5em;
	font-weight: bold;
}
 
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	flex: 1;
	padding: 20px;
}
 
.profile-box {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	padding: 30px;
	width: 100%;
	max-width: 600px;
}
 
.edit-button, .back-button {
	background-color: #295F98;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 10px 15px;
	cursor: pointer;
	font-size: 16px;
	margin-bottom: 20px;
	transition: background-color 0.3s ease;
}
 
.edit-button:hover, .back-button:hover {
	background-color: #1a3a6e;
}
 
.user-details {
	margin-top: 20px;
}
 
.field {
	margin-bottom: 15px;
	margin-top: 10px;
}
 
.field label {
	display: block;
	font-weight: bold;
	color: #295F98;
}
 
.field input {
	width: 95%;
	padding: 10px;
	border: 2px solid #295F98;
	border-radius: 5px;
	background-color: #f9f9f9;
	color: #333;
	font-size: 14px;
}
 
img {
	max-width: 150px;
	border-radius: 50%;
	margin-bottom: 20px;
}
 
.back-button {
	position: absolute;
	top: 20px;
	right: 20px;
}
</style>
</head>
<body>
 
	<%
    User user = (User) session.getAttribute("user");
    int roleId = user.getRole().getRoleId();
%>
<% if (roleId == 2) { %>
    <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/subadmin'">Back to Dashboard</button>
<% } else { %>
    <button class="back-button" onclick="window.location.href='${pageContext.request.contextPath}/homepageuser'">Back to home</button>
<% } %>
 
	<div class="container">
 
		<div class="profile-box">
			<button class="edit-button" type="button"
				onclick="window.location.href='${pageContext.request.contextPath}/user/editprofile'">Edit
				Profile</button>
 
			<div class="user-details">
				<%
				String profileImage = (String) request.getAttribute("profileImage");
				%>
				<%
				if (profileImage != null && !profileImage.isEmpty()) {
				%>
				<img src="data:image/jpeg;base64,<%=profileImage%>"
					alt="Profile Image" />
				<%
				} else {
				%>
				<p>No Profile Image</p>
				<%
				}
				%>
 
				<div class="field">
					<label for="firstname">First Name:</label> <input type="text"
						id="firstname" value="<%=user.getFirstName()%>" readonly>
				</div>
 
				<div class="field">
					<label for="lastname">Last Name:</label> <input type="text"
						id="lastname" value="<%=user.getLastName()%>" readonly>
				</div>
 
				<div class="field">
					<label for="username">Username:</label> <input type="text"
						id="username" value="<%=user.getUsername()%>" readonly>
				</div>
 
				<div class="field">
					<label for="mobileno">Mobile No:</label> <input type="text"
						id="mobileno" value="<%=user.getMobileNo()%>" readonly>
				</div>
 
				<div class="field">
					<label for="emailId">Email Id:</label> <input type="text"
						id="emailId" value="<%=user.getEmailId()%>" readonly>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@ page import="ecom.app.entities.User"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - ElectroMart</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://img.freepik.com/free-vector/winter-light-blue-gradient-vector-background_53876-126054.jpg');
            background-size: cover;
            background-position: center;
            color: #333;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #295F98;
            color: white;
            padding: 15px;
        }

        nav .logo {
            font-size: 24px;
            font-weight: bold;
            color: #FF9874;
            margin-left: 15px;
        }

        nav .home-link {
            color: white;
            text-decoration: none;
            margin-right: 15px;
        }

        section {
            margin: 20px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #FF9874;
            margin-bottom: 20px;
        }

        .footer {
            background-color: #295F98;
            color: white;
            padding: 10px 0;
            text-align: center;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: 201px;
        }

        .footer-links a {
            color: #FF9874;
            margin: 0 10px;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav>
        <div class="logo">ElectroMart</div>
        
          
		<%
		User user = (User) session.getAttribute("user");
		
		%>

		<!-- Navigation Links -->
		<ul>
			<%
			if (user != null) {
			%>
        <a href="${pageContext.request.contextPath}/homepageuser" class="home-link">Home</a>

			<%
			} else {
			%>
        <a href="${pageContext.request.contextPath}/" class="home-link">Home</a>

			<%
			}
			%>
        
    </nav>

    <!-- About Us Section -->
    <section>
        <h1>About Us</h1>
        <p>
            At ElectroMart, we are passionate about bringing you the best in electronics. Our mission is to provide a wide range of high-quality products, from the latest gadgets to essential home appliances. With years of experience in the industry, we understand the diverse needs of our customers and strive to meet them effectively. We focus on a customer-centric approach, ensuring our dedicated team is always ready to assist you with any inquiries for the best shopping experience possible. We pride ourselves on competitive pricing, making quality products accessible to everyone with unbeatable deals and discounts. Our fast and reliable shipping ensures your orders arrive promptly, providing convenience and peace of mind. Your satisfaction is our top priority, which is reflected in our hassle-free returns policy. Additionally, we stay ahead of the curve by continuously innovating and curating the latest trends and technologies, ensuring you have access to the best and newest products.
        </p>
    </section>

    <!-- Footer Section -->
    <footer class="footer">
        <div class="footer-links">
            <a href="#">Contact Us</a>
            <a href="#">Payments</a>
            <a href="#">Shipping</a>
            <a href="#">Cancellation</a>
        </div>
        <p>© 2024 ElectroMart. All rights reserved.</p>
    </footer>

</body>
</html>

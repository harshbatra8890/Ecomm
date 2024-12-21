<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="ecom.app.entities.User"%>

		
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - ElectroMart</title>

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
			margin-top:183px;
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

    <!-- Contact Us Section -->
    <section>
        <h1>ElectroMart Help Center | 24x7 Customer Care Support</h1>
        <p>
            The ElectroMart Help Centre page lists out various types of issues that you may have encountered so that there can be quick resolution and you can go back to shopping online. For example, you can get more information regarding order tracking, delivery date changes, help with returns (and refunds), and much more. The ElectroMart Help Centre also lists out more information that you may need regarding ElectroMart Plus, payment, shopping, and more. The page has various filters listed out on the left-hand side so that you can get your queries solved quickly, efficiently, and without a hassle. You can get the ElectroMart Help Centre number or even access ElectroMart Help Centre support if you need professional help regarding various topics. The support executive will ensure speedy assistance so that your shopping experience is positive and enjoyable. You can even inform your loved ones of the support page so that they can properly get their grievances addressed as well. Once you have all your queries addressed, you can pull out your shopping list and shop for all your essentials in one place. You can shop during festive sales to get your hands on some unbelievable deals online. This information is updated on 19-Oct-24.
        </p>
    </section>

    <!-- Footer Section -->
    <footer class="footer">
        <div class="footer-links">
            <a href="#">About Us</a>
            <a href="#">Payments</a>
            <a href="#">Shipping</a>
            <a href="#">Cancellation</a>
        </div>
        <p>© 2024 ElectroMart. All rights reserved.</p>
    </footer>

</body>
</html>

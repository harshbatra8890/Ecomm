<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="ecom.app.entities.Products"%>
<%@ page import="ecom.app.entities.Feedback"%>
<%@ page import="ecom.app.entities.User"%>
<%@ page import="java.util.List"%>
<html>
<head>
<title>Product Details</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #F2EED7;
	margin: 0;
	padding: 0;
	color: #333;
}

nav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #295F98;
	color: white;
	padding: 8px;
}

.nav-container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

nav .logo {
	font-size: 24px;
	font-weight: bold;
	color: #FF9874;
	margin-lef: 15px;
}

nav .search-bar {
	flex-grow: 1;
	margin: 0 20px;
	position: relative; /* Position for icon */
	text-align: center;
	margin-top: 5px;
}

nav .search-bar form {
	display: inline-block;
	position: relative;
}

nav .search-bar input {
	width: 400px;
	padding: 8px 40px 8px 15px; /* Add padding for the search icon */
	border-radius: 5px;
	border: none;
	text-align: left;
}

nav .search-bar button {
	position: absolute;
	right: 5px;
	top: 50%;
	transform: translateY(-50%);
	background: none;
	border: none;
	cursor: pointer;
	color: #333;
}

nav ul {
	display: flex;
	list-style-type: none;
	padding: 0;
	margin: 0;
}

nav ul li {
	margin-left: 0px;
	position: relative;
}

nav ul li a {
	color: white;
	text-decoration: none;
	padding: 10px;
	display: block;
}

/* Dropdown menu for login */
nav ul li .dropdown-content {
	display: none;
	position: absolute;
	background-color: white;
	min-width: 160px;
	box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

nav ul li:hover .dropdown-content {
	display: block;
}

nav ul li .dropdown-content a {
	color: black;
	text-decoration: none;
	display: block;
	padding: 12px 16px;
}

nav ul li .dropdown-content a:hover {
	background-color: #ddd;
}

.shop-dropdown {
	margin-right: 100px;
}

.product-container {
	max-width: 1200px;
	margin: 40px auto;
	display: flex;
	flex-direction: row;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
}

.product-image {
	flex: 1;
	padding: 20px;
}

.product-image img {
	width: 100%;
	height: auto;
	border-radius: 10px;
	object-fit: contain;
	background-color: #e6e6e6;
}

.product-details {
	flex: 2;
	padding: 20px;
}

.product-details h1 {
	font-size: 34px;
	margin-bottom: 20px;
	color: #444;
}

.price-details {
	font-size: 26px;
	color: #ff5722;
	font-weight: bold;
	margin-bottom: 20px;
}

.btn-container {
	display: flex;
	gap: 20px;
	margin-top: 30px;
}

.btn-container button {
	padding: 12px 25px;
	border-radius: 6px;
	font-size: 16px;
	font-weight: bold;
	transition: all 0.3s ease;
	cursor: pointer;
}

.add-to-cart {
	background-color: #295F98;
	color: white;
}

.add-to-cart:hover {
	background-color: #1a3a6e;
	transform: translateY(-2px);
}

.buy-now {
	background-color: #295F98;
	color: white;
}

.buy-now:hover {
	background-color: #1a3a6e;
	transform: translateY(-2px);
}

.back-button {
	background-color: #295F98;
	color: white;
	border: none;
	padding: 12px 25px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.back-button:hover {
	background-color: #1a3a6e;
}

.feedback-section {
	margin-top: 40px;
	padding: 20px;
	background-color: #f9f9f9;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	padding-left: 50px;
	padding-right: 50px;
	margin-left: 60px;
	margin-right: 60px;
}

.feedback-section h2 {
	margin-bottom: 20px;
	font-size: 28px;
	color: #295F98; /* Heading color */
	border-bottom: 2px solid #295F98; /* Underline */
	padding-bottom: 10px;
}

.feedback-section textarea {
	width: 100%;
	height: 100px;
	padding: 12px;
	border-radius: 5px;
	border: 1px solid #ccc;
	margin-bottom: 10px;
	font-size: 16px;
	resize: none; /* Prevent resizing */
	transition: border-color 0.3s;
}

.feedback-section textarea:focus {
	border-color: #295F98; /* Change border color on focus */
	outline: none; /* Remove outline */
}

.feedback-section button {
	padding: 10px 20px;
	background-color: #295F98; /* Button color */
	color: white; /* Text color */
	border: none; /* Remove border */
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.3s;
	font-size: 16px;
}

.feedback-section button:hover {
	background-color: #1a3a6e; /* Hover color */
	transform: translateY(-2px); /* Lift effect */
}

#feedback-list {
	list-style-type: none;
	padding: 0;
	margin-top: 20px; /* Add space above the feedback list */
}

#feedback-list li {
	margin-bottom: 10px;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s;
}

#feedback-list li:hover {
	transform: scale(1.02); /* Slight scale on hover */
}

#feedback-list li strong {
	color: #295F98; /* Color for user name */
}

#feedback-list li small {
	display: block;
	color: #999; /* Color for feedback date */
	margin-top: 5px; /* Space above date */
}

.product-details {
	position: relative;
	/* Make it relative to position the cart icon absolutely */
	padding: 20px;
}

.cart-icon {
	position: absolute;
	top: 20px; /* Adjust as needed */
	right: 20px; /* Adjust as needed */
	color: #295F98; /* Cart icon color */
	font-size: 24px; /* Size of the icon */
	z-index: 10; /* Ensure it appears above other content */
}
</style>
</head>
<body>
	<nav>
		<div class="logo">ElectroMart</div>

		<!-- Search Bar in Center -->
		<div class="nav-container">
			<div class="search-bar">
				<form action="${pageContext.request.contextPath}/products/search"
					method="get">
					<input type="text" name="query"
						placeholder="Search for specific products..." required>
					<button type="submit">
						<i class="fas fa-search"></i>
						<!-- Lens icon -->
					</button>
				</form>
			</div>
		</div>


		<%
		User user = (User) session.getAttribute("user");
		Products product = (Products) session.getAttribute("product");
		String message = (String) request.getAttribute("message");
		List<Feedback> feedbackList = (List<Feedback>) session.getAttribute("feedbackList");
		String base64Image = product.getBase64ProductImage(); // Get the product image
		%>

		<!-- Navigation Links -->
		<ul>
			<%
			if (user != null) {
			%>
			<li><a href="${pageContext.request.contextPath}/homepageuser">Home</a></li>

			<%
			} else {
			%>
			<li><a href="${pageContext.request.contextPath}/">Home</a></li>

			<%
			}
			%>

			<!-- Shop Dropdown -->
			<li class="shop-dropdown"><a href="#">Shop</a>
				<ul class="dropdown-content">
					<li><a
						href="${pageContext.request.contextPath}/explore-all-categories">Shop
							by Category</a></li>
					<li><a
						href="${pageContext.request.contextPath}/products/display1">All
							Products</a></li>
				</ul></li>
		</ul>
	</nav>


	<div class="product-container">







		<!-- Message Display -->
		<c:if test="${not empty message}">
			<p style="font-weight: bold; color: green">${message}</p>
		</c:if>

		<!-- Product Image Section -->
		<div class="product-image">
			<%
			if (base64Image != null) {
			%>
			<img src="data:image/jpeg;base64,<%=base64Image%>"
				alt="<%=product.getProduct_name()%>">
			<%
			} else {
			%>
			<img src="https://via.placeholder.com/500" alt="No Image Available">
			<%
			}
			%>
		</div>

		<!-- Product Details Section -->
		<div class="product-details">
			<div class="cart-icon">

				<%
				if (user != null) {
				%>
				<a href="${pageContext.request.contextPath}/cart/view"> <%
 } else {
 %>

					<a href="${pageContext.request.contextPath}/"> <%
 }
 %> <i
						class="fas fa-shopping-cart"></i>
				</a>
			</div>
			<h1><%=product.getProduct_name()%></h1>
			<p>
				<strong>Description:</strong>
				<%=product.getDescription()%></p>
			<p>
				<strong>MRP:</strong> &#8377;<%=product.getMrp()%></p>
			<p>
				<strong>Discount:</strong>
				<%=product.getDiscount()%>%
			</p>
			<p>
				<strong>Stock:</strong>
				<%=product.getStock() > 0 ? product.getStock() + " available" : "Out of Stock"%></p>
			<!-- Stock Info -->
			<p class="price-details">
				Final Price: &#8377;<%=product.getFinal_price()%></p>

			<div class="btn-container">
				<!-- Add to Cart Button -->
				<form action="${pageContext.request.contextPath}/cart/add"
					method="POST">
					<input type="hidden" name="productId"
						value="${product.getProduct_id()}">
					<button type="submit" class="add-to-cart">Add to Cart</button>
				</form>

				<!-- Buy Now Button -->
				<form action="${pageContext.request.contextPath}/cart/buynow"
					method="GET">
					<input type="hidden" name="productId"
						value="${product.getProduct_id()}"> <input type="hidden"
						name="fromCart" value="false">
					<!-- Indicate this is a direct buy -->
					<button type="submit" class="buy-now">Buy Now</button>
				</form>
				<form
					action="${pageContext.request.contextPath}/wishlist/addToWishlist"
					method="POST">
					<input type="hidden" name="productId"
						value="${product.getProduct_id()}"> <input type="hidden"
						name="fromCart" value="false">
					<button type="submit" class="buy-now">Add to wishlist</button>
				</form>
			</div>

			<!-- Back to Products Button -->
			<%
			if (user != null) {
			%>
			<form action="${pageContext.request.contextPath}/homepageuser"
				method="GET" style="margin-top: 20px;">
				<button type="submit" class="back-button">Back to Products</button>
			</form>

			<%
			} else {
			%>
			<form action="${pageContext.request.contextPath}/" method="GET"
				style="margin-top: 20px;">
				<button type="submit" class="back-button">Back to Products</button>
			</form>

			<%
			}
			%>


		</div>
	</div>

	<!-- Feedback Section -->
	<div class="feedback-section">
		<h2>Leave Feedback</h2>
		<form action="${pageContext.request.contextPath}/feedback/submit"
			method="POST">
			<textarea name="feedbackText" maxlength="50"
				placeholder="Enter your feedback..." required></textarea>
			<input type="hidden" name="productId"
				value="<%=product.getProduct_id()%>"> <input type="hidden"
				name="userId"
				value="<%=session.getAttribute("userId") != null ? session.getAttribute("userId") : 0%>">
			<button type="submit">Submit Feedback</button>
		</form>

		<h3>User Feedback</h3>
		<ul id="feedback-list">
			<%
			if (feedbackList != null) {
				for (Feedback feedback : feedbackList) {
			%>
			<li><strong>User <%=feedback.getUserId()%>:
			</strong> <%=feedback.getFeedbackText()%> <br> <small><%=feedback.getFeedbackDate()%></small></li>
			<%
			}
			} else {
			%>
			<li>No feedback available yet.</li>
			<%
			}
			%>
		</ul>
	</div>

</body>
</html>
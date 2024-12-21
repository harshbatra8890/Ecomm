<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="ecom.app.entities.User"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Retailer Dashboard</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-image:
		url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7L114gQCrFSl1q55isT7q9e78SrGRoJVNKg&s');
	background-size: cover;
	background-position: center;
	background-repeat: no-repeat;
	position: relative;
}

.overlay {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: rgba(242, 238, 215, 0.2);
	z-index: 1;
}

.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #295F98;
	color: white;
	padding: 10px 20px;
	position: relative;
	z-index: 2;
}

.logo {
	color: #FF9874;
	font-size: 28px;
	font-weight: bold;
	margin-left: 15px;
}

.header {
	text-align: center;
	flex-grow: 1;
	font-size: 20px;
	margin-right: 70px;
}

.toggle-btn {
	cursor: pointer;
	font-size: 24px;
	background-color: #295F98;
	color: white;
	border: none;
	transition: background-color 0.3s;
}

.sidebar {
	height: 100%;
	width: 250px;
	position: fixed;
	top: 0;
	right: -250px;
	background-color: #295F98;
	transition: right 0.7s ease;
	z-index: 3;
}

.sidebar ul {
	list-style-type: none;
	padding: 0;
}

.sidebar ul li {
	padding: 15px;
}

.sidebar ul li a {
	color: white;
	text-decoration: none;
}

.sidebar ul li.logout {
	position: absolute;
	bottom: 20px;
	left: 0;
}

.content {
	margin-left: 20px;
	padding: 20px;
	margin-top: 0;
	position: relative;
	z-index: 2;
}

.slideshow-container {
	width: 70%;
	position: relative;
	margin: 0 auto;
	padding: 0;
	z-index: 1;
}

.mySlides {
	display: none;
	height: 350px;
}

img {
	width: 100%;
	height: 100%;
}

.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	color: white;
	font-weight: bold;
	font-size: 18px;
	border-radius: 0 3px 3px 0;
	user-select: none;
	z-index: 4;
}

.next {
	right: 0;
	border-radius: 3px 0 0 3px;
}

.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

.registration-steps {
	text-align: center;
	margin-top: 70px;
}

.step-container {
	display: flex;
	justify-content: space-around;
	margin-top: 40px;
	flex-wrap: wrap;
}

.step {
	max-width: 250px;
	margin: 20px;
	text-align: left;
}

.step img {
	width: 100%;
	height: auto;
}

.step h3 {
	text-align: center;
}

/* FAQ styles */
.faq-section {
	text-align: center;
	margin-top: 40px;
	width: 97%;
}

.faq-question {
	cursor: pointer;
	margin: 15px 0;
	background-color: #FF9874;
	color: black;
	padding: 10px;
	border-radius: 5px;
	transition: background-color 0.3s;
	text-align: left;
}

.faq-question:hover {
	background-color: #FF9874;
}

.faq-answer {
	display: none;
	padding: 10px;
	background-color: #f1f1f1;
	border-radius: 5px;
	margin-top: 5px;
	text-align: left;
}
</style>
</head>
<body>
	<div class="overlay"></div>

	<div class="navbar">
		<div class="logo">ElectroMart</div>
		<h1 class="header">WELCOME TO RETAILER DASHBOARD</h1>
		<button class="toggle-btn" onclick="toggleMenu()"
			style="color: #FF9874;">☰</button>
		<!-- Toggle Button in Navbar -->
	</div>

	<div class="sidebar" id="sidebar">
		<button class="toggle-btn" onclick="toggleMenu()"
			style="color: #FF9874;">✖</button>
		<ul>
			<li><a
				href="${pageContext.request.contextPath}/user/profile?username=${user.username}">View
					Profile</a></li>
			<li><a href="/user/resetPassword">Reset Password</a></li>

			<li><a href="/products/view_product">View All Products</a></li>
			<li><a href="/products/view_productbycategoryname">View by
					Category Name</a></li>
         <li><a href="/user/salesPerformance/subAdmin/${subAdminId}">Sales
					Report</a></li>

			<li><a href="/products/add1">Add Products</a></li>
			<li><a href="/products/view_product_update_table">Update
					Product</a></li>


			<li><a href="/products/remove_product">Remove Product</a></li>
			
			<li><a href="/">Logout</a></li>
		</ul>
	</div>

	<div class="content">
		<div class="slideshow-container">
			<div class="mySlides fade">
				<img
					src="https://www.instorindia.com/wp-content/uploads/2021/08/Blog-img8.jpg"
					alt="Slide 1">
			</div>
			<div class="mySlides fade">
				<img
					src="https://www.zegashop.com/web/wp-content/uploads/2021/05/Group-229.png"
					alt="Slide 2">
			</div>
			<div class="mySlides fade">
				<img
					src="https://fastercapital.com/i/Online-shopping--The-Rise-of-E-commerce-in-Mass-Market-Retail--The-Benefits-of-E-commerce-for-Retailers.webp"
					alt="Slide 3">
			</div>

			<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
				onclick="plusSlides(1)">&#10095;</a>
		</div>

		<div class="registration-steps">
			<h2>Steps to start selling your products</h2>
			<div class="step-container">
				<div class="step">
					<img
						src="https://media.istockphoto.com/id/1658170979/vector/hand01.jpg?s=612x612&w=0&k=20&c=C9xLL2Qd6nkJ2wCJqPtubRCzBYFvD-6-b1ZfJEiurpk="
						alt="Step 1 Image">
					<h3>1: Create account</h3>
					<p>Account creation in ElectroMart.in</p>
				</div>
				<div class="step">
					<img
						src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU_BUZvarX2BmZNWjyCaUqfKJLCQyx09aFkQ&s"
						alt="Step 2 Image">
					<h3>2: List Your Products</h3>
					<p>List your products with photos and description</p>
				</div>
				<div class="step">
					<img
						src="https://img.freepik.com/premium-vector/people-delivery-products_318923-61.jpg"
						alt="Step 3 Image">
					<h3>3: Complete Orders</h3>
					<p>Deliver orders to customers within 7 days</p>
				</div>
			</div>
		</div>

		<!-- FAQ Section -->
		<div class="faq-section">
			<h2>Frequently Asked Questions</h2>
			<div class="faq-question" onclick="toggleAnswer('faq1')">How do
				I sell on ElectroMart.in?</div>
			<div class="faq-answer" id="faq1">
				<p>1.Register yourself with a request to Owner to become a
					retailer</p>
				<p>2.Add your products which you want to sell</p>
				<p>3.Complete your order within 7 days</p>
			</div>
			<div class="faq-question" onclick="toggleAnswer('faq3')">How to
				create a retailer account on ElectroMart.in?</div>
			<div class="faq-answer" id="faq3">
				<p>Go to the ElectroMart retailer registration page and fill out
					the required form.</p>
			</div>
			<div class="faq-question" onclick="toggleAnswer('faq4')">Is
				there a fee to create a retailer account on ElectroMart.in?</div>
			<div class="faq-answer" id="faq4">
				<p>Creating an account is absoluately free.</p>
			</div>
		</div>
	</div>

	<script>
		let slideIndex = 0;
		showSlides();

		function toggleMenu() {
			const sidebar = document.getElementById('sidebar');
			if (sidebar.style.right === '0px') {
				sidebar.style.right = '-250px';
			} else {
				sidebar.style.right = '0px';
			}
		}

		function showSlides() {
			const slides = document.getElementsByClassName("mySlides");
			for (let i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slideIndex++;
			if (slideIndex > slides.length) {
				slideIndex = 1
			}
			slides[slideIndex - 1].style.display = "block";
			setTimeout(showSlides, 3000);
		}

		function plusSlides(n) {
			slideIndex += n;
			const slides = document.getElementsByClassName("mySlides");
			if (slideIndex > slides.length) {
				slideIndex = 1
			}
			if (slideIndex < 1) {
				slideIndex = slides.length
			}
			for (let i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slides[slideIndex - 1].style.display = "block";
		}

		function toggleAnswer(id) {
			const answer = document.getElementById(id);
			answer.style.display = answer.style.display === "block" ? "none"
					: "block";
		}
	</script>
</body>
</html>

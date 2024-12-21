<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ecom.app.entities.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Owner Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpuyBACBlBsXpWU4pkOLpzzNGQfDLnvW3g2x3kHgwjUgff37varoVVOUE4lZpWaxCW0WE&usqp=CAU');
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
            background-color: rgba(242, 238, 215, 0.4);
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
			margin-left:15px;
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
            width: 80%;
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

        .logout-btn {
            background-color: #295F98;
            color: white;             
            border: none;              
            cursor: pointer;           
            text-align: left;          
            width: 100%;               
            font-size: 16px;           
        }

        .logout-btn:hover {
            background-color: #295F98;
        }

        .why-sell {
            text-align: center;
            margin-top: 60px;
        }

        .why-sell h2 {
            margin-bottom: 20px;
            color: black;
            font-size: 32px;
        }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px; /* Reduced gap */
            padding: 20px 10px;
            margin: 40px auto; 
            max-width: 1000px; 
        }

        .grid-item {
            border: 2px solid #295F98;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
        }

        .grid-item img {
            width: 60%; 
            height: 60%; 
        }
    </style>
</head>
<body>
    <div class="overlay"></div>

    <div class="navbar">
        <div class="logo">ElectroMart</div>
        <h1 class="header">WELCOME TO OWNER DASHBOARD</h1>
        <button class="toggle-btn" onclick="toggleMenu()" style="color: #FF9874;">☰</button>
    </div>
    
   <div class="sidebar" id="sidebar">
    <button class="toggle-btn" onclick="toggleMenu()" style="color: #FF9874;">✖</button>
    <ul>
        <li><a href="/superAdmin/viewProfile">View Profile</a></li>
        <li><a href="/superAdmin/resetPassword">Reset Password</a></li>
        <li><a href="/superAdmin/viewAllSubAdmins">View All Retailers</a></li>
        <li><a href="/superAdmin/viewAllCustomers">View All Customers</a></li>
        <li><a href="/category/add">Add Category</a></li>
                 <li><a href="/category/view">View All Categories</a></li>
         
          <li><a href="/superAdmin/salesPerformance">Total Sales Report</a></li>
          <li> <a href="/superAdmin/commissions">View Commission</a></li>
        <li><a href="/superAdmin/viewSubadminRequests">View Retailer Requests</a></li> 
        <li class="logout">
            <form method="POST" style="margin: 0;">
                <li><a href="/superAdmin/logout">Logout</a></li>
            </form>
        </li>
    </ul>
</div>


    <div class="content">
        <div class="slideshow-container">
            <div class="mySlides fade">
                <img src="https://www.scnsoft.com/blog-pictures/ecommerce/b2c-ecom.png" alt="Slide 1">
            </div>
            <div class="mySlides fade">
                <img src="https://www.scnsoft.com/blog-pictures/ecommerce/ia-ecommerce-best-practices.png" alt="Slide 2">
            </div>
            <div class="mySlides fade">
                <img src="https://www.rixxo.com/wp-content/uploads/2023/06/benefits-of-B2C-eCommerce-1536x1152.png.webp" alt="Slide 3">
            </div>

            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>

        <div class="why-sell">
            <h2>Why Sell on ElectroMart?</h2>
            <div class="grid-container">
                <div class="grid-item">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXcsCXTEys0kprkovC-Ufc4aHX7ldsXvq1Fw&s" alt="Sell Across India">
                    <h3>Sell Across India</h3>
                    <p>Reach over 50 crore+ customers across 27000+ pincodes</p>
                </div>
                <div class="grid-item">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbyffbyoEQ5FsEgxOjqkuTearET45VMRVDpoOdLJ11GZZRzaxhwi7pWupBQrnhaPnaot0&usqp=CAU" alt="Higher Profits">
                    <h3>Higher Profits</h3>
                    <p>With small commission*, you take maximum profits with you</p>
                </div>
                <div class="grid-item">
                    <img src="https://i.pinimg.com/564x/8d/ff/49/8dff49985d0d8afa53751d9ba8907aed.jpg" alt="Account Management">
                    <h3>Account Management</h3>
                    <p>Our retailer dashboard will help your business on ElectroMart</p>
                </div>
                <div class="grid-item">
                    <img src="https://media.istockphoto.com/id/1411957271/vector/indian-rupee-decrease-icon-sticker-on-gray-background.jpg?s=612x612&w=0&k=20&c=UbDGAYEVGCEurxFtqmy49sOufz9Gixj73DOUFjuvvfo=" alt="Lower Return Charges">
                    <h3>Lower Return Charges</h3>
                    <p>With our flat and low return charges, ship your products stress-free</p>
                </div>
                <div class="grid-item">
                    <img src="https://previews.123rf.com/images/marvinjk/marvinjk1205/marvinjk120500014/13511584-cartoon-calculator.jpg" alt="Simple Pricing Calculator">
                    <h3>Simple Pricing Calculator</h3>
                    <p>Use our simple pricing calculator to decide the best and competitive selling price for your product</p>
                </div>
                <div class="grid-item">
                    <img src="https://media.istockphoto.com/id/1430316360/vector/rupee-3d-isometric-physical-coin.jpg?s=612x612&w=0&k=20&c=nGJMx4I1EZeFnxl_tQgbNDsg6CO0HI0WphGwL43GXdw=" alt="Fast & Regular Payments">
                    <h3>Fast & Regular Payments</h3>
                    <p>Get payments as fast as 7-10 days from the date of dispatch</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        let slideIndex = 0;
        showSlides();

        function toggleMenu() {
            const sidebar = document.getElementById('sidebar');
            if (sidebar.style.right === '0px') {
                sidebar.style.right = '-250px'; // Hide sidebar
            } else {
                sidebar.style.right = '0px'; // Show sidebar
            }
        }

        function showSlides() {
            const slides = document.getElementsByClassName("mySlides");
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";  
            }
            slideIndex++;
            if (slideIndex > slides.length) {slideIndex = 1}    
            slides[slideIndex - 1].style.display = "block";  
            setTimeout(showSlides, 3000); 
        }

        function plusSlides(n) {
            slideIndex += n;
            const slides = document.getElementsByClassName("mySlides");
            if (slideIndex > slides.length) {slideIndex = 1}
            if (slideIndex < 1) {slideIndex = slides.length}
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";  
            }
            slides[slideIndex - 1].style.display = "block";  
        }
    </script>
</body>
</html>

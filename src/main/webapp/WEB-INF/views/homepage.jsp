<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.Products" %>
<%@ page import="ecom.app.entities.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ElectroMart - Home</title>

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('https://img.freepik.com/free-vector/winter-light-blue-gradient-vector-background_53876-126054.jpg');
            background-size: cover;
            background-position: center;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #295F98;
            color: white;
            padding: 15px;
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
            margin-left: 15px;
        }

        nav .search-bar {
            flex-grow: 1;
            margin: 0 20px;
            position: relative;
            text-align: center;
        }

        nav .search-bar form {
            display: inline-block;
            position: relative;
        }

        nav .search-bar input {
            width: 400px;
            padding: 8px 40px 8px 15px;
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

        .login-dropdown {
            margin-right: 10px;
        }

        .shop-dropdown {
            margin-right: 100px;
        }

        section {
            margin: 20px;
            text-align: center;
        }

        h1 {
            margin: 20px 0;
            font-size: 28px;
        }

        h2 {
            margin: 20px 0;
            font-size: 24px;
            color: #FF9874;
            border-bottom: 2px solid #295F98;
            display: inline-block;
            padding-bottom: 5px;
        }

        .exp-btn {
            background-color: #295F98;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-left: 570px;
        }

        .exp-btn:hover {
            background-color: #1a3a6e;
            color: white;
        }

        .products-row {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .product {
            margin-right: 20px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            text-align: center;
            flex: 1;
        }

        img {
            width: auto;
            height: 200px;
            object-fit: cover;
            border-radius: 5px;
        }

        .product-name {
            font-weight: bold;
        }

        .product-price {
            color: green;
            font-weight: bold;
            font-size: 16px;
            margin-top: 5px;
        }

        .explore-button {
            background-color: #295F98;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .explore-button:hover {
            background-color: #1a3a6e;
            color: white;
        }

        .footer {
            background-color: #295F98;
            color: white;
            padding: 5px 0;
            text-align: center;
            position: relative;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            max-width: 1200px;
            margin: 0 auto;
            padding: 5px 0;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: #FF9874;
            margin: 0 10px;
            text-decoration: none;
        }

        .contact-info {
            text-align: left;
            margin: 0;
        }

        .footer p {
            margin: 0;
            color: white;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav>
        <div class="logo">ElectroMart</div>

        <!-- Search Bar in Center -->
        <div class="nav-container">
            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/products/search" method="get">
                    <input type="text" name="query" placeholder="Search for specific products..." required>
                    <button type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </div>

        <!-- Navigation Links -->
        <ul>
            <li class="login-dropdown">
                <a href="#">Login</a>
                <ul class="dropdown-content">
                    <li><a href="/superAdmin/login" onclick="submitLoginForm('super_admin')">Login as Owner</a></li>
                    <li><a href="/user/login" onclick="submitLoginForm('retailer')">Login</a></li>
                </ul>
            </li>

            <li class="shop-dropdown">
                <a href="#">Shop</a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/explore-all-categories">Shop by Category</a></li>
                    <li><a href="${pageContext.request.contextPath}/products/display1">All Products</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <!-- Welcome Section -->
    <section>
        <p style="font-size: 34px; color: #FF9874; margin: 20px 0;">Welcome to the Electronic Universe</p>
        <button onclick="window.location.href='${pageContext.request.contextPath}/products/display1'" class="exp-btn">Explore All Products</button>
    </section>
   
    <!-- Trends Section -->
    <section>
        <h2>New Trends</h2>
        <div class="products-row">
            <%
                List<Products> newTrends = (List<Products>) request.getAttribute("newTrends");
                for (int i = 0; i < newTrends.size(); i++) {
                    Products product = newTrends.get(i);
            %>
                <div class="product">
                    <a href="${pageContext.request.contextPath}/products/<%= product.getProduct_id() %>">
                        <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="<%= product.getProduct_name() %>">
                    </a>
                    <p class="product-name"><%= product.getProduct_name() %></p>
                    <p class="product-price">&#8377;<%= product.getFinal_price() %></p>
                </div>
            <%
                if ((i + 1) % 3 == 0) {
            %>
                <div class="explore-button" onclick="window.location.href='${pageContext.request.contextPath}/explore-new-trends'">Explore All</div>
            <%
                }
            }
            %>
        </div>
    </section>
     
    <!-- New Arrivals Section -->
    <section>
        <h2>New Arrivals</h2>
        <div class="products-row">
            <%
                List<Products> newArrivals = (List<Products>) request.getAttribute("newArrivals");
                for (int i = 0; i < newArrivals.size(); i++) {
                    Products product = newArrivals.get(i);
            %>
                <div class="product">
                    <a href="${pageContext.request.contextPath}/products/<%= product.getProduct_id() %>">
                        <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="<%= product.getProduct_name() %>">
                    </a>
                    <p class="product-name"><%= product.getProduct_name() %></p>
                    <p class="product-price">&#8377;<%= product.getFinal_price() %></p>
                </div>
            <%
                if ((i + 1) % 3 == 0) {
            %>
                <div class="explore-button" onclick="window.location.href='${pageContext.request.contextPath}/explore-new-arrivals'">Explore All</div>
            <%
                }
            }
            %>
        </div>
    </section>

    <!-- Discount Products Section -->
    <section>
        <h2>Discount Products</h2>
        <div class="products-row">
            <%
                List<Products> discountProducts = (List<Products>) request.getAttribute("discountProducts");
                for (int i = 0; i < discountProducts.size(); i++) {
                    Products product = discountProducts.get(i);
            %>
                <div class="product">
                    <a href="${pageContext.request.contextPath}/products/<%= product.getProduct_id() %>">
                        <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="<%= product.getProduct_name() %>">
                    </a>
                    <p class="product-name"><%= product.getProduct_name() %></p>
                    <p class="product-price">&#8377;<%= product.getFinal_price() %></p>
                </div>
            <%
                if ((i + 1) % 3 == 0) {
            %>
                <div class="explore-button" onclick="window.location.href='${pageContext.request.contextPath}/explore-discount-products'">Explore All</div>
            <%
                }
            }
            %>
        </div>
    </section>

    <!-- Best Brands Section -->
    <section>
        <h2>Best Brands</h2>
        <div class="products-row">
            <%
                List<Products> bestBrands = (List<Products>) request.getAttribute("bestBrands");
                for (int i = 0; i < bestBrands.size(); i++) {
                    Products product = bestBrands.get(i);
            %>
                <div class="product">
                    <a href="${pageContext.request.contextPath}/products/<%= product.getProduct_id() %>">
                        <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="<%= product.getProduct_name() %>">
                    </a>
                    <p class="product-name"><%= product.getProduct_name() %></p>
                    <p class="product-price">&#8377;<%= product.getFinal_price() %></p>
                </div>
            <%
                if ((i + 1) % 3 == 0) {
            %>
                <div class="explore-button" onclick="window.location.href='${pageContext.request.contextPath}/explore-best-brands'">Explore All</div>
            <%
                }
            }
            %>
        </div>
    </section>
    
    <!-- Category Section -->
    <section>
        <h2>Shop By Category</h2>
        <div class="products-row">
            <%
                List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
                for (int i = 0; i < categoryList.size(); i++) {
                    Category category = categoryList.get(i);
            %>
                <div class="product">
                    <a href="<%= request.getContextPath() %>/products/category/<%= category.getCategory_id() %>">
                        <img src="data:image/jpeg;base64,<%= category.getBase64CategoryImage() %>" alt="<%= category.getCategory_name() %>" style="width:200px;height:200px;">
                    </a>
                    <p style="font-weight: bold;"><%= category.getCategory_name() %></p> <!-- Bolded category name -->
                </div>
            <%
                if ((i + 1) % 3 == 0) {
            %>
                <div class="explore-button" onclick="window.location.href='<%= request.getContextPath() %>/explore-all-categories'">Explore All</div>
            <%
                }
            }
            %>
        </div>
    </section>

    <!-- Footer Section -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-links">
                <a href="${pageContext.request.contextPath}/aboutus">About Us</a>
                <a href="${pageContext.request.contextPath}/contactus">Contact Us</a>
                <p style="color: #FF9874; margin:0px 8px;">Payments</p>
                <p style="color: #FF9874; margin: 0px 8px;">Shipping</p>
                <p style="color: #FF9874; margin:0px 10px;">Cancellation</p>
            </div>
            <div class="contact-info">
                <p><strong>Address:</strong>  ElectroMart Pvt. Ltd.<br>
                    Bagmane Constellation Business Park Block-7,<br>
                    Bagmane Constellation Service Rd,<br>
                    Ferns City, Doddanekkundi,<br>
                    Bengaluru, Karnataka 560048,<br>
                    India</p>
                <p><strong>Mail Us:</strong> electromart@gmail.com</p>
            </div>
        </div>
        <p>© 2024 ElectroMart. All rights reserved.</p>
    </footer>

    <script>
        // JavaScript function for handling login dropdown selection
        function submitLoginForm(role) {
            window.location.href = '${pageContext.request.contextPath}/login?role=' + role;
        }
    </script>
</body>
</html>

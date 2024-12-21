<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ecom.app.entities.User"%>
<%@ page import="ecom.app.entities.Products"%>
<html>
<head>
    <title>Products Dashboard</title>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7;
            margin: 0;
            padding: 0;
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
			margin-left:15px;
        }

        nav .search-bar {
            flex-grow: 1;
            margin: 0 20px;
            position: relative;
            text-align: center;
            margin-top: 5px;
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

        .shop-dropdown {
            margin-right: 100px;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .controls select {
            padding: 10px;
            font-size: 16px;
            border-radius: 4px;
            border: 1px solid #ccc;
            outline: none;
            cursor: pointer;
        }

        .controls .back-home {
            text-decoration: none;
            color: white;
            background-color: #0073e6;
            padding: 10px 20px;
            border-radius: 4px;
            transition: background-color 0.2s ease-in-out;
        }

        .controls .back-home:hover {
            background-color: #005bb5;
        }

        .container {
            width: 90%;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .product-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px;
            margin: 5px;
            width: 23%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s ease-in-out;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .product-card img {
            width: 100%;
            height: 200px;
            border-radius: 8px 8px 0 0;
            object-fit: contain;
            background-color: #f4f4f4;
        }

        .product-card h3 {
            font-size: 18px;
            color: #333;
            margin: 15px 0;
            font-weight: bold; /* Bold product name */
        }

        .product-card p {
            color: green; /* Green color for price */
            font-size: 16px;
            margin-bottom: 15px;
            font-weight: bold; /* Bold price */
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .product-card a {
            text-decoration: none;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            display: inline-block;
            transition: background-color 0.2s ease-in-out;
            margin: 0 5px;
            white-space: nowrap;
        }

        .product-card .details-btn {
            background-color: #295F98;
        }

        .product-card .details-btn:hover {
            background-color: #1a3a6e;
        }

        .product-card .wishlist-btn {
            background-color: #ffc107;
        }

        .product-card .wishlist-btn:hover {
            background-color: #e0a800;
        }

        .no-products {
            text-align: center;
            font-size: 24px;
            color: #999;
            margin-top: 100px;
        }
    </style>

    <script>
        function sortProducts() {
            var sortOption = document.getElementById("sortDropdown").value;
            window.location.href = "<%=request.getContextPath()%>/products?sort=" + sortOption;
        }
    </script>
</head>
<body>
<nav>
    <div class="logo">ElectroMart</div>

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

    <ul>
        <%
        User user = (User) session.getAttribute("user");
        %>
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
        <li class="shop-dropdown"><a href="#">Shop</a>
            <ul class="dropdown-content">
                <li><a href="${pageContext.request.contextPath}/explore-all-categories">Shop by Category</a></li>
                <li><a href="${pageContext.request.contextPath}/products/display1">All Products</a></li>
            </ul>
        </li>
    </ul>
</nav>

<div class="controls">
    <div>
        <label for="sortDropdown">Sort by:</label>
        <select id="sortDropdown" onchange="sortProducts()">
            <option value="alphabetical">Price</option>
            <option value="priceAsc">Low to High</option>
            <option value="priceDesc">High to Low</option>
        </select>
    </div>
</div>

<div class="container">
    <%
    List<Products> products = (List<Products>) request.getAttribute("products");

    if (products != null && !products.isEmpty()) {
        for (Products product : products) {
    %>
    <div class="product-card">
        <%
        String base64Image = product.getBase64ProductImage();
        %>
        <img src="data:image/jpeg;base64,<%=base64Image != null ? base64Image : ""%>" alt="<%=product.getProduct_name()%>" />
        <h3><%=product.getProduct_name()%></h3>
        <p>Price: &#8377;<%=product.getFinal_price()%></p>
        <div class="button-container">
            <center>
                <a href="<%=request.getContextPath()%>/products/<%=product.getProduct_id()%>" class="details-btn">More Details</a>
            </center>
        </div>
    </div>
    <%
        }
    } else {
    %>
    <div class="no-products">No products available</div>
    <%
    }
    %>
</div>
</body>
</html>
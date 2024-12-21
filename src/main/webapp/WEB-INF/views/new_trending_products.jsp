<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.Products" %>
<%@ page import="ecom.app.entities.User"%>

 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>New Trends - ElectroMart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7; /* Soft background */
            margin: 0;
            padding: 20px; /* Added padding for overall spacing */
        }
        h1 {
            color: #FF9874; /* Soft orange */
            text-align: center;
            margin-bottom: 30px;
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
        .products-row {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px; /* Space between products */
        }
        .product {
            margin: 10px; /* Margin for product containers */
            background: white;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            width: 250px; /* Fixed width for uniformity */
            height: 350px; /* Fixed height for uniformity */
            display: flex;
            flex-direction: column; /* Stack items vertically */
            justify-content: flex-start; /* Align items at the top */
            padding: 15px;
            transition: box-shadow 0.3s; /* Smooth shadow effect */
        }
        .product:hover {
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Shadow on hover */
        }
        img {
            width: 100%;
            height: 200px; /* Fixed height for images */
            object-fit: contain; /* Contain image */
            border-radius: 5px;
        }
        a {
            text-decoration: none;
            color: white; /* Text color for links */
            background-color: white; /* Dark blue */
            padding: 10px;
            border-radius: 5px;
            display: inline-block;
            transition: background-color 0.3s; /* Smooth color transition */
        }
        a:hover {
            background-color: white; /* Darker blue on hover */
        }
        h3 {
            font-weight: bold; /* Bold product name */
        }
        .price {
            font-weight: bold; /* Bold price */
            color: green; /* Green price color */
        }
        .home-button {
            position: absolute; /* Position it at the top right */
            top: 20px; /* Distance from the top */
            right: 20px; /* Distance from the right */
            background-color: #295F98; /* Dark blue */
            color: white; /* Text color for links */
            padding: 10px;
            border-radius: 5px;
            text-decoration: none; /* No underline */
            transition: background-color 0.3s; /* Smooth color transition */
        }
        .home-button:hover {
            background-color: #1a3a6e; /* Darker blue on hover */
        }
    </style>
    <script>
    function sortProducts1() {
        var sortOption = document.getElementById("sortDropdown").value;
               
        window.location.href = "<%= request.getContextPath() %>/explore-new-trends?sort=" + sortOption;
    }
    </script>
</head>
<body>


 
 
 <%
		User user = (User) session.getAttribute("user");
		%>
		
	<% if(user!=null){ %>	
		
		    <a href="${pageContext.request.contextPath}/homepageuser" class="home-button">Home</a>
		
		<% }else{ %>
		    <a href="${pageContext.request.contextPath}/" class="home-button">Home</a>
		
		<% }%>
 
    
    <h1>New Trends</h1>
    
    <div class="controls">
        <div>
            <label for="sortDropdown">Sort by:</label>
            <select id="sortDropdown" onchange="sortProducts1()">
                <option value="alphabetical">Price</option>
                <option value="priceAsc">Low to High</option>
                <option value="priceDesc">High to Low</option>
            </select>
        </div>
    </div>
    
    <div class="products-row">
        <%
            List<Products> newTrends = (List<Products>) request.getAttribute("newTrends");
            for (Products product : newTrends) {
        %>
            <div class="product">
                <a href="${pageContext.request.contextPath}/products/<%= product.getProduct_id() %>">
                    <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="<%= product.getProduct_name() %>">
                </a>
                <h3><%= product.getProduct_name() %></h3>
                <p class="price">&#8377;<%= product.getFinal_price() %></p>
            </div>
        <%
            }
        %>
    </div>
 
</body>
</html>
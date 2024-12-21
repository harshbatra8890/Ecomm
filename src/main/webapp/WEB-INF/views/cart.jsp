<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ecom.app.entities.CartItems"%>
<%@ page import="ecom.app.entities.Cart"%>
<html>
<head>
<title>Your Cart</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
	body {
	          background-color: #F2EED7; /* Soft background */
	          font-family: Arial, sans-serif;
	          margin: 0;
	          padding: 0px;
	      }
	nav {
							           display: flex;
							           justify-content: space-between;
							           align-items: center;
							           background-color: #295F98;
							           color: white;
									   width:101%;
							           
							       }

							       .nav-container {
							           display: flex;
							           justify-content: center;
							           align-items: center;
							           width: 110%;
							       }

							       nav .logo {
							           font-size: 24px;
							           font-weight: bold;
									color:#FF9874;
									margin-left:15px;
							       }

							       nav .search-bar {
							           flex-grow: 1;
							           margin: 0 20px;
							           position: relative; /* Position for icon */
							           text-align: center;
									   margin-top:5px;
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
								
								.shop-dropdown{
									margin-right:100px;
									
								}
								body {
								    background-color: #F2EED7; /* Soft background */
								    font-family: Arial, sans-serif;
								    margin: 0;
								    padding: 0;
								}

								h1 {
								    color: #FF9874; /* Soft orange */
								    text-align: center;
								    margin: 20px 0; /* Space around heading */
								}

								table {
								    width: 100%;
								    border-collapse: collapse;
								    margin: 20px auto; /* Center the table */
								    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Optional shadow */
								}

								thead {
								    background-color: #295F98; /* Dark blue */
								    color: white;
								}

								th, td {
								    padding: 12px;
								    text-align: left;
								    border-bottom: 1px solid #ddd;
								}

								tbody tr:hover {
								    background-color: #f1f1f1; /* Light hover effect */
								}

								form {
								    margin: 20px auto;
								    text-align: left; /* Align buttons to the left */
								}

								form input[type="checkbox"] {
								    width: 20px;
								    height: 20px;
								}

								form button {
								    background-color: #295F98; /* Dark blue */
								    color: white;
								    border: none;
								    padding: 10px 15px;
								    border-radius: 5px;
								    cursor: pointer;
								    margin-right: 10px; /* Space between buttons */
								    transition: background-color 0.3s, transform 0.2s; /* Add transition for hover effect */
									margin-left:10px;
								}

								form button:hover {
								    background-color: #1a3a6e; /* Darker blue */
								    transform: scale(1.05); /* Slightly enlarge on hover */
								}

								p {
								    text-align: center;
								    color: #333; /* Dark text color for visibility */
								}
								.go-back {
								    background-color: #295F98; /* Dark blue */
								    color: white;
								    border: none;
								    padding: 10px 15px;
								    border-radius: 5px;
								    cursor: pointer;
								    margin-left: 10px; /* Space between buttons */
								    transition: background-color 0.3s, transform 0.2s; /* Add transition for hover effect */
								}

								.go-back:hover {
								    background-color: #1a3a6e; /* Darker blue */
								    transform: scale(1.05); /* Slightly enlarge on hover */
								}
								.button-container {
								    display: inline-flex; /* Align buttons in a row */
								    margin-left: 2px; /* Space above the buttons */
								}




					
</style>
</head>
<body>
	<nav>
				       <div class="logo">ElectroMart</div>

				       <!-- Search Bar in Center -->
				       <div class="nav-container">
				           <div class="search-bar">
				               <form action="${pageContext.request.contextPath}/products/search" method="get">
				                   <input type="text" name="query" placeholder="Search for specific products..." required>
				                   <button type="submit">
				                       <i class="fas fa-search"></i> <!-- Lens icon -->
				                   </button>
				               </form>
				           </div>
				       </div>

				       <!-- Navigation Links -->
				       <ul>
						<li><a href="${pageContext.request.contextPath}/wishlist/view">Wishlist</a></li>
						   <li><a href="${pageContext.request.contextPath}/homepageuser">Home</a></li>
				           <!-- Shop Dropdown -->
				           <li class="shop-dropdown">
				               <a href="#">Shop</a>
				               <ul class="dropdown-content">
				                   <li><a href="${pageContext.request.contextPath}/explore-all-categories">Shop by Category</a></li>
				                   <li><a href="${pageContext.request.contextPath}/products/display1">All Products</a></li>
				               </ul>
				           </li>
				       </ul>
				   </nav>
		 

	<h1>Your Cart</h1>



	<%
	List<CartItems> cartItems = (List<CartItems>) session.getAttribute("cartItems");

	if (cartItems != null && !cartItems.isEmpty()) {
	%>
	<form action="${pageContext.request.contextPath}/cart/removeMultiple"
		method="post">
		<table>
			<thead>
				<tr>
					<th>Select</th>
					<th>Product Name</th>
					<th>Description</th>
					<th>Price</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (CartItems item : cartItems) {
				%>
				<tr>
					<td><input type="checkbox" name="productIds"
						value="<%=item.getProductId()%>" /></td>
					<td><%=item.getProductName()%></td>
					<td><%=item.getDescription()%></td>
					<td><%=item.getPrice()%></td>
					<td><%=item.getQuantity()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<button type="submit">Remove Selected</button>
	</form>
	<!-- Button Container for Checkout and Go Back -->
	<div class="button-container">
	    <!-- Proceed to Checkout Button -->
	    <form action="${pageContext.request.contextPath}/cart/checkout" method="get">
	        <button type="submit" class="proceed-checkout">Proceed to Checkout</button>
	    </form>
	    <!-- Go Back Button -->
	    <form action="${pageContext.request.contextPath}/products/display1" method="get">
	        <button type="submit" class="go-back">Go to Products Page</button>
	    </form>
	</div>



	<%
	} else {
	%>
	<p>Your cart is empty.</p>
	<%
	}
	%>



	<%@include file="message.jsp"%>

</body>
</html>
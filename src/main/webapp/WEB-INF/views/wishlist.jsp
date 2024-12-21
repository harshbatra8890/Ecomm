<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="ecom.app.entities.Wishlist"%>
<%@ page import="ecom.app.entities.Products"%>
<%@ page import="ecom.app.entities.User"%>

<html>
<head>
    <title>Your Wishlist</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #F2EED7; /* Soft background */
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0px;
        }

        h1 {
            color: #FF9874; /* Soft orange */
            text-align: center;
            margin-bottom: 20px;
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
							       white-space: nowrap; /* Prevent line break */
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
							
				

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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

        button {
            background-color: #295F98; /* Dark blue */
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-right: 5px;
        }

        button:hover {
            background-color: #1a3a6e; /* Darker blue */
        }

        .message, .error {
            text-align: center;
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
        }

        .error {
            color: red;
            background-color: #f8d7da; /* Light red background */
        }

        .message {
            color: green;
            background-color: #d4edda; /* Light green background */
        }

     
    </style>
</head>
<body>


	<%
		User user = (User) session.getAttribute("user");
		
		%>

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
			       <% 
			           if (user != null) { %>
			        	   <li><a href="${pageContext.request.contextPath}/homepageuser">Home</a></li>
						   <li><a href="${pageContext.request.contextPath}/cart/view">Cart Item</a></li>    
			<%
			} else {
			%>
			          <li><a href="${pageContext.request.contextPath}/">Home</a></li>
					   <li><a href="${pageContext.request.contextPath}/user/login">Cart Item</a></li>
			
			<%
			}
			%>
			       
			       
					   
			           <li class="shop-dropdown">
			               <a href="#">Shop</a>
			               <ul class="dropdown-content">
			                   <li><a href="${pageContext.request.contextPath}/explore-all-categories">Shop by Category</a></li>
			                   <li><a href="${pageContext.request.contextPath}/products/display1">All Products</a></li>
			               </ul>
			           </li>
			       </ul>
			   </nav>
	 

    <h1>Your Wishlist</h1>

    <%
    // Display messages from RedirectAttributes
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");

    if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
    }
    if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
    }

    List<Wishlist> wishlistItems = (List<Wishlist>) request.getAttribute("wishlistItems");
    List<Products> products = (List<Products>) request.getAttribute("products");

    if (wishlistItems != null && !wishlistItems.isEmpty()) {
    %>
    <table>
        <thead>
            <tr>
                <th>Product Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
            for (int i = 0; i < wishlistItems.size(); i++) {
                Wishlist item = wishlistItems.get(i);
                Products product = products.get(i);
            %>
            <tr>
                <td><%= product != null ? product.getProduct_name() : "Product not found" %></td>
                <td><%= product != null ? product.getDescription() : "Description not available" %></td>
                <td>&#8377;<%= product != null ? product.getFinal_price() : "Price not available" %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/wishlist/moveToCart" method="post" style="display:inline;">
                        <input type="hidden" name="wishlistId" value="<%= item.getWishlistId() %>">
                        <button type="submit">Move to Cart</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/wishlist/remove" method="post" style="display:inline;">
                        <input type="hidden" name="wishlistId" value="<%= item.getWishlistId() %>">
                        <button type="submit">Remove</button>
					
					</form>
                    </form>
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
    <%
    } else {
    %>
    <p>Your wishlist is empty.</p>
    <%
    }
    %>
</body>
</html>

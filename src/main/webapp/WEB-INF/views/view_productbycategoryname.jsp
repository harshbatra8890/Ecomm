<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ecom.app.entities.Products" %>
<%@ page import="java.util.List" %>
<%@ page import="ecom.app.entities.Category" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Search by Category Name</title>
    <style>
		body {
		    background-color: #F2EED7; /* Soft background */
		    font-family: 'Arial', sans-serif;
		    padding: 40px; /* Increased padding for better layout */
		}

		.search-container {
		    background: linear-gradient(135deg, #ffffff, #f9f9f9); /* Subtle gradient */
		    border-radius: 15px; /* Rounded corners */
		    padding: 40px;
		    margin: 0 auto;
		    max-width: 600px; /* Wider container */
		    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2); /* Deeper shadow */
		}

		h2 {
		    color: #FF9874; /* Soft orange */
		    margin-bottom: 30px;
		    text-align: center;
		    font-size: 28px; /* Increased font size */
		    text-transform: uppercase; /* Uppercase for emphasis */
		}

		.form-group {
		    margin-bottom: 20px; /* Spacing between form groups */
		}

		label {
		    display: block; /* Block display for labels */
		    margin-bottom: 8px; /* Space below labels */
		    color: #295F98; /* Dark blue for labels */
		    font-weight: bold; /* Bold labels */
		}

		select {
		    width: 100%; /* Full width */
		    padding: 12px; /* Padding for inputs */
		    border: 1px solid #ccc; /* Light border */
		    border-radius: 5px; /* Rounded edges */
		    transition: border-color 0.3s; /* Smooth transition */
		}

		select:focus {
		    border-color: #FF9874; /* Highlight border on focus */
		    outline: none; /* Remove outline */
		}

		.btn-search {
		    background-color: #295F98; /* Dark blue */
		    border: none; /* No border */
		    color: white; /* White text */
		    font-size: 18px; /* Larger font size */
		    width: 40%;
		    border-radius: 5px;
		    padding: 12px; /* Padding for a better click area */
		    cursor: pointer;
		    transition: background-color 0.3s, transform 0.2s; /* Smooth transitions */
		}

		.btn-search:hover {
		    background-color: #1a3a6e; /* Darker blue on hover */
		    transform: translateY(-2px); /* Lift effect */
		}

		table {
		    width: 100%;
		    border-collapse: collapse; /* Removes gaps between cells */
		    margin-top: 30px; /* Space above the table */
		    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Shadow for table */
		}

		th, td {
		    padding: 15px; /* More padding for cells */
		    text-align: left;
		    border-bottom: 2px solid #ddd; /* Bottom border for cells */
		}

		th {
		    background-color: #295F98; /* Dark blue for header */
		    color: white; /* White text */
		    font-weight: bold; /* Bold text for header */
		    text-transform: uppercase; /* Uppercase for header */
		}

		tbody tr {
		    transition: background-color 0.3s; /* Smooth transition for row hover */
		}

		tbody tr:hover {
		    background-color: #FFFCF2; /* Soft highlight color on row hover */
		}

		td {
		    color: #333; /* Dark text color */
		}

		img {
		    width: 70px; /* Increased width for better visibility */
		    height: auto; /* Maintain aspect ratio */
		    border-radius: 5px; /* More pronounced rounded corners */
		}

	 .back-button {
            position: absolute; /* Position it in the top right */
            right: 20px;
            top: 20px;
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            background-color: #295F98; /* Soft orange */
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #1a3a6e; /* Darker orange on hover */
        }

    </style>
</head>
<body>

    <div class="container">
        <div class="search-container">
            <h2>Search by Category Name</h2>
 
                 <a href="/subadmin" class="back-button">Back to Dashboard</a>
        
       
            <form action="/products/view_productbycategoryname" method="get">
        <div class="form-group">
            <label for="categoryName">Select Category:</label>
            <select name="category_id" id="category_id" required>
                <option value="" disabled selected>Select a category</option>
                <%
                    // Fetch categories from request attribute
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    if (categories != null) {
                        for (Category category : categories) {
                %>
                            <option value="<%= category.getCategory_id() %>"><%= category.getCategory_name() %></option>
                <%
                        }
                    }
                %>
            </select>
        </div>
        <button type="submit" class="btn-search">Search Products</button>
    </form>
        </div>
    </div>
    
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Product Image</th>
                    <th>Product Name</th>
                    <th>Description</th>
                    <th>MRP</th>
                    <th>Discount</th>
                    <th>Final Price</th>
                    <th>Stock</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Products> products = (List<Products>) request.getAttribute("products");
                    if (products != null) {
                        for (Products product : products) {
                %>
                    <tr>
                        <td><%= product.getProduct_id() %></td>
                        <td>
                            <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="Product Image">
                        </td>
                        <td><%= product.getProduct_name() %></td>
                        <td><%= product.getDescription() %></td>
                        <td><%= product.getMrp() %></td>
                        <td><%= product.getDiscount() %></td>
                        <td><%= product.getFinal_price() %></td>
                        <td><%= product.getStock() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8">No products found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    
   

</body>
</html>

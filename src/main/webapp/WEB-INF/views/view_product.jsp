<%@ page import="ecom.app.entities.Products"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>View Products</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #F2EED7; /* Soft background */
        }
        .message {
            font-size: 24px;
            font-weight: bold;
            color: #FF9874; /* Soft orange */
            margin-bottom: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: relative; /* For absolute positioning of the button */
        }
        /* Centering the search bar */
        .search-container {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-bar {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            width: 80%; /* Adjust width */
            max-width: 600px; /* Max width */
            display: inline-block; /* Center alignment */
        }
        table {
            width: 100%;
            border-collapse: collapse;
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
            background-color: #f1f1f1; /* Light Gray on hover */
        }
        img {
            border-radius: 4px;
            object-fit: cover; 
        }
        .btn {
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            background-color: #295F98; /* Dark blue */
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #1a3a6e; /* Darker blue */
        }
        .back-button {
            position: absolute; /* Position it in the top right */
            right: 20px;
            top: 20px;
            padding: 10px 15px;
            border-radius: 5px;
            color: white;
            background-color: #295F98; /* Dark blue */
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .back-button:hover {
            background-color: #1a3a6e; /* Darker blue on hover */
        }
        /* Responsive Styles */
        @media (max-width: 768px) {
            th, td {
                padding: 8px;
                font-size: 14px;
            }
            .message {
                font-size: 20px;
            }
            img {
                width: 40px; 
                height: 40px;
            }
        }
    </style>
</head>
<body>
    <div class="message">All Products</div>

    <div class="container">
        <!-- Back to Dashboard Button -->
        <a href="/subadmin" class="back-button">Back to Dashboard</a>

        <!-- Search Bar Centered in the Container -->
        <div class="search-container">
            <input type="text" id="filter" class="search-bar" placeholder="Search for products..." />
        </div>

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
            <tbody id="product-table-body">
    <%
        List<Products> products = (List<Products>) request.getAttribute("products");
        if (products != null) {
            for (Products product : products) {
    %>
                <tr class="product-row" 
                    data-id="<%= product.getProduct_id() %>"
                    data-name="<%= product.getProduct_name().toLowerCase() %>"
                    data-description="<%= product.getDescription().toLowerCase() %>"
                    data-mrp="<%= product.getMrp() %>"
                    data-discount="<%= product.getDiscount() %>"
                    data-final_price="<%= product.getFinal_price() %>"
                    data-stock="<%= product.getStock() %>">
                    <td><%= product.getProduct_id() %></td>
                    <td>
                        <img src="data:image/jpeg;base64,<%= product.getBase64ProductImage() %>" alt="Product Image" style="width:50px;height:50px;">
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

    <script>
        function filterProducts() {
            const filterValue = document.getElementById('filter').value.toLowerCase();
            const rows = document.querySelectorAll('.product-row');

            rows.forEach(row => {
                const id = row.dataset.id.toString().toLowerCase();
                const name = row.dataset.name;
                const description = row.dataset.description;
                const mrp = row.dataset.mrp.toString();
                const discount = row.dataset.discount.toString();
                const finalPrice = row.dataset.final_price.toString();
                const stock = row.dataset.stock.toString();

                // Check if any of the attributes include the filter value
                const matches = id.includes(filterValue) || 
                                name.includes(filterValue) || 
                                description.includes(filterValue) || 
                                mrp.includes(filterValue) || 
                                discount.includes(filterValue) || 
                                finalPrice.includes(filterValue) || 
                                stock.includes(filterValue);
                
                row.style.display = matches ? '' : 'none';
            });
        }

        document.getElementById('filter').addEventListener('input', filterProducts);
    </script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ecom.app.entities.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Product</title>
    <style>
		body {
		    background-color: #F2EED7; /* Soft green background */
		    font-family: Arial, sans-serif;
		    padding: 20px;
		}

		.form-container {
		    border: 1px solid #295F98; /* Dark blue border */
		    border-radius: 10px;
		    background-color: #ffffff;
		    padding: 40px;
		    margin: 50px auto;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		    max-width: 800px;
		}

		h2 {
		    color: #FF9874; /* Soft orange for headings */
		    margin-bottom: 20px;
		    text-align: center;
		}

		.message {
		    color: #FF9874; /* Soft orange for messages */
		    margin-bottom: 20px;
		    text-align: center;
		}

		label {
		    font-weight: bold;
		    color: #295F98; /* Dark blue for labels */
			
		}

		.form-control {
		    border-radius: 5px;
		    border: 1px solid #cccccc;
		    width: 97%;
		    margin-bottom: 15px;
		    padding: 10px;
		}

		.btn {
		    border-radius: 5px;
		    font-size: 16px;
		    margin-top: 10px;
		    padding: 10px;
		    width: 100%;
		    border: none; /* No border for buttons */
		}

		.btn-danger {
		    background-color:#295F98 ; /* Soft orange for reset button */
			color: white; 
		}

		.btn-danger:hover {
		    background-color: #1a3a6e; /* Slightly darker orange on hover */
		}

		.btn-success {
		    background-color: #295F98; /* Dark blue for submit button */
		    color: white; /* White text for contrast */
		}

		.btn-success:hover {
		    background-color: #1a3a6e; /* Darker blue on hover */
		}

		.error {
		    color: red; /* Error messages in red */
		}

    </style>
</head>
<body>

    <div class="container">
        <div class="row">
            <form class="form-container" enctype="multipart/form-data" method="post" action="/products/add" id="productForm">
                <div class="text-center">
                    <h2>Product Addition</h2>
                    <p class="message">Enter the product details below.</p>
                </div>
                <div class="form-group"> 
              <label for="name">Product Name</label>
                 <input type="text" placeholder="Enter Product Name" name="product_name" class="form-control" id="name" 
                maxlength="20" required pattern="^[^\d].*" title="Product name should not start with a number.">
             <span id="productNameError" style="color:red" class="error"></span>
                </div>

                <div class="form-group">
                    <label for="description">Product Description</label>
                    <textarea name="description" placeholder="Enter Product Description" class="form-control" 
                              id="description" maxlength="40" required></textarea>
                </div>
                <div class="form-group">
                    <label for="mrp">MRP</label>
                    <input type="number" step="0.01" placeholder="Enter MRP" name="mrp" class="form-control" id="mrp" 
                           required min="0" max="99999.99" oninput="validateMRP(); calculateFinalPrice()">
                    <span id="mrpError" style="color:red"></span>
                </div>
                <div class="form-group">
           <label for="discount">Discount in Percentage(%)</label>
           <input type="number" step="0.1" placeholder="Enter Discount" name="discount" class="form-control" 
           id="discount" min="0" max="99.9" oninput="validateDiscount(); calculateFinalPrice()" required>
        <span id="discountError" style="color:red" class="error"></span>
        </div>

      <div class="form-group">
    <label for="delivery_charges">Delivery Charges</label>
    <input type="number" step="0.1" placeholder="Enter Delivery Charges" name="delivery_charge" 
           class="form-control" id="delivery_charges" min="0" max="999.9" required oninput="validateDeliveryCharge(); calculateFinalPrice()">
    <span id="deliveryChargeError" style="color:red" class="error"></span>
    </div>

    <div class="form-group">
    <label for="final_price">Final Price</label>
    <input type="number" step="0.01" placeholder="Final Price" name="final_price" 
           class="form-control" id="final_price" required readonly>
      </div>

<div class="form-group">
    <label for="stock">Stock Quantity</label>
    <input type="number" placeholder="Enter Stock Quantity" name="stock" class="form-control" 
           id="stock" required min="1" oninput="validateStock()">
    <span id="stockError" style="color:red" class="error"></span>
</div>

                <div class="form-group">
                    <label for="category_id">Category</label>
                    <select name="category_id" id="category_id" class="form-control" required>
                        <%
                            List<Category> categories = (List<Category>) request.getAttribute("categories");
                            for (Category category : categories) {
                        %>
                        <option value="<%= category.getCategory_id() %>"><%= category.getCategory_name() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
               <div class="form-group">
    <label for="image">Product Image</label>
    <input type="file" name="product_image" class="form-control" id="image" required accept="image/*" 
           title="Only JPG, JPEG, PNG formats are allowed." onchange="validateImageFile()">
    <span id="imageError" style="color:red" class="error"></span>
</div>


                <div class="row">
                    <div class="col-md-6">
                        <button type="reset" class="btn btn-danger">Reset</button>
                    </div>
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-success">Add Product</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        function calculateFinalPrice() {
            const mrp = parseFloat(document.getElementById('mrp').value) || 0;
            const discount = parseFloat(document.getElementById('discount').value) || 0;
            const deliveryCharge = parseFloat(document.getElementById('delivery_charges').value) || 0;

            const finalPrice = mrp - (discount * mrp / 100) + deliveryCharge;
            document.getElementById('final_price').value = finalPrice.toFixed(2);
        }

        function validateMRP() {
            const mrp = document.getElementById('mrp').value;
            if (mrp.length > 5) {
                document.getElementById('mrpError').innerText = 'MRP exceeds the allowed limit (5 digits).';
            } else {
                document.getElementById('mrpError').innerText = '';
            }
        }
        
     // Validate Discount
        function validateDiscount() {
            const discount = parseFloat(document.getElementById('discount').value);
            if (isNaN(discount) || discount < 0 || discount > 99.9) {
                document.getElementById('discountError').innerText = 'Discount should be between 0 and 99.9.';
            } else {
                document.getElementById('discountError').innerText = '';
            }
        }

        // Validate Delivery Charge
        function validateDeliveryCharge() {
            const deliveryCharge = parseFloat(document.getElementById('delivery_charges').value);
            if (isNaN(deliveryCharge) || deliveryCharge < 0 || deliveryCharge > 999.9) {
                document.getElementById('deliveryChargeError').innerText = 'Delivery charge must be between 0 and 999.9.';
            } else {
                document.getElementById('deliveryChargeError').innerText = '';
            }
        }

        // Validate Stock
        function validateStock() {
            const stock = parseInt(document.getElementById('stock').value);
            if (isNaN(stock) || stock < 1) {
                document.getElementById('stockError').innerText = 'Stock quantity must be a positive integer.';
            } else {
                document.getElementById('stockError').innerText = '';
            }
        }
        
     // Validate Product Name
        function validateProductName() {
            const productName = document.getElementById('name').value;
            const productNameError = document.getElementById('productNameError');

            // Check if product name starts with a number
            if (/^\d/.test(productName)) {
                productNameError.innerText = 'Product name should not start with a number.';
            } else if (productName.length > 20) {
                productNameError.innerText = 'Product name must be 20 characters or less.';
            } else {
                productNameError.innerText = '';
            }
        }

        // Add the validation to the input field on input event
        document.getElementById('name').addEventListener('input', validateProductName);
        
     // Validate Image File Type
        function validateImageFile() {
            const imageFile = document.getElementById('image').files[0];
            const imageError = document.getElementById('imageError');

            if (imageFile) {
                const fileExtension = imageFile.name.split('.').pop().toLowerCase();
                const validExtensions = ['jpg', 'jpeg', 'png'];

                if (!validExtensions.includes(fileExtension)) {
                    imageError.textContent = 'Invalid file type. Please upload a JPG, JPEG, or PNG image.';
                    document.getElementById('image').value = ''; // Clear the input
                } else {
                    imageError.textContent = ''; // Clear any previous error messages
                }
            }
        }




    </script>
</body>
</html>

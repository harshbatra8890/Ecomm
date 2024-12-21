<%@ page import="ecom.app.entities.Products"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F2EED7; 
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .message {
            font-size: 24px;
            font-weight: bold;
            color: #FF9874;
            margin-bottom: 20px;
            text-align: center;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #295F98;
        }
        input[type="text"],
        input[type="number"],
        input[type="file"],
        textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0 20px 0;
            border: 2px solid #295F98; 
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #295F98;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #1a3a6e;
        }
        .error-message {
            color: red;
            font-weight: bold;
            text-align: center;
            margin-top: 10px;
        }
    </style>
    <script>
        // Validation Functions
        function validateProductName() {
            const productName = document.getElementById('product_name');
            const nameError = document.getElementById('nameError');
            const pattern = /^[^\d].*/; // Should not start with a number

            if (!pattern.test(productName.value)) {
                nameError.textContent = 'Product name should not start with a number.';
            } else {
                nameError.textContent = '';
            }
        }

        function validateMRP() {
            const mrp = document.getElementById('mrp');
            const mrpError = document.getElementById('mrpError');
            const min = 0;
            const max = 9999999.99;

            if (mrp.value < min || mrp.value > max) {
                mrpError.textContent = 'MRP must be between 0 and 9999999.99.';
            } else {
                mrpError.textContent = '';
            }
        }

        function validateDiscount() {
            const discount = document.getElementById('discount');
            const discountError = document.getElementById('discountError');
            const min = 0;
            const max = 99.9;

            if (discount.value < min || discount.value > max) {
                discountError.textContent = 'Discount must be between 0 and 99.9.';
            } else {
                discountError.textContent = '';
            }
        }

        function validateDeliveryCharge() {
            const deliveryCharge = document.getElementById('delivery_charge');
            const deliveryChargeError = document.getElementById('deliveryChargeError');
            const min = 0;
            const max = 999.9;

            if (deliveryCharge.value < min || deliveryCharge.value > max) {
                deliveryChargeError.textContent = 'Delivery Charge must be between 0 and 999.9.';
            } else {
                deliveryChargeError.textContent = '';
            }
        }

        function validateStock() {
            const stock = document.getElementById('stock');
            const stockError = document.getElementById('stockError');
            const min = 1;

            if (stock.value < min) {
                stockError.textContent = 'Stock quantity must be at least 1.';
            } else {
                stockError.textContent = '';
            }
        }

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
</head>
<body>
    <div class="container">
        <div class="message">Update Product</div>

        <% 
            Products product = (Products) request.getAttribute("product"); 
            if (product != null) {
        %>
            <form action="${pageContext.request.contextPath}/products/product_updation" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                <input type="hidden" name="product_id" value="<%= product.getProduct_id() %>">

                <label for="product_name">Product Name:</label>
                <input type="text" id="product_name" name="product_name" value="<%= product.getProduct_name() %>" required oninput="validateProductName()" />
                <span id="nameError" class="error-message"></span>

                <label for="description">Description:</label>
                <textarea id="description" name="description" required><%= product.getDescription() %></textarea>

                <label for="mrp">MRP:</label>
                <input type="number" id="mrp" name="mrp" value="<%= product.getMrp() %>" required oninput="validateMRP()" />
                <span id="mrpError" class="error-message"></span>

                <label for="discount">Discount in Percentage:</label>
                <input type="number" id="discount" name="discount" value="<%= product.getDiscount() %>" required oninput="validateDiscount()" />
                <span id="discountError" class="error-message"></span>

                <label for="delivery_charge">Delivery Charge:</label>
                <input type="number" id="delivery_charge" name="delivery_charge" value="<%= product.getDelivery_charge() %>" required oninput="validateDeliveryCharge()" />
                <span id="deliveryChargeError" class="error-message"></span>

                <label for="final_price">Final Price:</label>
                <input type="number" id="final_price" name="final_price" value="<%= product.getFinal_price() %>" required />

                <label for="stock">Stock:</label>
                <input type="number" id="stock" name="stock" value="<%= product.getStock() %>" required oninput="validateStock()" />
                <span id="stockError" class="error-message"></span>

                <label for="image">Product Image</label>
    <input type="file" name="product_image" class="form-control" id="image"  accept="image/*" 
           title="Only JPG, JPEG, PNG formats are allowed." onchange="validateImageFile()">
    <span id="imageError" style="color:red" class="error"></span>

                <button type="submit">Update Product</button>
            </form>
        <% } else { %>
            <div class="error-message">Product not found.</div>
        <% } %>
    </div>
</body>
</html>

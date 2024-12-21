<%@ page import="ecom.app.entities.CartItems"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout</title>
<style>
body {
	background: linear-gradient(to bottom right, #F2EED7, #e1d4b7);
	/* Gradient background */
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 20px;
}

h1, h2 {
	color: #FF9874; /* Soft orange */
	text-align: center;
	margin: 10px 0;
	font-weight: 700; /* Bold font */
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1); /* Subtle shadow */
}

.address-section, .order-summary {
	background-color: #ffffff; /* White background for sections */
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 4px 25px rgba(0, 0, 0, 0.2); /* Deeper shadow */
	margin-bottom: 30px;
	transition: transform 0.3s, box-shadow 0.3s; /* Smooth transition */
}

.address-section:hover, .order-summary:hover {
	transform: translateY(-4px); /* Lift effect on hover */
	box-shadow: 0 8px 40px rgba(0, 0, 0, 0.3);
	/* Stronger shadow on hover */
}

.address-input {
	width: 100%; /* Full width */
	height: 150px; /* Increased height for more space */
	padding: 15px; /* Adjusted padding for better spacing */
	font-size: 18px; /* Font size for readability */
	box-sizing: border-box;
	/* Ensures padding and border are included in total width */
	border-radius: 8px; /* Rounded corners */
	transition: border-color 0.3s, box-shadow 0.3s;
	/* Smooth transition for focus */
	resize: vertical; /* Allow vertical resizing */
}

.address-input:focus {
	box-shadow: 0 0 5px rgba(255, 152, 116, 0.5); /* Subtle glow */
	outline: none; /* Remove default outline */
}

.address-actions {
	margin-top: 15px;
	text-align: center;
}

.proceed-button, .edit-button, .confirm-button {
	background-color: #295F98; /* Dark blue */
	color: white;
	border: none;
	padding: 12px 25px;
	font-size: 16px;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s, transform 0.2s;
	margin: 5px; /* Space between buttons */
	font-weight: 600; /* Bold button text */
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
}

.proceed-button:hover, .edit-button:hover, .confirm-button:hover {
	background-color: #1a3a6e; /* Darker blue */
	transform: scale(1.05); /* Slightly enlarge on hover */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
	/* Enhanced shadow on hover */
}

.confirm-button:disabled {
	background-color: #ccc; /* Disabled button color */
	cursor: not-allowed;
}

.order-summary table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

thead {
	background-color: #295F98; /* Dark blue */
	color: white;
}

th, td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

tbody tr:hover {
	background-color: rgba(255, 152, 116, 0.1); /* Light hover effect */
}

.total {
	font-weight: bold; /* Bold for total */
	color: #295F98; /* Use primary color for emphasis */
}

button {
	background-color: #295F98; /* Dark blue */
	color: white;
	border: none;
	padding: 12px 20px;
	border-radius: 6px;
	cursor: pointer;
	margin-top: 20px;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #1a3a6e; /* Darker blue */
}

/* Responsive styling */
@media ( max-width : 768px) {
	.address-input {
		font-size: 14px; /* Smaller font for mobile */
	}
	.proceed-button, .edit-button, .confirm-button {
		font-size: 14px; /* Smaller button text */
		padding: 10px 15px; /* Adjust button padding */
	}
}
</style>
<script>
	function makeAddressReadOnly() {
		document.getElementById('deliveryAddress').readOnly = true;
	}

	function makeAddressEditable() {
		document.getElementById('deliveryAddress').readOnly = false;
		document.getElementById('deliveryAddress').focus();
	}

	function handleDeliveryButtonClick() {
		const deliveryAddress = document.getElementById('deliveryAddress').value;
		if (!deliveryAddress.trim()) {
			alert("Please enter your delivery address.");
			return;
		}
		document.getElementById('addressForm').submit();
	}

	function validateAddress() {
		const address = document.getElementById('deliveryAddress').value.trim();
		const confirmButton = document.getElementById('confirmButton');
		if (address === "") {
			confirmButton.disabled = true;
		} else {
			confirmButton.disabled = false;
		}
	}

	document.addEventListener("DOMContentLoaded", function() {
		document.getElementById('deliveryAddress').addEventListener('input',
				validateAddress);
		validateAddress(); // Check initially if the address is already filled
	});
</script>
</head>
<body>
	<h1>Checkout</h1>

	<div class="address-section">
		<h2>Delivery Address</h2>
		<%
		String deliveryAddress = (String) session.getAttribute("deliveryAddress");
		%>
		<form id="addressForm"
			action="${pageContext.request.contextPath}/address/saveAddress"
			method="post">
			<label for="deliveryAddress">Delivery Address:</label> <input
				type="text" id="deliveryAddress" name="deliveryAddress"
				class="address-input" maxlength="50" required
				value="<%=deliveryAddress != null ? deliveryAddress : ""%>"
				<%=deliveryAddress != null && !deliveryAddress.isEmpty() ? "readOnly" : ""%> />
			<div class="address-actions">
				<button type="button" class="proceed-button"
					onclick="handleDeliveryButtonClick()">Deliver to this
					Address</button>
				<button type="button" class="edit-button"
					onclick="makeAddressEditable()">Edit Delivery Address</button>
			</div>
		</form>
	</div>

	<div class="order-summary">
		<h2>Order Summary</h2>

		<%
		List<String> outOfStockMessages = (List<String>) session.getAttribute("outOfStockMessages");
		if (outOfStockMessages != null && !outOfStockMessages.isEmpty()) {
		%>
		<div class="alert alert-warning">
			<h3>Out of Stock Items:</h3>
			<ul>
				<%
				for (String message : outOfStockMessages) {
				%>
				<li><%=message%></li>
				<%
				}
				%>
			</ul>
		</div>
		<%
		session.removeAttribute("outOfStockMessages");
		}
		%>

		<table>
			<thead>
				<tr>
					<th>Product Name</th>
					<th>Quantity</th>
					<th>Price</th>
					<th>Subtotal</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<CartItems> cartItems = (List<CartItems>) request.getAttribute("cartItems");
				double total = 0.0;
				Double deliveryChargeObj = (Double) request.getAttribute("deliveryCharge");
				double deliveryCharge = (deliveryChargeObj != null) ? deliveryChargeObj : 0.0;

				if (cartItems != null && !cartItems.isEmpty()) {
					for (CartItems item : cartItems) {
						double itemTotal = item.getPrice() * item.getQuantity();
						total += itemTotal;
				%>
				<tr>
					<td><%=item.getProductName()%></td>
					<td><%=item.getQuantity()%></td>
					<td><%=String.format("%.2f", item.getPrice())%></td>
					<td><%=String.format("%.2f", itemTotal)%></td>
				</tr>
				<%
				}
				total += deliveryCharge;
				%>
				<tr>
					<td colspan="3" class="total">Delivery Charge</td>
					<td><%=String.format("%.2f", deliveryCharge)%></td>
				</tr>
				<tr>
					<td colspan="3" class="total">Total</td>
					<td><%=String.format("%.2f", total)%></td>
				</tr>
				<%
				} else {
				%>
				<tr>
					<td colspan="4">No items in your cart.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<form action="/payment/openPaymentPage" method="get">
			<input type="hidden" name="totalAmount" value="<%=total%>">
			<button type="submit" class="confirm-button" id="confirmButton">Confirm
				Order</button>
		</form>
	</div>
</body>
</html>

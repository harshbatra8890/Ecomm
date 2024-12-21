<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Make a Payment</title>
<style>
	body {
	    background-color: #F2EED7; /* Soft background */
	    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	    margin: 0;
	    padding: 40px;
	}

	h2 {
	    color: #FF9874; /* Soft orange */
	    text-align: center;
	    margin-bottom: 30px;
	    font-size: 2em;
	    text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
	}

	.form-container {
	    background-color: white;
	    border-radius: 15px;
	    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
	    padding: 40px;
	    transition: transform 0.3s;
	}

	.form-container:hover {
	    transform: translateY(-5px);
	}

	.form-group {
	    margin-bottom: 20px;
	}

	label {
	    font-weight: bold;
	    color: #295F98; /* Dark blue */
	    display: block;
	    margin-bottom: 5px;
	}

	.form-control {
	    border: 2px solid #ddd; /* Light border */
	    border-radius: 8px;
	    padding: 15px;
	    font-size: 1em;
	    transition: border-color 0.3s, box-shadow 0.3s;
		width:20%;
	}

	.form-control:focus {
	    border-color: #295F98 ; /* Soft orange */
	    box-shadow:gray;
	}

	.btn {
	    background-color: #295F98; /* Dark blue */
	    color: white;
	    border: none;
	    border-radius: 8px;
	    padding: 12px 20px;
	    font-size: 1em;
	    cursor: pointer;
	    transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
	    display: block;
	    width: 30%;
	}

	.btn:hover {
	    background-color: #1a3a6e; /* Darker blue */
	    transform: translateY(-3px); /* Lift effect */
	    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Shadow on hover */
	}

	.error-message {
	    display: none; /* Hide error messages by default */
	    color: #d9534f; /* Bootstrap danger color */
	    font-size: 0.9em;
	    margin-top: 5px;
	}

	#bankTransferDetails,
	#upiDetails,
	#cardDetails,
	#codDetails {
	    background-color: #f9f9f9; /* Light background for details sections */
	    padding: 15px;
	    border-radius: 10px;
	    border: 1px solid #ddd; /* Light border */
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
	}

	#bankTransferDetails input,
	#upiDetails input,
	#cardDetails input {
	    margin-bottom: 15px; /* Space between inputs */
	}

</style>

<script>
    <%LocalDate today = LocalDate.now();
    String formattedDate = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));%>
    
    function handlePaymentMethodChange() {
        const paymentMethod = document.getElementById("paymentMethod").value;
        document.getElementById("paymentMethodInput").value = paymentMethod;

        const fields = {
            bankTransfer: document.getElementById("bankTransferDetails"),
            upi: document.getElementById("upiDetails"),
            credit: document.getElementById("cardDetails"),
            debit: document.getElementById("cardDetails"),
            cod: document.getElementById("codDetails")
        };

        // Reset validity and hide all fields
        Object.values(fields).forEach(field => {
            field.style.display = "none";
            field.querySelectorAll('input, select').forEach(input => {
                input.setCustomValidity(''); // Clear validation messages
                input.value = ''; // Clear input values
            });
        });

        // Show the selected payment method's fields
        if (fields[paymentMethod]) {
            fields[paymentMethod].style.display = "block";
        }

        // Show or hide the Proceed to Payment button
        const proceedButton = document.getElementById("proceedButton");
        if (paymentMethod) {
            proceedButton.style.display = "block"; // Show button if a payment method is selected
        } else {
            proceedButton.style.display = "none"; // Hide button if no payment method is selected
        }
    }

    window.onload = handlePaymentMethodChange;
</script>

</head>
<body>
	<div class="container">
		<div class="form-container card p-4">
			<h2 class="text-center mb-4">Make a Payment</h2>
			<form method="post" action="/order/confirm">
				<!-- Change this line -->
				<input type="hidden" name="totalAmount" value="${totalAmount}">
				<input type="hidden" id="paymentMethodInput" name="paymentMethod"
					required>

				<div class="form-group">
    <label for="paymentMethod">Payment Method:</label> 
    <select class="form-control" id="paymentMethod" onchange="handlePaymentMethodChange()">
        <option value="">Select a Payment Method</option> <!-- Default option -->
        <option value="bankTransfer">Bank Transfer</option>
        <option value="upi">UPI</option>
        <option value="credit">Credit Card</option>
        <option value="debit">Debit Card</option>
        <option value="cod">Cash on Delivery</option>
    </select>
</div>

				<div class="form-group">
					<label for="price">Amount:</label> <input type="number"
						class="form-control" id="price" name="price" step="0.01"
						value="${totalAmount}" readonly>
				</div>

				<div class="form-group">
					<label for="paymentDate">Payment Date:</label> <input type="text"
						class="form-control" id="paymentDate" name="paymentDate"
						value="<%=formattedDate%>" readonly>
				</div>

				<div id="bankTransferDetails" class="form-group"
					style="display: none;">
					<label for="bankName">Bank Name:</label> <select
						class="form-control" id="bankName" name="bankName">
						<option value="">Select a Bank</option>
						<option value="SBI">State Bank of India (SBI)</option>
						<option value="HDFC">HDFC Bank</option>
						<option value="ICICI">ICICI Bank</option>
						<option value="Kotak">Kotak Mahindra Bank</option>
						<option value="Axis">Axis Bank</option>
						<option value="BankOfBaroda">Bank of Baroda</option>
					</select> <span id="bankNameError" class="error-message text-danger">Please
						select a bank.</span> <label for="accountNumber">Account Number:</label>
					<input type="text" class="form-control" id="accountNumber"
						name="accountNumber" placeholder="Enter Account Number"> <span
						id="accountNumberError" class="error-message text-danger">Please
						enter a valid account number (10-18 digits).</span> <label for="ifscCode">IFSC
						Code:</label> <input type="text" class="form-control" id="ifscCode"
						name="ifscCode" placeholder="Enter IFSC Code"> <span
						id="ifscCodeError" class="error-message text-danger">Please
						enter a valid IFSC code.</span>
				</div>


				<div id="upiDetails" class="form-group" style="display: none;">
					<label for="upiId">UPI ID:</label> <input type="text"
						class="form-control" id="upiId" name="upiId"
						placeholder="Enter UPI ID">
				</div>

				<div id="cardDetails" class="form-group" style="display: none;">
					<label for="cardNumber">Card Number:</label> <input type="text"
						class="form-control" id="cardNumber" name="cardNumber"
						placeholder="0000-0000-0000-0000" maxlength="19"
						pattern="^(\d{4}-){3}\d{4}$"> <label for="expiryDate">Expiry
						Date (MM/YY):</label> <input type="text" class="form-control"
						name="expiryDate" placeholder="MM/YY" maxlength="5"
						pattern="^(0[1-9]|1[0-2])\/\d{2}$"> <label for="cvv">CVV:</label>
					<input type="password" class="form-control" name="cvv"
						placeholder="Enter CVV" maxlength="3"> <label
						for="cardHolderName">Card Holder Name:</label> <input type="text"
						class="form-control" name="cardHolderName"
						placeholder="Enter Card Holder Name">
				</div>

				<div id="codDetails" class="form-group" style="display: none;">
					<p>Cash on Delivery is selected. Please prepare the exact
						amount for the delivery.</p>
				</div>

				<button type="submit" class="btn btn-primary btn-block" id="proceedButton" style="display: none;">Proceed to Payment</button>

			</form>
		</div>
	</div>
</body>
</html>

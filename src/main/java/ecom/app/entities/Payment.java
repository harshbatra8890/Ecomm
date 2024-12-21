package ecom.app.entities;

public class Payment {
    private String transactionId;
    private String paymentMethod;
    private String bankName;
    private String accountNumber;
    private String ifscCode;
    private String upiId;
    private String cardNumber;
    private String expiryDate;
    private String cardHolderName;
    private double amount;
    private String status;
    
	public Payment() {
		super();
	}

	public Payment(String transactionId, String paymentMethod, String bankName, String accountNumber, String ifscCode,
			String upiId, String cardNumber, String expiryDate, String cardHolderName, double amount, String status) {
		super();
		this.transactionId = transactionId;
		this.paymentMethod = paymentMethod;
		this.bankName = bankName;
		this.accountNumber = accountNumber;
		this.ifscCode = ifscCode;
		this.upiId = upiId;
		this.cardNumber = cardNumber;
		this.expiryDate = expiryDate;
		this.cardHolderName = cardHolderName;
		this.amount = amount;
		this.status = status;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getIfscCode() {
		return ifscCode;
	}

	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}

	public String getUpiId() {
		return upiId;
	}

	public void setUpiId(String upiId) {
		this.upiId = upiId;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public String getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getCardHolderName() {
		return cardHolderName;
	}

	public void setCardHolderName(String cardHolderName) {
		this.cardHolderName = cardHolderName;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "\n Payment [transactionId=" + transactionId + ", paymentMethod=" + paymentMethod + ", bankName=" + bankName
				+ ", accountNumber=" + accountNumber + ", ifscCode=" + ifscCode + ", upiId=" + upiId + ", cardNumber="
				+ cardNumber + ", expiryDate=" + expiryDate + ", cardHolderName=" + cardHolderName + ", amount="
				+ amount + ", status=" + status + "]";
	}

    
 
    
    
    
    
}
package ecom.app.entities;

import java.sql.Date;

public class Payments {

	private int paymentId;
	private int orderId;
	private int customerId;
	private double amountPaid;
	private String paymentMethod;
	private Date paymentDate;
	
	public Payments(int paymentId, int orderId, int customerId, double amountPaid, String paymentMethod,
			Date paymentDate) {
		super();
		this.paymentId = paymentId;
		this.orderId = orderId;
		this.customerId = customerId;
		this.amountPaid = amountPaid;
		this.paymentMethod = paymentMethod;
		this.paymentDate = paymentDate;
	}
	public int getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public double getAmountPaid() {
		return amountPaid;
	}
	public void setAmountPaid(int amountPaid) {
		this.amountPaid = amountPaid;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public Date getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}
	@Override
	public String toString() {
		return "Payments [paymentId=" + paymentId + ", orderId=" + orderId + ", customerId=" + customerId
				+ ", amountPaid=" + amountPaid + ", paymentMethod=" + paymentMethod + ", paymentDate=" + paymentDate
				+ "]";
	}
	
	
	
}

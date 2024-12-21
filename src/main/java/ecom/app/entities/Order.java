package ecom.app.entities;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;
    private int userId;
    private List<CartItems> orderItems;
    private double totalAmount;
    private String paymentMethod;
    private String status;
    private LocalDateTime orderDate;

    // Constructors
    public Order(int userId, List<CartItems> orderItems, double totalAmount, String paymentMethod) {
        this.userId = userId;
        this.orderItems = orderItems;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = "Pending"; // Default status
        this.orderDate = LocalDateTime.now(); // Set current date and time
    }

    public Order(int orderId, int userId, List<CartItems> orderItems, double totalAmount, String paymentMethod,
                 String status, Timestamp orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderItems = orderItems;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.orderDate = orderDate.toLocalDateTime(); // Convert Timestamp to LocalDateTime
    }

    

	public Order() {
		// TODO Auto-generated constructor stub
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public List<CartItems> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(List<CartItems> orderItems) {
		this.orderItems = orderItems;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public LocalDateTime getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

	@Override
	public String toString() {
		return "\n Order [orderId=" + orderId + ", userId=" + userId + ", orderItems=" + orderItems + ", totalAmount="
				+ totalAmount + ", paymentMethod=" + paymentMethod + ", status=" + status + ", orderDate=" + orderDate
				+ "]";
	}




}

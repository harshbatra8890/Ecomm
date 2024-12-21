package ecom.app.entities;

public class ProductOrders {

	private int orderItemId;
	private int orderId;
	private int productId;
	private int quantity;
	private double price;
	
	public ProductOrders(int orderItemId, int orderId, int productId, int quantity, double price) {
		super();
		this.orderItemId = orderItemId;
		this.orderId = orderId;
		this.productId = productId;
		this.quantity = quantity;
		this.price = price;
	}
	public int getOrderItemId() {
		return orderItemId;
	}
	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	@Override
	public String toString() {
		return "ProductOrders [orderItemId=" + orderItemId + ", orderId=" + orderId + ", productId=" + productId
				+ ", quantity=" + quantity + ", price=" + price + "]";
	}
	
	
}

package ecom.app.entities;

import java.util.Arrays;

public class CartItems {
    private int productId;
    private String productName;
    private String description;
    private double price; // Price as double
    private int quantity;
    private double deliveryCharge;


    

    public CartItems() {
		super();
	}


	public CartItems(int productId, String productName, String description, double price, int quantity,
			double deliveryCharge) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.description = description;
		this.price = price;
		this.quantity = quantity;
		this.deliveryCharge = deliveryCharge;
	}


	public CartItems(int productId, int quantity) {
		super();
		this.productId = productId;
		this.quantity = quantity;
	}


	public int getProductId() {
		return productId;
	}


	public void setProductId(int productId) {
		this.productId = productId;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public double getPrice() {
		return price;
	}


	public void setPrice(double price) {
		this.price = price;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public double getDeliveryCharge() {
		return deliveryCharge;
	}


	public void setDeliveryCharge(double deliveryCharge) {
		this.deliveryCharge = deliveryCharge;
	}


	@Override
	public String toString() {
		return "CartItems [productId=" + productId + ", productName=" + productName + ", description=" + description
				+ ", price=" + price + ", quantity=" + quantity + ", deliveryCharge=" + deliveryCharge + "]";
	}


}

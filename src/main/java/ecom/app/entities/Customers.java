package ecom.app.entities;

public class Customers {

	  private int customerId;
	  private String Address;
	  
	  public Customers(int customerId, String address) {
		super();
		this.customerId = customerId;
		Address = address;
    	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getAddress() {
		return Address;
	}

	public void setAddress(String address) {
		Address = address;
	}

	@Override
	public String toString() {
		return "Customers [customerId=" + customerId + ", Address=" + Address + "]";
	}
	  
	  
	  
	
}

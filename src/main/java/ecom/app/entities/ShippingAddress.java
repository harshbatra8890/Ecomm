package ecom.app.entities;

public class ShippingAddress {

	private int addressId;
	private int customerId;
	private String street;
	private String city;
	private String state;
	private int postalCode;
	private String country;
	
	public ShippingAddress(int addressId, int customerId, String street, String city, String state, int postalCode,
			String country) {
		super();
		this.addressId = addressId;
		this.customerId = customerId;
		this.street = street;
		this.city = city;
		this.state = state;
		this.postalCode = postalCode;
		this.country = country;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(int postalCode) {
		this.postalCode = postalCode;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	@Override
	public String toString() {
		return "ShippingAddress [addressId=" + addressId + ", customerId=" + customerId + ", street=" + street
				+ ", city=" + city + ", state=" + state + ", postalCode=" + postalCode + ", country=" + country + "]";
	}
	
	
	
	
}

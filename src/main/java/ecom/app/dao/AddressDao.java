package ecom.app.dao;

public interface AddressDao {
	 String getDeliveryAddress(int userId);
	    void saveDeliveryAddress(int userId, String deliveryAddress);
	}
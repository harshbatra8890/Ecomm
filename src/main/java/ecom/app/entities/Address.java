package ecom.app.entities;

public class Address {
    private int addressId;
    private int userId;
    private String deliveryAddress;

    // Constructor
    public Address(int addressId, int userId, String deliveryAddress) {
        this.addressId = addressId;
        this.userId = userId;
        this.deliveryAddress = deliveryAddress;
    }

    // Getters and Setters
    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    @Override
    public String toString() {
        return "Address{" +
                "addressId=" + addressId +
                ", userId=" + userId +
                ", deliveryAddress='" + deliveryAddress + '\'' +
                '}';
    }
}

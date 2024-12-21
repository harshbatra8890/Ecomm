package ecom.app.entities;

public class Wishlist {
    private int wishlistId;
    private int userId;
    private int productId;

    // No-argument constructor
    public Wishlist() {
    }

    // Parameterized constructor
    public Wishlist(int userId, int productId) {
        this.userId = userId;
        this.productId = productId;
    }

    // Getters and Setters
    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    @Override
    public String toString() {
        return "Wishlist [wishlistId=" + wishlistId + ", userId=" + userId + ", productId=" + productId + "]";
    }
}

package ecom.app.dao;

import ecom.app.entities.Wishlist;
import java.util.List;

public interface WishlistDao {
    void addToWishlist(Wishlist wishlist);
    List<Wishlist> getUserWishlist(int userId);
    void removeFromWishlist(int wishlistId);
}

package ecom.app.dao;

import ecom.app.entities.Cart;
import ecom.app.entities.CartItems;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public interface CartDao {
	Cart createCartForUser(int userId) throws IOException, SQLException;

	int addItemToCart(int cartId, CartItems item) throws IOException, SQLException;

	Cart getCartByUserId(int userId) throws IOException, SQLException;

	Cart getCartById(int cartId) throws IOException, SQLException;

	void removeItemFromCart(int cartId, int productId) throws IOException, SQLException;

	List<CartItems> getCartItemsByUserId(int userId) throws IOException, SQLException;

}

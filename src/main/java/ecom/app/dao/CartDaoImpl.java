package ecom.app.dao;

import ecom.app.entities.Cart;
import ecom.app.entities.CartItems;
import ecom.app.entities.Products;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CartDaoImpl implements CartDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private ProductDao productDao; // Add this line to inject ProductDao

	@Override
	public Cart createCartForUser(int userId) throws IOException, SQLException {
		String sql = "INSERT INTO cart (user_id) VALUES (?)";
		jdbcTemplate.update(sql, userId);

		String cartIdSql = "SELECT LAST_INSERT_ID()";
		int cartId = jdbcTemplate.queryForObject(cartIdSql, Integer.class);

		return new Cart(cartId, userId); // Make sure Cart constructor accepts cartId
	}

	@Override
	public int addItemToCart(int cartId, CartItems item) throws IOException, SQLException {

		String sql = "INSERT INTO cart_items (cart_id, product_id, quantity) " + "VALUES (?, ?, ?) "
				+ "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
		return jdbcTemplate.update(sql, cartId, item.getProductId(), item.getQuantity());
	}

	@Override
	public Cart getCartByUserId(int userId) throws SQLException {
		String sql = "SELECT c.cart_id FROM cart c " + "JOIN user u ON c.user_id = u.user_id WHERE c.user_id = ?";

		Cart cart = jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
			return new Cart(rs.getInt("cart_id"));
		}, userId // Provide the userId parameter for the query
		);

		return cart; // Return the Cart object with the fetched cart_id
	}

	@Override
	public List<CartItems> getCartItemsByUserId(int userId) throws IOException, SQLException {
	    String sql = "SELECT c.cart_id, ci.product_id, ci.quantity FROM cart c " +
	                 "JOIN cart_items ci ON c.cart_id = ci.cart_id WHERE c.user_id = ?";

	    List<CartItems> cartItems = jdbcTemplate.query(sql, new Object[]{userId}, (rs, rowNum) -> {
	        int productId = rs.getInt("product_id");
	        int quantity = rs.getInt("quantity");
	        Products product = productDao.getProductById(productId); // Fetch product details
	        
	        double deliveryCharge = product.getDelivery_charge(); // Get delivery charge from product
	        return new CartItems(productId, product.getProduct_name(), product.getDescription(),
	                             product.getFinal_price(), quantity, deliveryCharge);
	    });
	    return cartItems;
	}


	@Override
	public Cart getCartById(int cartId) throws IOException, SQLException {
		String sql = "SELECT user_id FROM cart WHERE cart_id = ?";
		Integer userId = jdbcTemplate.queryForObject(sql, new Object[] { cartId }, Integer.class);

		if (userId != null) {
			return getCartByUserId(userId);
		} else {
			return null; // or throw an exception
		}
	}

	

	@Override
	public void removeItemFromCart(int cartId, int productId) throws IOException, SQLException {
	    String sql = "UPDATE cart_items SET quantity = quantity - 1 WHERE cart_id = ? AND product_id = ?";
	    int rowsAffected = jdbcTemplate.update(sql, cartId, productId);
	    
	    // Check if any rows were updated
	    if (rowsAffected == 0) {
	        // If no rows were updated, it means the product might have been removed already
	        throw new SQLException("Product not found in the cart or already removed.");
	    }

	    // Now remove the item if the quantity becomes 0
	    String checkQuantitySql = "SELECT quantity FROM cart_items WHERE cart_id = ? AND product_id = ?";
	    Integer quantity = jdbcTemplate.queryForObject(checkQuantitySql, new Object[] { cartId, productId }, Integer.class);
	    
	    if (quantity != null && quantity <= 0) {
	        String deleteSql = "DELETE FROM cart_items WHERE cart_id = ? AND product_id = ?";
	        jdbcTemplate.update(deleteSql, cartId, productId);
	    }

	    System.out.println("Rows affected by removal: " + rowsAffected);
	}

	public void removeCartProducts(int userId) throws SQLException {
	    String sql = "DELETE FROM cart_items WHERE cart_id = (SELECT cart_id FROM cart WHERE user_id = ?)";
	    jdbcTemplate.update(sql, userId);
	}

	
}
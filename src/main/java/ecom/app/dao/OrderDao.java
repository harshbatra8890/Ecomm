package ecom.app.dao;

import ecom.app.entities.CartItems;
import ecom.app.entities.Order;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public interface OrderDao {

	List<Order> getOrdersByUserId(int userId) throws SQLException, IOException;
	List<CartItems> getOrderItems(int orderId) throws SQLException, IOException;

	void removeCartProducts(int userId) throws SQLException;

	List<Order> getSalesDataByDateRange(String startDate, String endDate) throws SQLException;

	void saveOrder(Order order, boolean truncateCart) throws IOException, SQLException;

    List<Order> getSalesDataByCategory(int categoryId) throws SQLException;
	
	
}

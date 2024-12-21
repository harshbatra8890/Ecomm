package ecom.app.dao;

import ecom.app.entities.Order;
import ecom.app.entities.CartItems;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

public class OrderRowMapper implements RowMapper<Order> {
    private final OrderDaoImpl orderDao;

    public OrderRowMapper(OrderDaoImpl orderDao) {
        this.orderDao = orderDao;
    }

    @Override
    public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
        int orderId = rs.getInt("order_id");
        int userId = rs.getInt("user_id");
        double totalAmount = rs.getDouble("total_amount");
        String paymentMethod = rs.getString("payment_method");
        String status = rs.getString("status");
        Timestamp orderDate = rs.getTimestamp("order_date");

        // Fetch order items for this order
        List<CartItems> orderItems = orderDao.getOrderItems(orderId);

        return new Order(orderId, userId, orderItems, totalAmount, paymentMethod, status, orderDate);
    }
}

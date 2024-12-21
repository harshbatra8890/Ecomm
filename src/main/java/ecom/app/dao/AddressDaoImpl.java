package ecom.app.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AddressDaoImpl implements AddressDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public String getDeliveryAddress(int userId) {
        String sql = "SELECT delivery_address FROM deli_address WHERE user_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{userId}, String.class);
        } catch (Exception e) {
            return ""; // Handle exception if not found
        }
    }

    @Override
    public void saveDeliveryAddress(int userId, String deliveryAddress) {
        String sql = "INSERT INTO deli_address (user_id, delivery_address) VALUES (?, ?) " +
                     "ON DUPLICATE KEY UPDATE delivery_address = ?";
        try {
            jdbcTemplate.update(sql, userId, deliveryAddress, deliveryAddress);
            System.out.println("Address saved successfully for user ID: " + userId);
        } catch (Exception e) {
            System.out.println("Error saving address: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

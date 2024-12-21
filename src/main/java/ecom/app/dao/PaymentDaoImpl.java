package ecom.app.dao;

import ecom.app.entities.Payment;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDaoImpl implements PaymentDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void savePayment(Payment payment) {
        String sql = "INSERT INTO payment (transaction_id, payment_method, bank_name, account_number, ifsc_code, upi_id, card_number, expiry_date, holder_name, amount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            jdbcTemplate.update(sql, payment.getTransactionId(), payment.getPaymentMethod(),
                    payment.getBankName(), payment.getAccountNumber(),
                    payment.getIfscCode(), payment.getUpiId(),
                    payment.getCardNumber(), payment.getExpiryDate(),
                    payment.getCardHolderName(), payment.getAmount(), payment.getStatus());
        } catch (Exception e) {
            System.err.println("Error executing SQL: " + sql);
            e.printStackTrace(); // Log the exception for debugging
        }
    }


    @Override
    public Payment getPaymentById(String transactionId) throws SQLException {
        // Implementation for getting payment by ID can be added here
        return null;
    }
}

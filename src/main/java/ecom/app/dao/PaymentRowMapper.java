package ecom.app.dao;

import ecom.app.entities.Payment;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentRowMapper implements RowMapper<Payment> {
    @Override
    public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
        Payment payment = new Payment();
        payment.setTransactionId(rs.getString("transaction_id"));
        payment.setPaymentMethod(rs.getString("payment_method"));
        payment.setBankName(rs.getString("bank_name"));
        payment.setAccountNumber(rs.getString("account_number"));
        payment.setIfscCode(rs.getString("ifsc_code"));
        payment.setUpiId(rs.getString("upi_id"));
        payment.setCardNumber(rs.getString("card_number"));
        payment.setExpiryDate(rs.getString("expiry_date"));
        payment.setCardHolderName(rs.getString("holder_name"));
        payment.setAmount(rs.getDouble("amount"));
        payment.setStatus(rs.getString("status"));

        return payment;
    }
}

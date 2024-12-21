package ecom.app.dao;

import java.sql.SQLException;
import ecom.app.entities.Payment;

public interface PaymentDao {
    void savePayment(Payment payment) throws SQLException;
    Payment getPaymentById(String transactionId) throws SQLException;
}

package ecom.app.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ecom.app.entities.Feedback;

import java.util.List;

@Repository
public class FeedbackDaoImpl implements FeedbackDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void addFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (product_id, user_id, feedback_text, feedback_date) VALUES (?, ?, ?, ?)";
        try {
            jdbcTemplate.update(sql, feedback.getProductId(), feedback.getUserId(), feedback.getFeedbackText(), feedback.getFeedbackDate());
            System.out.println("Feedback added successfully for product ID: " + feedback.getProductId());
        } catch (Exception e) {
            System.out.println("Error adding feedback: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public List<Feedback> getFeedbackByProductId(int productId) {
        String sql = "SELECT * FROM feedback WHERE product_id = ?";
        return jdbcTemplate.query(sql, new Object[]{productId}, (rs, rowNum) -> {
            Feedback feedback = new Feedback();
            feedback.setFeedbackId(rs.getInt("feedback_id"));
            feedback.setProductId(rs.getInt("product_id"));
            feedback.setUserId(rs.getInt("user_id"));
            feedback.setFeedbackText(rs.getString("feedback_text"));
            feedback.setFeedbackDate(rs.getDate("feedback_date"));
            return feedback;
        });
    }

	
}

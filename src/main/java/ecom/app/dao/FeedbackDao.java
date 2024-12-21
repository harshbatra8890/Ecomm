package ecom.app.dao;

import java.util.List;

import ecom.app.entities.Feedback;

public interface FeedbackDao {
    void addFeedback(Feedback feedback);
    List<Feedback> getFeedbackByProductId(int productId);
}

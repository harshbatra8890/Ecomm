package ecom.app.entities;

import java.util.Date;

public class Feedback {
    private int feedbackId;
    private int productId;
    private int userId;
    private String feedbackText;
    private Date feedbackDate;

    // Getters and Setters
    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFeedbackText() {
        return feedbackText;
    }

    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

	@Override
	public String toString() {
		return "\n Feedback [feedbackId=" + feedbackId + ", productId=" + productId + ", userId=" + userId
				+ ", feedbackText=" + feedbackText + ", feedbackDate=" + feedbackDate + "]";
	}
    
    
}

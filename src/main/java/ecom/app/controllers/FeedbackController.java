package ecom.app.controllers;

import ecom.app.entities.Feedback;
import ecom.app.entities.Products;
import ecom.app.entities.User;
import jakarta.servlet.http.HttpSession;
import ecom.app.dao.FeedbackDaoImpl; // Ensure this imports your DAO
import ecom.app.dao.ProductDaoImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.SQLException;
import java.util.List;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    @Autowired
    private FeedbackDaoImpl feedbackDaoImpl;
    
    @Autowired
    private ProductDaoImpl productDaoImpl;
    

    @PostMapping("/submit")
    public String submitFeedback(@RequestParam(value = "productId", required = false) String productIdStr,
                                  @RequestParam(value = "userId", required = false) String userIdStr,
                                  @RequestParam("feedbackText") String feedbackText,
                                  RedirectAttributes attributes , HttpSession session) {
        try {
            int productId = Integer.parseInt(productIdStr);
            int userId = Integer.parseInt(userIdStr);
            User user = (User) session.getAttribute("user");
            

            Feedback feedback = new Feedback();
            feedback.setProductId(productId);
           
            feedback.setUserId(user.getUserId());
            feedback.setFeedbackText(feedbackText);
            feedback.setFeedbackDate(new java.sql.Date(System.currentTimeMillis()));
            System.out.println("Feedback: " + feedback);

            feedbackDaoImpl.addFeedback(feedback);
            List<Feedback> feedbackList = feedbackDaoImpl.getFeedbackByProductId(productId);
            System.out.println("Feedbacklist " + feedbackList);
           session.setAttribute("feedbackList", feedbackList);

            
            attributes.addFlashAttribute("message", "Feedback submitted successfully!");
            return "redirect:/products/"+productId;
        } catch (NumberFormatException e) {
            attributes.addFlashAttribute("error", "Invalid product ID or user ID.");
        } catch (Exception e) {
            attributes.addFlashAttribute("error", "Error submitting feedback: " + e.getMessage());
        }
        return "product_details"; 
    }

    


}

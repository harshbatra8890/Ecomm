package ecom.app.controllers;

import ecom.app.entities.Order;
import ecom.app.entities.Payment;
import ecom.app.entities.CartItems;
import ecom.app.entities.User;
import ecom.app.dao.CartDaoImpl;
import ecom.app.dao.OrderDaoImpl;
import ecom.app.dao.PaymentDao;
import ecom.app.dao.PaymentDaoImpl;
import ecom.app.dao.ProductDaoImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderDaoImpl orderDaoImpl;

    @Autowired
    private CartDaoImpl cartDaoImpl;

    @Autowired
    private ProductDaoImpl productDaoImpl;
    
    @Autowired
    private PaymentDaoImpl paymentDaoImpl;
    

    @PostMapping("/confirm")
    @Transactional
    public String confirmOrder(HttpSession session, Model model,
                               @RequestParam String paymentMethod,
                               @RequestParam(required = false) String bankName,
                               @RequestParam(required = false) String accountNumber,
                               @RequestParam(required = false) String ifscCode,
                               @RequestParam(required = false) String upiId,
                               @RequestParam(required = false) String cardNumber,
                               @RequestParam(required = false) String expiryDate,
                               @RequestParam(required = false) String cardHolderName) {
        User user = (User) session.getAttribute("user");
        List<CartItems> cartItems = (List<CartItems>) session.getAttribute("cartItems");
        List<CartItems> buyNowItems = (List<CartItems>) session.getAttribute("buyNowItems");

        // Determine which items to process
        List<CartItems> itemsToProcess = (buyNowItems != null && !buyNowItems.isEmpty()) ? buyNowItems : cartItems;

        // Check if there are items to process
        if (itemsToProcess == null || itemsToProcess.isEmpty()) {
            model.addAttribute("error", "Your cart is empty.");
            return "checkout"; // Redirect back to checkout if no items are found
        }

        double totalAmount = itemsToProcess.stream().mapToDouble(item -> item.getPrice() * item.getQuantity()).sum();
        Order order = new Order(user.getUserId(), itemsToProcess, totalAmount, paymentMethod);

        try {
            // Check stock availability
            for (CartItems item : itemsToProcess) {
                if (!productDaoImpl.hasSufficientStock(item.getProductId(), item.getQuantity())) {
                    model.addAttribute("error", "Insufficient stock for product: " + item.getProductName());
                    return "checkout"; // Return to checkout without saving order
                }
            }

            // Save the order in the database
            boolean isBuyNow = (buyNowItems != null && !buyNowItems.isEmpty());
            orderDaoImpl.saveOrder(order, !isBuyNow); // Truncate cart only if it's not Buy Now

            // Create and save the payment details
            String transactionId = UUID.randomUUID().toString();
            Payment payment = new Payment(transactionId, paymentMethod, bankName, accountNumber,
                                           ifscCode, upiId, cardNumber, expiryDate,
                                           cardHolderName, totalAmount, "Pending");
            paymentDaoImpl.savePayment(payment); // Assuming you have an instance of PaymentDao

            // Update stock for items
            for (CartItems item : itemsToProcess) {
                productDaoImpl.updateProductStock(item.getProductId(), item.getQuantity());
            }

            // Clear session attributes for successful order
            if (!isBuyNow) {
                session.setAttribute("cartItems", new ArrayList<CartItems>()); // Clear cart items if necessary
            }
            session.removeAttribute("buyNowItems"); // Clear buy now items

            return "order_successful"; // Redirect to order success page
        } catch (Exception e) {
            model.addAttribute("error", "Error processing your order. Please try again.");
            return "checkout"; // Redirect back to checkout if there's an error
        }
    }



    
    @GetMapping("/displayOrders")
    public String viewOrders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null) {
            return "redirect:/user/login"; // Redirect to login if user is not logged in
        }

        try {
            List<Order> orders = orderDaoImpl.getOrdersByUserId(user.getUserId()); // Implement this method
            model.addAttribute("orders", orders);
        } catch (SQLException | IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "Error fetching your orders.");
        }

        return "orders"; // Return to the my_orders.jsp page
    }
    
 // Method to get the current sub-admin ID from the session
    private int getCurrentSubAdminId(HttpSession session) {
        Integer subAdminId = (Integer) session.getAttribute("subAdminId");
        return (subAdminId != null) ? subAdminId : -1; // Return -1 or throw an exception if not found
    }
}

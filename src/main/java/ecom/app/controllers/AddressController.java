package ecom.app.controllers;

import ecom.app.dao.AddressDao;
import ecom.app.dao.AddressDaoImpl;
import ecom.app.entities.CartItems;
import ecom.app.entities.User;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/address")
public class AddressController {

    @Autowired
    private AddressDaoImpl addressDaoImpl;


    @PostMapping("/saveAddress")
    public String saveAddress(@RequestParam("deliveryAddress") String deliveryAddress, HttpSession session) {
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            return "reAdirect:/user/login"; // Redirect to login if user is not logged in
        }
        
        Integer userId = user.getUserId(); // Get user ID from the User object
        
        // Check if the delivery address is not empty
        if (deliveryAddress == null || deliveryAddress.isEmpty()) {
            System.out.println("Delivery address is empty");
            return "redirect:/cart/checkout"; // Handle empty address
        }

        // Save or update the delivery address for the user
        addressDaoImpl.saveDeliveryAddress(userId, deliveryAddress);
        
        session.setAttribute("deliveryAddress", deliveryAddress);
           System.out.println("Deivery address" + deliveryAddress);
        
           
           List<CartItems> cartItems = (List<CartItems>) session.getAttribute("cartItems");
           if (cartItems != null) {
               session.setAttribute("cartItems", cartItems); // Reinforce cart items in the session
           }
           
           System.out.println("Cart items before redirect: " + session.getAttribute("cartItems"));

           
        return "redirect:/cart/checkout"; // Redirect back to the checkout page
    }
}

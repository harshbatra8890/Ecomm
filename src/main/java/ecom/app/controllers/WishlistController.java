package ecom.app.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ecom.app.dao.WishlistDaoImpl;
import ecom.app.dao.CartDaoImpl; // Make sure you import your CartDaoImpl
import ecom.app.dao.ProductDaoImpl;
import ecom.app.entities.Cart;
import ecom.app.entities.CartItems;
import ecom.app.entities.User;
import ecom.app.entities.Wishlist;
import ecom.app.entities.Products; // Import your Product class
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {

	@Autowired
	private WishlistDaoImpl wishlistDaoImpl;

	@Autowired
	private CartDaoImpl cartDaoImpl; // Autowire your CartDaoImpl

	@Autowired
	private ProductDaoImpl productDaoImpl;

	@GetMapping("/view")
	public String viewWishlist(Model model, HttpSession session) {
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        List<Wishlist> wishlistItems = wishlistDaoImpl.getUserWishlist(user.getUserId());
	        List<Products> products = new ArrayList<>();

	        // Fetch product details for each wishlist item
	        for (Wishlist item : wishlistItems) {
	            Products product = productDaoImpl.getProductById(item.getProductId());
	            if (product != null) {
	                products.add(product);
	            }
	        }

	        model.addAttribute("wishlistItems", wishlistItems);
	        model.addAttribute("products", products);
	    }
	    return "wishlist"; // Ensure this matches your JSP filename
	}




	@PostMapping("/addToWishlist")
	public String addToWishlist(@RequestParam int productId, HttpSession session, RedirectAttributes attributes) {
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        // Check if the product is already in the wishlist
	        List<Wishlist> existingWishlist = wishlistDaoImpl.getUserWishlist(user.getUserId());
	        boolean alreadyExists = existingWishlist.stream().anyMatch(item -> item.getProductId() == productId);

	        if (alreadyExists) {
	            attributes.addFlashAttribute("message", "Product is already present in your wishlist.");
	        } else {
	            Wishlist wishlist = new Wishlist();
	            wishlist.setUserId(user.getUserId());
	            wishlist.setProductId(productId);
	            wishlistDaoImpl.addToWishlist(wishlist);
	            attributes.addFlashAttribute("message", "Product added to wishlist.");
	        }
	    } else {
	        attributes.addFlashAttribute("error", "You must be logged in to add to wishlist.");
	    }
	    return "redirect:/wishlist/view"; // Redirect to the wishlist view
	}



	@PostMapping("/moveToCart")
	public String moveToCart(@RequestParam int wishlistId, HttpSession session, RedirectAttributes attributes) {
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        Wishlist wishlistItem = wishlistDaoImpl.getUserWishlistItem(wishlistId);
	        if (wishlistItem != null) {
	            // Create a new CartItems object
	            CartItems cartItem = new CartItems();
	            cartItem.setProductId(wishlistItem.getProductId());
	            cartItem.setQuantity(1); // Set quantity to 1, or modify as needed

	            // Retrieve or create the user's cart
	            Cart userCart;
	            try {
	                userCart = cartDaoImpl.getCartByUserId(user.getUserId());
	            } catch (SQLException e) {
	                attributes.addFlashAttribute("error", "Error retrieving user's cart.");
	                return "redirect:/wishlist/view";
	            }

	            if (userCart == null) {
	                // Create a new cart if it doesn't exist
	                try {
	                    userCart = cartDaoImpl.createCartForUser(user.getUserId());
	                } catch (IOException | SQLException e) {
	                    attributes.addFlashAttribute("error", "Error creating cart.");
	                    return "redirect:/wishlist/view";
	                }
	            }

	            // Add the item to the cart
	            try {
	                cartDaoImpl.addItemToCart(userCart.getCartId(), cartItem);
	                wishlistDaoImpl.removeFromWishlist(wishlistId); // Remove from wishlist after moving
	                attributes.addFlashAttribute("message", "Product moved to cart.");
	            } catch (IOException | SQLException e) {
	                attributes.addFlashAttribute("error", "Error moving product to cart.");
	            }
	        } else {
	            attributes.addFlashAttribute("error", "Wishlist item not found.");
	        }
	    } else {
	        attributes.addFlashAttribute("error", "You must be logged in to move items to cart.");
	    }
	    return "redirect:/wishlist/view"; // Redirect to the wishlist view
	}

	
	@PostMapping("/remove")
	public String removeFromWishlist(@RequestParam int wishlistId, HttpSession session, RedirectAttributes attributes) {
	    User user = (User) session.getAttribute("user");
	    if (user != null) {
	        wishlistDaoImpl.removeFromWishlist(wishlistId); // Call to the DAO method
	        attributes.addFlashAttribute("message", "Product removed from wishlist.");
	    } else {
	        attributes.addFlashAttribute("error", "You must be logged in to remove items from wishlist.");
	    }
	    return "redirect:/wishlist/view"; // Redirect back to the wishlist view
	}


	
	
	
}

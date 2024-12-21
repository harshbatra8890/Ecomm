package ecom.app.controllers;

import ecom.app.entities.Cart;
import ecom.app.entities.CartItems;
import ecom.app.entities.Products;
import ecom.app.dao.CartDaoImpl;
import ecom.app.dao.ProductDao;
import ecom.app.dao.ProductDaoImpl;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import ecom.app.entities.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	private ProductDaoImpl productDaoImpl;

	@Autowired
	private CartDaoImpl cartDaoImpl;

	@PostMapping("/add")
	public String addToCart(@RequestParam("productId") int product_id, HttpSession session, Model model) {
	    User user = (User) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/user/login"; // Ensure user is logged in
	    }

	    int userId = user.getUserId();
	    int cartId = 0;

	    try {
	        Cart cart = cartDaoImpl.getCartByUserId(userId);
	        cartId = cart.getCartId();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    Products product = productDaoImpl.getProductById(product_id);

	    if (product != null && cartId != 0) {
	        try {
	            int res = cartDaoImpl.addItemToCart(cartId, new CartItems(product_id, 1));
	            model.addAttribute("message", "Product added to cart successfully!");

	            // Check stock after adding the item
	            if (product.getStock() < 1) {
	                // Store out-of-stock message in session
	                List<String> outOfStockMessages = (List<String>) session.getAttribute("outOfStockMessages");
	                if (outOfStockMessages == null) {
	                    outOfStockMessages = new ArrayList<>();
	                }
	                outOfStockMessages.add(product.getProduct_name() + " is out of stock.");
	                session.setAttribute("outOfStockMessages", outOfStockMessages);
	            }

	        } catch (IOException | SQLException e) {
	            e.printStackTrace();
	            model.addAttribute("message", "Error adding product to cart. Please try again.");
	        }
	    } else {
	        model.addAttribute("message", "Product not found or cart not initialized.");
	    }

	    // Load the product details again to display on the page
	    model.addAttribute("product", product);
	    return "product_details"; // Return to the product details page
	}


	@GetMapping("/view")
	public String viewCart(HttpSession session, Model model) {

		User user = (User) session.getAttribute("user");
		int userId = user.getUserId();

		try {
			List<CartItems> cartItems = cartDaoImpl.getCartItemsByUserId(userId);
			System.out.println(cartItems);
			session.setAttribute("cartItems", cartItems);
			  model.addAttribute("cartItems", cartItems); 
			return "cart";

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "cart"; 
	}

	@PostMapping("/remove")
	public String removeFromCart(@RequestParam("productId") int product_id, HttpSession session,
			RedirectAttributes attributes) {

		Integer cartId = (Integer) session.getAttribute("cartId");

		if (cartId != null) {
			try {
				cartDaoImpl.removeItemFromCart(cartId, product_id); // You need to implement this method in CartDaoImpl
				attributes.addFlashAttribute("message", "Item removed from cart successfully.");
			     return "redirect:/cart/view";
			} catch (IOException | SQLException e) {
				e.printStackTrace();
				attributes.addFlashAttribute("message", "Error removing item from cart. Please try again.");
			     return "redirect:/cart/view";

			}
		} else {
			attributes.addFlashAttribute("message", "Your cart is not initialized. Please log in.");
		     return "redirect:/user/login";

		}

	}
	
	

	@PostMapping("/removeMultiple")
	public String removeMultipleFromCart(@RequestParam(required = false, name = "productIds") List<Integer> productIds,
			HttpSession session, RedirectAttributes attributes) {
		System.out.println(productIds);
		
		User user = (User) session.getAttribute("user");
		int userId = user.getUserId();
		System.out.println(userId);
		int cartId = 0;

		try {
			Cart cart = cartDaoImpl.getCartByUserId(userId);
			cartId = cart.getCartId();
			System.out.println(cartId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (cartId != 0 && productIds != null) {
			try {
				for (Integer productId : productIds) {
					cartDaoImpl.removeItemFromCart(cartId, productId);
				}
				attributes.addFlashAttribute("message", "Selected items removed from cart successfully.");
			} catch (IOException | SQLException e) {
				e.printStackTrace();
				attributes.addFlashAttribute("message", "Error removing items from cart. Please try again.");
			}
		} else {
			attributes.addFlashAttribute("message", "Your cart is not initialized. Please log in.");
		}

		return "redirect:/cart/view"; // Redirect to the view cart page
	}


	@GetMapping("/checkout")
	public String checkout(HttpSession session, Model model) {
	    List<CartItems> cartItems = (List<CartItems>) session.getAttribute("cartItems");
	    List<CartItems> buyNowItems = (List<CartItems>) session.getAttribute("buyNowItems");
	    
	    List<String> outOfStockMessages = new ArrayList<>();

	    // Determine which items to use
	    List<CartItems> itemsToCheckout = (buyNowItems != null && !buyNowItems.isEmpty()) ? buyNowItems : cartItems;

	    if (itemsToCheckout == null || itemsToCheckout.isEmpty()) {
	        model.addAttribute("error", "Your cart is empty.");
	        return "cart"; // Redirect to cart if no items
	    }

	    // Check stock for all items in the cart
	    for (CartItems item : itemsToCheckout) {
	        Products product = productDaoImpl.getProductById(item.getProductId());
	        if (product.getStock() < item.getQuantity()) { // Check stock
	            outOfStockMessages.add(product.getProduct_name() + " is out of stock.");
	        }
	    }

	    // Store out-of-stock messages in the session
	    session.setAttribute("outOfStockMessages", outOfStockMessages);

	    model.addAttribute("cartItems", itemsToCheckout);
	    double deliveryCharge = calculateDeliveryCharge(itemsToCheckout);
	    model.addAttribute("deliveryCharge", deliveryCharge);
	    
	    String deliveryAddress = (String) session.getAttribute("deliveryAddress");
	    model.addAttribute("deliveryAddress", deliveryAddress);

	    return "checkout"; // Return the checkout view
	}




	private double calculateDeliveryCharge(List<CartItems> cartItems) {
	    double totalDeliveryCharge = 0.0;
	    for (CartItems item : cartItems) {
	        totalDeliveryCharge += item.getDeliveryCharge() * item.getQuantity(); // Assuming delivery charge can vary by quantity
	    }
	    return totalDeliveryCharge; // Return the total delivery charge
	}


	@GetMapping("/buynow")
	public String buyNow(@RequestParam("productId") int productId, HttpSession session, Model model) {
	    User user = (User) session.getAttribute("user");
	    if (user == null) {
	        return "redirect:/user/login"; // Ensure the user is logged in
	    }

	    Products product = productDaoImpl.getProductById(productId); // Fetch the product details

	    if (product != null) {
	        // Check stock before adding to the cart
	        if (product.getStock() < 1) {
	            List<String> outOfStockMessages = (List<String>) session.getAttribute("outOfStockMessages");
	            if (outOfStockMessages == null) {
	                outOfStockMessages = new ArrayList<>();
	            }
	            outOfStockMessages.add(product.getProduct_name() + " is out of stock.");
	            session.setAttribute("outOfStockMessages", outOfStockMessages);
	        } else {
	            // Create a CartItem for this product
	            CartItems cartItem = new CartItems(productId, product.getProduct_name(), product.getDescription(),
	                                                 product.getFinal_price(), 1, product.getDelivery_charge());

	            // Store this item in a separate session attribute for "Buy Now"
	            session.setAttribute("buyNowItems", List.of(cartItem));
	        }
	        
	        model.addAttribute("cartItems", session.getAttribute("buyNowItems")); // Prepare the model for checkout
	        model.addAttribute("deliveryCharge", product.getDelivery_charge()); // Include delivery charge if necessary

	        return "checkout"; // Return the checkout view
	    }

	    return "redirect:/products/display1"; // Redirect if product is not found
	}
}
	

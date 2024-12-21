package ecom.app.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ecom.app.dao.ProductDaoImpl;
import ecom.app.entities.Category;
import ecom.app.entities.Products;
import jakarta.servlet.http.HttpSession;

@Controller
public class NavigationController {
	@Autowired
	private ProductDaoImpl productDaoImpl;
	public List<Products> products;
   
	@Autowired
	private HttpSession session;
	
	@GetMapping("/")
	public String homepage(Model model) {

		List<Products> newArrivals = productDaoImpl.getAllNewArrivalProducts();
		List<Products> discountProducts = productDaoImpl.getAllDiscountProducts();
		List<Products> bestBrands = productDaoImpl.getAllBestBrandProducts();
		List<Products> newTrends = productDaoImpl.getAllNewTrendingProducts();
		List<Category> categoryList = productDaoImpl.getAllProductsByCategory();

		// Add these product lists to the model to be passed to the JSP
		model.addAttribute("newArrivals", newArrivals);
		model.addAttribute("discountProducts", discountProducts);
		model.addAttribute("bestBrands", bestBrands);
		model.addAttribute("newTrends", newTrends);
		model.addAttribute("categoryList", categoryList);

		return "homepage"; // JSP page
	}
	
	
	@GetMapping("/logout")
	public String logout() {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/expore-all")
	public String exploreall(Model model) {
		List<Products> newArrivals = productDaoImpl.getAllNewArrivalProducts();
		List<Products> discountProducts = productDaoImpl.getAllDiscountProducts();
		List<Products> bestBrands = productDaoImpl.getAllBestBrandProducts();

		// Add these product lists to the model to be passed to the JSP
		model.addAttribute("newArrivals", newArrivals);
		model.addAttribute("discountProducts", discountProducts);
		model.addAttribute("bestBrands", bestBrands);
		return "homepage"; // JSP page
	}

	@GetMapping("/explore-new-arrivals")
	public String explorenewarrivals(
             
            @RequestParam(value = "sort", required = false) String sort,
            Model model) throws IOException, SQLException {
 
        // Fetch products by category ID
		List<Products> newArrivals = productDaoImpl.getAllNewArrivalProducts1();
 
        // Apply sorting if the sort parameter is provided
        if ("priceAsc".equals(sort)) {
        	 newArrivals.sort(Comparator.comparing(Products::getFinal_price));
        } else if ("priceDesc".equals(sort)) {
        	 newArrivals.sort(Comparator.comparing(Products::getFinal_price).reversed());
        }
 
        
        model.addAttribute("newArrivals", newArrivals);
 
        return "new_arrivals_products"; // Return the JSP page
    }
	
	@GetMapping("/explore-discount-products")
	public String explorediscountproducts(
             
            @RequestParam(value = "sort", required = false) String sort,
            Model model) throws IOException, SQLException {
 
        // Fetch products by category ID
		List<Products> discountProducts = productDaoImpl.getAllDiscountProducts1();
 
        // Apply sorting if the sort parameter is provided
        if ("priceAsc".equals(sort)) {
        	discountProducts.sort(Comparator.comparing(Products::getFinal_price));
        } else if ("priceDesc".equals(sort)) {
        	discountProducts.sort(Comparator.comparing(Products::getFinal_price).reversed());
        }
 
        
        model.addAttribute("discountProducts", discountProducts);
 
        return "discount_products"; // Return the JSP page
    }
	
	@GetMapping("/explore-best-brands")
	public String explorebestbrands(
             
            @RequestParam(value = "sort", required = false) String sort,
            Model model) throws IOException, SQLException {
 
        // Fetch products by category ID
		List<Products> bestBrands = productDaoImpl.getAllBestBrandProducts1();;
 
        // Apply sorting if the sort parameter is provided
        if ("priceAsc".equals(sort)) {
        	bestBrands.sort(Comparator.comparing(Products::getFinal_price));
        } else if ("priceDesc".equals(sort)) {
        	bestBrands.sort(Comparator.comparing(Products::getFinal_price).reversed());
        }
 
        
        model.addAttribute("bestBrands", bestBrands);
 
        return "best_brand_products"; // Return the JSP page
    }
	
 
	@GetMapping("/explore-new-trends")
	public String exploretrendingproducts(
             
            @RequestParam(value = "sort", required = false) String sort,
            Model model) throws IOException, SQLException {
 
        // Fetch products by category ID
		List<Products> newTrends = productDaoImpl.getAllNewTrendingProducts1();
 
        // Apply sorting if the sort parameter is provided
        if ("priceAsc".equals(sort)) {
        	newTrends.sort(Comparator.comparing(Products::getFinal_price));
        } else if ("priceDesc".equals(sort)) {
        	newTrends.sort(Comparator.comparing(Products::getFinal_price).reversed());
        }
 
        
        model.addAttribute("newTrends", newTrends);
 
        return  "new_trending_products"; // Return the JSP page
    }
 
	
	@GetMapping("/explore-all-categories")
	public String exploreallcategories(Model model) {
 
		List<Category> categoryList = productDaoImpl.getAllProductsByCategory1();
		model.addAttribute("categoryList", categoryList);
		return "view_by_category"; // JSP page
	}
 

	@GetMapping("/login")
	public String Login() {
		return "login";
	}

	@GetMapping("/homepageuser")
	public String homepageuser(Model model) {
		List<Products> newArrivals = productDaoImpl.getAllNewArrivalProducts();
		List<Products> discountProducts = productDaoImpl.getAllDiscountProducts();
		List<Products> bestBrands = productDaoImpl.getAllBestBrandProducts();
		List<Products> newTrends = productDaoImpl.getAllNewTrendingProducts();
		List<Category> categoryList = productDaoImpl.getAllProductsByCategory();

		// Add these product lists to the model to be passed to the JSP
		model.addAttribute("newArrivals", newArrivals);
		model.addAttribute("discountProducts", discountProducts);
		model.addAttribute("bestBrands", bestBrands);
		model.addAttribute("newTrends", newTrends);
		model.addAttribute("categoryList", categoryList);
		return "homepageuser"; // JSP page
	}

	// Profile will mapped after the dashboard
	@GetMapping("/profile")
	public String profile() {
		return "profile";
	}

	@GetMapping("/login_superadmin")
	public String superadmin_login() {
		return "login_superadmin";
	}

	@GetMapping("/payments")
	public String payments() {
		return "payments";
	}

	@GetMapping("/order_successful")
	public String order_successful() {
		return "order_successful";
	}

	@GetMapping("/subadmin")
	public String subadmin() {
		return "subadmin";
	}

	@GetMapping("/wishlist")
	public String wishlist() {
		return "wishlist";
	}

	@GetMapping("/orders")
	public String orders() {
		return "orders";
	}

	@GetMapping("/cart")
	public String cart() {
		return "cart";
	}

	@GetMapping("/remove_product")
	public String removeproduct() {
		return "remove_product";
	}

    @GetMapping("/payment/openPaymentPage")
    public String openPaymentPage(@RequestParam double totalAmount, Model model) {
        model.addAttribute("totalAmount", totalAmount);
        return "Payment"; // JSP file for the payment page
    }
    @GetMapping("/contactus")
	public String contact() {
		return "contact_us";
	}
    
    @GetMapping("/aboutus")
  	public String about() {
  		return "about_us";
  	}
      
    
	
}
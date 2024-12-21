package ecom.app.controllers;

import ecom.app.entities.Category;
import ecom.app.entities.Feedback;
import ecom.app.entities.Order;
import ecom.app.entities.Products;
import java.util.Comparator;

import ecom.app.entities.User;
import ecom.app.utility.ByteArrayMultipartFile;
import ecom.app.entities.User;
import ecom.app.utility.ByteArrayMultipartFile;
import ecom.app.utility.Password;
import jakarta.servlet.http.HttpSession;
import ecom.app.dao.FeedbackDaoImpl;
import ecom.app.dao.OrderDaoImpl;
import ecom.app.dao.ProductDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

@Controller
@RequestMapping("/products")
public class ProductController {

	@Autowired
	private ProductDaoImpl productDaoImpl;
	
	@Autowired
	private FeedbackDaoImpl feedbackDaoImpl;
	
	public List<Products> products;
	private Products product;
	
	
	@PostMapping("/add")
	public String addProduct(@ModelAttribute Products product, 
	                         @RequestParam("product_image") MultipartFile file,
	                         RedirectAttributes attributes, 
	                         HttpSession session) {
	    try {
	        // Retrieve the sub-admin's ID from the session
	        Integer subAdminId = (Integer) session.getAttribute("subAdminId");

	        if (subAdminId != null) {
	            // Set the sub-admin's ID in the product object
	            product.setSubAdminId(subAdminId);  // Assuming your `Products` class has a `userId` field
	        } else {
	            attributes.addFlashAttribute("error", "Sub-admin ID not found in session. Please log in again.");
	            return "redirect:/user/login"; // Redirect to login if session is not available
	        }

	        // Check and set the product image
	        if (!file.isEmpty()) {
	            product.setProduct_image(
	                new ByteArrayMultipartFile(file.getBytes(), file.getOriginalFilename(), file.getContentType())
	            );
	        }

	        // Insert the product into the database
	        productDaoImpl.insertProduct(product,subAdminId);
	        attributes.addFlashAttribute("message", "Product added successfully!");

	    } catch (IOException | SQLException e) {
	        attributes.addFlashAttribute("error", "Error adding product: " + e.getMessage());
	    }

	    return "redirect:/subadmin"; // Adjust this to your actual view
	}


	@GetMapping("/view_product")
	public String viewProducts(Model model, HttpSession session) throws IOException, SQLException {
	    // Retrieve the sub-admin ID from the session
	    Integer subAdminId = (Integer) session.getAttribute("subAdminId");
	    
	    // Fetch products specific to the logged-in sub-admin
	    List<Products> listOfProducts = productDaoImpl.fetchProductsBySubAdminId(subAdminId);

	    System.out.println("Fetched Products for Sub Admin ID " + subAdminId + ": " + listOfProducts);
	    model.addAttribute("products", listOfProducts);
	    return "view_product"; // Ensure this matches your JSP filename
	}


	@GetMapping("/view_productbycategoryname") 
	public String viewProductsByCategory(Model model, @RequestParam(required = false) String category_id, HttpSession session) throws IOException, SQLException {
	    Integer subAdminId = (Integer) session.getAttribute("subAdminId"); // Get the sub-admin ID from session
	    List<Products> listOfProducts;

	    if (category_id == null)
	        listOfProducts = productDaoImpl.fetchProductsBySubAdminId(subAdminId); // Fetch products by sub-admin ID
	    else
	        listOfProducts = productDaoImpl.fetchProductsByCategoryAndSubAdminId(Integer.parseInt(category_id), subAdminId); // Fetch by category and sub-admin ID

	    List<Category> categories = productDaoImpl.getAllCategories();
	    model.addAttribute("categories", categories);
	    model.addAttribute("products", listOfProducts);
	    return "view_productbycategoryname"; // Ensure this matches your JSP filename
	}


	@GetMapping("/remove_product/{id}")
	public String removeProduct(@PathVariable("id") int id, RedirectAttributes attributes) {
		try {

			productDaoImpl.deleteProduct(id);
			attributes.addFlashAttribute("message", "Product removed successfully!");
		} catch (Exception e) {
			attributes.addFlashAttribute("error", "Error removing product: " + e.getMessage());
		}
		return "redirect:/products/remove_product"; // Redirect back to the list after removal
	}

	@GetMapping("/remove_product")
	public String removeProducts(Model model, HttpSession session) throws IOException, SQLException {
	    Integer subAdminId = (Integer) session.getAttribute("subAdminId"); // Get sub-admin ID from session
	    List<Products> listOfProducts = productDaoImpl.fetchProductsBySubAdminId(subAdminId); // Fetch products by sub-admin ID

	    model.addAttribute("products", listOfProducts);
	    return "remove_product"; // Ensure this matches your JSP filename
	}


	@GetMapping("/view_product_update_table")
	public String viewProductsUpdate(Model model, HttpSession session) throws IOException, SQLException {
	    Integer subAdminId = (Integer) session.getAttribute("subAdminId"); // Retrieve sub-admin ID from session

	    if (subAdminId != null) {
	        List<Products> listOfProducts = productDaoImpl.fetchProductsBySubAdminId(subAdminId); // Fetch products for this sub-admin
	        model.addAttribute("products", listOfProducts);
	        session.setAttribute("products", listOfProducts);
	    } else {
	        // Handle case where sub-admin ID is not found in session
	        model.addAttribute("error", "Sub-admin ID not found.");
	    }

	    return "update_table"; // Ensure this matches your JSP filename
	}



	@GetMapping("/edit_product/{id}")
	public String editProduct(@PathVariable("id") int id, Model model, HttpSession session) throws IOException, SQLException {
	    Integer subAdminId = (Integer) session.getAttribute("subAdminId"); // Get sub-admin ID from session

	    if (subAdminId != null) {
	        Products product = productDaoImpl.fetchProductById(id, subAdminId); // Fetch the product by ID

	        // Check if the product belongs to the logged-in sub-admin
	        if (product != null && product.getSubAdminId() != null && product.getSubAdminId().equals(subAdminId)) {
	            model.addAttribute("product", product);
	            return "update_product"; // Ensure this matches your JSP filename
	        } else {
	            // Handle the case where the product does not belong to the sub-admin
	            return "redirect:/products/view_product_update_table"; // Redirect back if not authorized
	        }
	    } else {
	        // Handle case where sub-admin ID is not found in session
	        return "redirect:/products/view_product_update_table"; // Redirect if no sub-admin ID
	    }
	}



	@PostMapping("/product_updation")
	public String updateProduct(@ModelAttribute Products updatedProduct, RedirectAttributes attributes,
	        HttpSession session) throws SerialException, IOException, SQLException {

	    Integer subAdminId = (Integer) session.getAttribute("subAdminId"); // Get sub-admin ID from session

	    if (subAdminId != null) {
	        // Retrieve the existing product from the database
	        Products currentProduct = productDaoImpl.getProductById(updatedProduct.getProduct_id()); 

	        if (currentProduct == null || currentProduct.getSubAdminId() == null || !currentProduct.getSubAdminId().equals(subAdminId)) {
	            attributes.addFlashAttribute("error", "Product not found or you do not have permission to edit this product.");
	            return "redirect:/products/view_product_update_table";
	        }

	        // Use the current product's image if none is provided in the updated product
	        if (updatedProduct.getProduct_image() == null || updatedProduct.getProduct_image().isEmpty()) {
	            updatedProduct.setProduct_image(currentProduct.getProduct_image());
	        }

	        try {
	            productDaoImpl.updateProduct(updatedProduct);
	            attributes.addFlashAttribute("message", "Product updated successfully");
	        } catch (Exception e) {
	            attributes.addFlashAttribute("message", "Updation failed. Please try again later");
	        }

	        System.out.println("Fetched Products: " + currentProduct);

	        return "redirect:/products/view_product_update_table";
	    } else {
	        attributes.addFlashAttribute("error", "You must be logged in to update a product.");
	        return "redirect:/products/view_product_update_table";
	    }
	}

	

	
	@GetMapping("/add1")
    public String products(Model model) {
        List<Category> categories =  productDaoImpl.getAllCategories(); 
        model.addAttribute("categories", categories); 
        return "products"; 
        }
 
       @GetMapping("/display1")
    public String listProducts(Model model) {
        List<Products> productList = productDaoImpl.getAllProducts();
        model.addAttribute("products", productList);
        return "display_products"; // JSP page
    }
    
    @GetMapping
    public String getProducts(@RequestParam(value = "sort", required = false) String sort, Model model) {
        List<Products> products = productDaoImpl.getAllProducts();
 
        // Sorting logic
        if ("priceAsc".equals(sort)) {
            products.sort(Comparator.comparing(Products::getFinal_price));
        } else if ("priceDesc".equals(sort)) {
            products.sort(Comparator.comparing(Products::getFinal_price).reversed());
        }
        model.addAttribute("products", products);
        return "display_products"; // Return the JSP page
    }
 
    
    
    @GetMapping("/{id}")
    public String viewProductDetails(@PathVariable("id") int productId, HttpSession session) throws IOException, SQLException {
        Products product = productDaoImpl.getProductById(productId);
        session.setAttribute("product", product);
        List<Feedback> feedbackList = feedbackDaoImpl.getFeedbackByProductId(productId);
        System.out.println("Feedbacklist " + feedbackList);
       session.setAttribute("feedbackList", feedbackList);

        return "product_details"; // JSP page
    }
    

    @GetMapping("/category/{id}")
    public String viewProductDetailsByCategory(
            @PathVariable("id") int categoryId,
            @RequestParam(value = "sort", required = false) String sort,
            Model model) throws IOException, SQLException {
 
        // Fetch products by category ID
        List<Products> products = productDaoImpl.fetchProductsByCategory(categoryId);
 
        // Apply sorting if the sort parameter is provided
        if ("priceAsc".equals(sort)) {
            products.sort(Comparator.comparing(Products::getFinal_price));
        } else if ("priceDesc".equals(sort)) {
            products.sort(Comparator.comparing(Products::getFinal_price).reversed());
        }
 
        // Add products and categoryId to the model
        model.addAttribute("products", products);
        model.addAttribute("categoryId", categoryId);
 
        return "product_by_category"; // Return the JSP page
    }
    
    @GetMapping("/addProductForm")
    public String showAddProductForm(Model model) {
        List<Category> categories = productDaoImpl.getAllCategories();
        model.addAttribute("categories", categories);
        return "add_product_form";  // Name of your JSP page
    }

    
    @GetMapping("/search")
    public String searchProducts(@RequestParam("query") String query, Model model) {
        List<Products> searchResults = productDaoImpl.searchProducts(query);
        model.addAttribute("searchResults", searchResults);
        return "search_results";  // JSP page to display the search results
    }
    


    
 
}
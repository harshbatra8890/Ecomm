package ecom.app.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ecom.app.dao.CategoryDao;
import ecom.app.dao.ProductDaoImpl;
import ecom.app.entities.Category;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    private CategoryDao categoryDao;
    
    @Autowired
	private ProductDaoImpl productDaoImpl;

    @GetMapping("/add")
    public String showAddCategoryForm() {
        return "addCategory"; 
    }

    @PostMapping("/add")
    public String addCategory(@ModelAttribute Category category, 
                              @RequestParam("category_image") MultipartFile file,
                              RedirectAttributes attributes, 
                              HttpSession session) { 
        try {
            if (!file.isEmpty()) {
                category.setCategory_image(file);
            }
            int generatedCategoryId = categoryDao.insertCategory(category);
            
            session.setAttribute("categoryId", generatedCategoryId);
            
            attributes.addFlashAttribute("message", "Category added successfully!");
        } catch (IOException | SQLException e) {
            attributes.addFlashAttribute("error", "Error adding Category: " + e.getMessage());
        }
        return "redirect:/category/dashboard"; 
    }
    
    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {

    	Integer categoryId = (Integer) session.getAttribute("categoryId");
        session.setAttribute("categoryId", categoryId); 
        
        return "superadmin_dashboard"; 
    }
    
    @GetMapping("/view")
    public String viewcategory(Model model) {
    	List<Category> categories = productDaoImpl.getAllCategories(); 
        model.addAttribute("categories", categories);
        return "display_category"; 
    }
    
}

package ecom.app.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ecom.app.dao.CartDaoImpl;
import ecom.app.dao.OrderDaoImpl;
import ecom.app.dao.UserDaoImpl;
import ecom.app.entities.User;
import ecom.app.utility.Password;
import jakarta.servlet.http.HttpSession;
import ecom.app.entities.Cart;
import ecom.app.entities.Order;
import ecom.app.entities.Role;
import ecom.app.entities.SuperAdmin;

@Controller
@RequestMapping("/user")
public class UserController {

	private User user;

	@Autowired
	UserDaoImpl userDaoImpl;


    @Autowired
    private CartDaoImpl cartDaoImpl;
    
    @Autowired
	private OrderDaoImpl orderDaoImpl;

	
	@GetMapping("/login")
	public String Login() {
		
		return "user_login";
	}
	
	
	@GetMapping("/openRegistrationPage")
	public ModelAndView openRegistrationPage(ModelAndView modelAndView ) {


		List<Role> listOfRoles = userDaoImpl.fetchAllRoles();
		
		System.out.println(listOfRoles );

		   
		
		modelAndView.addObject("listOfRoles", listOfRoles);
		modelAndView.setViewName("user_registration");

		System.out.println("User is regitered");
		return modelAndView;
	}
	




	@PostMapping("/login")
	public String login(@RequestParam String username, 
	                    @RequestParam String password, 
	                    @RequestParam String role,
	                    Model model, 
	                    RedirectAttributes attributes,
	                    HttpSession session) {

	    String usernameError = null;
	    String passwordError = null;

	    try {
	        user = userDaoImpl.fetchUser(username);

	        if (!"ACTIVE".equals(user.getStatus())) {
	            attributes.addFlashAttribute("message", "Your account is not active. Status: " + user.getStatus());
	            return "redirect:/user/login";
	        }

	        String pwdSalt = user.getPasswordSalt();
	        String oldPwdHash = user.getPasswordHash();
	        String newPassword = password + pwdSalt;
	        String newPasswordHash = Password.generatePwdHash(newPassword);

	        if (newPasswordHash.equals(oldPwdHash)) {
	            model.addAttribute("user", user);
	            int roleId = user.getRole().getRoleId();
	            attributes.addFlashAttribute("user", user); // Pass the user object
	            session.setAttribute("user", user); // Store user in session

	            if (role.equalsIgnoreCase("Retailer")) {
	                if (roleId == 2) {
	                    session.setAttribute("subAdminId", user.getUserId());
	                    return "subadmin"; 
	                } else {
	                    usernameError = "No Retailer found with this username";
	                }
	            } else if (role.equalsIgnoreCase("Customer")) {
	                if (roleId == 3) {
	                    return "redirect:/homepageuser"; // Redirect to customer page
	                } else {
	                    usernameError = "No Customer found with this username";
	                }
	            }
	        } else {
	            passwordError = "Incorrect Password";
	        }
	    } catch (EmptyResultDataAccessException e) {
	        usernameError = "Incorrect Username";
	    }

	    // Add error messages to the attributes
	    if (usernameError != null && passwordError != null) {
	        attributes.addFlashAttribute("error", "Both " + usernameError + " and " + passwordError);
	    } else if (usernameError != null) {
	        attributes.addFlashAttribute("error", usernameError);
	    } else if (passwordError != null) {
	        attributes.addFlashAttribute("error", passwordError);
	    }

	    return "redirect:/user/login"; // Redirect back to login on failure
	}

	
	@PostMapping("/register")
	public String register(@ModelAttribute User user, @RequestParam("roleId") int roleId, RedirectAttributes attributes, HttpSession session)
	        throws IOException, SQLException {

	    System.out.println("Selected Role ID: " + roleId);

	    
	    // Fetch role based on roleId and set it to user
	    Role selectedRole = userDaoImpl.fetchRoleById(roleId); // Create this method in your UserDaoImpl
	    user.setRole(selectedRole);

	    System.out.println("Selected Role: " + selectedRole);

	    // Password Encryption
	    String passwordSalt = Password.generatePwdSalt(10);
	    user.setPasswordSalt(passwordSalt);
	    String newPassword = user.getPassword() + passwordSalt;
	    String passwordHash = Password.generatePwdHash(newPassword);
	    user.setPasswordHash(passwordHash);

	    // Set status based on role
	    if (selectedRole != null) {
	        int selectedRoleId = selectedRole.getRoleId();
	        if (selectedRoleId == 2) { // Retailer
	            user.setStatus("PENDING"); // Set status to pending for retailers
	        } else if (selectedRoleId == 3) { // Assuming roleId 3 is for Customers
	            user.setStatus("ACTIVE"); // Set status to active for customers
	        }
	    } else {
	        attributes.addFlashAttribute("error", "Please select a role.");
	        return "redirect:/user/openRegistrationPage";
	    }

	    int result = userDaoImpl.insertUser(user);

	    if (result > 0) {
	        attributes.addFlashAttribute("message", "Registration Successful");
	        return "redirect:/user/login";
	    } else {
	        attributes.addFlashAttribute("error", "Registration Failed");
	        return "redirect:/user/openRegistrationPage";
	    }
	}


	
	@GetMapping("/profile")
	public ModelAndView viewProfile(ModelAndView mView, @RequestParam String username , HttpSession session) throws IOException, SQLException {
	    User user = userDaoImpl.fetchUser(username);
	    System.out.println(user);
        session.setAttribute("user", user); // Store user in session


	    if (user.getProfileImage() != null) {
	        byte[] imageBytes = user.getProfileImage().getBytes();
	        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
	        mView.addObject("profileImage", base64Image);
	    } else {
	        mView.addObject("profileImage", null);
	    }
	    

	    byte[] imageBytes = user.getProfileImage().getBytes();
	    String base64Image = Base64.getEncoder().encodeToString(imageBytes);

	    mView.setViewName("profile");
	    mView.addObject("user", user);
	    mView.addObject("profileImage", base64Image); // Now it's Base64 encoded
	    
	    return mView;
	}
	
	@GetMapping("/editprofile")
	public String editProfile(Model model, HttpSession session) {
	    User user = (User) session.getAttribute("user");
	    
	    if (user == null) {
	        return "redirect:/user/login";
	    }

	    // Pass the user object to the model
	    model.addAttribute("user", user);
	    
	    // Check if the user has a profile image
	    if (user.getProfileImage() != null && user.getProfileImage().getSize() > 0) {
	        try {
	            byte[] imageBytes = user.getProfileImage().getBytes();
	            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
	            model.addAttribute("profileImage", base64Image);
	        } catch (IOException e) {
	            // Handle the exception (log it, etc.)
	            model.addAttribute("profileImage", null);
	        }
	    } else {
	        model.addAttribute("profileImage", null);
	    }

	    return "editprofile"; // Return the edit profile view
	}



	@PostMapping("/updateProfile")
	public String updateProfile(@ModelAttribute User updatedUser, RedirectAttributes attributes, HttpSession session) 
	        throws SerialException, IOException, SQLException {
	    
	    // Get the current user from the session
	    User currentUser = (User) session.getAttribute("user");

	    // Make sure the username is present in updatedUser
	    if (updatedUser.getUsername() == null || updatedUser.getUsername().isEmpty()) {
	        updatedUser.setUsername(currentUser.getUsername());
	    }

	    // Check if a new image is uploaded
	    if (updatedUser.getProfileImage() != null && updatedUser.getProfileImage().getSize() > 0) {
	        // Use the new image
	        updatedUser.setProfileImage(updatedUser.getProfileImage());
	    } else {
	        // Keep the existing image
	        updatedUser.setProfileImage(currentUser.getProfileImage());
	    }

	    System.out.println("Username from request: " + updatedUser);

	    try {
	        userDaoImpl.modifyUser(updatedUser);
	        attributes.addFlashAttribute("message", "Profile updated successfully");
	    } catch (Exception e) {
	        attributes.addFlashAttribute("error", "Updation failed. Please try again later");
	    }

	    // Use the username from the current user for redirection
	    return "redirect:/user/profile?username=" + currentUser.getUsername(); 
	}

	 

	 
	@GetMapping("/resetPassword")
    public String showResetPasswordForm(Model model) {
        return "user_reset_pswd";
    }

  private boolean isValidUsername(String username) {
    	user = userDaoImpl.fetchUser(username);
        return username != null && !username.trim().isEmpty() && user.getUsername().equals(username);
    }
  
  private boolean isValidPassword(String password) {
	    // Regex patterns
	    String specialCharPattern = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*"; // At least one special character
	    String lowerCasePattern = ".*[a-z].*"; // At least one lowercase letter
	    String upperCasePattern = ".*[A-Z].*";
	    String hasNumbers = ".*[0-9].*"; // At least one uppercase letter

	    return password != null
	        && password.length() >= 8
	        && password.length() <= 15
	        && !password.contains(" ")
	        && password.matches(specialCharPattern) // Check for special character
	        && password.matches(lowerCasePattern) // Check for lowercase letter
	        && password.matches(upperCasePattern)
	        && password.matches(hasNumbers); // Check for uppercase letter
	}

  
  
  
  @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam("username") String username,
                                @RequestParam("newPassword") String newPassword,
                                @RequestParam("confirmPassword") String confirmPassword,
                                RedirectAttributes redirectAttributes) {
    	
    	  user = userDaoImpl.fetchUser(username);
    	    if (user == null) {
    	        redirectAttributes.addFlashAttribute("error", "Username does not exist.");
    	        return "redirect:/user/resetPassword";
    	    }
    	if (!isValidUsername(username)) {
            redirectAttributes.addFlashAttribute("error", "Invalid username. Username must match an existing one.");
            return "redirect:/user/resetPassword";
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match.");
            return "redirect:/user/resetPassword";
        }

        if (!isValidPassword(newPassword)) {
            redirectAttributes.addFlashAttribute("error", "Invalid password. It should be 8-15 characters long without spaces, contains atleast one lowercase alphabet, uppercase alphabet and digit.");
            return "redirect:/user/resetPassword";
        }

        String passwordSalt = Password.generatePwdSalt(10);
        String passwordHash1 = newPassword + passwordSalt;

        String passwordHash = Password.generatePwdHash(passwordHash1);
       
        int result = userDaoImpl.resetUserPassword(username,passwordHash,passwordSalt);
        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "New password set successfully.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Username does not exist.");
        }
        
        return "subadmin";
    }
  
  @GetMapping("/forgotpassword1")
    public String showforgotpasswordpage() {
        return "user_forgot_password"; // JSP page for entering email
    }

		  @PostMapping("/verifyemail")
	public String verifyEmail(@RequestParam("email") String email, Model model) {
	    // Email format validation to accept only @gmail.com emails
	    String emailRegex = "^[\\w-\\.]+@gmail\\.com$";
	    
	    // Check email length
	    if (email.length() < 5 || email.length() > 25) {
	        model.addAttribute("error", "Email must be between 5 and 25 characters.");
	        return "user_forgot_password"; // Stay on the same page with error message
	    }

	    if (!email.matches(emailRegex)) {
	        model.addAttribute("error", "Invalid email format. Please enter a valid Gmail address.");
	        return "user_forgot_password"; // Stay on the same page with error message
	    }

	    User user = userDaoImpl.findByEmail(email);
	    if ( user != null) {
	        model.addAttribute("email", email); // Pass email to next page
	        return "reset2_password"; // Redirect to the reset password page
	    } else {
	        model.addAttribute("error", "Email not found. Please try again.");
	        return "user_forgot_password"; // Stay on the same page with error message
	    }
	}

    

    @PostMapping("/resetpassword1")
    public String resetPassword(
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            @RequestParam("email") String email,
            Model model) {

        // Validate passwords
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error1", "Passwords do not match.");
            model.addAttribute("email", email); // Keep email in case of error
            return "reset2_password"; // Return to reset password page with error
        }

        if (!isValidPassword(newPassword)) {
            model.addAttribute("error1", "Invalid password. It should be 8-15 characters long without spaces.");
            model.addAttribute("email", email); // Keep email in case of error
            return "reset2_password"; // Return to reset password page with error
        }

        // Proceed with password reset
        String passwordSalt = Password.generatePwdSalt(10);
        String passwordHash = Password.generatePwdHash(newPassword + passwordSalt);

        // Update the password in the database
        int result = userDaoImpl.forgotUserPassword(email, passwordHash, passwordSalt);
        if (result > 0) {
            model.addAttribute("message", "New password set successfully.");
            return "user_login"; // Redirect to login page after success
        } else {
            model.addAttribute("error1", "Error updating password. Please try again.");
            model.addAttribute("email", email); // Keep email in case of error
            return "reset2_password"; // Return to reset password page with error
        }
    }

	 // Display all product sales for a specific sub-admin
	    @GetMapping("/salesPerformance/subAdmin/{subAdminId}")
	    public String generateSubAdminSalesReport(@PathVariable("subAdminId") int subAdminId, Model model) {
	        try {
	            // Fetch orders for the specific sub-admin's products
	            List<Order> orders = orderDaoImpl.getSalesDataBySubAdminProducts(subAdminId, "1970-01-01", "9999-12-31"); // Use a broad date range or adjust as needed
	            model.addAttribute("orders", orders);
	        } catch (SQLException e) {
	            e.printStackTrace();
	            model.addAttribute("error", "Could not fetch orders.");
	        }
	        return "subadmin_sales_performance";  // Use the JSP for displaying the sub-admin's sales performance
	    }

	    @PostMapping("/salesPerformance/subAdmin/{subAdminId}/getSalesData")
	    public String getSalesDataForSubAdmin(@PathVariable("subAdminId") int subAdminId, 
	                                          @RequestParam("startDate") String startDate, 
	                                          @RequestParam("endDate") String endDate, 
	                                          Model model) {
	        List<Order> salesData = new ArrayList<>();
	        try {
	            // Fetch orders for the products added by the specific sub-admin
	            salesData = orderDaoImpl.getSalesDataBySubAdminProducts(subAdminId, startDate, endDate);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        // Calculate total sales for the sub-admin
	        double totalSales = salesData.stream().mapToDouble(Order::getTotalAmount).sum();

	        model.addAttribute("orders", salesData);
	        model.addAttribute("totalSales", totalSales);
	        model.addAttribute("startDate", startDate);
	        model.addAttribute("endDate", endDate);
	        
	        return "subadmin_sales_performance"; // Return to sub-admin's sales report page
	    }


}
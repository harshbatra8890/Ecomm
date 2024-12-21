package ecom.app.controllers;



import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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

import ecom.app.dao.OrderDaoImpl;
import ecom.app.dao.SuperAdminDaoImpl;
import ecom.app.dao.UserDaoImpl;
import ecom.app.entities.Order;
import ecom.app.entities.Role;
import ecom.app.entities.SuperAdmin;
import ecom.app.entities.User;
import ecom.app.utility.Password;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/superAdmin")
public class SuperAdminController {

	@Autowired
	SuperAdminDaoImpl superAdminDaoImpl;
	SuperAdmin superAdmin;

	@Autowired
	UserDaoImpl userDaoImpl;

	@Autowired
	OrderDaoImpl orderDaoImpl;

	@GetMapping("/dashboard")
	public String dashboard(HttpSession session) {

		   if (session.getAttribute("superAdmin")== null) {
			   return "redirect:/";
		   }
		   
		return "superadmin_dashboard";

	}
	

	@PostMapping("/login")
	public String login(@RequestParam String username, @RequestParam String password, Model model,
			HttpSession session) {
		System.out.println("\n login request data: " + username + ", " + password);

		// Fetch user details from the database
		superAdmin = superAdminDaoImpl.findByUsername(username);
		System.out.println(superAdmin);

		if (superAdmin != null) {
			String pwdSalt = superAdmin.getPasswordSalt();
			String oldPwdHash = superAdmin.getPasswordHash();

			// Check credentials
			String newPassword = password + pwdSalt;
			String newPasswordHash = Password.generatePwdHash(newPassword);
			System.out.println("pwd Salt : " + pwdSalt);
			System.out.println("Old password : " + oldPwdHash);
			System.out.println("New password: " + newPasswordHash);

			if (newPasswordHash.equals(oldPwdHash)) {
				model.addAttribute("superAdmin", superAdmin);
				session.setAttribute("superAdmin", superAdmin);
				return "redirect:/superAdmin/dashboard"; // Redirect to the super admin dashboard on success
			} else {
				model.addAttribute("error", "Incorrect password. Please try again."); // Password mismatch
			}
		} else {
			model.addAttribute("error", "Username does not exist. Please check your username."); // Username not found
		}

		return "login_superadmin"; // Redirect back to login page with error message
	}

	@GetMapping("/login")
	public String Login() {
		return "login_superadmin";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {

		session.removeAttribute("superAdmin");

		return "redirect:/";

	}

	@GetMapping("/viewSubadminRequests")
	public String viewPendingSubadminRequests(Model model) {
		List<User> pendingUsers = userDaoImpl.getPendingSubadminRequests(); // Use your method to get pending users
		List<User> inactiveUsers = userDaoImpl.getInactiveSubadminRequests(); // Fetch inactive users
		List<User> activeUserList = userDaoImpl.findAllSubAdmins(); // Fetch active users

		model.addAttribute("userList", pendingUsers);
		model.addAttribute("inactiveUserList", inactiveUsers); // Add inactive users to the model
		model.addAttribute("activeUserList", activeUserList); // Add active users

		System.out.println("Pending users: " + pendingUsers);
		System.out.println("Inactive users: " + inactiveUsers);
		System.out.println("Active users: " + activeUserList);

		return "view_subadmin_requests"; // Return the correct view name
	}

	@PostMapping("/approveUser")
	public String approveUser(@RequestParam int userId) {
		userDaoImpl.updateUserStatus(userId, "ACTIVE"); // Change status to ACTIVE
		return "redirect:/superAdmin/viewSubadminRequests"; // Redirect back to the requests view
	}

	@PostMapping("/deleteUser")
	public String deleteUser(@RequestParam int userId) {
		userDaoImpl.updateUserStatus(userId, "INACTIVE");
		return "redirect:/superAdmin/viewSubadminRequests";
	}

	@GetMapping("/viewProfile")
	public ModelAndView viewProfile(ModelAndView mView) {
		mView.setViewName("superadmin_profile");
		mView.addObject("superAdmin", superAdmin);
		return mView;
	}

	//

	@PostMapping("/updateProfile")
	public String updateProfile(@ModelAttribute SuperAdmin updateSuperAdmin, RedirectAttributes redirectAttributes) {
		List<String> errors = new ArrayList<>();


		// Validate first name
		if (updateSuperAdmin.getFirstName() == null || !updateSuperAdmin.getFirstName().matches("[a-zA-Z]{3,20}")) {
			errors.add("First name must be between 3-20 characters and contain only alphabets.");
		}

		// Validate last name
		if (updateSuperAdmin.getLastName() == null || !updateSuperAdmin.getLastName().matches("[a-zA-Z]{3,20}")) {
			errors.add("Last name must be between 3-20 characters and contain only alphabets.");
		}

		// Validate email
		if (updateSuperAdmin.getEmailId() == null
				|| !updateSuperAdmin.getEmailId().matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$")) {
			errors.add("Email must be in the format of example@gmail.com.");
		}

		// Validate phone number
		if (updateSuperAdmin.getMobileNo() == null || !updateSuperAdmin.getMobileNo().matches("\\d{10}")) {
			errors.add("Phone number must be 10 digits.");
		}

		// Validate username
		if (updateSuperAdmin.getUsername() == null || !updateSuperAdmin.getUsername().matches("^[a-zA-Z0-9]{7,15}$")) {
			errors.add("Username must be between 7-15 characters and contain only alphabets and numbers.");
		}

		if (!errors.isEmpty()) {

			redirectAttributes.addFlashAttribute("errors", errors);
			return "redirect:/superAdmin/viewProfile";
		}

		
		  // Fetch the original super admin by username
	    SuperAdmin originalSuperAdmin = superAdminDaoImpl.getSuperAdminDetails();
	    
	    System.out.println("Superadmin : "+originalSuperAdmin);

	    // Compare fields to check for changes
	    boolean isChanged = false;
	    
	    if (!originalSuperAdmin.getFirstName().equals(updateSuperAdmin.getFirstName()) ||
	        !originalSuperAdmin.getLastName().equals(updateSuperAdmin.getLastName()) ||
	        !originalSuperAdmin.getEmailId().equals(updateSuperAdmin.getEmailId()) ||
	        !originalSuperAdmin.getMobileNo().equals(updateSuperAdmin.getMobileNo()) ||
	        !originalSuperAdmin.getUsername().equals(updateSuperAdmin.getUsername())) {
	        
	        isChanged = true; // There are changes in the profile
	    }

	    // If no changes were made, set a flag for the front-end
	    if (!isChanged) {
	        redirectAttributes.addFlashAttribute("noChangesMade", true);
	        return "redirect:/superAdmin/viewProfile";
	    }

	    // Save the updated super admin information
	    superAdminDaoImpl.updateSuperAdminProfile(updateSuperAdmin);
		// Save updated super admin information (you may need to implement this)
		superAdmin = superAdminDaoImpl.updateSuperAdminProfile(updateSuperAdmin);
		

		
		redirectAttributes.addFlashAttribute("message", "Profile updated successfully!");
		return "redirect:/superAdmin/viewProfile";

	}

	@GetMapping("/resetPassword")
	public String showResetPasswordForm(Model model) {
		return "reset_superadmin_password";
	}
 
	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam("username") String username,
			@RequestParam("newPassword") String newPassword, @RequestParam("confirmPassword") String confirmPassword,
			RedirectAttributes redirectAttributes) {
 
		superAdmin = superAdminDaoImpl.findByUsername(username);
		if (superAdmin == null) {
			redirectAttributes.addFlashAttribute("error", "Username does not exist.");
			return "redirect:/superAdmin/resetPassword";
		}
		if (!isValidUsername(username)) {
			redirectAttributes.addFlashAttribute("error", "Invalid username. Username must match an existing one.");
			return "redirect:/superAdmin/resetPassword";
		}
 
		if (!newPassword.equals(confirmPassword)) {
			redirectAttributes.addFlashAttribute("error", "Passwords do not match.");
			return "redirect:/superAdmin/resetPassword";
		}
 
		if (!isValidPassword(newPassword)) {
			redirectAttributes.addFlashAttribute("error",
					"Invalid password. It should be 8-15 characters long without spaces.");
			return "redirect:/superAdmin/resetPassword";
		}
 
		String passwordSalt = Password.generatePwdSalt(10);
		String passwordHash1 = newPassword + passwordSalt;
 
		String passwordHash = Password.generatePwdHash(passwordHash1);
 
		int result = superAdminDaoImpl.resetSuperAdminPassword(username, passwordHash, passwordSalt);
		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "New password set successfully.");
		} else {
			redirectAttributes.addFlashAttribute("error", "Username does not exist.");
		}
 
		return "superadmin_dashboard";
	}
 
	private boolean isValidUsername(String username) {
		superAdmin = superAdminDaoImpl.findByUsername(username);
		return username != null && !username.trim().isEmpty() && superAdmin.getUsername().equals(username);
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
	
	@GetMapping("/viewAllCustomers")
	public String viewAllCustomers(Model model) {
		List<User> customers = userDaoImpl.findAllCustomers();
		System.out.println(customers);
		model.addAttribute("customers", customers);
		return "view_all_customers";
	}

	// View All Sub Admins
	@GetMapping("/viewAllSubAdmins")
	public String viewAllSubAdmins(Model model) {
		List<User> subAdmins = userDaoImpl.findAllSubAdmins();
		model.addAttribute("subadmins", subAdmins);
		return "view_all_subadmins";
	}

	// profile mapped
	@GetMapping("/profile")
	public ModelAndView viewProfile(ModelAndView mView, @RequestParam String username) {
		User user = userDaoImpl.fetchUser(username);

		mView.setViewName("profile");
		mView.addObject("user", user);
		return mView;
	}

	// Handle the entire forgot password flow
		@GetMapping("/forgotpassword")
		public String showForgotPasswordPage() {
			return "forgot_password"; // JSP page for entering email
		}
	 
		@PostMapping("/verify_email")
		public String verifyEmail(@RequestParam("email") String email, Model model) {
		    // Email format validation to accept only @gmail.com emails
		    String emailRegex = "^[\\w-\\.]+@gmail\\.com$";
		    
		    // Check email length
		    if (email.length() < 11 || email.length() > 30) {
		        model.addAttribute("error", "Email must be between 11 and 30 characters.");
		        return "forgot_password"; // Stay on the same page with error message
		    }
	 
		    if (!email.matches(emailRegex)) {
		        model.addAttribute("error", "Invalid email format. Please enter a valid Gmail address.");
		        return "forgot_password"; // Stay on the same page with error message
		    }
	 
		    SuperAdmin superAdmin = superAdminDaoImpl.findByEmail(email);
		    if (superAdmin != null) {
		        model.addAttribute("email", email); // Pass email to next page
		        return "reset1_password"; // Redirect to the reset password page
		    } else {
		        model.addAttribute("error", "Email not found. Please try again.");
		        return "forgot_password"; // Stay on the same page with error message
		    }
		}
	 
	 
		@PostMapping("/resetpassword")
		public String resetpassword(@RequestParam("newPassword") String newPassword,
				@RequestParam("confirmPassword") String confirmPassword, @RequestParam("email") String email, Model model) {
	 
			if (!newPassword.equals(confirmPassword)) {
				model.addAttribute("error1", "Passwords do not match.");
				model.addAttribute("email", email); // Keep email in case of error
				return "reset1_password"; // Return to reset password page with error
			}
	 
			if (!isValidPassword(newPassword)) {
				model.addAttribute("error1", "Invalid password. It should be 8-15 characters long without spaces, contains atleast one lowercase alphabet, uppercase alphabet and  digit.");
				model.addAttribute("email", email); // Keep email in case of error
				return "reset1_password"; // Return to reset password page with error
			}
	 
			// Proceed with password reset if no errors
			String passwordSalt = Password.generatePwdSalt(10);
			String passwordHash1 = newPassword + passwordSalt;
			String passwordHash = Password.generatePwdHash(passwordHash1);
	 
			int result = superAdminDaoImpl.resetSuperAdminPassword(passwordHash, passwordSalt);
			if (result > 0) {
				model.addAttribute("message", "New password set successfully.");
				return "login_superadmin"; // Redirect to login page after success
			} else {
				model.addAttribute("error1", "Error updating password. Please try again.");
				model.addAttribute("email", email); // Keep email in case of error
				return "reset1_password"; // Return to reset password page with error
			}
		}
	 
	 

	// this is for display all the product sales
	@GetMapping("/salesPerformance")
	public String generateSalesReport(Model model) {
		try {
			List<Order> orders = orderDaoImpl.getAllOrders();
			model.addAttribute("orders", orders);
		} catch (SQLException e) {
			e.printStackTrace();
			model.addAttribute("error", "Could not fetch orders.");
		}
		return "sales_performance";
	}

	// this is for display all the sales according to date
	@PostMapping("/salesPerformance/getSalesData")
	public String getSalesData(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate,
			Model model) {
		List<Order> salesData = new ArrayList<>();
		try {
			salesData = orderDaoImpl.getSalesDataByDateRange(startDate, endDate);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		double totalSales = salesData.stream().mapToDouble(Order::getTotalAmount).sum();

		model.addAttribute("orders", salesData);
		model.addAttribute("totalSales", totalSales);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "sales_performance";
	}

	@GetMapping("/commissions")
	public String displayCommissions(Model model) {
		try {
			List<Order> orders = orderDaoImpl.getAllOrders(); // Adjust as necessary
			model.addAttribute("orders", orders);
		} catch (SQLException e) {
			e.printStackTrace();
			model.addAttribute("error", "Could not fetch orders.");
		}
		return "superadmin_commission";
	}

	@PostMapping("/commissions/getCommissionsData")
	public String getCommissionsData(@RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate, Model model) {
		List<Order> commissionsData = new ArrayList<>();
		double totalCommissions = 0;

		try {
			commissionsData = orderDaoImpl.getOrdersByDateRange(startDate, endDate);
			totalCommissions = commissionsData.stream().mapToDouble(order -> order.getTotalAmount() * 0.01).sum(); // Calculate
																													// total
																													// commissions
		} catch (SQLException e) {
			e.printStackTrace();
		}

		model.addAttribute("orders", commissionsData);
		model.addAttribute("totalCommissions", totalCommissions);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);

		return "superadmin_commission";
	}

}
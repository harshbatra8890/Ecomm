package ecom.app.dao;

import ecom.app.entities.SuperAdmin;

public interface SuperAdminDao {

	 // Fetch the super admin details by ID
		SuperAdmin findByUsername(String username);

	    // Update super admin profile details
		 SuperAdmin updateSuperAdminProfile(SuperAdmin superAdmin);

	    // Update password for super admin
	    int resetSuperAdminPassword(String username, String passwordHash, String passwordSalt);
	    

	   SuperAdmin findByEmail(String email);

	SuperAdmin getSuperAdminDetails();
      

}

package ecom.app.dao;
 
 
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
 
import ecom.app.entities.SuperAdmin;
 
@SpringBootTest
public class SuperAdminDaoImplTest {
 
    @Autowired
    private SuperAdminDaoImpl superAdminDaoImpl;
 
    private SuperAdmin dummySuperAdmin;
 
    @BeforeEach
    public void setUp() {
        // Initializing a dummy SuperAdmin object for testing
        dummySuperAdmin = new SuperAdmin();
        dummySuperAdmin.setFirstName("Harsh");
        dummySuperAdmin.setLastName("Batra");
        dummySuperAdmin.setEmailId("batra@example.com");
        dummySuperAdmin.setMobileNo("1234567890");
        dummySuperAdmin.setUsername("batraji");
        dummySuperAdmin.setPasswordSalt("salt12345");
        dummySuperAdmin.setPasswordHash("hashedPass");
    }
 
    @Test
    @Rollback
    public void testFindByUsername() {
       
        // Fetching the super admin by username
        SuperAdmin foundSuperAdmin = superAdminDaoImpl.findByUsername(dummySuperAdmin.getUsername());
        // Asserting that the found super admin is not null and username matches
        Assertions.assertNotNull(foundSuperAdmin, "SuperAdmin should be found by username.");
        Assertions.assertEquals(dummySuperAdmin.getUsername(), foundSuperAdmin.getUsername(), "Usernames should match.");
    }
 
    @Test
    @Rollback
    public void testFindByEmail() {
        
 
        // Fetching the super admin by email
        SuperAdmin foundSuperAdmin = superAdminDaoImpl.findByEmail(dummySuperAdmin.getEmailId());
        // Asserting that the found super admin is not null and email matches
        Assertions.assertNotNull(foundSuperAdmin, "SuperAdmin should be found by email.");
        Assertions.assertEquals(dummySuperAdmin.getEmailId(), foundSuperAdmin.getEmailId(), "Emails should match.");
    }
 
    @Test
    @Rollback
    public void testUpdateSuperAdminProfile() {
 
        // Fetch the inserted super admin to ensure the ID is set correctly
        SuperAdmin insertedSuperAdmin = superAdminDaoImpl.findByUsername(dummySuperAdmin.getUsername());
        Assertions.assertNotNull(insertedSuperAdmin, "Inserted SuperAdmin should be retrievable.");
        
        // Update the ID of the dummySuperAdmin with the inserted SuperAdmin's ID
        dummySuperAdmin.setId(insertedSuperAdmin.getId());
        dummySuperAdmin.setFirstName("BATRA");
 
        // Now, call the update method
        SuperAdmin updatedSuperAdmin = superAdminDaoImpl.updateSuperAdminProfile(dummySuperAdmin);
        
        // Ensure the first name has been updated
        Assertions.assertEquals("BATRA", updatedSuperAdmin.getFirstName(), "SuperAdmin's first name should be updated.");
    }
 
 
   
 
}
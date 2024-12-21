package ecom.app.dao;


import java.io.IOException;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.annotation.Rollback;
import org.springframework.web.multipart.MultipartFile;

import ecom.app.entities.User;
import ecom.app.entities.Role;

@SpringBootTest
public class UserDaoImplTest {

    @Autowired
    private UserDaoImpl userDaoImpl;

    
    
    @Test
    public void testFetchAllRoles() {
        List<Role> roles = userDaoImpl.fetchAllRoles();
        Assertions.assertFalse(roles.isEmpty(), "Roles list should not be empty.");
    }
    
   

  
}
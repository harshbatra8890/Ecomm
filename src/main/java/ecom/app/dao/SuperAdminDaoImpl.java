package ecom.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import ecom.app.entities.SuperAdmin;
import ecom.app.entities.User;


@Repository
public class SuperAdminDaoImpl implements SuperAdminDao{

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public SuperAdmin findByUsername(String username) {
    	try {
        String sql = "SELECT * FROM super_admin WHERE username = ?";
        return jdbcTemplate.queryForObject(sql, new SuperAdminRowMapper(),username);
        
    } catch (EmptyResultDataAccessException e) {
        return null; // Username not found
    }
    }
    
    
 
    
    @Override
    public SuperAdmin findByEmail(String email) {
    	try {
        String sql = "SELECT * FROM super_admin WHERE email_id = ?";
        return jdbcTemplate.queryForObject(sql, new SuperAdminRowMapper(),email);
        
    } catch (EmptyResultDataAccessException e) {
        return null; // Username not found
    }
    }
    public SuperAdmin updateSuperAdminProfile(SuperAdmin superAdmin) {
        String sql1 = "UPDATE super_admin SET first_name = ?, last_name = ?, email_id = ?, mobile_no = ?, username = ? WHERE id = ?";
         jdbcTemplate.update(sql1, superAdmin.getFirstName(), superAdmin.getLastName(), superAdmin.getEmailId(),
                superAdmin.getMobileNo(), superAdmin.getUsername(), superAdmin.getId());
        
        String sql2 = "SELECT * FROM super_admin WHERE id = ?";
		return jdbcTemplate.queryForObject(sql2, new SuperAdminRowMapper(),superAdmin.getId());
    }

    public  int resetSuperAdminPassword(String username, String passwordHash, String passwordSalt) {
        String sql = "UPDATE super_admin SET password_hash = ?, password_salt = ? WHERE username = ?";
        return jdbcTemplate.update(sql, passwordHash, passwordSalt, username);
        
        
    }
    
    public  int resetSuperAdminPassword(String passwordHash, String passwordSalt) {
        String sql = "UPDATE super_admin SET password_hash = ?, password_salt = ? WHERE id = ?";
        return jdbcTemplate.update(sql, passwordHash, passwordSalt,1);
    }
    
    
    @Override
    public SuperAdmin getSuperAdminDetails() {
    	try {
        String sql = "SELECT * FROM super_admin";
        return jdbcTemplate.queryForObject(sql, new SuperAdminRowMapper());
        
    }  catch (EmptyResultDataAccessException e) {
        return null; // Username not found
    }
    }
    
    
    private final class SuperAdminRowMapper implements RowMapper<SuperAdmin> {
        @Override
        public SuperAdmin mapRow(ResultSet rs, int rowNum) throws SQLException {
            SuperAdmin superAdmin = new SuperAdmin();
            superAdmin.setId(rs.getInt("id"));
            superAdmin.setFirstName(rs.getString("first_name"));
            superAdmin.setLastName(rs.getString("last_name"));
            superAdmin.setEmailId(rs.getString("email_id"));
            superAdmin.setMobileNo(rs.getString("mobile_no"));;
            superAdmin.setUsername(rs.getString("username"));
            superAdmin.setPasswordSalt(rs.getString("password_salt"));
            superAdmin.setPasswordHash(rs.getString("password_hash"));
            return superAdmin;
        }
    }
	
	

}

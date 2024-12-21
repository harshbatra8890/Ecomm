package ecom.app.dao;

import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.multipart.MultipartFile;

import ecom.app.entities.Role;
import ecom.app.entities.User;
import ecom.app.utility.ByteArrayMultipartFile;


public class UserRowMapper implements RowMapper<User> {

	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {

		User user = new User();

		user.setUserId(rs.getInt("user_id"));
		user.setStatus(rs.getString("status"));
		user.setFirstName(rs.getString("first_name"));
		user.setLastName(rs.getString("last_name"));
		user.setEmailId(rs.getString("email_id"));
		user.setMobileNo(rs.getString("mobile_no"));
		user.setDateOfBirth(rs.getDate("date_of_birth"));
		user.setUsername(rs.getString("username"));
		user.setPasswordSalt(rs.getString("passwordSalt"));
		user.setPasswordHash(rs.getString("passwordHash"));

		Role role = new Role();
		role.setRoleId(rs.getInt("role_id"));
		user.setRole(role);
		
		Blob profileImageBlob = rs.getBlob("profile_image");
		
		// Convert blob to MultipartFile
		byte[] imageBytes = profileImageBlob.getBytes(1, (int) profileImageBlob.length());
		MultipartFile profileImage = new ByteArrayMultipartFile(imageBytes, "profileImage.jpg", "image/jpeg");
		
		user.setProfileImage(profileImage);
		
		return user;
	}

}

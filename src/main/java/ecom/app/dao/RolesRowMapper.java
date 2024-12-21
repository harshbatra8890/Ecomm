package ecom.app.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import ecom.app.entities.Role;

public class RolesRowMapper implements RowMapper<Role> {

	@Override
	public Role mapRow(ResultSet rs, int rowNum) throws SQLException {

		int roleId = rs.getInt("role_id");
		String role = rs.getString("role_name");

		return new Role(roleId, role);
	}

}

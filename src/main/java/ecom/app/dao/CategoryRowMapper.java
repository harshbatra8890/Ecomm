package ecom.app.dao;

import ecom.app.entities.Category;
import ecom.app.utility.ByteArrayMultipartFile;

import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Blob;

public class CategoryRowMapper implements RowMapper<Category> {

    @Override
    public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
        Category category = new Category();
        
        // Set basic properties
        category.setCategory_id(rs.getInt("category_id"));
        category.setCategory_name(rs.getString("category_name"));
        category.setDescription(rs.getString("description"));

        // Convert BLOB to MultipartFile for category_image
        Blob imageBlob = rs.getBlob("category_image");
        if (imageBlob != null) {
            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
            category.setCategory_image(new ByteArrayMultipartFile(imageBytes, "categoryImage.jpg", "image/jpeg"));
        }

        System.out.println(category);
        return category;
    }
}

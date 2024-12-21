package ecom.app.dao;

import java.io.IOException;
import java.sql.Blob;
import java.sql.SQLException;

import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import ecom.app.entities.Category; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository; // Import this
import org.springframework.web.multipart.MultipartFile;

@Repository 
public class CategoryDaoImpl implements CategoryDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public int insertCategory(Category category) throws IOException, SQLException {
        String query = "INSERT INTO category (category_name, description, category_image) VALUES (?, ?, ?)"; 
        return jdbcTemplate.update(query,
            category.getCategory_name(),
            category.getDescription(),
            getBlob(category.getCategory_image()) // Convert MultipartFile to Blob
        );
    }

    private Blob getBlob(MultipartFile image) throws IOException, SerialException, SQLException {
        byte[] byteArr = image.getBytes();
        Blob imageBlob = new SerialBlob(byteArr);
        return imageBlob;
    }
}

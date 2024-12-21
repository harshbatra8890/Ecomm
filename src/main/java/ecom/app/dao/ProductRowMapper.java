package ecom.app.dao;

import ecom.app.entities.Products;
import ecom.app.utility.ByteArrayMultipartFile;

import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Blob;

public class ProductRowMapper implements RowMapper<Products> {
	 
	 @Override
	    public Products mapRow(ResultSet rs, int rowNum) throws SQLException {
	        Products product = new Products();
	        product.setProduct_id(rs.getInt("product_id"));
	        product.setCategory_id(rs.getInt("category_id"));
	        product.setProduct_name(rs.getString("product_name"));
	        product.setDescription(rs.getString("description"));
	        product.setMrp(rs.getDouble("mrp"));
	        product.setDiscount(rs.getDouble("discount"));
	        product.setDelivery_charge(rs.getDouble("delivery_charge"));
	        product.setFinal_price(rs.getDouble("final_price"));
	        product.setStock(rs.getInt("stock"));
	        product.setSubAdminId(rs.getInt("user_id"));

	     // Convert BLOB to MultipartFile
	        Blob imageBlob = rs.getBlob("product_image");
	        if (imageBlob != null) {
	            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
	            product.setProduct_image(new ByteArrayMultipartFile(imageBytes, "productImage.jpg", "image/jpeg"));
	        }
	        
	        System.out.println(product);
	        return product;
	    }
	}

	

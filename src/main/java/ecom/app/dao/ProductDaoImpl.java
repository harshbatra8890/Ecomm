 package ecom.app.dao;   
import ecom.app.entities.Category;
import ecom.app.entities.Products;
	import ecom.app.entities.User;
	 
	import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
	import org.springframework.stereotype.Repository;
	import org.springframework.web.multipart.MultipartFile;
	 
	import java.io.IOException;
	import java.sql.Blob;
	import java.sql.SQLException;
	import java.util.List;
	 
	import javax.sql.rowset.serial.SerialBlob;
	import javax.sql.rowset.serial.SerialException;
	 
	@Repository
	public class ProductDaoImpl implements ProductDao {
	    @Autowired
	    private JdbcTemplate jdbcTemplate;
	 
	    @Override
	    public int insertProduct(Products product, int subAdminId) throws IOException, SQLException {
	        String query = "INSERT INTO product (product_name, description, mrp, discount, final_price, stock, "
	                     + "delivery_charge, category_id, product_image, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // Include subAdminId

	        return jdbcTemplate.update(query,
	            product.getProduct_name(),
	            product.getDescription(),
	            product.getMrp(),
	            product.getDiscount(),
	            product.getFinal_price(),
	            product.getStock(),
	            product.getDelivery_charge(),
	            product.getCategory_id(),
	            product.getProduct_image().getBytes(), // Handle product image
	            subAdminId // Add the subAdminId to the parameters
	        );
	    }


	 
		private Blob getBlob(MultipartFile image) throws IOException, SerialException, SQLException {
			byte[] byteArr = image.getBytes();
			Blob imageBlob = new SerialBlob(byteArr);
			return imageBlob;
		}
		
		@Override
		public Products updateProduct(Products product) throws IOException, SQLException {
		    Blob productImage = getBlob(product.getProduct_image());

		    String query = "UPDATE product SET  product_name = ? ,description = ?, mrp = ?, discount = ?, delivery_charge = ?, "
		                 + "final_price = ?, stock = ?, product_image = ? WHERE product_id = ?";

		    try {
		        int rowsAffected = jdbcTemplate.update(query, 
			            product.getProduct_name(),
		        		product.getDescription(),
		                product.getMrp(),
		                product.getDiscount(),
		                product.getDelivery_charge(),
		                product.getFinal_price(),
		                product.getStock(),
		                productImage,
		                product.getProduct_id()); // Use product_id to identify the record

		        System.out.println("Rows affected: " + rowsAffected);

		        // Check if the update was successful
		        if (rowsAffected == 0) {
		            throw new SQLException("No rows affected. Product with ID " + product.getProduct_id() + " not found.");
		        }
		    } catch (Exception e) {
		        e.printStackTrace(); // Log the exception for debugging
		        throw new SQLException("Error updating product: " + e.getMessage());
		    }

		    // Return the updated product
		    return getProductById(product.getProduct_id());
		}

	 
		// Get a list of all products
	    @Override
	    public List<Products> getAllProducts() {
	        String sql = "SELECT * FROM product where status = 1";
	        return jdbcTemplate.query(sql, new ProductRowMapper());
	    }
		
		

	 
		public Products getProductById(int product_id) {
	        String sql = "SELECT * FROM product WHERE product_id = ? and status = 1";
	        try {
	            return jdbcTemplate.queryForObject(sql, new Object[]{product_id}, new ProductRowMapper());
	        } catch (EmptyResultDataAccessException e) {
	            System.out.println("Product not found for ID: " + product_id); // Log the missing product
	            return null; // Return null or handle it as needed
	        }
	    }
	 
		@Override
		public void deleteProduct(int productId) throws IOException, SQLException {
	        String sql = "UPDATE product SET status = 0 WHERE product_id = ?";
			jdbcTemplate.update(sql , productId);
		}
	 
	 
		@Override 
		public List<Products> fetchProductsBySubAdminId(int subAdminId) throws IOException, SQLException {
		    // SQL query modified to order products by 'created_at' in descending order
		    String sql = "SELECT * FROM product WHERE user_id = ? and status = 1 ORDER BY created_at DESC";
		    
		    // Fetch the list of products for the specified sub-admin
		    List<Products> productsList = jdbcTemplate.query(sql, new Object[]{subAdminId}, new ProductRowMapper());
		    
		    // Debug log for fetched products
		    System.out.println("Fetched Products for Sub Admin ID " + subAdminId + ": " + productsList); 
		    
		    return productsList;
		}


	 
	 
		@Override
		public List<Products> fetchProductsByCategoryAndSubAdminId(int categoryId, int subAdminId) throws IOException, SQLException {
		    String sql = "SELECT * FROM product WHERE category_id = ? AND user_id = ? AND status = 1" ;
		    return jdbcTemplate.query(sql, new Object[]{categoryId, subAdminId}, new ProductRowMapper());
		}
	 
		@Override
		public Products fetchProductById(int product_id,int subAdminId) throws IOException, SQLException {
		   String sql = "SELECT * FROM product WHERE product_id = ? and user_id = ?  AND status = 1";
		    return jdbcTemplate.queryForObject(sql, new ProductRowMapper(),product_id,subAdminId);
		}
	 
		
		@Override
		public List<Products> getAllDiscountProducts1() {
			 String sql = "SELECT * FROM product where tag = 'Best Discount' AND status = 1 ";
			    List<Products> productsList2 = jdbcTemplate.query(sql, new ProductRowMapper());
			    return productsList2;
		}
 
		@Override
		public List<Products> getAllBestBrandProducts1() {
			String sql = "SELECT * FROM product where tag = 'Best Brand' AND status = 1 ";
		    List<Products> productsList3 = jdbcTemplate.query(sql, new ProductRowMapper());
		    return productsList3;
		}
	
		@Override
		public List<Products> getAllNewArrivalProducts1() {
			 String sql = "SELECT * FROM product where tag = 'New Arrivals' AND status = 1 ";
			    List<Products> productsList1 = jdbcTemplate.query(sql, new ProductRowMapper());
			    return productsList1;
		}
		
		@Override
		public List<Products> getAllNewArrivalProducts() {
			 String sql = "SELECT * FROM product where tag = 'New Arrivals' AND status = 1 LIMIT 3 ";
			    List<Products> productsList1 = jdbcTemplate.query(sql, new ProductRowMapper());
			    return productsList1;
		}
 
 
		@Override
		public List<Products> getAllDiscountProducts() {
			 String sql = "SELECT * FROM product where tag = 'Best Discount' AND status = 1 LIMIT 3 ";
			    List<Products> productsList2 = jdbcTemplate.query(sql, new ProductRowMapper());
			    return productsList2;
		}
    
		@Override
		public List<Products> getAllBestBrandProducts() {
			String sql = "SELECT * FROM product where tag = 'Best Brand'  AND status = 1 LIMIT 3 ";
		    List<Products> productsList3 = jdbcTemplate.query(sql, new ProductRowMapper());
		    return productsList3;
		}
	   
		
		public boolean updateProductStock(int productId, int quantity) {
		    if (!hasSufficientStock(productId, quantity)) {
		        System.out.println("Insufficient stock for product ID: " + productId);
		        return false; // Not enough stock to fulfill the request
		    }

		    String updateQuery = "UPDATE product SET stock = stock - ? WHERE product_id = ? ";
		    jdbcTemplate.update(updateQuery, quantity, productId);
		    return true; // Stock updated successfully
		}

		
		
		
		public boolean hasSufficientStock(int productId, int quantity) {
		    String stockQuery = "SELECT stock FROM product WHERE product_id = ?";
		    Integer currentStock;

		    try {
		        currentStock = jdbcTemplate.queryForObject(stockQuery, new Object[]{productId}, Integer.class);
		    } catch (EmptyResultDataAccessException e) {
		        System.out.println("Product not found for ID: " + productId);
		        return false; // Product doesn't exist
		    }

		    // Check if there is enough stock
		    return currentStock != null && currentStock >= quantity;
		}

		@Override
		public List<Products> getAllNewTrendingProducts() {
			String sql = "SELECT * FROM product where tag = 'Trends' AND status = 1  LIMIT 3  ";
		    List<Products> productsList1 = jdbcTemplate.query(sql, new ProductRowMapper());
		    return productsList1;
		}
 
		@Override
		public List<Products> getAllNewTrendingProducts1() {
			String sql = "SELECT * FROM product where tag = 'Trends' AND status = 1";
		    List<Products> productsList1 = jdbcTemplate.query(sql, new ProductRowMapper());
		    return productsList1;
			
		}
 
		@Override
		public List<Category> getAllProductsByCategory() {
			String sql = "SELECT * FROM category LIMIT 3 ";
		    List<Category> categoryList = jdbcTemplate.query(sql, new CategoryRowMapper());
		    return categoryList;
		}
	   
		@Override
		public List<Category> getAllProductsByCategory1() {
			String sql = "SELECT * FROM category";
		    List<Category> categoryList = jdbcTemplate.query(sql, new CategoryRowMapper());
		    return categoryList;
		}
		@Override
		public List<Category> getAllCategories() {
		    String sql = "SELECT * FROM category";
		    return jdbcTemplate.query(sql, new CategoryRowMapper()); // Adjust as per your implementation
		}
		
		@Override
	    public List<Products> searchProducts(String query) {
	        String sql = "SELECT * FROM product WHERE product_name LIKE ? OR description LIKE ? AND status = 1";
	        String searchPattern = "%" + query + "%";
	        return jdbcTemplate.query(sql, new Object[]{searchPattern, searchPattern}, new ProductRowMapper());
	    }

		@Override
		public List<Products> fetchAllProducts() throws IOException, SQLException {
		    String sql = "SELECT * FROM product";
		    List<Products> productsList = jdbcTemplate.query(sql, new ProductRowMapper());
		    System.out.println("Fetched Products: " + productsList); // Debug log
		    return productsList;
		}
	 
		@Override
		public List<Products> fetchProductsByCategory(int category_id) throws IOException, SQLException {
	 
		    String sql = "SELECT * FROM product where category_id= ?";
		    List<Products> productsList = jdbcTemplate.query(sql, new ProductRowMapper(), category_id);
		    return productsList;
	 
		}
}
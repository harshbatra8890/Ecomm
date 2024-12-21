package ecom.app.dao;
 
import java.util.List;
import java.io.IOException;
import java.sql.SQLException;

import ecom.app.entities.Category;
import ecom.app.entities.Products;
import ecom.app.entities.User;
 
public interface ProductDao {
 
	 // int insertProduct(Products product) throws IOException, SQLException;
 
	   Products updateProduct(Products product) throws IOException, SQLException;
  
 
	    List<Products> fetchProductsBySubAdminId(int subAdminId) throws IOException, SQLException;
	    
	    List<Products> fetchAllProducts() throws IOException, SQLException;
	    
	    List<Products> fetchProductsByCategory(int categoryId) throws IOException, SQLException;
	    
	
	    void deleteProduct(int productId) throws IOException, SQLException;
 
	    List<Products> fetchProductsByCategoryAndSubAdminId(int categoryId, int subAdminId) throws IOException, SQLException;
 
	    Products fetchProductById(int id,int subAdminId) throws IOException, SQLException;
 
		Products getProductById(int productId);
		
 
		 List<Products> getAllNewArrivalProducts();
		 List<Products> getAllDiscountProducts();
		 List<Products> getAllBestBrandProducts();
		 List<Products> getAllNewTrendingProducts();
		 
		 List<Products> getAllNewArrivalProducts1();
		 List<Products> getAllDiscountProducts1();
		 List<Products> getAllBestBrandProducts1();
		 List<Products> getAllNewTrendingProducts1();
		 
		 List<Category> getAllProductsByCategory();
		 List<Category> getAllProductsByCategory1();
		 List<Products> getAllProducts();
		 List<Category> getAllCategories();
		
		 List<Products> searchProducts(String query);
		 int insertProduct(Products product, int subAdminId) throws IOException,SQLException; 
}
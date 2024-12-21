package ecom.app.dao;

import java.io.IOException;
import java.sql.SQLException;

import ecom.app.entities.Category;
import ecom.app.entities.Products;

public interface CategoryDao {

	  int insertCategory(Category category) throws IOException, SQLException;
     
	
	
	 
}

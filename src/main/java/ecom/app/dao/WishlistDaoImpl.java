package ecom.app.dao;

import ecom.app.entities.Wishlist;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class WishlistDaoImpl implements WishlistDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void addToWishlist(Wishlist wishlist) {
        String sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)";
        jdbcTemplate.update(sql, wishlist.getUserId(), wishlist.getProductId());
    }

    @Override
    public List<Wishlist> getUserWishlist(int userId) {
        String sql = "SELECT * FROM wishlist WHERE user_id = ?";
        return jdbcTemplate.query(sql, new Object[]{userId}, new RowMapper<Wishlist>() {
            @Override
            public Wishlist mapRow(ResultSet rs, int rowNum) throws SQLException {
                Wishlist wishlist = new Wishlist();
                wishlist.setWishlistId(rs.getInt("wishlist_id"));
                wishlist.setUserId(rs.getInt("user_id"));
                wishlist.setProductId(rs.getInt("product_id"));
                return wishlist;
            }
        });
    }


    @Override
    public void removeFromWishlist(int wishlistId) {
        String sql = "DELETE FROM wishlist WHERE wishlist_id = ?";
        jdbcTemplate.update(sql, wishlistId);
    }

    public Wishlist getUserWishlistItem(int wishlistId) {
        String sql = "SELECT * FROM wishlist WHERE wishlist_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{wishlistId}, (rs, rowNum) -> {
                Wishlist wishlist = new Wishlist();
                wishlist.setWishlistId(rs.getInt("wishlist_id"));
                wishlist.setUserId(rs.getInt("user_id"));
                wishlist.setProductId(rs.getInt("product_id"));
                return wishlist;
            });
        } catch (EmptyResultDataAccessException e) {
            return null; // Handle the case when no wishlist item is found
        }
    }


}

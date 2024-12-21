package ecom.app.entities;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private int cartId; 
    private int userId;
    private List<CartItems> items;

    public Cart() {
        this.items = new ArrayList<>();
    }

    public Cart(int cartId) {
        this.cartId = cartId;
    }

    public Cart(int cartId, int userId) {
        this.cartId = cartId;
        this.userId = userId;
        this.items = new ArrayList<>();
    }

    public Cart(int userId, List<CartItems> items) {
        this.userId = userId;
        this.items = items;
    }

    

    public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setItems(List<CartItems> items) {
		this.items = items;
	}

	public List<CartItems> getItems() {
        return items;
    }

    public void addItem(CartItems item) {
        items.add(item);
    }

    public void removeItem(CartItems item) {
        items.remove(item);
    }
}

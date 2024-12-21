package ecom.app.entities;

import java.io.IOException;
import java.util.Base64;
import org.springframework.web.multipart.MultipartFile;

public class Products {
    private int product_id;
    private int category_id;
    private String product_name;
    private String description;
    private double mrp;
    private double discount;
    private double delivery_charge;
    private double final_price;
    private int stock;
    private MultipartFile product_image;
    private boolean status;
    
    // New field for sub-admin ID
    private Integer subAdminId; // Change type as needed (e.g., int or Integer)

    public Products() {
        super();
    }

    public Products(int product_id, int category_id, String product_name, String description, double mrp,
            double discount, double delivery_charge, double final_price, int stock, MultipartFile product_image,
            boolean status, Integer subAdminId) { // Include subAdminId in the constructor
        super();
        this.product_id = product_id;
        this.category_id = category_id;
        this.product_name = product_name;
        this.description = description;
        this.mrp = mrp;
        this.discount = discount;
        this.delivery_charge = delivery_charge;
        this.final_price = final_price;
        this.stock = stock;
        this.product_image = product_image;
        this.status = status;
        this.subAdminId = subAdminId; // Initialize subAdminId
    }

    public Products(int category_id, String product_name, String description, double mrp, double discount,
            double delivery_charge, double final_price, int stock, MultipartFile product_image, boolean status, Integer subAdminId) { // Include subAdminId
        super();
        this.category_id = category_id;
        this.product_name = product_name;
        this.description = description;
        this.mrp = mrp;
        this.discount = discount;
        this.delivery_charge = delivery_charge;
        this.final_price = final_price;
        this.stock = stock;
        this.product_image = product_image;
        this.status = status;
        this.subAdminId = subAdminId; // Initialize subAdminId
    }

    // Existing getters and setters...

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getMrp() {
        return mrp;
    }

    public void setMrp(double mrp) {
        this.mrp = mrp;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getDelivery_charge() {
        return delivery_charge;
    }

    public void setDelivery_charge(double delivery_charge) {
        this.delivery_charge = delivery_charge;
    }

    public double getFinal_price() {
        return final_price;
    }

    public void setFinal_price(double final_price) {
        this.final_price = final_price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public MultipartFile getProduct_image() {
        return product_image;
    }

    public void setProduct_image(MultipartFile product_image) {
        this.product_image = product_image;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Integer getSubAdminId() { // Getter for subAdminId
        return subAdminId;
    }

    public void setSubAdminId(Integer subAdminId) { // Setter for subAdminId
        this.subAdminId = subAdminId;
    }

    public String getBase64ProductImage() {
        if (product_image != null && product_image.getSize() > 0) {
            try {
                byte[] imageBytes = product_image.getBytes();
                return Base64.getEncoder().encodeToString(imageBytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return "\n Products [product_id=" + product_id + ", category_id=" + category_id + ", product_name="
                + product_name + ", description=" + description + ", mrp=" + mrp + ", discount=" + discount
                + ", delivery_charge=" + delivery_charge + ", final_price=" + final_price + ", stock=" + stock
                + ", product_image=" + product_image + ", status=" + status + ", subAdminId=" + subAdminId + "]"; // Include subAdminId in toString
    }
}

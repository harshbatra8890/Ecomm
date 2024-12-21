package ecom.app.entities;

import java.io.IOException;
import java.util.Base64;
import org.springframework.web.multipart.MultipartFile;

public class Category {

    private int category_id;
    private String category_name;
    private String description;
    private MultipartFile category_image;

    // No-argument constructor
    public Category() {
    }

    // Existing constructors
    public Category(int category_id, String category_name, String description, MultipartFile category_image) {
        super();
        this.category_id = category_id;
        this.category_name = category_name;
        this.description = description;
        this.category_image = category_image;
    }

    public Category(String category_name, String description, MultipartFile category_image) {
        super();
        this.category_name = category_name;
        this.description = description;
        this.category_image = category_image;
    }

    // Getters and Setters
    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public MultipartFile getCategory_image() {
        return category_image;
    }

    public void setCategory_image(MultipartFile category_image) {
        this.category_image = category_image;
    }

    public String getBase64CategoryImage() {
        if (category_image != null && category_image.getSize() > 0) {
            try {
                byte[] imageBytes = category_image.getBytes();
                return Base64.getEncoder().encodeToString(imageBytes);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return "\n Category [category_id=" + category_id + ", category_name=" + category_name + ", description="
                + description + ", category_image=" + category_image + "]";
    }
}

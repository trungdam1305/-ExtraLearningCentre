/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.LocalDateTime;

public class Blog {
    private int ID_Blog;
    private String BlogTitle;
    private String BlogDescription;
    private LocalDateTime BlogDate;
    private String Image;
    private int ID_Khoi;

    // Constructor không tham số
    public Blog() {
    }

    // Constructor đầy đủ tham số
    public Blog(int ID_Blog, String BlogTitle, String BlogDescription, LocalDateTime BlogDate, String Image, int ID_Khoi) {
        this.ID_Blog = ID_Blog;
        this.BlogTitle = BlogTitle;
        this.BlogDescription = BlogDescription;
        this.BlogDate = BlogDate;
        this.Image = Image;
        this.ID_Khoi = ID_Khoi;
    }

    // Getter và Setter
    public int getID_Blog() {
        return ID_Blog;
    }

    public void setID_Blog(int ID_Blog) {
        this.ID_Blog = ID_Blog;
    }

    public String getBlogTitle() {
        return BlogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        BlogTitle = blogTitle;
    }

    public String getBlogDescription() {
        return BlogDescription;
    }

    public void setBlogDescription(String blogDescription) {
        BlogDescription = blogDescription;
    }

    public LocalDateTime getBlogDate() {
        return BlogDate;
    }

    public void setBlogDate(LocalDateTime BlogDate) {
        this.BlogDate = BlogDate;
    }

    

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        Image = image;
    }

    public int getID_Khoi() {
        return ID_Khoi;
    }

    public void setID_Khoi(int ID_Khoi) {
        this.ID_Khoi = ID_Khoi;
    }
}


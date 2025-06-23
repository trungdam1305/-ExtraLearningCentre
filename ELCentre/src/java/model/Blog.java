/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Represents a blog entry containing information such as title, description, 
 * date posted, image, grade level (Khoi), and category (PhanLoai).
 * 
 * Author: trungdam1305
 */
public class Blog {
    // Unique identifier for the blog
    private int ID_Blog;

    // Title of the blog
    private String BlogTitle;

    // Description or content summary of the blog
    private String BlogDescription;

    // Date and time when the blog was posted
    private LocalDateTime BlogDate;

    // Image associated with the blog post
    private String Image;

    // ID of the educational grade level the blog is associated with
    private int ID_Khoi;

    // ID of the blog category
    private int ID_PhanLoai;

    // Name of the blog category
    private String PhanLoai;

    /**
     * Default constructor
     */
    public Blog() {
    }

    /**
     * Constructor to initialize all fields
     */
    public Blog(int ID_Blog, String BlogTitle, String BlogDescription, LocalDateTime BlogDate, String Image, int ID_Khoi, int ID_PhanLoai, String PhanLoai) {
        this.ID_Blog = ID_Blog;
        this.BlogTitle = BlogTitle;
        this.BlogDescription = BlogDescription;
        this.BlogDate = BlogDate;
        this.Image = Image;
        this.ID_Khoi = ID_Khoi;
        this.ID_PhanLoai = ID_PhanLoai;
        this.PhanLoai = PhanLoai;
    }

    // Getters and setters

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

    public int getID_PhanLoai() {
        return ID_PhanLoai;
    }

    public void setID_PhanLoai(int ID_PhanLoai) {
        this.ID_PhanLoai = ID_PhanLoai;
    }

    public String getPhanLoai() {
        return PhanLoai;
    }

    public void setPhanLoai(String PhanLoai) {
        this.PhanLoai = PhanLoai;
    }

    /**
     * Returns the blog date formatted as dd-MM-yyyy for display
     */
    public String getFormattedDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        return BlogDate.format(formatter);
    }
}

package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Represents a blog entry containing information such as title, description, 
 * date posted, image, grade level (Khoi), and category (PhanLoai).
 * * Author: trungdam1305
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

    
    // The actual KeyTag string (e.g., "Technology", "Education")
    // This would typically come from a JOIN with the KeyTag table
    private String KeyTag; 
    
    // The actual KeyWord string (e.g., "Java", "SQL")
    // This would typically come from a JOIN with the Keyword table
    private String KeyWord; 
    
    // Name of the blog category (from PhanLoaiBlog table)
    private String PhanLoai;
    
    // Detailed content of the blog (from CKEditor)
    private String NoiDung; 
    
     private Integer ID_Khoi;       // Changed to Integer
    private Integer ID_PhanLoai;   // Changed to Integer
    private Integer ID_KeyTag;     // Changed to Integer
    private Integer ID_Keyword;

    /**
     * Default constructor
     */
    public Blog() {
    }

    /**
     * Constructor for creating a Blog object with most common attributes.
     * This might be used when retrieving data from the database where some linked names (PhanLoai)
     * are already joined.
     */
    public Blog(int ID_Blog, String BlogTitle, String BlogDescription, LocalDateTime BlogDate, String Image, 
                int ID_Khoi, int ID_PhanLoai, String KeyTag, String KeyWord, String PhanLoai, 
                String NoiDung, int ID_KeyTag, int ID_Keyword) {
        this.ID_Blog = ID_Blog;
        this.BlogTitle = BlogTitle;
        this.BlogDescription = BlogDescription;
        this.BlogDate = BlogDate;
        this.Image = Image;
        this.ID_Khoi = ID_Khoi;
        this.ID_PhanLoai = ID_PhanLoai;
        this.KeyTag = KeyTag;
        this.KeyWord = KeyWord;
        this.PhanLoai = PhanLoai;
        this.NoiDung = NoiDung;
        this.ID_KeyTag = ID_KeyTag;
        this.ID_Keyword = ID_Keyword;
    }

    public Blog(int ID_Blog, String BlogTitle, String BlogDescription, LocalDateTime BlogDate, String Image, String KeyTag, String KeyWord, String PhanLoai, String NoiDung, Integer ID_PhanLoai, Integer ID_KeyTag, Integer ID_Keyword) {
        this.ID_Blog = ID_Blog;
        this.BlogTitle = BlogTitle;
        this.BlogDescription = BlogDescription;
        this.BlogDate = BlogDate;
        this.Image = Image;
        this.KeyTag = KeyTag;
        this.KeyWord = KeyWord;
        this.PhanLoai = PhanLoai;
        this.NoiDung = NoiDung;
        this.ID_PhanLoai = ID_PhanLoai;
        this.ID_KeyTag = ID_KeyTag;
        this.ID_Keyword = ID_Keyword;
    }
    
    

    // --- Getters and Setters ---
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

    public String getKeyTag() {
        return KeyTag;
    }

    public void setKeyTag(String KeyTag) {
        this.KeyTag = KeyTag;
    }

    public String getKeyWord() {
        return KeyWord;
    }

    public void setKeyWord(String KeyWord) {
        this.KeyWord = KeyWord;
    }
    
    public String getNoiDung() {
        return NoiDung;
    }

    public void setNoiDung(String NoiDung) {
        this.NoiDung = NoiDung;
    }

    public int getID_KeyTag() {
        return ID_KeyTag;
    }

    public void setID_KeyTag(int ID_KeyTag) {
        this.ID_KeyTag = ID_KeyTag;
    }

    public int getID_Keyword() {
        return ID_Keyword;
    }

    public void setID_Keyword(int ID_Keyword) {
        this.ID_Keyword = ID_Keyword;
    }

    /**
     * Returns the blog date formatted as dd-MM-yyyy for display
     */
    public String getFormattedDate() {
        if (BlogDate == null) {
            return ""; // Or handle as appropriate for your application
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        return BlogDate.format(formatter);
    }
}
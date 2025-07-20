package dal;

import java.sql.Connection; // Import Connection
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.PhanLoaiBlog;
import model.KeyTag; // Import the KeyTag model
import model.Keyword;
 // Import the Keyword model (assuming you have one, needed for mapping)
public class BlogDAO { // IMPORTANT: NO LONGER extends DBContext

    /**
     * Listing Blogs from the Database.
     * @return A list of all Blog objects.
     */
    public List<Blog> getAllBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = """
                     SELECT b.*, pl.PhanLoai, kt.KeyTag, kw.Keyword
                     FROM Blog b
                     JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
                     LEFT JOIN KeyTag kt ON b.ID_KeyTag = kt.ID_KeyTag
                     LEFT JOIN Keyword kw ON b.ID_Keyword = kw.ID_Keyword
                     ORDER BY b.BlogDate DESC
                     """;
        // Get connection using getInstance()
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return list;
    }

    /**
     * Get blogs by Category name (PhanLoai).
     * @param tenPhanLoai The name of the category to filter by.
     * @return A list of Blog objects matching the category name.
     */
    public List<Blog> getBlogsByPhanLoai(String tenPhanLoai) {
        List<Blog> list = new ArrayList<>();
        String sql = """
                     SELECT b.*, pl.PhanLoai, kt.KeyTag, kw.Keyword
                     FROM Blog b
                     JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
                     LEFT JOIN KeyTag kt ON b.ID_KeyTag = kt.ID_KeyTag
                     LEFT JOIN Keyword kw ON b.ID_Keyword = kw.ID_Keyword
                     WHERE pl.PhanLoai LIKE ?
                     ORDER BY b.BlogDate DESC
                     """;
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + tenPhanLoai + "%"); // Use LIKE for partial matching
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToBlog(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * Searches and filters blogs based on keyword, category ID, KeyTag ID, year,
     * and sorting order, with pagination. This is the comprehensive filtering method.
     *
     * @param keyword Search term (can be part of title or description). Null or empty to ignore.
     * @param categoryId Category ID to filter by. Null or empty string to ignore.
     * @param idKeyTag KeyTag ID to filter by. 0 or less to ignore.
     * @param year Specific year of BlogDate to filter by. Null to ignore.
     * @param sort Sorting order for BlogDate ("asc" for ascending, "desc" for descending).
     * @param page Current page number (1-indexed).
     * @param pageSize Number of blogs per page.
     * @return A list of Blog objects matching the criteria.
     */
    public List<Blog> searchBlogsAdvanced(String keyword, String categoryId, int idKeyTag, Integer year, String sort, int page, int pageSize) {
        List<Blog> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT b.*, pl.PhanLoai, kt.KeyTag, kw.Keyword
            FROM Blog b
            LEFT JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
            LEFT JOIN KeyTag kt ON b.ID_KeyTag = kt.ID_KeyTag
            LEFT JOIN Keyword kw ON b.ID_Keyword = kw.ID_Keyword
            WHERE 1 = 1
        """);

        List<Object> params = new ArrayList<>();
        // Add conditions based on parameters
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (b.BlogTitle LIKE ? OR b.BlogDescription LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            sql.append(" AND b.ID_PhanLoai = ?");
            params.add(Integer.parseInt(categoryId)); // Assuming ID_PhanLoai is int
        }
        if (idKeyTag > 0) { // Assuming 0 means no filter
            sql.append(" AND b.ID_KeyTag = ?");
            params.add(idKeyTag);
        }
        if (year != null) {
            sql.append(" AND YEAR(b.BlogDate) = ?");
            params.add(year);
        }

        sql.append(" ORDER BY b.BlogDate ").append(sort.equalsIgnoreCase("asc") ? "ASC" : "DESC");
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                ps.setObject(idx++, param);
            }
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToBlog(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
        }
        return list;
    }

    /**
     * Counts the total number of blogs based on advanced search filters.
     *
     * @param keyword Search term.
     * @param categoryId Category ID to filter by.
     * @param idKeyTag KeyTag ID to filter by.
     * @param year Specific year of BlogDate to filter by.
     * @return Total count of blogs matching the criteria.
     */
    public int countBlogsAdvanced(String keyword, String categoryId, int idKeyTag, Integer year) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Blog WHERE 1=1 ");

        List<Object> params = new ArrayList<>();
        // Add conditions based on parameters
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (BlogTitle LIKE ? OR BlogDescription LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            sql.append(" AND ID_PhanLoai = ?");
            params.add(Integer.parseInt(categoryId));
        }
        if (idKeyTag > 0) {
            sql.append(" AND ID_KeyTag = ?");
            params.add(idKeyTag);
        }
        if (year != null) {
            sql.append(" AND YEAR(BlogDate) = ?");
            params.add(year);
        }

        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                ps.setObject(idx++, param);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
        }
        return 0;
    }

    /**
     * Adds a new blog entry to the database.
     *
     * @param blog The Blog object to be added.
     */
    public void addBlog(Blog blog) {
        String sql = "INSERT INTO Blog (BlogTitle, BlogDescription, BlogDate, Image, ID_PhanLoai, ID_KeyTag, ID_Keyword, NoiDung) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, blog.getBlogTitle());
            ps.setString(2, blog.getBlogDescription());
            ps.setObject(3, blog.getBlogDate());
            ps.setString(4, blog.getImage());
            ps.setInt(5, blog.getID_PhanLoai());
            ps.setInt(6, blog.getID_KeyTag());
            ps.setInt(7, blog.getID_Keyword());
            ps.setString(8, blog.getNoiDung());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves a single blog by its ID.
     *
     * @param blogId The ID of the blog to retrieve.
     * @return A Blog object if found, otherwise null.
     */
    public Blog getBlogById(int blogId) {
        Blog blog = null;
        String sql = """
                     SELECT b.*, pl.PhanLoai, kt.KeyTag, kw.Keyword
                     FROM Blog b
                     LEFT JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
                     LEFT JOIN KeyTag kt ON b.ID_KeyTag = kt.ID_KeyTag
                     LEFT JOIN Keyword kw ON b.ID_Keyword = kw.ID_Keyword
                     WHERE b.ID_Blog = ?
                     """;
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, blogId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    blog = mapResultSetToBlog(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }

    /**
     * Retrieves all distinct KeyTag names.
     * This method fetches the actual string names from the KeyTag table.
     * @return A list of distinct KeyTag objects.
     */
    public List<KeyTag> getAllKeyTags() {
        List<KeyTag> tags = new ArrayList<>();
        String sql = "SELECT ID_KeyTag, KeyTag FROM KeyTag ORDER BY KeyTag";
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tags.add(new KeyTag(rs.getInt("ID_KeyTag"), rs.getString("KeyTag")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tags;
    }

    /**
     * Retrieves a paginated list of blogs filtered by a specific KeyTag ID.
     *
     * @param idKeyTag The ID of the KeyTag to filter by.
     * @param page Current page number (1-indexed).
     * @param pageSize Number of blogs per page.
     * @return A list of Blog objects.
     */
    public List<Blog> getBlogsByIDKeyTag(int idKeyTag, int page, int pageSize) {
        List<Blog> blogs = new ArrayList<>();
        String sql = """
                     SELECT b.*, pl.PhanLoai, kt.KeyTag, kw.Keyword
                     FROM Blog b
                     LEFT JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
                     JOIN KeyTag kt ON b.ID_KeyTag = kt.ID_KeyTag
                     LEFT JOIN Keyword kw ON b.ID_Keyword = kw.ID_Keyword
                     WHERE b.ID_KeyTag = ?
                     ORDER BY b.BlogDate DESC
                     OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
                     """;

        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idKeyTag);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    blogs.add(mapResultSetToBlog(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    /**
     * Counts the total number of blog posts associated with a specific KeyTag ID.
     *
     * @param ID_KeyTag The ID of the KeyTag to count blogs for.
     * @return The total count of blogs for the given KeyTag ID.
     */
    public int countBlogsByIDKeyTag(int ID_KeyTag) {
        String sql = "SELECT COUNT(*) FROM Blog WHERE ID_KeyTag = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ID_KeyTag);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Retrieves all distinct years from BlogDate column for filtering.
     * @return List of distinct years.
     */
    public List<Integer> getDistinctBlogYears() {
        List<Integer> years = new ArrayList<>();
        String sql = "SELECT DISTINCT YEAR(BlogDate) AS BlogYear FROM Blog WHERE BlogDate IS NOT NULL ORDER BY BlogYear DESC";

        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                years.add(rs.getInt("BlogYear"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return years;
    }

    /**
     * Updates an existing Blog in the database.
     * @param blog The Blog object with updated data.
     * @throws SQLException if a database access error occurs
     */
    public void updateBlog(Blog blog) throws SQLException {
        String sql = """
            UPDATE Blog SET
                BlogTitle = ?,
                BlogDescription = ?,
                BlogDate = ?,
                Image = ?,
                ID_Khoi = ?,
                ID_PhanLoai = ?,
                ID_KeyTag = ?,
                ID_Keyword = ?,
                NoiDung = ?
            WHERE ID_Blog = ?
            """;
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, blog.getBlogTitle());
            ps.setString(2, blog.getBlogDescription());
            ps.setObject(3, blog.getBlogDate());
            ps.setString(4, blog.getImage());
            ps.setInt(5, blog.getID_Khoi());
            ps.setInt(6, blog.getID_PhanLoai());
            ps.setInt(7, blog.getID_KeyTag());
            ps.setInt(8, blog.getID_Keyword());
            ps.setString(9, blog.getNoiDung());
            ps.setInt(10, blog.getID_Blog());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-throw to allow higher layers to handle
        }
    }

    /**
     * Deletes a Blog from the database by its ID.
     * @param blogId The ID of the blog to delete.
     * @throws SQLException if a database access error occurs
     */
    public void deleteBlog(int blogId) throws SQLException {
        String sql = "DELETE FROM Blog WHERE ID_Blog = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, blogId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Helper method to map a ResultSet row to a Blog object.
     * Encapsulates the logic for populating a Blog object from a ResultSet.
     * @param rs The ResultSet containing the current row's data.
     * @return A Blog object populated with data from the ResultSet.
     * @throws SQLException If a database access error occurs.
     */
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setID_Blog(rs.getInt("ID_Blog"));
        blog.setBlogTitle(rs.getString("BlogTitle"));
        blog.setBlogDescription(rs.getString("BlogDescription"));

        if (rs.getTimestamp("BlogDate") != null) {
            blog.setBlogDate(rs.getTimestamp("BlogDate").toLocalDateTime());
        } else {
            blog.setBlogDate(null);
        }

        blog.setImage(rs.getString("Image"));
        blog.setID_Khoi(rs.getInt("ID_Khoi"));
        blog.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
        blog.setID_KeyTag(rs.getInt("ID_KeyTag"));
        blog.setID_Keyword(rs.getInt("ID_Keyword"));

        // Retrieve the actual KeyTag and Keyword names from the JOINs
        blog.setKeyTag(rs.getString("KeyTag"));
        blog.setKeyWord(rs.getString("Keyword"));

        blog.setNoiDung(rs.getString("NoiDung"));
        blog.setPhanLoai(rs.getString("PhanLoai"));
        return blog;
    }

    /**
     * Retrieves all categories for dropdowns.
     * @return List of PhanLoaiBlog objects.
     */
    public List<PhanLoaiBlog> getAllPhanLoaiBlog() {
        List<PhanLoaiBlog> list = new ArrayList<>();
        String sql = "SELECT ID_PhanLoai, PhanLoai FROM PhanLoaiBlog";
        try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new PhanLoaiBlog(rs.getInt("ID_PhanLoai"), rs.getString("PhanLoai")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Keyword> getAllKeywords() { // Ensure model.Keyword is imported
    List<model.Keyword> keywords = new ArrayList<>();
    String sql = "SELECT ID_Keyword, Keyword FROM Keyword ORDER BY Keyword"; // Assuming your Keyword table has ID_Keyword and Keyword columns
    try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            keywords.add(new model.Keyword(rs.getInt("ID_Keyword"), rs.getString("Keyword")));
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Log error
    }
    return keywords;
}   
    public List<Blog> getFilteredBlogs(String keyword, int idKeyTag, Integer year, int page, int pageSize) {
    List<Blog> list = new ArrayList<>();
    
    StringBuilder sql = new StringBuilder("""
        SELECT b.*, pl.PhanLoai, kt.KeyTag, kw.Keyword
        FROM Blog b
        LEFT JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
        LEFT JOIN KeyTag kt ON b.ID_KeyTag = kt.ID_KeyTag
        LEFT JOIN Keyword kw ON b.ID_Keyword = kw.ID_Keyword
        WHERE 1 = 1
    """);

    List<Object> params = new ArrayList<>(); // To store parameters dynamically

    // Add conditions based on provided filters
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (b.BlogTitle LIKE ? OR b.BlogDescription LIKE ?)");
        params.add("%" + keyword + "%");
        params.add("%" + keyword + "%");
    }

    if (idKeyTag > 0) { // Apply filter only if a valid KeyTag ID is provided
        sql.append(" AND b.ID_KeyTag = ?");
        params.add(idKeyTag);
    }

    if (year != null) { // Apply filter only if a year is provided
        sql.append(" AND YEAR(b.BlogDate) = ?");
        params.add(year);
    }

    // Add sorting and pagination clauses
    sql.append(" ORDER BY b.BlogDate DESC"); // Default sort by newest first
    sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection from singleton
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        
        int idx = 1; // Parameter index starts from 1
        // Set dynamic parameters for filters
        for (Object param : params) {
            ps.setObject(idx++, param);
        }
        
        // Set pagination parameters
        ps.setInt(idx++, (page - 1) * pageSize); // OFFSET (skip results)
        ps.setInt(idx, pageSize);               // FETCH NEXT (number of results to retrieve)

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToBlog(rs)); // Use your existing mapping helper
            }
        }
    } catch (SQLException e) {
        // Log the exception for debugging. In a real application, you might throw a custom exception
        // or handle it more gracefully (e.g., return an empty list and log the error).
        e.printStackTrace(); 
    }
    return list;
}

/**
 * Counts the total number of blogs based on the same keyword, KeyTag ID, and year filters.
 * This is used for pagination to determine the total number of pages.
 *
 * @param keyword Search term. Null or empty to ignore.
 * @param idKeyTag KeyTag ID to filter by. 0 or less to ignore.
 * @param year Specific year of BlogDate to filter by. Null to ignore.
 * @return Total count of blogs matching the criteria.
 */
public int countFilteredBlogs(String keyword, int idKeyTag, Integer year) {
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Blog WHERE 1=1 ");

    List<Object> params = new ArrayList<>(); // To store parameters dynamically

    // Add conditions based on provided filters (must match getFilteredBlogs)
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (BlogTitle LIKE ? OR BlogDescription LIKE ?)");
        params.add("%" + keyword + "%");
        params.add("%" + keyword + "%");
    }

    if (idKeyTag > 0) {
        sql.append(" AND ID_KeyTag = ?");
        params.add(idKeyTag);
    }

    if (year != null) {
        sql.append(" AND YEAR(BlogDate) = ?");
        params.add(year);
    }

    try (Connection conn = DBContext.getInstance().getConnection(); // Obtain Connection from singleton
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        
        int idx = 1; // Parameter index starts from 1
        // Set dynamic parameters for filters
        for (Object param : params) {
            ps.setObject(idx++, param);
        }
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1); // Return the count from the first column
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0; // Return 0 if no blogs found or an error occurs
}


// Add this main method to the end of your BlogDAO class

public static void main(String[] args) {
    BlogDAO dao = new BlogDAO();

    System.out.println("--- Starting Debug Test for addBlog ---");

    // --- Create a new Blog object with sample data ---
    Blog newBlog = new Blog();
    newBlog.setBlogTitle("Bài viết test từ Main - " + LocalDateTime.now()); // Unique title
    newBlog.setBlogDescription("Mô tả ngắn của bài viết test.");
    newBlog.setNoiDung("<p>Nội dung chi tiết <strong>từ hàm main</strong> của bài viết test.</p>");
    newBlog.setBlogDate(LocalDateTime.now());
    newBlog.setImage("default_blog_image.jpg"); // Replace with a valid image file name or leave null if nullable

    // --- IMPORTANT: Use valid IDs that exist in your database ---
    // If these foreign keys don't exist, you'll get an SQLException.
    // Check your PhanLoaiBlog, Khoi, KeyTag, and Keyword tables.    // Example: Assuming Khoi ID 1 exists
    newBlog.setID_PhanLoai(1);   // Example: Assuming PhanLoaiBlog ID 1 exists
    newBlog.setID_KeyTag(1);     // Example: Assuming KeyTag ID 1 exists
    newBlog.setID_Keyword(1);    // Example: Assuming Keyword ID 1 exists

    // For debugging, if these IDs can be 0 or nullable in your DB:
    // newBlog.setID_Khoi(0); // If 0 is accepted or means 'none'
    // newBlog.setID_PhanLoai(0); // If 0 is accepted or means 'none'
    // newBlog.setID_KeyTag(0); // If 0 is accepted or means 'none'
    // newBlog.setID_Keyword(0); // If 0 is accepted or means 'none'


    try {
        System.out.println("\nAttempting to add new blog: \"" + newBlog.getBlogTitle() + "\"");
        dao.addBlog(newBlog);
        System.out.println("Blog added successfully! Check your database.");

        // --- Optional: Verify by fetching recent blogs ---
        System.out.println("\nVerifying by fetching the latest 2 blogs:");
        List<Blog> recentBlogs = dao.getAllBlog(); // Assuming getAllBlog fetches recent ones or you have a getLatestBlogs method
        if (!recentBlogs.isEmpty()) {
            // Sort by date DESC to easily find the newly added one
            recentBlogs.sort((b1, b2) -> b2.getBlogDate().compareTo(b1.getBlogDate()));
            for (int i = 0; i < Math.min(recentBlogs.size(), 2); i++) { // Print up to 2 latest
                Blog blog = recentBlogs.get(i);
                System.out.println("  Found Blog ID: " + blog.getID_Blog() +
                                   ", Title: " + blog.getBlogTitle() +
                                   ", Desc: " + blog.getBlogDescription() +
                                   ", PhanLoai: " + blog.getPhanLoai() +
                                   ", KeyTag: " + blog.getKeyTag() +
                                   ", Keyword: " + blog.getKeyWord());
            }
        } else {
            System.out.println("No blogs found in the database after adding.");
        }

    } catch (RuntimeException e) {
        // This catches RuntimeExceptions thrown by DBContext.getInstance() if connection fails
        System.err.println("Failed to add blog due to database connection issue: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        // Catch any other unexpected exceptions during the addBlog process
        System.err.println("An unexpected error occurred while adding blog: " + e.getMessage());
        e.printStackTrace();
    }

    System.out.println("\n--- Debug Test for addBlog Complete ---");
}

}
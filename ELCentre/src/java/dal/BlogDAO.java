
package dal;

import java.security.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.KhoiHoc;

/**
 *
 * @author admin
 */
public class BlogDAO {
    //Listing Blog form the Database
    public List<Blog> getAllBlog() {
        DBContext db = DBContext.getInstance();
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM Blog JOIN PhanLoaiBlog ON Blog.ID_PhanLoai = PhanLoaiBlog.ID_PhanLoai";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Blog bl = new Blog();
                bl.setID_Blog(rs.getInt("ID_Blog"));
                bl.setBlogTitle(rs.getString("BlogTitle"));
                bl.setBlogDescription(rs.getString("BlogDescription"));
                bl.setBlogDate(rs.getTimestamp("BlogDate").toLocalDateTime());
                bl.setImage(rs.getString("Image"));
                bl.setID_Khoi(rs.getInt("ID_Khoi"));
                bl.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
                bl.setPhanLoai(rs.getString("PhanLoai"));
                list.add(bl);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
                    return list;
    }

    //get blog by Category = trungtam
    public List<Blog> getBlogsByTrungTam(String tenDanhMuc) {
    List<Blog> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();
    String sql = """
                 SELECT * FROM BLOG JOIN PhanLoaiBlog
                 ON Blog.ID_PhanLoai =  PhanLoaiBlog.ID_PhanLoai
                 WHERE PhanLoaiBlog.PhanLoai like ?
                 """;

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql);
         ) {

        ps.setString(1, tenDanhMuc);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Blog blog = new Blog();
            blog.setID_Blog(rs.getInt("ID_Blog"));
            blog.setBlogTitle(rs.getString("BlogTitle"));
            blog.setBlogDescription(rs.getString("BlogDescription"));
            blog.setBlogDate(rs.getTimestamp("BlogDate").toLocalDateTime());
            blog.setImage(rs.getString("Image"));
            blog.setID_Khoi(rs.getInt("ID_Khoi"));
            blog.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
            blog.setPhanLoai(rs.getString("PhanLoai"));
            list.add(blog);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
    public List<Blog> searchBlogsAdvanced(String keyword, String categoryId, String sort, int page, int pageSize) {
    List<Blog> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();

    // Build SQL dynamically based on provided filters
    StringBuilder sql = new StringBuilder("""
        SELECT * FROM Blog
        JOIN PhanLoaiBlog ON Blog.ID_PhanLoai = PhanLoaiBlog.ID_PhanLoai
        WHERE 1 = 1
    """);

    // Add condition for keyword search (title or description)
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (BlogTitle LIKE ? OR BlogDescription LIKE ?)");
    }

    // Add condition for category filter
    if (categoryId != null && !categoryId.trim().isEmpty()) {
        sql.append(" AND Blog.ID_PhanLoai = ?");
    }

    // Add sorting by date and pagination using OFFSET-FETCH
    sql.append(" ORDER BY BlogDate ")
       .append(sort.equalsIgnoreCase("asc") ? "ASC" : "DESC")
       .append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        int idx = 1;

        // Set parameters for keyword search if provided
        if (keyword != null && !keyword.trim().isEmpty()) {
            ps.setString(idx++, "%" + keyword + "%");
            ps.setString(idx++, "%" + keyword + "%");
        }

        // Set parameter for category ID if provided
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            ps.setInt(idx++, Integer.parseInt(categoryId));
        }

        // Set pagination parameters: OFFSET and page size
        ps.setInt(idx++, (page - 1) * pageSize);
        ps.setInt(idx, pageSize);

        // Execute query and map result to Blog objects
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Blog bl = new Blog();
            bl.setID_Blog(rs.getInt("ID_Blog"));
            bl.setBlogTitle(rs.getString("BlogTitle"));
            bl.setBlogDescription(rs.getString("BlogDescription"));
            bl.setBlogDate(rs.getTimestamp("BlogDate").toLocalDateTime());
            bl.setImage(rs.getString("Image"));
            bl.setID_Khoi(rs.getInt("ID_Khoi"));
            bl.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
            bl.setPhanLoai(rs.getString("PhanLoai"));
            list.add(bl);
        }

    } catch (Exception e) {
        e.printStackTrace(); // Log error if query fails
    }

    return list; // Return the filtered and paginated list
}

    public int countBlogsAdvanced(String keyword, String categoryId) {
    DBContext db = DBContext.getInstance();

    // Build SQL to count blogs with the same filtering logic
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Blog WHERE 1=1 ");

    // Add condition for keyword search
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (BlogTitle LIKE ? OR BlogDescription LIKE ?)");
    }

    // Add condition for category filter
    if (categoryId != null && !categoryId.trim().isEmpty()) {
        sql.append(" AND ID_PhanLoai = ?");
    }

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        int idx = 1;

        // Set parameters for keyword if present
        if (keyword != null && !keyword.trim().isEmpty()) {
            ps.setString(idx++, "%" + keyword + "%");
            ps.setString(idx++, "%" + keyword + "%");
        }

        // Set parameter for category ID if present
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            ps.setInt(idx++, Integer.parseInt(categoryId));
        }

        // Execute query to get total matching blog count
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1); // Return the count

    } catch (Exception e) {
        e.printStackTrace(); // Log error
    }

    return 0; // Return 0 if any error occurs
}
    
    public void addBlog(Blog blog) {
        DBContext db = DBContext.getInstance();
    String sql = "INSERT INTO Blog (BlogTitle, BlogDescription, BlogDate, Image, ID_Khoi, ID_PhanLoai, KeyTag, KeyWord, NoiDung) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        
        ps.setString(1, blog.getBlogTitle());
        ps.setString(2, blog.getBlogDescription());
        ps.setObject(3, blog.getBlogDate());
        ps.setString(4, blog.getImage());
        ps.setInt(5, blog.getID_Khoi());
        ps.setInt(6, blog.getID_PhanLoai());
        ps.setString(7, blog.getKeyTag());
        ps.setString(8, blog.getKeyWord());
        ps.setString(9, blog.getNoiDung()); // Thêm tham số NoiDung
        
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public Blog getBlogById(int blogId) {
    DBContext db = DBContext.getInstance();
    Blog blog = null;
    String sql = """
          SELECT b.*, pl.PhanLoai
        FROM Blog b 
        LEFT JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai
        WHERE b.ID_Blog = ?
    """;

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {

        ps.setInt(1, blogId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                blog = new Blog();
                blog.setID_Blog(rs.getInt("ID_Blog"));
                blog.setBlogTitle(rs.getString("BlogTitle"));
                blog.setBlogDescription(rs.getString("BlogDescription"));
                blog.setBlogDate(rs.getTimestamp("BlogDate").toLocalDateTime());
                blog.setImage(rs.getString("Image"));
                blog.setID_Khoi(rs.getInt("ID_Khoi"));
                blog.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
                blog.setKeyTag(rs.getString("KeyTag"));
                blog.setKeyWord(rs.getString("KeyWord"));
                blog.setPhanLoai(rs.getString("PhanLoai"));
                
                // Lấy nội dung chi tiết từ CKEditor
                blog.setNoiDung(rs.getString("NoiDung")); 
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return blog;
}
    
public List<String> getAllKeyTags() {
    DBContext db = DBContext.getInstance();
    List<String> tags = new ArrayList<>();
    String sql = "SELECT DISTINCT KeyTag FROM Blog WHERE KeyTag IS NOT NULL AND KeyTag != '' ORDER BY KeyTag";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())){
         ResultSet rs = ps.executeQuery(); 
        while (rs.next()) {
            tags.add(rs.getString("KeyTag"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return tags;
}

/**
 * Lấy danh sách các bài blog theo một KeyTag cụ thể, có phân trang.
 */
public List<Blog> getBlogsByKeyTag(String keyTag, int page, int pageSize) {
    List<Blog> blogs = new ArrayList<>();
    DBContext db = DBContext.getInstance(); 
    String sql = """
        SELECT b.*, pl.PhanLoai 
        FROM Blog b 
        LEFT JOIN PhanLoaiBlog pl ON b.ID_PhanLoai = pl.ID_PhanLoai 
        WHERE b.KeyTag = ?
        ORDER BY b.BlogDate DESC 
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

    // Sử dụng try-with-resources để tự động đóng Connection và PreparedStatement
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        
        // Thiết lập các tham số cho câu lệnh SQL
        ps.setString(1, keyTag);
        ps.setInt(2, (page - 1) * pageSize);
        ps.setInt(3, pageSize);
        
        // ✅ BẮT ĐẦU PHẦN THÊM VÀO
        
        // Thực thi truy vấn và dùng try-with-resources để tự đóng ResultSet
        try (ResultSet rs = ps.executeQuery()) {
            
            // Lặp qua từng dòng kết quả
            while (rs.next()) {
                // Tạo một đối tượng Blog mới cho mỗi dòng
                Blog blog = new Blog();

                // Đọc dữ liệu từ các cột và gán vào thuộc tính của đối tượng Blog
                blog.setID_Blog(rs.getInt("ID_Blog"));
                blog.setBlogTitle(rs.getString("BlogTitle"));
                blog.setBlogDescription(rs.getString("BlogDescription"));
                blog.setNoiDung(rs.getString("NoiDung")); // Lấy nội dung chi tiết
                
                // Kiểm tra null trước khi chuyển đổi Timestamp sang LocalDateTime
                if (rs.getTimestamp("BlogDate") != null) {
                    blog.setBlogDate(rs.getTimestamp("BlogDate").toLocalDateTime());
                }
                
                blog.setImage(rs.getString("Image"));
                blog.setID_Khoi(rs.getInt("ID_Khoi"));
                blog.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
                blog.setKeyTag(rs.getString("KeyTag"));
                blog.setKeyWord(rs.getString("KeyWord"));
                
                // Lấy tên phân loại từ bảng đã JOIN
                blog.setPhanLoai(rs.getString("PhanLoai"));

                // Thêm đối tượng Blog vừa tạo vào danh sách
                blogs.add(blog);
            }
        }
        // ✅ KẾT THÚC PHẦN THÊM VÀO

    } catch (Exception e) {
        // In lỗi ra console để dễ dàng gỡ lỗi
        e.printStackTrace(); 
    }
    
    // Trả về danh sách các bài blog (sẽ rỗng nếu không tìm thấy hoặc có lỗi)
    return blogs;
}
/**
 * Đếm số lượng bài viết theo một KeyTag cụ thể.
 */
public int countBlogsByKeyTag(String keyTag) {
    DBContext db = DBContext.getInstance();
    String sql = "SELECT COUNT(*) FROM Blog WHERE KeyTag = ?";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        ps.setString(1, keyTag);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}
    
    public static void main(String[] args) {
        List<Blog> khoi = new ArrayList<Blog>();
        BlogDAO dao = new BlogDAO();
        khoi = dao.getAllBlog();
        for (Blog bl : khoi){
            System.out.println(bl.getBlogTitle() + " " + bl.getImage() + " " + bl.getPhanLoai());
        }
    }
}

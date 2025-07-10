    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    public static void main(String[] args) {
        List<Blog> khoi = new ArrayList<Blog>();
        BlogDAO dao = new BlogDAO();
        khoi = dao.getAllBlog();
        for (Blog bl : khoi){
            System.out.println(bl.getBlogTitle() + " " + bl.getImage() + " " + bl.getPhanLoai());
        }
    }
}

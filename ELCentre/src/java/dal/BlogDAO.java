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
        String sql = "SELECT * FROM Blog";
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
                list.add(bl);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
                    return list;
    }
    
    public static void main(String[] args) {
        List<Blog> khoi = new ArrayList<Blog>();
        BlogDAO dao = new BlogDAO();
        khoi = dao.getAllBlog();
        for (Blog bl : khoi){
            System.out.println(bl.getBlogTitle() + " " + bl.getImage());
        }
    }
}

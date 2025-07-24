// Author: trungdam
// Servlet: SliderDAO
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

/**
 * Data Access Object for Slider entities.
 * Handles database operations for managing homepage sliders.
 */
public class SliderDAO { 

    /**
     * Retrieves all sliders from the database.
     */
    public List<Slider> getAllSlider() {
        DBContext db = DBContext.getInstance(); 
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Slider] ORDER BY ID_Slider DESC"; 
        try (Connection conn = db.getConnection(); 
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToSlider(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
            System.err.println("Error retrieving all sliders: " + e.getMessage());
        }
        return list;
    }
    
    /**
     * Retrieves a paginated and filtered list of sliders.
     */
    public List<Slider> getFilteredSliders(String keyword, int page, int pageSize) {
        DBContext db = DBContext.getInstance(); 
        List<Slider> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM [dbo].[Slider] WHERE 1 = 1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        sql.append(" ORDER BY ID_Slider DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                ps.setObject(idx++, param);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToSlider(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving filtered sliders: " + e.getMessage());
        }
        return list;
    }

    /**
     * Counts the total number of sliders based on filter criteria.
     */
    public int countFilteredSliders(String keyword) {
        DBContext db = DBContext.getInstance(); 
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[Slider] WHERE 1 = 1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        try (Connection conn = db.getConnection(); 
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
            e.printStackTrace();
            System.err.println("Error counting filtered sliders: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Retrieves a single slider by its ID.
     */
    public Slider getSliderById(int sliderId) {
        DBContext db = DBContext.getInstance(); 
        Slider slider = null;
        String sql = "SELECT * FROM [dbo].[Slider] WHERE ID_Slider = ?";
        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sliderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    slider = mapResultSetToSlider(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving slider by ID: " + e.getMessage());
        }
        return slider;
    }

    /**
     * Adds a new slider to the database.
     */
    public void addSlider(Slider slider) throws SQLException {
        DBContext db = DBContext.getInstance(); 
        String sql = "INSERT INTO [dbo].[Slider] (Title, Image, BackLink) VALUES (?, ?, ?)";
        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImage());
            ps.setString(3, slider.getBackLink());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error adding slider: " + e.getMessage());
            throw e; 
        }
    }

    /**
     * Updates an existing slider in the database.
     */
    public void updateSlider(Slider slider) throws SQLException {
        DBContext db = DBContext.getInstance(); 
        String sql = "UPDATE [dbo].[Slider] SET Title = ?, Image = ?, BackLink = ? WHERE ID_Slider = ?";
        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImage());
            ps.setString(3, slider.getBackLink());
            ps.setInt(4, slider.getID_Slider());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating slider: " + e.getMessage());
            throw e; 
        }
    }

    /**
     * Deletes a slider from the database by its ID.
     */
    public void deleteSlider(int sliderId) throws SQLException {
        DBContext db = DBContext.getInstance(); 
        String sql = "DELETE FROM [dbo].[Slider] WHERE ID_Slider = ?";
        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sliderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error deleting slider: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Helper method to map a ResultSet row to a Slider object.
     */
    private Slider mapResultSetToSlider(ResultSet rs) throws SQLException {
        Slider sl = new Slider();
        sl.setID_Slider(rs.getInt("ID_Slider"));
        sl.setTitle(rs.getString("Title"));
        sl.setImage(rs.getString("Image"));
        sl.setBackLink(rs.getString("BackLink"));
        return sl;
    }
    
}
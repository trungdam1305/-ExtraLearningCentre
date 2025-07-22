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
public class SliderDAO { // Does NOT extend DBContext

    /**
     * Retrieves all sliders from the database.
     * @return A list of all Slider objects.
     */
    public List<Slider> getAllSlider() {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Slider] ORDER BY ID_Slider DESC"; // Ordered for consistent results
        try (Connection conn = db.getConnection(); // Use connection from instance
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToSlider(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception for debugging
        }
        return list;
    }
    
    /**
     * Retrieves a paginated and filtered list of sliders.
     * @param keyword Search term for slider title. Null or empty to ignore.
     * @param page Current page number (1-indexed).
     * @param pageSize Number of sliders per page.
     * @return A list of Slider objects matching the criteria.
     */
    public List<Slider> getFilteredSliders(String keyword, int page, int pageSize) {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
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

        try (Connection conn = db.getConnection(); // Use connection from instance
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
        }
        return list;
    }

    /**
     * Counts the total number of sliders based on filter criteria.
     * @param keyword Search term for slider title. Null or empty to ignore.
     * @return Total count of sliders matching the criteria.
     */
    public int countFilteredSliders(String keyword) {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[Slider] WHERE 1 = 1");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND Title LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        try (Connection conn = db.getConnection(); // Use connection from instance
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
        }
        return 0;
    }

    /**
     * Retrieves a single slider by its ID.
     * @param sliderId The ID of the slider to retrieve.
     * @return A Slider object if found, otherwise null.
     */
    public Slider getSliderById(int sliderId) {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
        Slider slider = null;
        String sql = "SELECT * FROM [dbo].[Slider] WHERE ID_Slider = ?";
        try (Connection conn = db.getConnection(); // Use connection from instance
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sliderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    slider = mapResultSetToSlider(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slider;
    }

    /**
     * Adds a new slider to the database.
     * @param slider The Slider object to be added.
     * @throws SQLException if a database access error occurs.
     */
    public void addSlider(Slider slider) throws SQLException {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
        String sql = "INSERT INTO [dbo].[Slider] (Title, Image, BackLink) VALUES (?, ?, ?)";
        try (Connection conn = db.getConnection(); // Use connection from instance
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImage());
            ps.setString(3, slider.getBackLink());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-throw to allow servlet to catch and inform user
        }
    }

    /**
     * Updates an existing slider in the database.
     * @param slider The Slider object with updated data.
     * @throws SQLException if a database access error occurs.
     */
    public void updateSlider(Slider slider) throws SQLException {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
        String sql = "UPDATE [dbo].[Slider] SET Title = ?, Image = ?, BackLink = ? WHERE ID_Slider = ?";
        try (Connection conn = db.getConnection(); // Use connection from instance
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImage());
            ps.setString(3, slider.getBackLink());
            ps.setInt(4, slider.getID_Slider());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-throw
        }
    }

    /**
     * Deletes a slider from the database by its ID.
     * @param sliderId The ID of the slider to delete.
     * @throws SQLException if a database access error occurs.
     */
    public void deleteSlider(int sliderId) throws SQLException {
        DBContext db = DBContext.getInstance(); // Get DBContext instance
        String sql = "DELETE FROM [dbo].[Slider] WHERE ID_Slider = ?";
        try (Connection conn = db.getConnection(); // Use connection from instance
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sliderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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
    
    // Main method for testing the DAO functionality
    public static void main(String[] args) {
        SliderDAO dao = new SliderDAO(); 
        
        System.out.println("--- Starting SliderDAO Debug Tests (using DBContext.getInstance()) ---");

        // Test 1: Get all sliders
        System.out.println("\n--- Test getAllSlider ---");
        List<Slider> allSliders = dao.getAllSlider();
        if (allSliders.isEmpty()) {
            System.out.println("No sliders found in DB. Consider adding one for testing.");
        } else {
            for (Slider sl : allSliders) {
                System.out.println("Slider: ID=" + sl.getID_Slider() + ", Title='" + sl.getTitle() + "', Image='" + sl.getImage() + "'");
            }
        }

        // Test 2: Add a new slider
        System.out.println("\n--- Test addSlider ---");
        Slider newSlider = new Slider();
        newSlider.setTitle("Test Slider " + System.currentTimeMillis()); // Unique title
        newSlider.setImage("uploads/slider_test_" + System.currentTimeMillis() + ".jpg"); // Placeholder image path
        newSlider.setBackLink("https://example.com/testlink");
        try {
            dao.addSlider(newSlider);
            System.out.println("Added new slider successfully: " + newSlider.getTitle());
            // Fetch newly added slider using getFilteredSliders to get its ID
            List<Slider> updatedList = dao.getFilteredSliders(newSlider.getTitle(), 1, 1);
            if (!updatedList.isEmpty()) {
                System.out.println("Found newly added slider (ID: " + updatedList.get(0).getID_Slider() + ")");
                newSlider.setID_Slider(updatedList.get(0).getID_Slider()); // Store ID for update/delete tests
            }
        } catch (SQLException e) {
            System.err.println("Failed to add slider: " + e.getMessage());
            e.printStackTrace();
        }

        // Test 3: Get filtered sliders
        System.out.println("\n--- Test getFilteredSliders (keyword: 'Test Slider') ---");
        List<Slider> filteredSliders = dao.getFilteredSliders("Test Slider", 1, 5);
        System.out.println("Found " + filteredSliders.size() + " filtered sliders:");
        for (Slider sl : filteredSliders) {
            System.out.println("  ID: " + sl.getID_Slider() + ", Title: " + sl.getTitle());
        }

        // Test 4: Count filtered sliders
        System.out.println("\n--- Test countFilteredSliders (keyword: 'Test Slider') ---");
        int count = dao.countFilteredSliders("Test Slider");
        System.out.println("Counted " + count + " sliders with keyword 'Test Slider'.");

        // Test 5: Update a slider (use the one just added)
        if (newSlider.getID_Slider() != 0) {
            System.out.println("\n--- Test updateSlider (ID: " + newSlider.getID_Slider() + ") ---");
            newSlider.setTitle("Updated Title " + System.currentTimeMillis());
            newSlider.setBackLink("https://new.example.com");
            try {
                dao.updateSlider(newSlider);
                System.out.println("Updated slider successfully.");
                Slider updatedSlider = dao.getSliderById(newSlider.getID_Slider());
                System.out.println("Verified Update: Title='" + updatedSlider.getTitle() + "', Link='" + updatedSlider.getBackLink() + "'");
            } catch (SQLException e) {
                System.err.println("Failed to update slider: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("\nSkipping update test as no slider was added.");
        }

        // Test 6: Delete a slider (use the one just added)
        if (newSlider.getID_Slider() != 0) {
            System.out.println("\n--- Test deleteSlider (ID: " + newSlider.getID_Slider() + ") ---");
            try {
                dao.deleteSlider(newSlider.getID_Slider());
                System.out.println("Deleted slider successfully.");
                Slider deletedSlider = dao.getSliderById(newSlider.getID_Slider());
                System.out.println("Verified Deletion: " + (deletedSlider == null ? "Slider not found (as expected)" : "Slider found (unexpected)"));
            } catch (SQLException e) {
                System.err.println("Failed to delete slider: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("\nSkipping delete test as no slider was added.");
        }

        System.out.println("\n--- SliderDAO Debug Tests Complete ---");
    }
}
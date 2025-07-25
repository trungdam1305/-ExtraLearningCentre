// Author: trungdam
// Servlet: SlotHocDAO
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.SlotHoc;

public class SlotHocDAO {

    /**
     * Retrieves all time slots from the database.
     */
    public List<SlotHoc> getAllSlotHoc() throws SQLException {
        List<SlotHoc> slotHocList = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM SlotHoc ORDER BY ID_SlotHoc";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                SlotHoc slot = new SlotHoc();
                slot.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                slot.setSlotThoiGian(rs.getString("SlotThoiGian"));
                slotHocList.add(slot);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tất cả slot học: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw the exception for handling upstream
        }
        return slotHocList;
    }

    /**
     * Retrieves all time slots from the database (alternative method, functionally similar to getAllSlotHoc but with logging).
     */
    public List<SlotHoc> getAllSlotHoc1() {
        List<SlotHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT ID_SlotHoc, SlotThoiGian FROM SlotHoc";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SlotHoc slot = new SlotHoc();
                slot.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                slot.setSlotThoiGian(rs.getString("SlotThoiGian"));
                list.add(slot);
            }
            System.out.println("getAllSlotHoc: Retrieved " + list.size() + " slots");
        } catch (SQLException e) {
            System.out.println("SQL Error in getAllSlotHoc: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves a time slot by its ID.
     */
    public SlotHoc getSlotHocById(int idSlotHoc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT ID_SlotHoc, SlotThoiGian FROM [dbo].[SlotHoc] WHERE ID_SlotHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSlotHoc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SlotHoc slot = new SlotHoc();
                    slot.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                    slot.setSlotThoiGian(rs.getString("SlotThoiGian"));
                    return slot;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy slot học theo ID: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw the exception
        }
        return null;
    }

    /**
     * Adds a new time slot to the database.
     */
    public boolean addSlotHoc(SlotHoc slot) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO [dbo].[SlotHoc] (SlotThoiGian) VALUES (?)";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slot.getSlotThoiGian());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm slot học: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw the exception
        }
    }

    /**
     * Updates an existing time slot in the database.
     */
    public boolean updateSlotHoc(int idSlotHoc, SlotHoc slot) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE [dbo].[SlotHoc] SET SlotThoiGian = ? WHERE ID_SlotHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slot.getSlotThoiGian());
            ps.setInt(2, idSlotHoc);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật slot học: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw the exception
        }
    }

    /**
     * Deletes a time slot from the database by its ID.
     */
    public boolean deleteSlotHoc(int idSlotHoc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM [dbo].[SlotHoc] WHERE ID_SlotHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSlotHoc);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa slot học: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw the exception
        }
    }

    /**
     * Checks if two time slots conflict.
     */
    private boolean isTimeConflict(String slotThoiGian1, String slotThoiGian2) {
        try {
            if (slotThoiGian1 == null || slotThoiGian2 == null) {
                System.err.println("SlotThoiGian không hợp lệ: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2);
                return false;
            }
            String[] parts1 = slotThoiGian1.trim().split(" đến ");
            String[] parts2 = slotThoiGian2.trim().split(" đến ");
            if (parts1.length != 2 || parts2.length != 2) {
                System.err.println("Định dạng SlotThoiGian không hợp lệ: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2);
                return false;
            }
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("H:mm");
            LocalTime start1 = LocalTime.parse(parts1[0].trim(), timeFormatter);
            LocalTime end1 = LocalTime.parse(parts1[1].trim(), timeFormatter);
            LocalTime start2 = LocalTime.parse(parts2[0].trim(), timeFormatter);
            LocalTime end2 = LocalTime.parse(parts2[1].trim(), timeFormatter);
            // Check for overlap (conflicts if any time points are common)
            return !end1.isBefore(start2) && !start1.isAfter(end2);
        } catch (Exception e) {
            System.err.println("Lỗi phân tích SlotThoiGian: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2 + ", error = " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public static void main(String[] args) {
        SlotHocDAO dao = new SlotHocDAO();
        List<SlotHoc> li = new ArrayList<>();
        li = dao.getAllSlotHoc1();
        for (SlotHoc l : li){
            System.out.println(l.getID_SlotHoc() + " " + l.getSlotThoiGian());
        }
    }
}
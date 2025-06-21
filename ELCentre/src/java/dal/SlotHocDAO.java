package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.SlotHoc;

public class SlotHocDAO {

    // Lấy tất cả slot học từ database
    public List<SlotHoc> getAllSlotHoc() throws SQLException {
        List<SlotHoc> slotHocList = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT ID_SlotHoc, SlotThoiGian FROM [dbo].[SlotHoc]";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                SlotHoc slot = new SlotHoc();
                slot.setIdSlotHoc(rs.getInt("ID_SlotHoc"));
                slot.setSlotThoiGian(rs.getString("SlotThoiGian"));
                slotHocList.add(slot);
            }
        }
        return slotHocList;
    }

    // Lấy slot học theo ID
    public SlotHoc getSlotHocById(int idSlotHoc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT ID_SlotHoc, SlotThoiGian FROM [dbo].[SlotHoc] WHERE ID_SlotHoc = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSlotHoc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    SlotHoc slot = new SlotHoc();
                    slot.setIdSlotHoc(rs.getInt("ID_SlotHoc"));
                    slot.setSlotThoiGian(rs.getString("SlotThoiGian"));
                    return slot;
                }
            }
        }
        return null;
    }

    // Thêm slot học mới
    public boolean addSlotHoc(SlotHoc slot) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO [dbo].[SlotHoc] (SlotThoiGian) VALUES (?)";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slot.getSlotThoiGian());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Cập nhật slot học
    public boolean updateSlotHoc(int idSlotHoc, SlotHoc slot) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE [dbo].[SlotHoc] SET SlotThoiGian = ? WHERE ID_SlotHoc = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slot.getSlotThoiGian());
            ps.setInt(2, idSlotHoc);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Xóa slot học
    public boolean deleteSlotHoc(int idSlotHoc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM [dbo].[SlotHoc] WHERE ID_SlotHoc = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSlotHoc);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
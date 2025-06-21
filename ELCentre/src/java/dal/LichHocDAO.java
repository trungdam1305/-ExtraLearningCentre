package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import model.LichHoc;

public class LichHocDAO {

    // Lấy tất cả lịch học từ ngày hiện tại trở đi
    public ArrayList<LichHoc> adminGetAllLichHoc(String ngayHienTai) {
        ArrayList<LichHoc> lichHocs = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.*, sh.SlotThoiGian
            FROM [dbo].[LichHoc] lh
            LEFT JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            WHERE lh.NgayHoc >= ?
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, ngayHienTai);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LichHoc lichHoc = new LichHoc();
                lichHoc.setIdSchedule(rs.getInt("ID_Schedule"));
                lichHoc.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lichHoc.setIdSlotHoc(rs.getInt("ID_SlotHoc"));
                lichHoc.setIdLopHoc(rs.getInt("ID_LopHoc"));
                lichHoc.setGhiChu(rs.getString("GhiChu"));
                lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lichHocs.add(lichHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return lichHocs.isEmpty() ? null : lichHocs;
    }

    // Thêm lịch học mới
    public LichHoc addLichHoc(LocalDate ngayHoc, int idSlotHoc, String ghiChu) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO [dbo].[LichHoc] (NgayHoc, ID_SlotHoc, GhiChu)
            VALUES (?, ?, ?)
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmt.setInt(2, idSlotHoc);
            stmt.setString(3, ghiChu);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    LichHoc lichHoc = new LichHoc();
                    lichHoc.setIdSchedule(rs.getInt(1));
                    lichHoc.setNgayHoc(ngayHoc);
                    lichHoc.setIdSlotHoc(idSlotHoc);
                    lichHoc.setGhiChu(ghiChu);
                    // Lấy SlotThoiGian
                    String sqlSelect = """
                        SELECT SlotThoiGian FROM [dbo].[SlotHoc] WHERE ID_SlotHoc = ?
                    """;
                    try (PreparedStatement selectStmt = conn.prepareStatement(sqlSelect)) {
                        selectStmt.setInt(1, idSlotHoc);
                        ResultSet rsSelect = selectStmt.executeQuery();
                        if (rsSelect.next()) {
                            lichHoc.setSlotThoiGian(rsSelect.getString("SlotThoiGian"));
                        }
                    }
                    return lichHoc;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy lịch học theo ID
    public LichHoc getLichHocById(int idSchedule) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.*, sh.SlotThoiGian
            FROM [dbo].[LichHoc] lh
            LEFT JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            WHERE lh.ID_Schedule = ?
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idSchedule);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                LichHoc lichHoc = new LichHoc();
                lichHoc.setIdSchedule(rs.getInt("ID_Schedule"));
                lichHoc.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lichHoc.setIdSlotHoc(rs.getInt("ID_SlotHoc"));
                lichHoc.setIdLopHoc(rs.getInt("ID_LopHoc"));
                lichHoc.setGhiChu(rs.getString("GhiChu"));
                lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                return lichHoc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật lịch học
    public boolean updateLichHoc(int idSchedule, LocalDate ngayHoc, int idSlotHoc, String ghiChu) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE [dbo].[LichHoc]
            SET NgayHoc = ?, ID_SlotHoc = ?, GhiChu = ?
            WHERE ID_Schedule = ?
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmt.setInt(2, idSlotHoc);
            stmt.setString(3, ghiChu);
            stmt.setInt(4, idSchedule);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa lịch học
    public boolean deleteLichHoc(int idSchedule) {
        DBContext db = DBContext.getInstance();
        String sql = """
            DELETE FROM [dbo].[LichHoc]
            WHERE ID_Schedule = ?
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idSchedule);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy tất cả lịch học (không giới hạn ngày)
    public ArrayList<LichHoc> getAllLichHoc() {
        ArrayList<LichHoc> lichHocs = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.*, sh.SlotThoiGian
            FROM [dbo].[LichHoc] lh
            LEFT JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LichHoc lichHoc = new LichHoc();
                lichHoc.setIdSchedule(rs.getInt("ID_Schedule"));
                lichHoc.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lichHoc.setIdSlotHoc(rs.getInt("ID_SlotHoc"));
                lichHoc.setIdLopHoc(rs.getInt("ID_LopHoc"));
                lichHoc.setGhiChu(rs.getString("GhiChu"));
                lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lichHocs.add(lichHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return lichHocs.isEmpty() ? null : lichHocs;
    }
    
    public static void main(String[] args) {
        // Khởi tạo DAO
        LichHocDAO dao = new LichHocDAO();

        // ID cần kiểm tra — bạn có thể thay bằng ID có sẵn trong DB
        int idSchedule = 3;

        // Gọi phương thức getLichHocById
        LichHoc lich = dao.getLichHocById(idSchedule);

        // Kiểm tra kết quả
        if (lich != null) {
            System.out.println(">>> Lịch học tìm được:");
            System.out.println("ID: " + lich.getIdSchedule());
            System.out.println("Ngày học: " + lich.getNgayHoc());
            System.out.println("Slot học: " + lich.getIdSlotHoc() + " (" + lich.getSlotThoiGian() + ")");
            System.out.println("Lớp học ID: " + lich.getIdLopHoc());
            System.out.println("Ghi chú: " + lich.getGhiChu());
        } else {
            System.out.println("Không tìm thấy lịch học với ID_Schedule = " + idSchedule);
        }
    }
}
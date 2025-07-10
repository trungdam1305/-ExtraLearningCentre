package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.LichHoc;
import model.PhongHoc;

public class PhongHocDAO {

    // Gán lớp học vào phòng học
    public boolean assignClassToRoom(int idLopHoc, int idPhongHoc) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra lớp học tồn tại và lấy sĩ số
            String checkLopHocSql = """
                SELECT SiSo, SiSoToiDa
                FROM [dbo].[LopHoc]
                WHERE ID_LopHoc = ? AND TrangThai = 'Active'
            """;
            int siSo;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("Lớp học ID " + idLopHoc + " không tồn tại hoặc không hoạt động");
                    return false;
                }
                siSo = rs.getInt("SiSo");
            }

            // Kiểm tra phòng học tồn tại và sức chứa
            String checkRoomSql = """
                SELECT SucChua
                FROM [dbo].[PhongHoc]
                WHERE ID_PhongHoc = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkRoomSql)) {
                stmt.setInt(1, idPhongHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("Phòng học ID " + idPhongHoc + " không tồn tại hoặc không hoạt động");
                    return false;
                }
                int sucChua = rs.getInt("SucChua");
                if (siSo > sucChua) {
                    System.out.println("Sĩ số lớp học (" + siSo + ") vượt quá sức chứa phòng (" + sucChua + ")");
                    return false;
                }
            }

            // Kiểm tra phòng học trống cho tất cả lịch học của lớp
            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            for (LichHoc lich : lichHocList) {
                List<PhongHoc> availableRooms = checkRoomAvailability(lich.getNgayHoc(), lich.getID_SlotHoc());
                if (!availableRooms.stream().anyMatch(ph -> ph.getID_PhongHoc() == idPhongHoc)) {
                    System.out.println("Phòng học ID " + idPhongHoc + " không trống vào ngày " + lich.getNgayHoc() + ", slot " + lich.getID_SlotHoc());
                    return false;
                }
            }

            // Cập nhật ID_PhongHoc trong LopHoc
            String updateLopHocSql = """
                UPDATE [dbo].[LopHoc]
                SET ID_PhongHoc = ?
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(updateLopHocSql)) {
                stmt.setInt(1, idPhongHoc);
                stmt.setInt(2, idLopHoc);
                stmt.executeUpdate();
            }

            // Cập nhật ID_PhongHoc trong LichHoc
            String updateLichHocSql = """
                UPDATE [dbo].[LichHoc]
                SET ID_PhongHoc = ?
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(updateLichHocSql)) {
                stmt.setInt(1, idPhongHoc);
                stmt.setInt(2, idLopHoc);
                stmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            System.out.println("SQL Error in assignClassToRoom: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Chuyển lớp học sang phòng học khác
    public boolean moveClassToAnotherRoom(int idLopHoc, int newIdPhongHoc) {
        return assignClassToRoom(idLopHoc, newIdPhongHoc); // Tái sử dụng hàm assignClassToRoom
    }

    // Kiểm tra phòng học còn trống hay đã có lớp
    public List<PhongHoc> checkRoomAvailability(LocalDate ngayHoc, int idSlotHoc) {
        List<PhongHoc> availableRooms = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT ph.*
            FROM [dbo].[PhongHoc] ph
            WHERE ph.TrangThai = 'Active'
            AND ph.ID_PhongHoc NOT IN (
                SELECT ID_PhongHoc
                FROM [dbo].[LichHoc]
                WHERE NgayHoc = ? AND ID_SlotHoc = ?
            )
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmt.setInt(2, idSlotHoc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                PhongHoc ph = new PhongHoc();
                ph.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                ph.setTenPhongHoc(rs.getString("TenPhongHoc"));
                ph.setSucChua(rs.getInt("SucChua"));
                ph.setTrangThai(rs.getString("TrangThai"));
                availableRooms.add(ph);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in checkRoomAvailability: " + e.getMessage());
            e.printStackTrace();
        }
        return availableRooms;
    }

    
    // Thêm phòng học mới
    public boolean addPhongHoc(PhongHoc phongHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO [dbo].[PhongHoc] (TenPhongHoc, SucChua, TrangThai)
            VALUES (?, ?, ?)
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phongHoc.getTenPhongHoc());
            stmt.setInt(2, phongHoc.getSucChua());
            stmt.setString(3, phongHoc.getTrangThai() != null ? phongHoc.getTrangThai() : "Active");
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in addPhongHoc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật phòng học
    public boolean updatePhongHoc(int idPhongHoc, PhongHoc phongHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE [dbo].[PhongHoc]
            SET TenPhongHoc = ?, SucChua = ?, TrangThai = ?
            WHERE ID_PhongHoc = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phongHoc.getTenPhongHoc());
            stmt.setInt(2, phongHoc.getSucChua());
            stmt.setString(3, phongHoc.getTrangThai() != null ? phongHoc.getTrangThai() : "Active");
            stmt.setInt(4, idPhongHoc);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in updatePhongHoc: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa phòng học
    public boolean deletePhongHoc(int idPhongHoc) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra phòng học có đang được sử dụng
            String checkUsageSql = """
                SELECT COUNT(*) FROM [dbo].[LichHoc] WHERE ID_PhongHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkUsageSql)) {
                stmt.setInt(1, idPhongHoc);
                ResultSet rs = stmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    System.out.println("Phòng học ID " + idPhongHoc + " đang được sử dụng trong lịch học");
                    return false;
                }
            }

            // Xóa phòng học
            String sql = "DELETE FROM [dbo].[PhongHoc] WHERE ID_PhongHoc = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idPhongHoc);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit();
                    return true;
                }
            }
            conn.rollback();
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error in deletePhongHoc: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    // Lấy danh sách phòng học đang hoạt động
    public static List<PhongHoc> getActivePhongHoc() {
        List<PhongHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT ID_PhongHoc, TenPhongHoc, SucChua, TrangThai
            FROM [dbo].[PhongHoc]
            WHERE TrangThai = 'Active'
            ORDER BY TenPhongHoc ASC
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PhongHoc ph = new PhongHoc();
                ph.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                ph.setTenPhongHoc(rs.getString("TenPhongHoc"));
                ph.setSucChua(rs.getInt("SucChua"));
                ph.setTrangThai(rs.getString("TrangThai"));
                list.add(ph);
            }
            System.out.println("getActivePhongHoc: Retrieved " + list.size() + " active rooms");
        } catch (SQLException e) {
            System.out.println("SQL Error in getActivePhongHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Lấy phòng học theo ID_LopHoc
    public static PhongHoc getPhongHocByLopHoc(int idLopHoc) {
        PhongHoc ph = null;
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT p.ID_PhongHoc, p.TenPhongHoc, p.SucChua, p.TrangThai
            FROM [dbo].[PhongHoc] p
            INNER JOIN [dbo].[LopHoc] l ON p.ID_PhongHoc = l.ID_PhongHoc
            WHERE l.ID_LopHoc = ?
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLopHoc);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ph = new PhongHoc();
                ph.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                ph.setTenPhongHoc(rs.getString("TenPhongHoc"));
                ph.setSucChua(rs.getInt("SucChua"));
                ph.setTrangThai(rs.getString("TrangThai"));
            }
            System.out.println("getPhongHocByLopHoc: Retrieved room for ID_LopHoc=" + idLopHoc + (ph != null ? " (found)" : " (not found)"));
        } catch (SQLException e) {
            System.out.println("SQL Error in getPhongHocByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return ph;
    }

    // Lấy phòng học theo ID_Schedule
    public static PhongHoc getPhongHocBySchedule(int idSchedule) {
        PhongHoc ph = null;
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT p.ID_PhongHoc, p.TenPhongHoc, p.SucChua, p.TrangThai
            FROM [dbo].[PhongHoc] p
            INNER JOIN [dbo].[LichHoc] lh ON p.ID_PhongHoc = lh.ID_PhongHoc
            WHERE lh.ID_Schedule = ?
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSchedule);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ph = new PhongHoc();
                ph.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                ph.setTenPhongHoc(rs.getString("TenPhongHoc"));
                ph.setSucChua(rs.getInt("SucChua"));
                ph.setTrangThai(rs.getString("TrangThai"));
            }
            System.out.println("getPhongHocBySchedule: Retrieved room for ID_Schedule=" + idSchedule + (ph != null ? " (found)" : " (not found)"));
        } catch (SQLException e) {
            System.out.println("SQL Error in getPhongHocBySchedule: " + e.getMessage());
            e.printStackTrace();
        }
        return ph;
    }
    
    public List<PhongHoc> getAllPhongHoc() {
        List<PhongHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT ID_PhongHoc, TenPhongHoc, SucChua FROM PhongHoc";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                PhongHoc phong = new PhongHoc();
                phong.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                phong.setTenPhongHoc(rs.getString("TenPhongHoc"));
                phong.setSucChua(rs.getInt("SucChua"));
                list.add(phong);
            }
            System.out.println("getAllPhongHoc: Retrieved " + list.size() + " rooms");
        } catch (SQLException e) {
            System.out.println("SQL Error in getAllPhongHoc: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return list;
    }

    public PhongHoc getPhongHocById(int id) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT ID_PhongHoc, TenPhongHoc, SucChua FROM PhongHoc WHERE ID_PhongHoc = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                PhongHoc phong = new PhongHoc();
                phong.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                phong.setTenPhongHoc(rs.getString("TenPhongHoc"));
                phong.setSucChua(rs.getInt("SucChua"));
                return phong;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getPhongHocById: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật ID_PhongHoc trong bảng LichHoc
    public boolean updatePhongHocInLichHoc1(int idSchedule, int idPhongHoc) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE [dbo].[LichHoc] SET ID_PhongHoc = ? WHERE ID_Schedule = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idPhongHoc);
            stmt.setInt(2, idSchedule);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updatePhongHocInLichHoc1: Updated " + rowsAffected + " rows for ID_Schedule=" + idSchedule + ", ID_PhongHoc=" + idPhongHoc);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in updatePhongHocInLichHoc1: " + e.getMessage() + 
                               " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
    }
}
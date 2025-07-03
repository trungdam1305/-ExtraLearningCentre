package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.LichHoc;
import model.PhongHoc;
import java.sql.Date;
import java.time.DayOfWeek;

public class LichHocDAO {

    public static ArrayList<LichHoc> adminGetAllLichHoc(String ngayHienTai) {
        ArrayList<LichHoc> lichhocs = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                       sh.SlotThoiGian, lop.TenLopHoc
                FROM [dbo].[LichHoc] lh
                JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
                JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
                WHERE NgayHoc <= ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ngayHienTai);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                LichHoc lichhoc = new LichHoc();
                lichhoc.setID_Schedule(rs.getInt("ID_Schedule"));
                lichhoc.setNgayHoc(rs.getDate("NgayHoc") != null ? rs.getDate("NgayHoc").toLocalDate() : null);
                lichhoc.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lichhoc.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lichhoc.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                lichhoc.setGhiChu(rs.getString("GhiChu"));
                lichhoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lichhoc.setTenLopHoc(rs.getString("TenLopHoc"));
                lichhocs.add(lichhoc);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in adminGetAllLichHoc: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        if (lichhocs.isEmpty()) {
            System.out.println("adminGetAllLichHoc: No schedules found for NgayHienTai=" + ngayHienTai);
            return null;
        }
        System.out.println("adminGetAllLichHoc: Retrieved " + lichhocs.size() + " schedules for NgayHienTai=" + ngayHienTai);
        return lichhocs;
    }

    public static LichHoc getLichHocById(int idSchedule) {
        LichHoc lh = null;
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                   sh.SlotThoiGian, lop.TenLopHoc
            FROM [dbo].[LichHoc] lh
            JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
            WHERE lh.ID_Schedule = ?
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idSchedule);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lh = new LichHoc();
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setNgayHoc(rs.getDate("NgayHoc") != null ? rs.getDate("NgayHoc").toLocalDate() : null);
                lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
            }
            System.out.println("getLichHocById: Retrieved schedule for ID_Schedule=" + idSchedule + (lh != null ? " (found)" : " (not found)"));
        } catch (SQLException e) {
            System.out.println("SQL Error in getLichHocById: " + e.getMessage());
            e.printStackTrace();
        }
        return lh;
    }

    public static List<LichHoc> getLichHocTrongTuan(int idTaiKhoan, LocalDate startDate, LocalDate endDate) {
        List<LichHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                   sh.SlotThoiGian, lop.TenLopHoc
            FROM [dbo].[LichHoc] lh
            JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
            JOIN [dbo].[GiaoVien_LopHoc] gvlh ON gvlh.ID_LopHoc = lop.ID_LopHoc
            JOIN [dbo].[GiaoVien] gv ON gv.ID_GiaoVien = gvlh.ID_GiaoVien
            WHERE gv.ID_TaiKhoan = ? 
            AND lh.NgayHoc BETWEEN ? AND ?
            ORDER BY lh.NgayHoc, sh.ID_SlotHoc
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTaiKhoan);
            ps.setDate(2, Date.valueOf(startDate));
            ps.setDate(3, Date.valueOf(endDate));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LichHoc lh = new LichHoc();
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setNgayHoc(rs.getDate("NgayHoc") != null ? rs.getDate("NgayHoc").toLocalDate() : null);
                lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                list.add(lh);
            }
            System.out.println("getLichHocTrongTuan: Retrieved " + list.size() + " schedules for ID_TaiKhoan=" + idTaiKhoan + ", startDate=" + startDate + ", endDate=" + endDate);
        } catch (SQLException e) {
            System.out.println("SQL Error in getLichHocTrongTuan: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public List<LichHoc> getLichHocByLopHoc(int idLopHoc) {
        List<LichHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                   sh.SlotThoiGian, lop.TenLopHoc
            FROM [dbo].[LichHoc] lh
            JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
            WHERE lh.ID_LopHoc = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LichHoc lichHoc = new LichHoc();
                lichHoc.setID_Schedule(rs.getInt("ID_Schedule"));
                lichHoc.setNgayHoc(rs.getDate("NgayHoc") != null ? rs.getDate("NgayHoc").toLocalDate() : null);
                lichHoc.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lichHoc.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lichHoc.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                lichHoc.setGhiChu(rs.getString("GhiChu"));
                lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lichHoc.setTenLopHoc(rs.getString("TenLopHoc"));
                list.add(lichHoc);
            }
            System.out.println("getLichHocByLopHoc: Retrieved " + list.size() + " schedules for ID_LopHoc=" + idLopHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in getLichHocByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public LichHoc addLichHoc(LocalDate ngayHoc, int idSlotHoc, int idLopHoc, int idPhongHoc, String ghiChu) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra lớp học tồn tại
            String checkLopHocSql = """
                SELECT COUNT(*) FROM [dbo].[LopHoc] WHERE ID_LopHoc = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    System.out.println("addLichHoc: Lớp học ID " + idLopHoc + " không tồn tại hoặc không hoạt động");
                    return null;
                }
            }

            // Kiểm tra phòng học trống
            PhongHocDAO phongHocDAO = new PhongHocDAO();
            List<PhongHoc> availableRooms = phongHocDAO.checkRoomAvailability(ngayHoc, idSlotHoc);
            if (!availableRooms.stream().anyMatch(ph -> ph.getID_PhongHoc() == idPhongHoc)) {
                System.out.println("addLichHoc: Phòng học ID " + idPhongHoc + " không trống vào ngày " + ngayHoc + ", slot " + idSlotHoc);
                return null;
            }

            // Kiểm tra sức chứa phòng học
            String checkRoomSql = """
                SELECT SucChua
                FROM [dbo].[PhongHoc]
                WHERE ID_PhongHoc = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkRoomSql)) {
                stmt.setInt(1, idPhongHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("addLichHoc: Phòng học ID " + idPhongHoc + " không tồn tại hoặc không hoạt động");
                    return null;
                }
                int sucChua = rs.getInt("SucChua");
                String checkSiSoSql = """
                    SELECT SiSo FROM [dbo].[LopHoc] WHERE ID_LopHoc = ?
                """;
                try (PreparedStatement siSoStmt = conn.prepareStatement(checkSiSoSql)) {
                    siSoStmt.setInt(1, idLopHoc);
                    ResultSet siSoRs = siSoStmt.executeQuery();
                    if (siSoRs.next()) {
                        int siSo = siSoRs.getInt("SiSo");
                        if (siSo > sucChua) {
                            System.out.println("addLichHoc: Sĩ số lớp học (" + siSo + ") vượt quá sức chứa phòng (" + sucChua + ")");
                            return null;
                        }
                    }
                }
            }

            // Thêm lịch học
            String sqlInsert = """
                INSERT INTO [dbo].[LichHoc] (NgayHoc, ID_SlotHoc, ID_LopHoc, ID_PhongHoc, GhiChu)
                VALUES (?, ?, ?, ?, ?)
            """;
            try (PreparedStatement stmt = conn.prepareStatement(sqlInsert, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
                stmt.setInt(2, idSlotHoc);
                stmt.setInt(3, idLopHoc);
                stmt.setInt(4, idPhongHoc);
                stmt.setString(5, ghiChu);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    ResultSet rs = stmt.getGeneratedKeys();
                    if (rs.next()) {
                        int idSchedule = rs.getInt(1);
                        String sqlSelect = """
                            SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                                   sh.SlotThoiGian, lop.TenLopHoc
                            FROM [dbo].[LichHoc] lh
                            JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
                            JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
                            WHERE lh.ID_Schedule = ?
                        """;
                        try (PreparedStatement selectStmt = conn.prepareStatement(sqlSelect)) {
                            selectStmt.setInt(1, idSchedule);
                            ResultSet rsSelect = selectStmt.executeQuery();
                            if (rsSelect.next()) {
                                LichHoc lichHoc = new LichHoc();
                                lichHoc.setID_Schedule(rsSelect.getInt("ID_Schedule"));
                                lichHoc.setNgayHoc(rsSelect.getDate("NgayHoc") != null ? rsSelect.getDate("NgayHoc").toLocalDate() : null);
                                lichHoc.setID_SlotHoc(rsSelect.getInt("ID_SlotHoc"));
                                lichHoc.setID_LopHoc(rsSelect.getInt("ID_LopHoc"));
                                lichHoc.setID_PhongHoc(rsSelect.getInt("ID_PhongHoc"));
                                lichHoc.setGhiChu(rsSelect.getString("GhiChu"));
                                lichHoc.setSlotThoiGian(rsSelect.getString("SlotThoiGian"));
                                lichHoc.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                                conn.commit();
                                System.out.println("addLichHoc: Successfully added schedule for ID_LopHoc=" + idLopHoc + ", ID_Schedule=" + idSchedule);
                                return lichHoc;
                            }
                        }
                    }
                }
                conn.rollback();
                System.out.println("addLichHoc: Failed to add schedule for ID_LopHoc=" + idLopHoc);
                return null;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in addLichHoc: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return null;
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

    public LichHoc updateLichHoc(int idSchedule, LocalDate ngayHoc, int idSlotHoc, int idLopHoc, int idPhongHoc, String ghiChu) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra lịch học tồn tại
            String checkLichHocSql = """
                SELECT ID_LopHoc FROM [dbo].[LichHoc] WHERE ID_Schedule = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkLichHocSql)) {
                stmt.setInt(1, idSchedule);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("updateLichHoc: Lịch học ID " + idSchedule + " không tồn tại");
                    return null;
                }
            }

            // Kiểm tra lớp học tồn tại
            String checkLopHocSql = """
                SELECT SiSo FROM [dbo].[LopHoc] WHERE ID_LopHoc = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("updateLichHoc: Lớp học ID " + idLopHoc + " không tồn tại hoặc không hoạt động");
                    return null;
                }
                int siSo = rs.getInt("SiSo");
                // Kiểm tra sức chứa phòng học
                String checkRoomSql = """
                    SELECT SucChua
                    FROM [dbo].[PhongHoc]
                    WHERE ID_PhongHoc = ? AND TrangThai = 'Active'
                """;
                try (PreparedStatement roomStmt = conn.prepareStatement(checkRoomSql)) {
                    roomStmt.setInt(1, idPhongHoc);
                    ResultSet roomRs = roomStmt.executeQuery();
                    if (!roomRs.next()) {
                        System.out.println("updateLichHoc: Phòng học ID " + idPhongHoc + " không tồn tại hoặc không hoạt động");
                        return null;
                    }
                    int sucChua = roomRs.getInt("SucChua");
                    if (siSo > sucChua) {
                        System.out.println("updateLichHoc: Sĩ số lớp học (" + siSo + ") vượt quá sức chứa phòng (" + sucChua + ")");
                        return null;
                    }
                }
            }

            // Kiểm tra phòng học trống
            PhongHocDAO phongHocDAO = new PhongHocDAO();
            List<PhongHoc> availableRooms = phongHocDAO.checkRoomAvailability(ngayHoc, idSlotHoc);
            if (!availableRooms.stream().anyMatch(ph -> ph.getID_PhongHoc() == idPhongHoc)) {
                System.out.println("updateLichHoc: Phòng học ID " + idPhongHoc + " không trống vào ngày " + ngayHoc + ", slot " + idSlotHoc);
                return null;
            }

            // Cập nhật lịch học
            String sqlUpdate = """
                UPDATE [dbo].[LichHoc]
                SET NgayHoc = ?, ID_SlotHoc = ?, ID_LopHoc = ?, ID_PhongHoc = ?, GhiChu = ?
                WHERE ID_Schedule = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(sqlUpdate)) {
                stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
                stmt.setInt(2, idSlotHoc);
                stmt.setInt(3, idLopHoc);
                stmt.setInt(4, idPhongHoc);
                stmt.setString(5, ghiChu);
                stmt.setInt(6, idSchedule);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Lấy thông tin lịch học vừa cập nhật
                    String sqlSelect = """
                        SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                               sh.SlotThoiGian, lop.TenLopHoc
                        FROM [dbo].[LichHoc] lh
                        JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
                        JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
                        WHERE lh.ID_Schedule = ?
                    """;
                    try (PreparedStatement selectStmt = conn.prepareStatement(sqlSelect)) {
                        selectStmt.setInt(1, idSchedule);
                        ResultSet rsSelect = selectStmt.executeQuery();
                        if (rsSelect.next()) {
                            LichHoc lichHoc = new LichHoc();
                            lichHoc.setID_Schedule(rsSelect.getInt("ID_Schedule"));
                            lichHoc.setNgayHoc(rsSelect.getDate("NgayHoc") != null ? rsSelect.getDate("NgayHoc").toLocalDate() : null);
                            lichHoc.setID_SlotHoc(rsSelect.getInt("ID_SlotHoc"));
                            lichHoc.setID_LopHoc(rsSelect.getInt("ID_LopHoc"));
                            lichHoc.setID_PhongHoc(rsSelect.getInt("ID_PhongHoc"));
                            lichHoc.setGhiChu(rsSelect.getString("GhiChu"));
                            lichHoc.setSlotThoiGian(rsSelect.getString("SlotThoiGian"));
                            lichHoc.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                            conn.commit();
                            System.out.println("updateLichHoc: Successfully updated schedule for ID_Schedule=" + idSchedule);
                            return lichHoc;
                        }
                    }
                }
                conn.rollback();
                System.out.println("updateLichHoc: Failed to update schedule for ID_Schedule=" + idSchedule);
                return null;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in updateLichHoc: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return null;
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

    public boolean deleteLichHoc(int idSchedule) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Xóa lịch học
            String sql = "DELETE FROM [dbo].[LichHoc] WHERE ID_Schedule = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idSchedule);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit();
                    System.out.println("deleteLichHoc: Successfully deleted schedule for ID_Schedule=" + idSchedule);
                    return true;
                }
            }
            conn.rollback();
            System.out.println("deleteLichHoc: Failed to delete schedule for ID_Schedule=" + idSchedule);
            return false;
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteLichHoc: " + e.getMessage());
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

    public List<LichHoc> addMultipleLichHoc(List<LocalDate> ngayHocs, List<Integer> idSlotHocs, int idLopHoc, List<Integer> idPhongHocs, String ghiChu) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        List<LichHoc> lichHocList = new ArrayList<>();
        Map<String, List<PhongHoc>> availabilityCache = new HashMap<>();

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra lớp học tồn tại
            String checkLopHocSql = """
                SELECT SiSo FROM [dbo].[LopHoc] WHERE ID_LopHoc = ? AND TrangThai = 'Active'
            """;
            int siSo;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("addMultipleLichHoc: Lớp học ID " + idLopHoc + " không tồn tại hoặc không hoạt động");
                    conn.rollback();
                    return null;
                }
                siSo = rs.getInt("SiSo");
            }

            // Kiểm tra phòng học và sức chứa
            PhongHocDAO phongHocDAO = new PhongHocDAO();
            for (int i = 0; i < ngayHocs.size(); i++) {
                LocalDate ngayHoc = ngayHocs.get(i);
                int idSlotHoc = idSlotHocs.get(i);
                int idPhongHoc = idPhongHocs.get(i);

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
                        System.out.println("addMultipleLichHoc: Phòng học ID " + idPhongHoc + " không tồn tại hoặc không hoạt động");
                        conn.rollback();
                        return null;
                    }
                    int sucChua = rs.getInt("SucChua");
                    if (siSo > sucChua) {
                        System.out.println("addMultipleLichHoc: Sĩ số lớp học (" + siSo + ") vượt quá sức chứa phòng (" + sucChua + ")");
                        conn.rollback();
                        return null;
                    }
                }

                // Kiểm tra phòng học trống
                String cacheKey = ngayHoc + "_" + idSlotHoc;
                List<PhongHoc> availableRooms;
                if (availabilityCache.containsKey(cacheKey)) {
                    availableRooms = availabilityCache.get(cacheKey);
                } else {
                    availableRooms = phongHocDAO.checkRoomAvailability(ngayHoc, idSlotHoc);
                    availabilityCache.put(cacheKey, availableRooms);
                }
                if (!availableRooms.stream().anyMatch(ph -> ph.getID_PhongHoc() == idPhongHoc)) {
                    System.out.println("addMultipleLichHoc: Phòng học ID " + idPhongHoc + " không trống vào ngày " + ngayHoc + ", slot " + idSlotHoc);
                    conn.rollback();
                    return null;
                }
            }

            // Chèn nhiều lịch học
            String sqlInsert = """
                INSERT INTO [dbo].[LichHoc] (NgayHoc, ID_SlotHoc, ID_LopHoc, ID_PhongHoc, GhiChu)
                VALUES (?, ?, ?, ?, ?)
            """;
            try (PreparedStatement stmt = conn.prepareStatement(sqlInsert, PreparedStatement.RETURN_GENERATED_KEYS)) {
                for (int i = 0; i < ngayHocs.size(); i++) {
                    stmt.setDate(1, java.sql.Date.valueOf(ngayHocs.get(i)));
                    stmt.setInt(2, idSlotHocs.get(i));
                    stmt.setInt(3, idLopHoc);
                    stmt.setInt(4, idPhongHocs.get(i));
                    stmt.setString(5, ghiChu);
                    stmt.addBatch();
                }
                int[] rowsAffected = stmt.executeBatch();
                ResultSet rs = stmt.getGeneratedKeys();
                List<Integer> generatedIds = new ArrayList<>();
                while (rs.next()) {
                    generatedIds.add(rs.getInt(1));
                }

                if (generatedIds.size() != ngayHocs.size()) {
                    System.out.println("addMultipleLichHoc: Failed to insert all schedules for ID_LopHoc=" + idLopHoc + ", inserted " + generatedIds.size() + "/" + ngayHocs.size());
                    conn.rollback();
                    return null;
                }

                // Lấy thông tin lịch học vừa tạo
                String sqlSelect = """
                    SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                           sh.SlotThoiGian, lop.TenLopHoc
                    FROM [dbo].[LichHoc] lh
                    JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
                    JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
                    WHERE lh.ID_Schedule = ?
                """;
                try (PreparedStatement selectStmt = conn.prepareStatement(sqlSelect)) {
                    for (int idSchedule : generatedIds) {
                        selectStmt.setInt(1, idSchedule);
                        ResultSet rsSelect = selectStmt.executeQuery();
                        if (rsSelect.next()) {
                            LichHoc lichHoc = new LichHoc();
                            lichHoc.setID_Schedule(rsSelect.getInt("ID_Schedule"));
                            lichHoc.setNgayHoc(rsSelect.getDate("NgayHoc") != null ? rsSelect.getDate("NgayHoc").toLocalDate() : null);
                            lichHoc.setID_SlotHoc(rsSelect.getInt("ID_SlotHoc"));
                            lichHoc.setID_LopHoc(rsSelect.getInt("ID_LopHoc"));
                            lichHoc.setID_PhongHoc(rsSelect.getInt("ID_PhongHoc"));
                            lichHoc.setGhiChu(rsSelect.getString("GhiChu"));
                            lichHoc.setSlotThoiGian(rsSelect.getString("SlotThoiGian"));
                            lichHoc.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                            lichHocList.add(lichHoc);
                        }
                    }
                }

                if (lichHocList.size() != ngayHocs.size()) {
                    System.out.println("addMultipleLichHoc: Failed to retrieve all inserted schedules for ID_LopHoc=" + idLopHoc);
                    conn.rollback();
                    return null;
                }

                conn.commit();
                System.out.println("addMultipleLichHoc: Successfully added " + lichHocList.size() + " schedules for ID_LopHoc=" + idLopHoc);
                return lichHocList;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in addMultipleLichHoc: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return null;
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

   

   
}
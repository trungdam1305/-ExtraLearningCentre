package dal;

import java.sql.Connection;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.LichHoc;
import model.LopHoc;

public class GiaoVienDAO {

    private Connection conn;

    public static ArrayList<GiaoVien_TruongHoc> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();

        try {
            String sql = """
                          select * from GiaoVien gv JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
                         order by IsHot DESC 
                          """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien_TruongHoc giaovien = new GiaoVien_TruongHoc(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc"),
                        rs.getString("BangCap") , 
                        rs.getString("LopDangDayTrenTruong") , 
                        rs.getString("TrangThaiDay")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            // Exception ignored    
            e.printStackTrace();
            return null;
        }

        if (giaoviens.isEmpty()) {
            return null;

        } else {
            return giaoviens;
        }
    }

    //Get All information from teacher contain Avatar
    public ArrayList<GiaoVien> HomePageGetGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();

        try {
            String sql = """
                          select * from GiaoVien 
                          """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien giaovien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            // Exception ignored    
            return new ArrayList<GiaoVien>();
        }

        if (giaoviens.isEmpty()) {
            return null;

        } else {
            return giaoviens;
        }
    }

    //Get Teacher by Name to have Specialised Teacher
    public GiaoVien getGiaoVienByHoTen(String hoTen) {
        DBContext db = DBContext.getInstance();
        GiaoVien gv = null;
        String sql = "SELECT * FROM GiaoVien gv JOIN TruongHoc th"
                + "ON gv.ID_TruongHoc = th.ID_TruongHoc"
                + " WHERE HoTen COLLATE Latin1_General_CI_AI = ?";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            statement.setString(1, hoTen.trim()); // loại bỏ khoảng trắng đầu cuối trước khi set
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setHoTen(rs.getString("HoTen"));
                gv.setChuyenMon(rs.getString("ChuyenMon"));
                gv.setSDT(rs.getString("SDT"));
                gv.setTenTruongHoc(rs.getString("TenTruongHoc"));
                gv.setLuong(rs.getBigDecimal("Luong"));
                gv.setIsHot(rs.getInt("IsHot"));
                gv.setTrangThai(rs.getString("TrangThai"));
                gv.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                gv.setAvatar(rs.getString("Avatar"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return gv;
    }

    //Get Teacher to have Specialised Teacher
    public ArrayList<GiaoVien> getSpecialised() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<>();
        String sql = """
                     SELECT gv.*, th.TenTruongHoc 
                     FROM GiaoVien gv
                     JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
                     WHERE gv.IsHot <> 0
                     ORDER BY gv.IsHot ASC""";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                GiaoVien gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setHoTen(rs.getString("HoTen"));
                gv.setChuyenMon(rs.getString("ChuyenMon"));
                gv.setSDT(rs.getString("SDT"));
                gv.setTenTruongHoc(rs.getString("TenTruongHoc"));
                gv.setLuong(rs.getBigDecimal("Luong"));
                gv.setIsHot(rs.getInt("IsHot"));
                gv.setTrangThai(rs.getString("TrangThai"));
                gv.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                gv.setAvatar(rs.getString("Avatar"));
                giaoviens.add(gv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return giaoviens;
    }

    public static ArrayList<GiaoVien_TruongHoc> adminGetGiaoVienByID(String id_TaiKhoan) {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();

        try {
            String sql = """
                         select * from GiaoVien gv JOIN TruongHoc th 
                         ON gv.ID_TruongHoc = th.ID_TruongHoc
                         where ID_TaiKhoan = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id_TaiKhoan);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien_TruongHoc giaovien = new GiaoVien_TruongHoc(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc"),
                        rs.getString("BangCap") , 
                        rs.getString("LopDangDayTrenTruong") , 
                        rs.getString("TrangThaiDay")
                        
                );
                giaoviens.add(giaovien);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (giaoviens.isEmpty()) {
            return null;
        } else {
            return giaoviens;
        }
    }

    public static boolean adminEnableGiaoVien(String ID_TaiKhoan) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE GiaoVien
                         SET TrangThai = 'Active'
                         WHERE ID_TaiKhoan = ?;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_TaiKhoan);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
        if (rs == 0) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean adminDisableGiaoVien(String id) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE GiaoVien
                         SET TrangThai = 'Inactive'
                         WHERE ID_TaiKhoan = ?;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();

        }
        if (rs == 0) {
            return false;
        } else {
            return true;
        }
    }

    public static int adminGetTongSoGiaoVienDangDay() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                         SELECT COUNT(*) 
                         FROM GiaoVien
                         WHERE TrangThaiDay LIKE N'%Đang Dạy%';
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return tong;
    }

    public static boolean adminUpdateInformationOfTeacher(String sdt, BigDecimal luong, int ishot, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        int rs = 0;

        try {
            String sql = """
                             UPDATE GiaoVien 
                             SET 
                             SDT = ?  , 
                             Luong = ? , 
                             IsHot = ? 
                             where ID_GiaoVien = ? 
                             """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, sdt);
            statement.setBigDecimal(2, luong);
            statement.setInt(3, ishot);
            statement.setInt(4, idGiaoVien);
            rs = statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        }

        if (rs == 0) {
            return false;
        } else {
            return true;
        }
    }

    public double getLuongTheoTaiKhoan(int idTaiKhoan) {
        DBContext db = DBContext.getInstance();
        double luong = -1;

        String sql = "SELECT GiaoVien.Luong FROM GiaoVien join TaiKhoan\n"
                + "  ON GiaoVien.ID_TaiKhoan  = TaiKhoan.ID_TaiKhoan\n"
                + "  WHERE GiaoVien.ID_TaiKhoan = ?";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idTaiKhoan);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                luong = rs.getDouble("Luong");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return luong;
    }

    public GiaoVien getGiaoVienByLopHoc(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        GiaoVien giaoVien = null;
        String sql = """
                 SELECT gv.*, th.TenTruongHoc 
                 FROM GiaoVien gv 
                 JOIN GiaoVien_LopHoc lhg ON gv.ID_GiaoVien = lhg.ID_GiaoVien 
                 LEFT JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc 
                 WHERE lhg.ID_LopHoc = ? 
                 """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                giaoVien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null,
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                );
            }
            System.out.println("GiaoVien fetched for LopHoc ID " + idLopHoc + ": " + (giaoVien != null ? giaoVien.getHoTen() : "null"));
        } catch (SQLException e) {
            System.out.println("SQL Error in getGiaoVienByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return giaoVien;
    }

    public String findConflictingClassName(int idGiaoVien, int idLopHoc, int idSlotHoc, LocalDate ngayHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
        SELECT lh.TenLopHoc, sh.SlotThoiGian
        FROM GiaoVien_LopHoc glh
        JOIN LopHoc lh ON glh.ID_LopHoc = lh.ID_LopHoc
        JOIN LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
        JOIN SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
        WHERE glh.ID_GiaoVien = ?
        AND glh.ID_LopHoc != ?
        AND lich.NgayHoc = ?
    """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setDate(3, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = stmt.executeQuery();

            // Lấy SlotThoiGian của lớp mới
            String sqlSlot = "SELECT SlotThoiGian FROM SlotHoc WHERE ID_SlotHoc = ?";
            try (PreparedStatement stmtSlot = db.getConnection().prepareStatement(sqlSlot)) {
                stmtSlot.setInt(1, idSlotHoc);
                ResultSet rsSlot = stmtSlot.executeQuery();
                if (rsSlot.next()) {
                    String newSlotThoiGian = rsSlot.getString("SlotThoiGian");
                    if (newSlotThoiGian == null || newSlotThoiGian.trim().isEmpty()) {
                        System.err.println("SlotThoiGian không hợp lệ cho ID_SlotHoc = " + idSlotHoc);
                        return null;
                    }
                    while (rs.next()) {
                        String tenLopHoc = rs.getString("TenLopHoc");
                        String existingSlotThoiGian = rs.getString("SlotThoiGian");
                        if (existingSlotThoiGian == null || existingSlotThoiGian.trim().isEmpty()) {
                            System.err.println("SlotThoiGian không hợp lệ trong lịch dạy của giáo viên ID " + idGiaoVien + " cho ngày " + ngayHoc);
                            continue;
                        }
                        if (isTimeConflict(newSlotThoiGian, existingSlotThoiGian)) {
                            System.out.println("Phát hiện xung đột khung giờ cho giáo viên ID " + idGiaoVien + " với lớp học '" + tenLopHoc + "' vào ngày " + ngayHoc);
                            return tenLopHoc;
                        }
                    }
                } else {
                    System.err.println("Không tìm thấy SlotHoc cho ID_SlotHoc = " + idSlotHoc);
                    return null;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong findConflictingClassName: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return null;
        }
        return null; // Không có xung đột
    }

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
            // Kiểm tra giao nhau (trùng nếu có bất kỳ thời điểm nào chung)
            return !end1.isBefore(start2) && !start1.isAfter(end2);
        } catch (Exception e) {
            System.err.println("Lỗi phân tích SlotThoiGian: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2 + ", error = " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<GiaoVien> getTeachersBySpecialization(String tenKhoaHoc) {
        List<GiaoVien> teachers = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        if (tenKhoaHoc == null || tenKhoaHoc.length() < 2) {
            return teachers;
        }

        List<String> subStrings = new ArrayList<>();
        String lowerTenKhoaHoc = tenKhoaHoc.toLowerCase();
        for (int i = 0; i < lowerTenKhoaHoc.length() - 1; i++) {
            subStrings.add(lowerTenKhoaHoc.substring(i, i + 2));
        }

        StringBuilder sql = new StringBuilder("""
                                              SELECT gv.*, th.TenTruongHoc 
                                              FROM GiaoVien gv 
                                              LEFT JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc 
                                              WHERE gv.TrangThai = 'Active' AND (
                                              """);
        List<Object> params = new ArrayList<>();
        for (int i = 0; i < subStrings.size(); i++) {
            if (i > 0) {
                sql.append(" OR ");
            }
            sql.append("LOWER(gv.ChuyenMon) LIKE ?");
            params.add("%" + subStrings.get(i) + "%");
        }
        sql.append(")");

        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                GiaoVien giaoVien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null,
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                );
                teachers.add(giaoVien);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getTeachersBySpecialization: " + e.getMessage());
            e.printStackTrace();
        }
        return teachers;
    }

   public boolean updateTeacherAssignment(int idLopHoc, int idGiaoVien) throws SQLException {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra giáo viên tồn tại và hoạt động
            String checkGiaoVienSql = """
                SELECT COUNT(*) 
                FROM [dbo].[GiaoVien] 
                WHERE ID_GiaoVien = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkGiaoVienSql)) {
                stmt.setInt(1, idGiaoVien);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    System.out.println("updateTeacherAssignment: Invalid ID_GiaoVien=" + idGiaoVien + " (not exists or not active)");
                    throw new SQLException("Giáo viên không tồn tại hoặc không hoạt động");
                }
            }

            // Kiểm tra lớp học tồn tại và có trạng thái hợp lệ ('Đang học' hoặc 'Chưa học')
            String checkLopHocSql = """
                SELECT TrangThai 
                FROM [dbo].[LopHoc] 
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("updateTeacherAssignment: Invalid ID_LopHoc=" + idLopHoc + " (not exists)");
                    throw new SQLException("Lớp học không tồn tại");
                }
                String trangThai = rs.getString("TrangThai");
                if (!"Đang học".equals(trangThai) && !"Chưa học".equals(trangThai)) {
                    System.out.println("updateTeacherAssignment: Invalid ID_LopHoc=" + idLopHoc + " (status=" + trangThai + " not in 'Đang học', 'Chưa học')");
                    throw new SQLException("Lớp học không ở trạng thái hợp lệ (Đang học hoặc Chưa học)");
                }
            }

            // Kiểm tra lịch học
            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            if (lichHocList == null || lichHocList.isEmpty()) {
                System.out.println("updateTeacherAssignment: No schedule found for ID_LopHoc=" + idLopHoc);
                throw new SQLException("Lớp học chưa có lịch học");
            }

            // Kiểm tra xung đột lịch học
            for (LichHoc lichHoc : lichHocList) {
                if (hasSlotConflict(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc())) {
                    String conflictingClass = findConflictingClassName(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc());
                    System.out.println("updateTeacherAssignment: Time slot conflict for ID_GiaoVien=" + idGiaoVien + " on " + lichHoc.getNgayHoc() + " with class " + conflictingClass);
                    throw new SQLException("Xung đột lịch học với lớp " + (conflictingClass != null ? conflictingClass : "khác") + " vào ngày " + lichHoc.getNgayHoc() + " tại khung giờ " + lichHoc.getSlotThoiGian());
                }
            }

            // Xóa phân công cũ nếu có
            String deleteOldAssignmentSql = """
                DELETE FROM [dbo].[GiaoVien_LopHoc] 
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(deleteOldAssignmentSql)) {
                stmt.setInt(1, idLopHoc);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("updateTeacherAssignment: Removed " + rowsAffected + " old assignments for ID_LopHoc=" + idLopHoc);
            }

            // Thêm phân công mới
            String insertSql = """
                INSERT INTO [dbo].[GiaoVien_LopHoc] (ID_LopHoc, ID_GiaoVien) 
                VALUES (?, ?)
            """;
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setInt(1, idLopHoc);
                stmt.setInt(2, idGiaoVien);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit();
                    System.out.println("updateTeacherAssignment: Successfully assigned ID_GiaoVien=" + idGiaoVien + " to ID_LopHoc=" + idLopHoc);
                    return true;
                } else {
                    System.out.println("updateTeacherAssignment: Failed to insert assignment for ID_LopHoc=" + idLopHoc + ", ID_GiaoVien=" + idGiaoVien);
                    conn.rollback();
                    throw new SQLException("Không thể cập nhật phân công giáo viên");
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in updateTeacherAssignment: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            throw e;
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

    public boolean hasSlotConflict(int idGiaoVien, int idLopHoc, int idSlotHoc, LocalDate ngayHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
        SELECT sh.SlotThoiGian
        FROM GiaoVien_LopHoc glh
        JOIN LichHoc lh ON glh.ID_LopHoc = lh.ID_LopHoc
        JOIN SlotHoc sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
        WHERE glh.ID_GiaoVien = ?
        AND glh.ID_LopHoc != ?
        AND lh.NgayHoc = ?
    """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setDate(3, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = stmt.executeQuery();

            // Lấy SlotThoiGian của lớp mới
            String sqlSlot = "SELECT SlotThoiGian FROM SlotHoc WHERE ID_SlotHoc = ?";
            try (PreparedStatement stmtSlot = db.getConnection().prepareStatement(sqlSlot)) {
                stmtSlot.setInt(1, idSlotHoc);
                ResultSet rsSlot = stmtSlot.executeQuery();
                if (rsSlot.next()) {
                    String newSlotThoiGian = rsSlot.getString("SlotThoiGian");
                    if (newSlotThoiGian == null || newSlotThoiGian.trim().isEmpty()) {
                        System.err.println("SlotThoiGian không hợp lệ cho ID_SlotHoc = " + idSlotHoc);
                        return false;
                    }
                    while (rs.next()) {
                        String existingSlotThoiGian = rs.getString("SlotThoiGian");
                        if (existingSlotThoiGian == null || existingSlotThoiGian.trim().isEmpty()) {
                            System.err.println("SlotThoiGian không hợp lệ trong lịch dạy của giáo viên ID " + idGiaoVien + " cho ngày " + ngayHoc);
                            continue;
                        }
                        if (isTimeConflict(newSlotThoiGian, existingSlotThoiGian)) {
                            System.out.println("Phát hiện xung đột khung giờ cho giáo viên ID " + idGiaoVien + " với lớp học ID " + idLopHoc + " vào ngày " + ngayHoc);
                            return true;
                        }
                    }
                } else {
                    System.err.println("Không tìm thấy SlotHoc cho ID_SlotHoc = " + idSlotHoc);
                    return false;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong hasSlotConflict: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean assignTeacherToClass(int idLopHoc, int idGiaoVien) throws SQLException {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra giáo viên tồn tại và hoạt động
            String checkGiaoVienSql = """
                SELECT COUNT(*) 
                FROM [dbo].[GiaoVien] 
                WHERE ID_GiaoVien = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkGiaoVienSql)) {
                stmt.setInt(1, idGiaoVien);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    System.out.println("assignTeacherToClass: Invalid ID_GiaoVien=" + idGiaoVien + " (not exists or not active)");
                    throw new SQLException("Giáo viên không tồn tại hoặc không hoạt động");
                }
            }

            // Kiểm tra lớp học tồn tại và có trạng thái hợp lệ ('Đang học' hoặc 'Chưa học')
            String checkLopHocSql = """
                SELECT TrangThai 
                FROM [dbo].[LopHoc] 
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    System.out.println("assignTeacherToClass: Invalid ID_LopHoc=" + idLopHoc + " (not exists)");
                    throw new SQLException("Lớp học không tồn tại");
                }
                String trangThai = rs.getString("TrangThai");
                if (!"Đang học".equals(trangThai) && !"Chưa học".equals(trangThai)) {
                    System.out.println("assignTeacherToClass: Invalid ID_LopHoc=" + idLopHoc + " (status=" + trangThai + " not in 'Đang học', 'Chưa học')");
                    throw new SQLException("Lớp học không ở trạng thái hợp lệ (Đang học hoặc Chưa học)");
                }
            }

            // Kiểm tra lịch học
            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            if (lichHocList == null || lichHocList.isEmpty()) {
                System.out.println("assignTeacherToClass: No schedule found for ID_LopHoc=" + idLopHoc);
                throw new SQLException("Lớp học chưa có lịch học");
            }

            // Kiểm tra xung đột lịch học
            for (LichHoc lichHoc : lichHocList) {
                if (hasSlotConflict(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc())) {
                    String conflictingClass = findConflictingClassName(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc());
                    System.out.println("assignTeacherToClass: Time slot conflict for ID_GiaoVien=" + idGiaoVien + " on " + lichHoc.getNgayHoc() + " with class " + conflictingClass);
                    throw new SQLException("Xung đột lịch học với lớp " + (conflictingClass != null ? conflictingClass : "khác") + " vào ngày " + lichHoc.getNgayHoc() + " tại khung giờ " + lichHoc.getSlotThoiGian());
                }
            }

            // Xóa phân công cũ nếu có
            String deleteOldAssignmentSql = """
                DELETE FROM [dbo].[GiaoVien_LopHoc] 
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement stmt = conn.prepareStatement(deleteOldAssignmentSql)) {
                stmt.setInt(1, idLopHoc);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("assignTeacherToClass: Removed " + rowsAffected + " old assignments for ID_LopHoc=" + idLopHoc);
            }

            // Thêm phân công mới
            String insertSql = """
                INSERT INTO [dbo].[GiaoVien_LopHoc] (ID_LopHoc, ID_GiaoVien) 
                VALUES (?, ?)
            """;
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setInt(1, idLopHoc);
                stmt.setInt(2, idGiaoVien);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    conn.commit();
                    System.out.println("assignTeacherToClass: Successfully assigned ID_GiaoVien=" + idGiaoVien + " to ID_LopHoc=" + idLopHoc);
                    return true;
                } else {
                    System.out.println("assignTeacherToClass: Failed to insert assignment for ID_LopHoc=" + idLopHoc + ", ID_GiaoVien=" + idGiaoVien);
                    conn.rollback();
                    throw new SQLException("Không thể thêm phân công giáo viên");
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in assignTeacherToClass: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            throw e;
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
    
    //Lấy thông tin giáo viên theo id
    public static GiaoVien getGiaoVienById(int id) {
        String sql = """
            SELECT g.*, tk.Email
            FROM GiaoVien g
            JOIN TaiKhoan tk ON g.ID_TaiKhoan = tk.ID_TaiKhoan
            WHERE g.ID_GiaoVien = ?
        """;

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    GiaoVien gv = new GiaoVien();
                    gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                    gv.setHoTen(rs.getString("HoTen"));
                    gv.setEmail(rs.getString("Email"));
                    gv.setChuyenMon(rs.getString("ChuyenMon"));
                    gv.setSDT(rs.getString("SDT"));
                    gv.setAvatar(rs.getString("Avatar"));
                    return gv;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //Kiểm tra dữ liệu    
    public static void main(String[] args) {
        String classCode = "LICH09A";

        // Bước 1: Lấy thông tin lớp học
        LopHoc lop = LopHocDAO.getLopHocByClassCode(classCode);
        if (lop == null) {
            System.out.println("❌ Không tìm thấy lớp học với mã: " + classCode);
            return;
        }

        System.out.println("===== THÔNG TIN LỚP HỌC =====");
        System.out.println("ClassCode:  " + lop.getClassCode());
        System.out.println("Tên lớp:    " + lop.getTenLopHoc());
        System.out.println("Khóa học:   " + lop.getTenKhoaHoc());
        System.out.println("Thời gian:  " + lop.getThoiGianBatDau() + " → " + lop.getThoiGianKetThuc());
        System.out.println("Ghi chú:    " + lop.getGhiChu());
        System.out.println("ID_Giáo viên phụ trách: " + lop.getID_GiaoVien());

        // Bước 2: Lấy thông tin giáo viên từ ID_GiaoVien của lớp
        GiaoVien gv = GiaoVienDAO.getGiaoVienById(lop.getID_GiaoVien());
        if (gv == null) {
            System.out.println("❌ Không tìm thấy giáo viên với ID: " + lop.getID_GiaoVien());
            return;
        }

        System.out.println("\n===== THÔNG TIN GIÁO VIÊN =====");
        System.out.println("Họ tên:     " + gv.getHoTen());
        System.out.println("Email:      " + gv.getEmail());
        System.out.println("SĐT:        " + gv.getSDT());
        System.out.println("Chuyên môn: " + gv.getChuyenMon());
        System.out.println("Avatar:     " + gv.getAvatar());
    }
}

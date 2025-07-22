package dal;

import java.sql.Connection;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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
                        rs.getString("BangCap"),
                        rs.getString("LopDangDayTrenTruong"),
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
                        JOIN TaiKhoan TK 
                        ON TK.ID_TaiKhoan = gv.ID_TaiKhoan
                    where gv.ID_TaiKhoan = ? ; 
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
                        rs.getString("BangCap"),
                        rs.getString("LopDangDayTrenTruong"),
                        rs.getString("TrangThaiDay"),
                        rs.getString("MatKhau")
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

    public static String adminGetIdGiaoVienToSendNTF(String ID_LopHoc) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                         select  GV.ID_TaiKhoan from GiaoVien_LopHoc GL
                        JOIN GiaoVien GV
                        ON GV.ID_GiaoVien = GL.ID_GiaoVien
                        WHERE GL.ID_LopHoc = ? ;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_LopHoc);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getString("ID_TaiKhoan");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static GiaoVien_TruongHoc getGiaoVienByID(int id_TaiKhoan) {
        // Không cần ArrayList vì chúng ta chỉ tìm một đối tượng
        GiaoVien_TruongHoc giaovien = null;
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                         select * from GiaoVien gv JOIN TruongHoc th 
                         ON gv.ID_TruongHoc = th.ID_TruongHoc
                         where gv.ID_TaiKhoan = ? 
                         """; // Thêm gv.ID_TaiKhoan để rõ ràng hơn
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, id_TaiKhoan);
            ResultSet rs = statement.executeQuery();

            // Dùng 'if' thay vì 'while' vì chúng ta chỉ mong đợi một kết quả
            if (rs.next()) {
                giaovien = new GiaoVien_TruongHoc(
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
                        rs.getString("BangCap"),
                        rs.getString("LopDangDayTrenTruong"),
                        rs.getString("TrangThaiDay")
                );
            }

            // Đóng tài nguyên để tránh rò rỉ bộ nhớ
            rs.close();
            statement.close();

        } catch (SQLException e) {
            e.printStackTrace();
            // Trả về null nếu có lỗi
            return null;
        }

        // Trả về đối tượng giáo viên tìm được (hoặc null nếu không tìm thấy)
        return giaovien;
    }

    public List<GiaoVien> getPreviousTeachersByLopHoc(int idLopHoc) {
        List<GiaoVien> previousTeachers = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
                 SELECT DISTINCT g.ID_GiaoVien, g.ID_TaiKhoan, g.HoTen, g.ChuyenMon, g.SDT, 
                                g.ID_TruongHoc, g.Luong, g.IsHot, g.TrangThai, g.NgayTao, 
                                g.Avatar, th.TenTruongHoc
                 FROM GiaoVien g
                 JOIN GiaoVien_LopHoc gl ON g.ID_GiaoVien = gl.ID_GiaoVien
                 JOIN TruongHoc th ON g.ID_TruongHoc = th.ID_TruongHoc
                 JOIN LichHoc lh ON gl.ID_LopHoc = lh.ID_LopHoc
                 WHERE lh.ID_LopHoc = ? AND lh.NgayHoc < GETDATE()
                 """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
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
                previousTeachers.add(giaoVien);
            }
            System.out.println("Previous teachers fetched for LopHoc ID " + idLopHoc + ": " + previousTeachers.size());
        } catch (SQLException e) {
            System.out.println("SQL Error in getPreviousTeachersByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return previousTeachers;
    }

    // Ghi lại lịch sử thay đổi giáo viên vào UserLogs
    public boolean logTeacherAssignmentChange1(int idLopHoc, int oldGiaoVienId, int newGiaoVienId, String action) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO UserLogs (ID_TaiKhoan, HanhDong, ThoiGian) VALUES (?, ?, ?)";
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Xác định ID_GiaoVien dựa trên hành động
            int idGiaoVien = action.toLowerCase().contains("xóa") ? oldGiaoVienId : newGiaoVienId;
            GiaoVien giaoVien = getGiaoVienById1(idGiaoVien);
            if (giaoVien == null) {
                System.out.println("logTeacherAssignmentChange1: Không tìm thấy giáo viên với ID_GiaoVien=" + idGiaoVien);
                return false;
            }

            stmt.setInt(1, giaoVien.getID_TaiKhoan());
            stmt.setString(2, String.format("%s giáo viên ID=%d cho lớp ID=%d", action, idGiaoVien, idLopHoc));
            stmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));

            int rowsAffected = stmt.executeUpdate();
            System.out.printf("logTeacherAssignmentChange1: Logged action '%s' for ID_LopHoc=%d, ID_GiaoVien=%d, ID_TaiKhoan=%d, Rows affected=%d%n",
                    action, idLopHoc, idGiaoVien, giaoVien.getID_TaiKhoan(), rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in logTeacherAssignmentChange1: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    // Lấy giáo viên theo ID_GiaoVien, lấy đầy đủ các cột
    public GiaoVien getGiaoVienById1(int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT g.ID_GiaoVien, g.ID_TaiKhoan, g.HoTen, g.ChuyenMon, g.SDT, 
                   g.ID_TruongHoc, g.Luong, g.IsHot, g.TrangThai, g.NgayTao, 
                   g.Avatar, g.BangCap, g.LopDangDayTrenTruong, g.TrangThaiDay, 
                   th.TenTruongHoc
            FROM GiaoVien g
            LEFT JOIN TruongHoc th ON g.ID_TruongHoc = th.ID_TruongHoc
            WHERE g.ID_GiaoVien = ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new GiaoVien(
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
                        rs.getString("TenTruongHoc"),
                        rs.getString("BangCap"),
                        rs.getString("LopDangDayTrenTruong"),
                        rs.getString("TrangThaiDay")
                );
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getGiaoVienById1: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Lấy giáo viên hiện tại của lớp học
    public GiaoVien getGiaoVienByLopHoc1(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT g.ID_GiaoVien, g.ID_TaiKhoan, g.HoTen, g.ChuyenMon, g.SDT, 
                   g.ID_TruongHoc, g.Luong, g.IsHot, g.TrangThai, g.NgayTao, 
                   g.Avatar, g.BangCap, g.LopDangDayTrenTruong, g.TrangThaiDay, 
                   th.TenTruongHoc
            FROM GiaoVien g
            JOIN GiaoVien_LopHoc gl ON g.ID_GiaoVien = gl.ID_GiaoVien
            LEFT JOIN TruongHoc th ON g.ID_TruongHoc = th.ID_TruongHoc
            WHERE gl.ID_LopHoc = ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new GiaoVien(
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
                        rs.getString("TenTruongHoc"),
                        rs.getString("BangCap"),
                        rs.getString("LopDangDayTrenTruong"),
                        rs.getString("TrangThaiDay")
                );
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getGiaoVienByLopHoc1: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách giáo viên theo chuyên môn
    public List<GiaoVien> getTeachersBySpecialization1(String tenKhoaHoc) {
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
            params.add("%" + tenKhoaHoc + "%");
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

    public boolean assignTeacherToClass1(int idLopHoc, int idGiaoVien) throws SQLException {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);
            // Set isolation level để giảm lock (optional, test nếu snapshot không đủ)
            // conn.setTransactionIsolation(Connection.TRANSACTION_READ_UNCOMMITTED);

            // Kiểm tra giáo viên tồn tại và hoạt động
            String checkGiaoVienSql = "SELECT COUNT(*) FROM [dbo].[GiaoVien] WHERE ID_GiaoVien = ? AND TrangThai = 'Active'";
            try (PreparedStatement stmt = conn.prepareStatement(checkGiaoVienSql)) {
                stmt.setInt(1, idGiaoVien);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    throw new SQLException("Giáo viên không tồn tại hoặc không hoạt động");
                }
            }

            // Kiểm tra lớp học tồn tại và trạng thái hợp lệ
            String checkLopHocSql = "SELECT TrangThai FROM [dbo].[LopHoc] WHERE ID_LopHoc = ?";
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    throw new SQLException("Lớp học không tồn tại");
                }
                String trangThai = rs.getString("TrangThai");
                if (!"Đang học".equals(trangThai) && !"Chưa học".equals(trangThai)) {
                    throw new SQLException("Lớp học không ở trạng thái hợp lệ (Đang học hoặc Chưa học)");
                }
            }

            // Kiểm tra lịch học
            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            if (lichHocList == null || lichHocList.isEmpty()) {
                throw new SQLException("Lớp học chưa có lịch học");
            }

            // Kiểm tra xung đột lịch học
            for (LichHoc lichHoc : lichHocList) {
                if (hasSlotConflict1(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc())) {
                    String conflictingClass = findConflictingClassName1(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc());
                    throw new SQLException("Xung đột lịch học với lớp " + (conflictingClass != null ? conflictingClass : "khác")
                            + " vào ngày " + lichHoc.getNgayHoc() + " tại khung giờ " + lichHoc.getSlotThoiGian());
                }
            }

            // Lấy giáo viên hiện tại (nếu có) để ghi log và cập nhật trạng thái
            GiaoVien currentTeacher = getGiaoVienByLopHoc1(idLopHoc);
            boolean hasOldTeacher = (currentTeacher != null && currentTeacher.getID_GiaoVien() != idGiaoVien);

            if (currentTeacher != null) {
                logTeacherAssignmentChange1(idLopHoc, currentTeacher.getID_GiaoVien(), idGiaoVien, "Xóa phân công");
            }

            // Xóa phân công cũ
            String deleteOldAssignmentSql = "DELETE FROM [dbo].[GiaoVien_LopHoc] WHERE ID_LopHoc = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteOldAssignmentSql)) {
                stmt.setInt(1, idLopHoc);
                stmt.executeUpdate();
            }

            // Thêm phân công mới
            String insertSql = "INSERT INTO [dbo].[GiaoVien_LopHoc] (ID_LopHoc, ID_GiaoVien) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setInt(1, idLopHoc);
                stmt.setInt(2, idGiaoVien);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    logTeacherAssignmentChange1(idLopHoc, idGiaoVien, idGiaoVien, "Thêm phân công");
                    conn.commit();  // Commit transaction trước khi update trạng thái để release lock sớm

                    // Cập nhật trạng thái sau commit (sử dụng cùng conn nhưng autoCommit true)
                    conn.setAutoCommit(true);  // Chuyển sang autoCommit để update riêng
                    if (hasOldTeacher) {
                        updateTrangThaiDay(conn, currentTeacher.getID_GiaoVien());
                    }
                    updateTrangThaiDay(conn, idGiaoVien);

                    System.out.println("assignTeacherToClass1: Successfully assigned ID_GiaoVien=" + idGiaoVien + " to ID_LopHoc=" + idLopHoc);
                    return true;
                } else {
                    conn.rollback();
                    throw new SQLException("Không thể thêm phân công giáo viên");
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in assignTeacherToClass1: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

// Method private mới (giữ nguyên, nhưng giờ gọi sau commit)
    private void updateTrangThaiDay(Connection conn, int idGiaoVien) throws SQLException {
        String countSql = "SELECT COUNT(*) FROM [dbo].[GiaoVien_LopHoc] WHERE ID_GiaoVien = ?";
        try (PreparedStatement countStmt = conn.prepareStatement(countSql)) {
            countStmt.setInt(1, idGiaoVien);
            ResultSet rs = countStmt.executeQuery();
            int soLop = 0;
            if (rs.next()) {
                soLop = rs.getInt(1);
            }

            String trangThaiDay = (soLop > 0) ? "Đang dạy" : "Chưa dạy";

            String updateSql = "UPDATE [dbo].[GiaoVien] SET TrangThaiDay = ? WHERE ID_GiaoVien = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, trangThaiDay);
                updateStmt.setInt(2, idGiaoVien);
                updateStmt.executeUpdate();
            }
        }
    }

    // Lấy lịch sử giáo viên đã dạy dựa trên các buổi học trước
    public List<GiaoVien> getPreviousTeachersByLopHoc1(int idLopHoc) {
        List<GiaoVien> previousTeachers = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT DISTINCT g.ID_GiaoVien, g.ID_TaiKhoan, g.HoTen, g.ChuyenMon, g.SDT, 
                           g.ID_TruongHoc, g.Luong, g.IsHot, g.TrangThai, g.NgayTao, 
                           g.Avatar, g.BangCap, g.LopDangDayTrenTruong, g.TrangThaiDay, 
                           th.TenTruongHoc
            FROM GiaoVien g
            JOIN GiaoVien_LopHoc gl ON g.ID_GiaoVien = gl.ID_GiaoVien
            JOIN TruongHoc th ON g.ID_TruongHoc = th.ID_TruongHoc
            JOIN LichHoc lh ON gl.ID_LopHoc = lh.ID_LopHoc
            WHERE lh.ID_LopHoc = ? AND lh.NgayHoc < GETDATE()
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
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
                        rs.getString("TenTruongHoc"),
                        rs.getString("BangCap"),
                        rs.getString("LopDangDayTrenTruong"),
                        rs.getString("TrangThaiDay")
                );
                previousTeachers.add(giaoVien);
            }
            System.out.println("getPreviousTeachersByLopHoc1: Fetched " + previousTeachers.size() + " previous teachers for ID_LopHoc=" + idLopHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in getPreviousTeachersByLopHoc1: " + e.getMessage());
            e.printStackTrace();
        }
        return previousTeachers;
    }

    // Tính số buổi dạy của giáo viên cho một lớp học
    public int getTeachingSessions1(int idGiaoVien, int idLopHoc, LocalDate beforeDate) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(*) 
            FROM LichHoc lh
            JOIN GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            WHERE glh.ID_GiaoVien = ? AND lh.ID_LopHoc = ? AND lh.NgayHoc < ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setDate(3, java.sql.Date.valueOf(beforeDate));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int sessions = rs.getInt(1);
                System.out.println("getTeachingSessions1: Teacher ID=" + idGiaoVien + ", Class ID=" + idLopHoc + ", Sessions=" + sessions);
                return sessions;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getTeachingSessions1: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // Tính lương giáo viên dựa trên số buổi dạy
    public double calculateTeacherSalary1(int idGiaoVien, int idLopHoc, LocalDate startDate, LocalDate endDate) {
        DBContext db = DBContext.getInstance();
        double salary = 0.0;
        String sql = """
            SELECT COUNT(*) AS Sessions, g.Luong
            FROM LichHoc lh
            JOIN GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            JOIN GiaoVien g ON glh.ID_GiaoVien = g.ID_GiaoVien
            WHERE glh.ID_GiaoVien = ? AND lh.ID_LopHoc = ? 
            AND lh.NgayHoc BETWEEN ? AND ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setDate(3, java.sql.Date.valueOf(startDate));
            stmt.setDate(4, java.sql.Date.valueOf(endDate));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int sessions = rs.getInt("Sessions");
                double luongPerSession = rs.getBigDecimal("Luong").doubleValue() / 30; // Giả sử lương tháng chia cho 30 buổi
                salary = sessions * luongPerSession;
                System.out.printf("calculateTeacherSalary1: Teacher ID=%d, Class ID=%d, Sessions=%d, Salary=%.2f%n",
                        idGiaoVien, idLopHoc, sessions, salary);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in calculateTeacherSalary1: " + e.getMessage());
            e.printStackTrace();
        }
        return salary;
    }

    // Kiểm tra xung đột lịch học
    private boolean hasSlotConflict1(int idGiaoVien, int idLopHoc, int idSlotHoc, LocalDate ngayHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(*) 
            FROM LichHoc lh
            JOIN GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            WHERE glh.ID_GiaoVien = ? AND lh.ID_LopHoc != ? 
            AND lh.ID_SlotHoc = ? AND lh.NgayHoc = ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setInt(3, idSlotHoc);
            stmt.setDate(4, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in hasSlotConflict1: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Tìm tên lớp học gây xung đột
    private String findConflictingClassName1(int idGiaoVien, int idLopHoc, int idSlotHoc, LocalDate ngayHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.ID_LopHoc, l.TenLopHoc
            FROM LichHoc lh
            JOIN GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            JOIN LopHoc l ON lh.ID_LopHoc = l.ID_LopHoc
            WHERE glh.ID_GiaoVien = ? AND lh.ID_LopHoc != ? 
            AND lh.ID_SlotHoc = ? AND lh.NgayHoc = ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setInt(3, idSlotHoc);
            stmt.setDate(4, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("TenLopHoc");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in findConflictingClassName1: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Xóa giáo viên khỏi lớp học
    public boolean removeTeacherFromClass1(int idLopHoc, int idGiaoVien) throws SQLException {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra giáo viên có trong lớp không
            String checkAssignmentSql = "SELECT COUNT(*) FROM GiaoVien_LopHoc WHERE ID_LopHoc = ? AND ID_GiaoVien = ?";
            try (PreparedStatement stmt = conn.prepareStatement(checkAssignmentSql)) {
                stmt.setInt(1, idLopHoc);
                stmt.setInt(2, idGiaoVien);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    System.out.printf("removeTeacherFromClass1: No assignment found for ID_LopHoc=%d, ID_GiaoVien=%d%n", idLopHoc, idGiaoVien);
                    return false;
                }
            }

            // Xóa phân công giáo viên
            String deleteSql = "DELETE FROM GiaoVien_LopHoc WHERE ID_LopHoc = ? AND ID_GiaoVien = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
                stmt.setInt(1, idLopHoc);
                stmt.setInt(2, idGiaoVien);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    // Ghi log hành động xóa
                    logTeacherAssignmentChange1(idLopHoc, idGiaoVien, idGiaoVien, "Xóa phân công");
                    conn.commit();  // Commit transaction trước khi update trạng thái để release lock sớm

                    // Cập nhật trạng thái sau commit (sử dụng cùng conn nhưng autoCommit true)
                    conn.setAutoCommit(true);  // Chuyển sang autoCommit để update riêng
                    updateTrangThaiDay(conn, idGiaoVien);

                    System.out.printf("removeTeacherFromClass1: Successfully removed ID_GiaoVien=%d from ID_LopHoc=%d, Rows affected=%d%n",
                            idGiaoVien, idLopHoc, rowsAffected);
                    return true;
                } else {
                    conn.rollback();
                    System.out.printf("removeTeacherFromClass1: Failed to delete assignment for ID_LopHoc=%d, ID_GiaoVien=%d%n",
                            idLopHoc, idGiaoVien);
                    return false;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in removeTeacherFromClass1: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
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

        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

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

    public static Optional<GiaoVien> findByLopHocId(int idLopHoc) {
        String sql = "SELECT gv.* FROM GiaoVien_LopHoc gl "
                + "JOIN GiaoVien gv ON gl.ID_GiaoVien = gv.ID_GiaoVien "
                + "WHERE gl.ID_LopHoc = ?";
        try (Connection con = DBContext.getInstance().getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idLopHoc);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                GiaoVien gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                return Optional.of(gv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public List<GiaoVien> getAllTeachers() {
        List<GiaoVien> list = new ArrayList<>();
        String sql = "SELECT ID_GiaoVien, HoTen FROM GiaoVien WHERE TrangThai = 'Active' order by IsHot desc"; // Chỉ lấy GV đang hoạt động
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                GiaoVien gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setHoTen(rs.getString("HoTen"));
                list.add(gv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<GiaoVien> getTeachersByCourseId(int courseId) {
        List<GiaoVien> list = new ArrayList<>();
        // Câu lệnh này JOIN các bảng để tìm đúng giáo viên
        String sql = """
        SELECT DISTINCT 
            gv.ID_GiaoVien, 
            gv.HoTen
        FROM 
            GiaoVien gv
        JOIN 
            GiaoVien_LopHoc gvlh ON gv.ID_GiaoVien = gvlh.ID_GiaoVien
        JOIN 
            LopHoc l ON gvlh.ID_LopHoc = l.ID_LopHoc
        WHERE 
            l.ID_KhoaHoc = ?
        ORDER BY
            gv.HoTen
    """;

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                GiaoVien gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setHoTen(rs.getString("HoTen"));
                list.add(gv);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static String getNameGiaoVienToSendSupport(String ID_TaiKhoan) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                             select GV.HoTen from GiaoVien GV
                             join TaiKhoan TK 
                             ON GV.ID_TaiKhoan = TK.ID_TaiKhoan 
                             where GV.ID_TaiKhoan = ? 
                             """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_TaiKhoan);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getString("HoTen");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }
    
    public static boolean adminUpdateInformationOfTeacher(String sdt, int ishot, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        int rs = 0;

        try {
            String sql = """
                             UPDATE GiaoVien 
                             SET 
                             SDT = ?  , 
                             
                             IsHot = ? 
                             where ID_GiaoVien = ? 
                             """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, sdt);

            statement.setInt(2, ishot);
            statement.setInt(3, idGiaoVien);
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
    
    public static String  adminGetTrangThaiDayGiaoVienByID_TaiKhoan(String ID_TaiKhoan) {
       
        DBContext db = DBContext.getInstance() ; 
        try {
            String sql = """
                         select GV.TrangThaiDay from GiaoVien GV 
                         WHERE GV.ID_TaiKhoan = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, ID_TaiKhoan);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()) {
                return rs.getString("TrangThaiDay") ; 
            }
        } catch(SQLException  e) {
            e.printStackTrace();
            return null ; 
        }
        return null ; 
    }
}
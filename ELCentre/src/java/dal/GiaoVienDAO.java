package dal;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien;
import model.GiaoVien_TruongHoc;
import model.LichHoc;

public class GiaoVienDAO {

    private Connection conn;

    public static ArrayList<GiaoVien_TruongHoc> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();
        try {
            String sql = """
                          select * from GiaoVien gv JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
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
                        rs.getString("DiaChi")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in admminGetAllGiaoVien: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        return giaoviens.isEmpty() ? null : giaoviens;
    }

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
                GiaoVien giaovien = new GiaoVien();
                giaovien.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                giaovien.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                giaovien.setHoTen(rs.getString("HoTen"));
                giaovien.setChuyenMon(rs.getString("ChuyenMon"));
                giaovien.setSDT(rs.getString("SDT"));
                giaovien.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                giaovien.setLuong(rs.getBigDecimal("Luong"));
                giaovien.setIsHot(rs.getInt("IsHot"));
                giaovien.setTrangThai(rs.getString("TrangThai"));
                giaovien.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                giaovien.setAvatar(rs.getString("Avatar"));
                giaovien.setBangCap(rs.getString("BangCap"));
                giaovien.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                giaovien.setTrangThaiDay(rs.getString("TrangThaiDay"));
                giaovien.setTenTruongHoc(rs.getString("TenTruongHoc"));
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in HomePageGetGiaoVien: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<GiaoVien>();
        }
        return giaoviens.isEmpty() ? null : giaoviens;
    }

    public GiaoVien getGiaoVienByHoTen(String hoTen) {
        DBContext db = DBContext.getInstance();
        GiaoVien gv = null;
        String sql = """
            SELECT gv.*, th.TenTruongHoc 
            FROM GiaoVien gv 
            JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
            WHERE HoTen COLLATE Latin1_General_CI_AI = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, hoTen.trim());
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                gv.setHoTen(rs.getString("HoTen"));
                gv.setChuyenMon(rs.getString("ChuyenMon"));
                gv.setSDT(rs.getString("SDT"));
                gv.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                gv.setLuong(rs.getBigDecimal("Luong"));
                gv.setIsHot(rs.getInt("IsHot"));
                gv.setTrangThai(rs.getString("TrangThai"));
                gv.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                gv.setAvatar(rs.getString("Avatar"));
                gv.setBangCap(rs.getString("BangCap"));
                gv.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                gv.setTrangThaiDay(rs.getString("TrangThaiDay"));
                gv.setTenTruongHoc(rs.getString("TenTruongHoc"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getGiaoVienByHoTen: " + e.getMessage());
            e.printStackTrace();
        }
        return gv;
    }

    public ArrayList<GiaoVien> getSpecialised() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<>();
        String sql = """
            SELECT gv.*, th.TenTruongHoc 
            FROM GiaoVien gv 
            JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc 
            ORDER BY gv.IsHot ASC
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                GiaoVien gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                gv.setHoTen(rs.getString("HoTen"));
                gv.setChuyenMon(rs.getString("ChuyenMon"));
                gv.setSDT(rs.getString("SDT"));
                gv.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                gv.setLuong(rs.getBigDecimal("Luong"));
                gv.setIsHot(rs.getInt("IsHot"));
                gv.setTrangThai(rs.getString("TrangThai"));
                gv.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                gv.setAvatar(rs.getString("Avatar"));
                gv.setBangCap(rs.getString("BangCap"));
                gv.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                gv.setTrangThaiDay(rs.getString("TrangThaiDay"));
                gv.setTenTruongHoc(rs.getString("TenTruongHoc"));
                giaoviens.add(gv);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getSpecialised: " + e.getMessage());
            e.printStackTrace();
        }
        return giaoviens;
    }

    public static ArrayList<GiaoVien_TruongHoc> adminGetGiaoVienByID(String id) {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();
        try {
            String sql = """
                SELECT * 
                FROM GiaoVien gv 
                JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
                WHERE ID_TaiKhoan = ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
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
                        rs.getString("DiaChi")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in adminGetGiaoVienByID: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        return giaoviens.isEmpty() ? null : giaoviens;
    }

    public static boolean adminEnableGiaoVien(String id) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                UPDATE GiaoVien
                SET TrangThai = 'Active'
                WHERE ID_TaiKhoan = ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            int rs = statement.executeUpdate();
            return rs > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in adminEnableGiaoVien: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static boolean adminDisableGiaoVien(String id) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                UPDATE GiaoVien
                SET TrangThai = 'Inactive'
                WHERE ID_TaiKhoan = ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            int rs = statement.executeUpdate();
            return rs > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in adminDisableGiaoVien: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static int adminGetTongSoGiaoVien() {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM GiaoVien";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in adminGetTongSoGiaoVien: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public static boolean adminUpdateInformationOfTeacher(String sdt, BigDecimal luong, int ishot, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                UPDATE GiaoVien 
                SET SDT = ?, Luong = ?, IsHot = ?
                WHERE ID_GiaoVien = ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, sdt);
            statement.setBigDecimal(2, luong);
            statement.setInt(3, ishot);
            statement.setInt(4, idGiaoVien);
            int rs = statement.executeUpdate();
            return rs > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in adminUpdateInformationOfTeacher: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public double getLuongTheoTaiKhoan(int idTaiKhoan) {
        DBContext db = DBContext.getInstance();
        double luong = -1;
        String sql = """
            SELECT GiaoVien.Luong 
            FROM GiaoVien 
            JOIN TaiKhoan ON GiaoVien.ID_TaiKhoan = TaiKhoan.ID_TaiKhoan
            WHERE GiaoVien.ID_TaiKhoan = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, idTaiKhoan);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                luong = rs.getDouble("Luong");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getLuongTheoTaiKhoan: " + e.getMessage());
            e.printStackTrace();
        }
        return luong;
    }

    public static GiaoVien getGiaoVienByLopHoc(int idLopHoc) {
        GiaoVien giaoVien = null;
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT g.ID_GiaoVien, g.ID_TaiKhoan, g.HoTen, g.ChuyenMon, g.SDT, g.ID_TruongHoc, 
                   g.Luong, g.IsHot, g.TrangThai, g.NgayTao, g.Avatar, g.BangCap, g.LopDangDayTrenTruong, g.TrangThaiDay
            FROM [dbo].[GiaoVien] g
            INNER JOIN [dbo].[GiaoVien_LopHoc] gl ON g.ID_GiaoVien = gl.ID_GiaoVien
            WHERE gl.ID_LopHoc = ?
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idLopHoc);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                giaoVien = new GiaoVien();
                giaoVien.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                giaoVien.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                giaoVien.setHoTen(rs.getString("HoTen"));
                giaoVien.setChuyenMon(rs.getString("ChuyenMon"));
                giaoVien.setSDT(rs.getString("SDT"));
                giaoVien.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                giaoVien.setLuong(rs.getBigDecimal("Luong"));
                giaoVien.setIsHot(rs.getInt("IsHot"));
                giaoVien.setTrangThai(rs.getString("TrangThai"));
                giaoVien.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                giaoVien.setAvatar(rs.getString("Avatar"));
                giaoVien.setBangCap(rs.getString("BangCap"));
                giaoVien.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                giaoVien.setTrangThaiDay(rs.getString("TrangThaiDay"));
            }
            System.out.println("getGiaoVienByLopHoc: Retrieved teacher for ID_LopHoc=" + idLopHoc + (giaoVien != null ? " (found)" : " (not found)"));
        } catch (SQLException e) {
            System.out.println("SQL Error in getGiaoVienByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return giaoVien;
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
            FROM [dbo].[GiaoVien] gv 
            JOIN [dbo].[TruongHoc] th ON gv.ID_TruongHoc = th.ID_TruongHoc 
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
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                GiaoVien giaoVien = new GiaoVien();
                giaoVien.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                giaoVien.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                giaoVien.setHoTen(rs.getString("HoTen"));
                giaoVien.setChuyenMon(rs.getString("ChuyenMon"));
                giaoVien.setSDT(rs.getString("SDT"));
                giaoVien.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                giaoVien.setLuong(rs.getBigDecimal("Luong"));
                giaoVien.setIsHot(rs.getInt("IsHot"));
                giaoVien.setTrangThai(rs.getString("TrangThai"));
                giaoVien.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                giaoVien.setAvatar(rs.getString("Avatar"));
                giaoVien.setBangCap(rs.getString("BangCap"));
                giaoVien.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                giaoVien.setTrangThaiDay(rs.getString("TrangThaiDay"));
                giaoVien.setTenTruongHoc(rs.getString("TenTruongHoc"));
                teachers.add(giaoVien);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getTeachersBySpecialization: " + e.getMessage());
            e.printStackTrace();
        }
        return teachers;
    }

    public boolean assignTeacherToClass(int idLopHoc, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        Connection conn = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Kiểm tra giáo viên tồn tại
            String checkGiaoVienSql = """
                SELECT COUNT(*) 
                FROM [dbo].[GiaoVien] 
                WHERE ID_GiaoVien = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkGiaoVienSql)) {
                stmt.setInt(1, idGiaoVien);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    System.out.println("Giáo viên ID " + idGiaoVien + " không tồn tại hoặc không hoạt động");
                    return false;
                }
            }

            // Kiểm tra lớp học tồn tại
            String checkLopHocSql = """
                SELECT COUNT(*) 
                FROM [dbo].[LopHoc] 
                WHERE ID_LopHoc = ? AND TrangThai = 'Active'
            """;
            try (PreparedStatement stmt = conn.prepareStatement(checkLopHocSql)) {
                stmt.setInt(1, idLopHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next() || rs.getInt(1) == 0) {
                    System.out.println("Lớp học ID " + idLopHoc + " không tồn tại hoặc không hoạt động");
                    return false;
                }
            }

            // Kiểm tra lịch học và xung đột
            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LichHoc> lichHocList = lichHocDAO.getLichHocByLopHoc(idLopHoc);
            if (lichHocList == null || lichHocList.isEmpty()) {
                System.out.println("Lớp học ID " + idLopHoc + " chưa có lịch học");
                return false;
            }
            for (LichHoc lichHoc : lichHocList) {
                if (hasSlotConflict(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc())) {
                    System.out.println("Xung đột khung giờ cho giáo viên ID " + idGiaoVien + " với lớp học ID " + idLopHoc + " vào ngày " + lichHoc.getNgayHoc());
                    return false;
                }
            }

            // Kiểm tra giáo viên đã được phân công
            String checkExistSql = """
                SELECT COUNT(*) 
                FROM [dbo].[GiaoVien_LopHoc] 
                WHERE ID_LopHoc = ? AND ID_GiaoVien = ?
            """;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkExistSql)) {
                checkStmt.setInt(1, idLopHoc);
                checkStmt.setInt(2, idGiaoVien);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    System.out.println("Giáo viên ID " + idGiaoVien + " đã được phân công cho lớp học ID " + idLopHoc);
                    return false;
                }
            }

            // Thêm phân công
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
                    return true;
                }
            }
            conn.rollback();
            return false;
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

    public boolean hasSlotConflict(int idGiaoVien, int idLopHoc, int idSlotHoc, LocalDate ngayHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT sh.SlotThoiGian
            FROM [dbo].[GiaoVien_LopHoc] glh
            JOIN [dbo].[LichHoc] lh ON glh.ID_LopHoc = lh.ID_LopHoc
            JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            WHERE glh.ID_GiaoVien = ? 
            AND glh.ID_LopHoc != ? 
            AND lh.NgayHoc = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setDate(3, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = stmt.executeQuery();

            // Lấy SlotThoiGian của slot mới
            String sqlSlot = """
                SELECT SlotThoiGian 
                FROM [dbo].[SlotHoc] 
                WHERE ID_SlotHoc = ?
            """;
            try (PreparedStatement stmtSlot = conn.prepareStatement(sqlSlot)) {
                stmtSlot.setInt(1, idSlotHoc);
                ResultSet rsSlot = stmtSlot.executeQuery();
                if (rsSlot.next()) {
                    String newSlotThoiGian = rsSlot.getString("SlotThoiGian");
                    if (newSlotThoiGian == null || newSlotThoiGian.trim().isEmpty()) {
                        System.out.println("SlotThoiGian không hợp lệ cho ID_SlotHoc = " + idSlotHoc);
                        return false;
                    }
                    while (rs.next()) {
                        String existingSlotThoiGian = rs.getString("SlotThoiGian");
                        if (existingSlotThoiGian == null || existingSlotThoiGian.trim().isEmpty()) {
                            System.out.println("SlotThoiGian không hợp lệ trong lịch dạy của giáo viên ID " + idGiaoVien);
                            continue;
                        }
                        if (isTimeConflict(newSlotThoiGian, existingSlotThoiGian)) {
                            return true;
                        }
                    }
                } else {
                    System.out.println("Không tìm thấy SlotHoc cho ID_SlotHoc = " + idSlotHoc);
                    return false;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in hasSlotConflict: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public String findConflictingClassName(int idGiaoVien, int idLopHoc, int idSlotHoc, LocalDate ngayHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.TenLopHoc, sh.SlotThoiGian
            FROM [dbo].[GiaoVien_LopHoc] glh
            JOIN [dbo].[LopHoc] lh ON glh.ID_LopHoc = lh.ID_LopHoc
            JOIN [dbo].[LichHoc] lich ON lh.ID_LopHoc = lich.ID_LopHoc
            JOIN [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE glh.ID_GiaoVien = ? 
            AND glh.ID_LopHoc != ? 
            AND lich.NgayHoc = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            stmt.setDate(3, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = stmt.executeQuery();

            // Lấy SlotThoiGian của slot mới
            String sqlSlot = """
                SELECT SlotThoiGian 
                FROM [dbo].[SlotHoc] 
                WHERE ID_SlotHoc = ?
            """;
            try (PreparedStatement stmtSlot = conn.prepareStatement(sqlSlot)) {
                stmtSlot.setInt(1, idSlotHoc);
                ResultSet rsSlot = stmtSlot.executeQuery();
                if (rsSlot.next()) {
                    String newSlotThoiGian = rsSlot.getString("SlotThoiGian");
                    if (newSlotThoiGian == null || newSlotThoiGian.trim().isEmpty()) {
                        System.out.println("SlotThoiGian không hợp lệ cho ID_SlotHoc = " + idSlotHoc);
                        return null;
                    }
                    while (rs.next()) {
                        String tenLopHoc = rs.getString("TenLopHoc");
                        String existingSlotThoiGian = rs.getString("SlotThoiGian");
                        if (existingSlotThoiGian == null || existingSlotThoiGian.trim().isEmpty()) {
                            System.out.println("SlotThoiGian không hợp lệ trong lịch dạy của giáo viên ID " + idGiaoVien + " cho ngày " + ngayHoc);
                            continue;
                        }
                        if (isTimeConflict(newSlotThoiGian, existingSlotThoiGian)) {
                            System.out.println("Phát hiện xung đột khung giờ cho giáo viên ID " + idGiaoVien + " với lớp học '" + tenLopHoc + "' vào ngày " + ngayHoc);
                            return tenLopHoc;
                        }
                    }
                } else {
                    System.out.println("Không tìm thấy SlotHoc cho ID_SlotHoc = " + idSlotHoc);
                    return null;
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in findConflictingClassName: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
        return null;
    }

    private boolean isTimeConflict(String slotThoiGian1, String slotThoiGian2) {
        try {
            if (slotThoiGian1 == null || slotThoiGian2 == null) {
                System.out.println("SlotThoiGian không hợp lệ: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2);
                return false;
            }
            String[] parts1 = slotThoiGian1.trim().split(" đến ");
            String[] parts2 = slotThoiGian2.trim().split(" đến ");
            if (parts1.length != 2 || parts2.length != 2) {
                System.out.println("Định dạng SlotThoiGian không hợp lệ: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2);
                return false;
            }
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("H:mm");
            LocalTime start1 = LocalTime.parse(parts1[0].trim(), timeFormatter);
            LocalTime end1 = LocalTime.parse(parts1[1].trim(), timeFormatter);
            LocalTime start2 = LocalTime.parse(parts2[0].trim(), timeFormatter);
            LocalTime end2 = LocalTime.parse(parts2[1].trim(), timeFormatter);
            return !end1.isBefore(start2) && !start1.isAfter(end2);
        } catch (Exception e) {
            System.out.println("Lỗi phân tích SlotThoiGian: slot1 = " + slotThoiGian1 + ", slot2 = " + slotThoiGian2 + ", error = " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        GiaoVienDAO dao = new GiaoVienDAO();
        double a = dao.getLuongTheoTaiKhoan(11);
        System.out.println("Lương: " + a);
    }
    
     // Lấy danh sách giáo viên theo ID_TruongHoc
    public static List<GiaoVien> getGiaoVienByTruongHoc(int idTruongHoc) {
        List<GiaoVien> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String sql = """
            SELECT ID_GiaoVien, ID_TaiKhoan, HoTen, ChuyenMon, SDT, ID_TruongHoc, 
                   Luong, IsHot, TrangThai, NgayTao, Avatar, BangCap, LopDangDayTrenTruong, TrangThaiDay
            FROM [dbo].[GiaoVien]
            WHERE ID_TruongHoc = ?
            ORDER BY HoTen ASC
        """;

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTruongHoc);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                GiaoVien gv = new GiaoVien();
                gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                gv.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                gv.setHoTen(rs.getString("HoTen"));
                gv.setChuyenMon(rs.getString("ChuyenMon"));
                gv.setSDT(rs.getString("SDT"));
                gv.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                gv.setLuong(rs.getBigDecimal("Luong"));
                gv.setIsHot(rs.getInt("IsHot"));
                gv.setTrangThai(rs.getString("TrangThai"));
                gv.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                gv.setAvatar(rs.getString("Avatar"));
                gv.setBangCap(rs.getString("BangCap"));
                gv.setLopDangDayTrenTruong(rs.getString("LopDangDayTrenTruong"));
                gv.setTrangThaiDay(rs.getString("TrangThaiDay"));
                list.add(gv);
            }
            System.out.println("getGiaoVienByTruongHoc: Retrieved " + list.size() + " teachers for ID_TruongHoc=" + idTruongHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in getGiaoVienByTruongHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
}
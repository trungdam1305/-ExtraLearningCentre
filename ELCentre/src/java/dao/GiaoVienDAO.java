/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author wrx_Chur04
 */
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
        String sql = "SELECT gv.*, th.TenTruongHoc FROM GiaoVien gv "
                + "JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc "
                + "ORDER BY gv.IsHot ASC;";
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

    public static ArrayList<GiaoVien_TruongHoc> adminGetGiaoVienByID(String id) {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();

        try {
            String sql = """
                         select * from GiaoVien gv JOIN TruongHoc th 
                         ON gv.ID_TruongHoc = th.ID_TruongHoc
                         where ID_TaiKhoan = ? 
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
            e.printStackTrace();
            return null;
        }

        if (giaoviens.isEmpty()) {
            return null;
        } else {
            return giaoviens;
        }
    }

    public static boolean adminEnableGiaoVien(String id) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE GiaoVien
                         SET TrangThai = 'Active'
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

    public static int adminGetTongSoGiaoVien() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                         select count(*) from GiaoVien
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

    //Debugging DAO
    public static void main(String[] args) {
        GiaoVienDAO dao = new GiaoVienDAO();
        double a = dao.getLuongTheoTaiKhoan(11);
        System.out.println(a);
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

    public boolean updateTeacherAssignment(int idLopHoc, int idGiaoVien) {
        DBContext db = DBContext.getInstance();

        // Kiểm tra ID hợp lệ
        if (idLopHoc <= 0 || idGiaoVien <= 0) {
            System.out.println("Lỗi: ID không hợp lệ - ID_LopHoc = " + idLopHoc + ", ID_GiaoVien = " + idGiaoVien);
            return false;
        }

        // Kiểm tra giáo viên tồn tại
        String checkGiaoVienSql = "SELECT COUNT(*) FROM GiaoVien WHERE ID_GiaoVien = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(checkGiaoVienSql)) {
            stmt.setInt(1, idGiaoVien);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next() || rs.getInt(1) == 0) {
                System.out.println("Lỗi: Giáo viên ID " + idGiaoVien + " không tồn tại");
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi kiểm tra giáo viên: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }

        // Kiểm tra lớp học tồn tại
        String checkLopHocSql = "SELECT COUNT(*) FROM LopHoc WHERE ID_LopHoc = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(checkLopHocSql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next() || rs.getInt(1) == 0) {
                System.out.println("Lỗi: Lớp học ID " + idLopHoc + " không tồn tại");
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi kiểm tra lớp học: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }

        // Kiểm tra lịch học
        LichHocDAO lichHocDAO = new LichHocDAO();
        LichHoc lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);
        if (lichHoc == null) {
            System.out.println("Lỗi: Không tìm thấy lịch học cho lớp học ID " + idLopHoc);
            return false;
        }

        // Kiểm tra xung đột khung giờ
        if (hasSlotConflict(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc())) {
            System.out.println("Lỗi: Xung đột khung giờ cho giáo viên ID " + idGiaoVien + " với lớp học ID " + idLopHoc);
            return false;
        }

        // Kiểm tra xem có bản ghi để cập nhật không
        String checkExistSql = "SELECT COUNT(*) FROM GiaoVien_LopHoc WHERE ID_LopHoc = ?";
        try (PreparedStatement checkStmt = db.getConnection().prepareStatement(checkExistSql)) {
            checkStmt.setInt(1, idLopHoc);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                // Không có bản ghi, thử thêm mới
                System.out.println("Không có bản ghi phân công cho lớp học ID " + idLopHoc + ", chuyển sang thêm mới");
                return assignTeacherToClass(idLopHoc, idGiaoVien);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi kiểm tra bản ghi phân công: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }

        // Cập nhật phân công
        String sql = "UPDATE GiaoVien_LopHoc SET ID_GiaoVien = ? WHERE ID_LopHoc = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            stmt.setInt(2, idLopHoc);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("Lỗi: Không có hàng nào được cập nhật trong GiaoVien_LopHoc cho ID_LopHoc = " + idLopHoc + ", ID_GiaoVien = " + idGiaoVien);
                return false;
            }
            System.out.println("Thành công: Đã cập nhật " + rowsAffected + " hàng trong GiaoVien_LopHoc");
            return true;
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi cập nhật phân công: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
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

    public boolean assignTeacherToClass(int idLopHoc, int idGiaoVien) {
        DBContext db = DBContext.getInstance();

        // Kiểm tra ID hợp lệ
        if (idLopHoc <= 0 || idGiaoVien <= 0) {
            System.out.println("Lỗi: ID không hợp lệ - ID_LopHoc = " + idLopHoc + ", ID_GiaoVien = " + idGiaoVien);
            return false;
        }

        // Kiểm tra giáo viên tồn tại
        String checkGiaoVienSql = "SELECT COUNT(*) FROM GiaoVien WHERE ID_GiaoVien = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(checkGiaoVienSql)) {
            stmt.setInt(1, idGiaoVien);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next() || rs.getInt(1) == 0) {
                System.out.println("Lỗi: Giáo viên ID " + idGiaoVien + " không tồn tại");
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi kiểm tra giáo viên: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }

        // Kiểm tra lớp học tồn tại
        String checkLopHocSql = "SELECT COUNT(*) FROM LopHoc WHERE ID_LopHoc = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(checkLopHocSql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next() || rs.getInt(1) == 0) {
                System.out.println("Lỗi: Lớp học ID " + idLopHoc + " không tồn tại");
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi kiểm tra lớp học: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }

        // Kiểm tra lịch học
        LichHocDAO lichHocDAO = new LichHocDAO();
        LichHoc lichHoc = lichHocDAO.getLichHocByLopHoc(idLopHoc);
        if (lichHoc == null) {
            System.out.println("Lỗi: Không tìm thấy lịch học cho lớp học ID " + idLopHoc);
            return false;
        }

        // Kiểm tra xung đột khung giờ
        if (hasSlotConflict(idGiaoVien, idLopHoc, lichHoc.getID_SlotHoc(), lichHoc.getNgayHoc())) {
            System.out.println("Lỗi: Xung đột khung giờ cho giáo viên ID " + idGiaoVien + " với lớp học ID " + idLopHoc);
            return false;
        }

        // Kiểm tra giáo viên đã được phân công
        String checkExistSql = "SELECT COUNT(*) FROM GiaoVien_LopHoc WHERE ID_LopHoc = ? AND ID_GiaoVien = ?";
        try (PreparedStatement checkStmt = db.getConnection().prepareStatement(checkExistSql)) {
            checkStmt.setInt(1, idLopHoc);
            checkStmt.setInt(2, idGiaoVien);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("Lỗi: Giáo viên ID " + idGiaoVien + " đã được phân công cho lớp học ID " + idLopHoc);
                return false;
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi kiểm tra phân công: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }

        // Thêm phân công
        String insertSql = "INSERT INTO GiaoVien_LopHoc (ID_LopHoc, ID_GiaoVien) VALUES (?, ?)";
        try (PreparedStatement insertStmt = db.getConnection().prepareStatement(insertSql)) {
            insertStmt.setInt(1, idLopHoc);
            insertStmt.setInt(2, idGiaoVien);
            int rowsAffected = insertStmt.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("Lỗi: Không có hàng nào được thêm vào GiaoVien_LopHoc cho ID_LopHoc = " + idLopHoc + ", ID_GiaoVien = " + idGiaoVien);
                return false;
            }
            System.out.println("Thành công: Đã thêm " + rowsAffected + " hàng vào GiaoVien_LopHoc");
            return true;
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi thêm phân công: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
    }

}

package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.HocSinh;

public class HocSinhDAO {
    
    public static List<HocSinh> adminGetAllHocSinh1() {
        DBContext db = DBContext.getInstance();
        List<HocSinh> hocSinhList = new ArrayList<>();
        String sql = """
            SELECT hs.*, th.TenTruongHoc
            FROM HocSinh hs
            LEFT JOIN TruongHoc th ON hs.ID_TruongHoc = th.ID_TruongHoc
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                HocSinh hocSinh = new HocSinh();
                hocSinh.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hocSinh.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                hocSinh.setHoTen(rs.getString("HoTen"));
                hocSinh.setNgaySinh(rs.getDate("NgaySinh") != null ? rs.getDate("NgaySinh").toLocalDate() : null);
                hocSinh.setGioiTinh(rs.getString("GioiTinh"));
                hocSinh.setDiaChi(rs.getString("DiaChi"));
                hocSinh.setSDT_PhuHuynh(rs.getString("SDT_PhuHuynh"));
                hocSinh.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                hocSinh.setTrangThai(rs.getString("TrangThai"));
                hocSinh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                hocSinh.setTenTruongHoc(rs.getString("TenTruongHoc")); // Lấy tên trường học
                hocSinhList.add(hocSinh);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong adminGetAllHocSinh: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return hocSinhList;
    }

    public static ArrayList<HocSinh> adminGetAllHocSinh() {
        DBContext db = DBContext.getInstance();
        ArrayList<HocSinh> hocsinhs = new ArrayList<>();
        String sql = """
                     select * from HocSinh hs JOIN TruongHoc th
                     ON hs.ID_TruongHoc = th.ID_TruongHoc
                     """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                HocSinh hocsinh = new HocSinh();
                hocsinh.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hocsinh.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                hocsinh.setHoTen(rs.getString("HoTen"));
                hocsinh.setNgaySinh(rs.getDate("NgaySinh") != null ? rs.getDate("NgaySinh").toLocalDate() : null);
                hocsinh.setGioiTinh(rs.getString("GioiTinh"));
                hocsinh.setDiaChi(rs.getString("DiaChi"));
                hocsinh.setSDT_PhuHuynh(rs.getString("SDT_PhuHuynh"));
                hocsinh.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                hocsinh.setGhiChu(rs.getString("GhiChu"));
                hocsinh.setTrangThai(rs.getString("TrangThai"));
                hocsinh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                hocsinh.setTenTruongHoc(rs.getString("TenTruongHoc"));
                hocsinhs.add(hocsinh);
            }
        } catch (SQLException e) {
            // Exception ignored 
        }
        return hocsinhs;
    }

    public static ArrayList<HocSinh> adminGetHocSinhByID(String id) {
        DBContext db = DBContext.getInstance();
        ArrayList<HocSinh> hocsinhs = new ArrayList<>();

        try {
            String sql = """
                         select * from HocSinh hs JOIN TruongHoc th
                         ON hs.ID_TruongHoc = th.ID_TruongHoc
                         where ID_TaiKhoan = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                HocSinh hocsinh = new HocSinh();
                hocsinh.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hocsinh.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                hocsinh.setHoTen(rs.getString("HoTen"));
                hocsinh.setNgaySinh(rs.getDate("NgaySinh") != null ? rs.getDate("NgaySinh").toLocalDate() : null);
                hocsinh.setGioiTinh(rs.getString("GioiTinh"));
                hocsinh.setDiaChi(rs.getString("DiaChi"));
                hocsinh.setSDT_PhuHuynh(rs.getString("SDT_PhuHuynh"));
                hocsinh.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                hocsinh.setGhiChu(rs.getString("GhiChu"));
                hocsinh.setTrangThai(rs.getString("TrangThai"));
                hocsinh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                hocsinh.setTenTruongHoc(rs.getString("TenTruongHoc"));
                hocsinhs.add(hocsinh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (hocsinhs.isEmpty()) {
            return null;
        } else {
            return hocsinhs;
        }
    }

    public static boolean adminEnableHocSinh(String id) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE HocSinh
                         SET TrangThai = 'Active'
                         WHERE ID_TaiKhoan = ?;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs > 0;
    }

    public static boolean adminDisableHocSinh(String id) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE HocSinh
                         SET TrangThai = 'Inactive'
                         WHERE ID_TaiKhoan = ?;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs > 0;
    }

    public static int adminGetTongSoHocSinh() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                          select count(*) from HocSinh
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tong;
    }

    public static int getTotalHocSinh() {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = """
            SELECT COUNT(*) FROM HocSinh
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
        return total;
    }

    public static boolean adminUpdateInformationOfStudent(String diachi, String truonghoc, String ghichu, int id) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE HocSinh
                         SET
                         DiaChi = ?,
                         ID_TruongHoc = ?,
                         GhiChu = ?
                         WHERE
                         ID_HocSinh = ?;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, diachi);
            statement.setString(2, truonghoc);
            statement.setString(3, ghichu);
            statement.setInt(4, id);
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return rs > 0;
    }

    public List<HocSinh> getHocSinhByLopHoc(int idLopHoc) {
        List<HocSinh> hocSinhList = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
                 SELECT hs.*, th.TenTruongHoc
                 FROM HocSinh hs
                 JOIN HocSinh_LopHoc lhh ON hs.ID_HocSinh = lhh.ID_HocSinh
                 LEFT JOIN TruongHoc th ON hs.ID_TruongHoc = th.ID_TruongHoc
                 WHERE lhh.ID_LopHoc = ?
                 """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                HocSinh hocSinh = new HocSinh();
                hocSinh.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hocSinh.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                hocSinh.setHoTen(rs.getString("HoTen"));
                hocSinh.setNgaySinh(rs.getDate("NgaySinh") != null ? rs.getDate("NgaySinh").toLocalDate() : null);
                hocSinh.setGioiTinh(rs.getString("GioiTinh"));
                hocSinh.setDiaChi(rs.getString("DiaChi"));
                hocSinh.setSDT_PhuHuynh(rs.getString("SDT_PhuHuynh"));
                hocSinh.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                hocSinh.setGhiChu(rs.getString("GhiChu"));
                hocSinh.setTrangThai(rs.getString("TrangThai"));
                hocSinh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                hocSinh.setTenTruongHoc(rs.getString("TenTruongHoc"));
                hocSinhList.add(hocSinh);
            }
            System.out.println("HocSinhList size for LopHoc ID " + idLopHoc + ": " + hocSinhList.size());
        } catch (SQLException e) {
            System.out.println("SQL Error in getHocSinhByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return hocSinhList;
    }

    public boolean addStudentToClass(int idHocSinh, int idLopHoc) {
    DBContext db = DBContext.getInstance();

    // Check for valid IDs
    if (idHocSinh <= 0 || idLopHoc <= 0) {
        System.out.println("Invalid ID: ID_HocSinh = " + idHocSinh + ", ID_LopHoc = " + idLopHoc);
        return false;
    }

    // Check if student and class exist
    String checkHocSinhSql = "SELECT COUNT(*) FROM HocSinh WHERE ID_HocSinh = ?";
    String checkLopHocSql = "SELECT COUNT(*) FROM LopHoc WHERE ID_LopHoc = ?";
    String checkExistSql = "SELECT COUNT(*) FROM HocSinh_LopHoc WHERE ID_LopHoc = ? AND ID_HocSinh = ?";
    String insertSql = "INSERT INTO HocSinh_LopHoc (ID_LopHoc, ID_HocSinh) VALUES (?, ?)";

    try (PreparedStatement stmt = db.getConnection().prepareStatement(checkHocSinhSql)) {
        stmt.setInt(1, idHocSinh);
        ResultSet rs = stmt.executeQuery();
        if (!rs.next() || rs.getInt(1) == 0) {
            System.out.println("HocSinh ID " + idHocSinh + " does not exist");
            return false;
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in check HocSinh: " + e.getMessage());
        e.printStackTrace();
        return false;
    }

    try (PreparedStatement stmt = db.getConnection().prepareStatement(checkLopHocSql)) {
        stmt.setInt(1, idLopHoc);
        ResultSet rs = stmt.executeQuery();
        if (!rs.next() || rs.getInt(1) == 0) {
            System.out.println("LopHoc ID " + idLopHoc + " does not exist");
            return false;
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in check LopHoc: " + e.getMessage());
        e.printStackTrace();
        return false;
    }

    // Check if student is already in the class
    try (PreparedStatement checkStmt = db.getConnection().prepareStatement(checkExistSql)) {
        checkStmt.setInt(1, idLopHoc);
        checkStmt.setInt(2, idHocSinh);
        ResultSet rs = checkStmt.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
            System.out.println("HocSinh ID " + idHocSinh + " already exists in LopHoc ID " + idLopHoc);
            return false;
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in check student: " + e.getMessage());
        e.printStackTrace();
        return false;
    }

    // Check for school conflict
    if (hasSchoolConflict(idHocSinh, idLopHoc)) {
        System.out.println("School conflict: HocSinh ID " + idHocSinh + " cannot join LopHoc ID " + idLopHoc + " due to same school as teacher");
        return false;
    }

    // Add student to class
    try (PreparedStatement insertStmt = db.getConnection().prepareStatement(insertSql)) {
        insertStmt.setInt(1, idLopHoc);
        insertStmt.setInt(2, idHocSinh);
        int rowsAffected = insertStmt.executeUpdate();
        System.out.println("Rows affected in addStudentToClass: " + rowsAffected);
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("SQL Error in addStudentToClass: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}
    
    public boolean hasSchoolConflict(int idHocSinh, int idLopHoc) {
    DBContext db = DBContext.getInstance();
    String sql = """
        SELECT COUNT(*)
        FROM HocSinh hs
        JOIN GiaoVien_LopHoc glh ON glh.ID_LopHoc = ?
        JOIN GiaoVien g ON glh.ID_GiaoVien = g.ID_GiaoVien
        WHERE hs.ID_HocSinh = ?
        AND hs.ID_TruongHoc = g.ID_TruongHoc
        """;
    try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
        stmt.setInt(1, idLopHoc);
        stmt.setInt(2, idHocSinh);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // Conflict if count > 0
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in hasSchoolConflict: " + e.getMessage());
        e.printStackTrace();
    }
    return false;
}
}

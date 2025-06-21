package dal;

import java.sql.Connection;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien;

public class GiaoVienDAO {

    private Connection conn;

    public static ArrayList<GiaoVien> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();

        try {
            String sql = """
                          select * from GiaoVien gv JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
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
                        rs.getString("GhiChu"),
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
                        rs.getString("GhiChu"),
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
                gv.setGhiChu(rs.getString("GhiChu"));
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
                + "WHERE gv.GhiChu IS NOT NULL;";
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
                gv.setGhiChu(rs.getString("GhiChu"));
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

    public static ArrayList<GiaoVien> adminGetGiaoVienByID(String id) {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();

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
                GiaoVien giaovien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
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

    public static boolean adminUpdateInformationOfTeacher(String sdt, String tenTruong, BigDecimal luong, String ghichu, int idGiaoVien) {
        DBContext db = DBContext.getInstance();

        String getIdTruongSql = "SELECT ID_TruongHoc FROM TruongHoc WHERE TenTruongHoc = ?";
        String updateGiaoVienSql = """
        UPDATE GiaoVien
        SET SDT = ?,
            ID_TruongHoc = ?,
            Luong = ?,
            GhiChu = ?
        WHERE ID_GiaoVien = ?
    """;

        try (
                PreparedStatement getTruongStmt = db.getConnection().prepareStatement(getIdTruongSql); PreparedStatement updateGvStmt = db.getConnection().prepareStatement(updateGiaoVienSql)) {
            // Lấy ID_TruongHoc từ TenTruongHoc
            getTruongStmt.setString(1, tenTruong);
            ResultSet rs = getTruongStmt.executeQuery();

            if (!rs.next()) {
                // Không tìm thấy trường học
                return false;
            }

            int idTruongHoc = rs.getInt("ID_TruongHoc");

            // Tiến hành cập nhật giáo viên
            updateGvStmt.setString(1, sdt);
            updateGvStmt.setInt(2, idTruongHoc);
            updateGvStmt.setBigDecimal(3, luong);
            updateGvStmt.setString(4, ghichu);
            updateGvStmt.setInt(5, idGiaoVien);

            int affected = updateGvStmt.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// Phương thức lấy thông tin giáo viên dựa trên ID_LopHoc
    public GiaoVien getGiaoVienByLopHoc(int idLopHoc) {
        GiaoVien giaoVien = null;
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT gv.*
            FROM GiaoVien gv
            JOIN LopHoc_GiaoVien lhg ON gv.ID_GiaoVien = lhg.ID_GiaoVien
            WHERE lhg.ID_LopHoc = ?
            LIMIT 1
        """;
        List<Object> params = new ArrayList<>();
        params.add(idLopHoc);
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                giaoVien = new GiaoVien();
                giaoVien.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                giaoVien.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                giaoVien.setHoTen(rs.getString("HoTen"));
                giaoVien.setChuyenMon(rs.getString("ChuyenMon"));
                giaoVien.setSDT(rs.getString("SDT"));
                giaoVien.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                giaoVien.setLuong(rs.getBigDecimal("Luong"));
                giaoVien.setGhiChu(rs.getString("GhiChu"));
                giaoVien.setTrangThai(rs.getString("TrangThai"));
                giaoVien.setNgayTao(rs.getObject("NgayTao", LocalDateTime.class));
                giaoVien.setAvatar(rs.getString("Avatar"));
                // TenTruongHoc không có trong truy vấn, cần lấy từ bảng khác nếu cần
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return giaoVien;
    }
    
    // Lấy danh sách giáo viên dựa trên chuyên môn gần giống tên khóa học
    public List<GiaoVien> getTeachersBySpecialization(String tenKhoaHoc) {
        List<GiaoVien> teachers = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT *
            FROM GiaoVien
            WHERE LOWER(ChuyenMon) LIKE ? AND TrangThai = 'Active'
        """;
        List<Object> params = new ArrayList<>();
        params.add("%" + tenKhoaHoc.toLowerCase() + "%");
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
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
                giaoVien.setGhiChu(rs.getString("GhiChu"));
                giaoVien.setTrangThai(rs.getString("TrangThai"));
                giaoVien.setNgayTao(rs.getObject("NgayTao", LocalDateTime.class));
                giaoVien.setAvatar(rs.getString("Avatar"));
                teachers.add(giaoVien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teachers;
    }

    // Gán giáo viên vào lớp học
    public boolean assignTeacherToClass(int idLopHoc, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO LopHoc_GiaoVien (ID_LopHoc, ID_GiaoVien)
            VALUES (?, ?)
            ON DUPLICATE KEY UPDATE ID_GiaoVien = VALUES(ID_GiaoVien)
        """;
        List<Object> params = new ArrayList<>();
        params.add(idLopHoc);
        params.add(idGiaoVien);
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật phân công giáo viên cho lớp học
    public boolean updateTeacherAssignment(int idLopHoc, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE LopHoc_GiaoVien 
            SET ID_GiaoVien = ?
            WHERE ID_LopHoc = ?
        """;
        List<Object> params = new ArrayList<>();
        params.add(idGiaoVien);
        params.add(idLopHoc);
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
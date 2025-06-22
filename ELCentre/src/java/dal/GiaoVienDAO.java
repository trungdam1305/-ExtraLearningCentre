package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import model.GiaoVien;

public class GiaoVienDAO {

    private Connection conn;

    public static ArrayList<GiaoVien> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<>();

        try {
            String sql = """
                         SELECT gv.*, th.TenTruongHoc 
                         FROM GiaoVien gv 
                         JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
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
                        rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null,
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }

        return giaoviens;
    }

    public ArrayList<GiaoVien> HomePageGetGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<>();

        try {
            String sql = """
                         SELECT gv.*, th.TenTruongHoc 
                         FROM GiaoVien gv 
                         LEFT JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
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
                        rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null,
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }

        return giaoviens;
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
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setString(1, hoTen.trim());
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                gv = new GiaoVien(
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
        } catch (SQLException e) {
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
                     WHERE gv.IsHot = 1
                     """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                GiaoVien gv = new GiaoVien(
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
                giaoviens.add(gv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return giaoviens;
    }

    public static ArrayList<GiaoVien> adminGetGiaoVienByID(String id) {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<>();

        try {
            String sql = """
                         SELECT gv.*, th.TenTruongHoc 
                         FROM GiaoVien gv 
                         JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc 
                         WHERE ID_TaiKhoan = ?
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
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null,
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                );
                giaoviens.add(giaovien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }

        return giaoviens;
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
            e.printStackTrace();
            return false;
        }
    }

    public static int adminGetTongSoGiaoVien() {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         SELECT COUNT(*) 
                         FROM GiaoVien
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static boolean adminUpdateInformationOfTeacher(String sdt, String tenTruong, BigDecimal luong, int isHot, int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        String getIdTruongSql = "SELECT ID_TruongHoc FROM TruongHoc WHERE TenTruongHoc = ?";
        String updateGiaoVienSql = """
                                  UPDATE GiaoVien 
                                  SET SDT = ?, ID_TruongHoc = ?, Luong = ?, IsHot = ? 
                                  WHERE ID_GiaoVien = ?
                                  """;

        try (
                PreparedStatement getTruongStmt = db.getConnection().prepareStatement(getIdTruongSql); PreparedStatement updateGvStmt = db.getConnection().prepareStatement(updateGiaoVienSql)) {
            getTruongStmt.setString(1, tenTruong);
            ResultSet rs = getTruongStmt.executeQuery();

            if (!rs.next()) {
                return false;
            }

            int idTruongHoc = rs.getInt("ID_TruongHoc");

            updateGvStmt.setString(1, sdt);
            updateGvStmt.setInt(2, idTruongHoc);
            updateGvStmt.setBigDecimal(3, luong);
            updateGvStmt.setInt(4, isHot);
            updateGvStmt.setInt(5, idGiaoVien);

            int affected = updateGvStmt.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
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

   public boolean assignTeacherToClass(int idLopHoc, int idGiaoVien) {
    DBContext db = DBContext.getInstance();

    // Kiểm tra ID hợp lệ
    if (idLopHoc <= 0 || idGiaoVien <= 0) {
        System.out.println("Invalid ID: ID_LopHoc = " + idLopHoc + ", ID_GiaoVien = " + idGiaoVien);
        return false;
    }

    // Kiểm tra giáo viên và lớp học tồn tại
    String checkGiaoVienSql = """
                             SELECT COUNT(*) FROM GiaoVien WHERE ID_GiaoVien = ?
                             """;
    String checkLopHocSql = """
                            SELECT COUNT(*) FROM LopHoc WHERE ID_LopHoc = ?
                            """;
    String checkExistSql = """
                           SELECT COUNT(*) FROM GiaoVien_LopHoc 
                           WHERE ID_LopHoc = ? AND ID_GiaoVien = ?
                           """;
    String insertSql = """
                       INSERT INTO GiaoVien_LopHoc (ID_LopHoc, ID_GiaoVien)
                       VALUES (?, ?)
                       """; // Loại bỏ ON DUPLICATE KEY UPDATE để kiểm tra lỗi rõ ràng

    try (PreparedStatement stmt = db.getConnection().prepareStatement(checkGiaoVienSql)) {
        stmt.setInt(1, idGiaoVien);
        ResultSet rs = stmt.executeQuery();
        if (!rs.next() || rs.getInt(1) == 0) {
            System.out.println("GiaoVien ID " + idGiaoVien + " does not exist");
            return false;
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in check GiaoVien: " + e.getMessage());
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

    try (PreparedStatement checkStmt = db.getConnection().prepareStatement(checkExistSql)) {
        checkStmt.setInt(1, idLopHoc);
        checkStmt.setInt(2, idGiaoVien);
        ResultSet rs = checkStmt.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
            System.out.println("GiaoVien ID " + idGiaoVien + " already exists in LopHoc ID " + idLopHoc);
            return false; // Trả về false để báo lỗi trùng lặp
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in check teacher: " + e.getMessage());
        e.printStackTrace();
        return false;
    }

    try (PreparedStatement insertStmt = db.getConnection().prepareStatement(insertSql)) {
        insertStmt.setInt(1, idLopHoc);
        insertStmt.setInt(2, idGiaoVien);
        int rowsAffected = insertStmt.executeUpdate();
        System.out.println("Rows affected in assignTeacherToClass: " + rowsAffected);
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("SQL Error in assignTeacherToClass: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
}

public boolean updateTeacherAssignment(int idLopHoc, int idGiaoVien) {
    DBContext db = DBContext.getInstance();
    String sql = """
                 UPDATE GiaoVien_LopHoc 
                 SET ID_GiaoVien = ? 
                 WHERE ID_LopHoc = ?
                 """;
    try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
        stmt.setInt(1, idGiaoVien);
        stmt.setInt(2, idLopHoc);
        int rowsAffected = stmt.executeUpdate();
        System.out.println("Rows affected in updateTeacherAssignment: " + rowsAffected);
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("SQL Error in updateTeacherAssignment: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
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

    

}

package dao;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.HocSinh;

public class HocSinhDAO {

    public static ArrayList<HocSinh> adminGetAllHocSinh() {
        DBContext db = DBContext.getInstance();
        ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>();
        String sql = """
                         select * from HocSinh hs JOIN TruongHoc th
                         ON hs.ID_TruongHoc = th.ID_TruongHoc
                         """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                HocSinh hocsinh = new HocSinh(
                        rs.getInt("ID_HocSinh"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getDate("NgaySinh").toLocalDate(),
                        rs.getString("GioiTinh"),
                        rs.getString("DiaChi"),
                        rs.getString("SDT_PhuHuynh"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("TenTruongHoc")
                );
                hocsinhs.add(hocsinh);
            }
        } catch (SQLException e) {
            // Exception ignored 
        }
        return hocsinhs;
    }

    public static ArrayList<HocSinh> adminGetAllHocSinh1() {
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
        ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>();

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
                HocSinh hocsinh = new HocSinh(
                        rs.getInt("ID_HocSinh"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getDate("NgaySinh").toLocalDate(),
                        rs.getString("GioiTinh"),
                        rs.getString("DiaChi"),
                        rs.getString("SDT_PhuHuynh"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("TenTruongHoc")
                );
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
        if (rs == 0) {
            return false;
        } else {
            return true;
        }
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
        if (rs == 0) {
            return false;
        } else {
            return true;
        }
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
                return tong;
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
        } catch (Exception e) {
            return 0; // hoặc có thể trả về -1 để phân biệt có lỗi
        }
        return total;
    }

    public static boolean adminUpdateInformationOfStudent(String diachi, String ghichu, int id) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                         UPDATE HocSinh
                         SET
                        
                        DiaChi = ?,
                       
                        GhiChu = ?
                         WHERE
                         ID_HocSinh = ?;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, diachi);

            statement.setString(2, ghichu);
            statement.setInt(3, id);

            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        if (rs == 0) {
            return false;
        } else {
            return true;
        }
    }

    public static List<String> nameofStudentDependPH(String idPhuHuynh) {
        List<String> ListName = new ArrayList<String>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                         select HS.HoTen from HocSinh HS
                         join PhuHuynh PH 
                         on HS.ID_HocSinh = PH.ID_HocSinh 
                         where PH.ID_TaiKhoan = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, idPhuHuynh);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("HoTen");
                ListName.add(name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (ListName == null) {
            return null;
        } else {
            return ListName;
        }
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

    public boolean isStudentInClass(int idHocSinh, int idLopHoc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM HocSinh_LopHoc WHERE ID_HocSinh = ? AND ID_LopHoc = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idHocSinh);
            stmt.setInt(2, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
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

    public boolean removeStudentFromClass(int idHocSinh, int idLopHoc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM HocSinh_LopHoc WHERE ID_HocSinh = ? AND ID_LopHoc = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idHocSinh);
            stmt.setInt(2, idLopHoc);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public void insertHocSinh(HocSinh hs) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = """
                     INSERT INTO HocSinh (ID_TaiKhoan, HoTen, NgaySinh, GioiTinh, DiaChi, SDT_PhuHuynh, TruongHoc, GhiChu, TrangThai, NgayTao)
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                     """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql) ) {
            statement.setInt(1, hs.getID_TaiKhoan());
            statement.setString(2, hs.getHoTen());
        
            if (hs.getNgaySinh() != null) {
                statement.setDate(3, java.sql.Date.valueOf(hs.getNgaySinh()));
            } else {
                statement.setNull(3, java.sql.Types.DATE);
            }

            if (hs.getGioiTinh() != null) {
                statement.setString(4, hs.getGioiTinh());
            } else {
                statement.setNull(4, java.sql.Types.VARCHAR);
            }

            if (hs.getDiaChi() != null) {
                statement.setString(5, hs.getDiaChi());
            } else {
                statement.setNull(5, java.sql.Types.VARCHAR);
            }

            if (hs.getSDT_PhuHuynh() != null) {
                statement.setString(6, hs.getSDT_PhuHuynh());
            } else {
                statement.setNull(6, java.sql.Types.VARCHAR);
            }

            if (hs.getTenTruongHoc() != null) {
                statement.setString(7, hs.getTenTruongHoc());
            } else {
                statement.setNull(7, java.sql.Types.VARCHAR);
            }

            if (hs.getGhiChu() != null) {
                statement.setString(8, hs.getGhiChu());
            } else {
                statement.setNull(8, java.sql.Types.VARCHAR);
            }

            statement.setString(9, hs.getTrangThai());

            if (hs.getNgayTao() != null) {
                statement.setTimestamp(10, java.sql.Timestamp.valueOf(hs.getNgayTao()));
            } else {
                statement.setNull(10, java.sql.Types.TIMESTAMP);
            }

            statement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        int a = getTotalHocSinh();
        System.out.println(a);
    }
}

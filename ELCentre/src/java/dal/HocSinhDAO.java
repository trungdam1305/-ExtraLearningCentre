
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement ;
import java.sql.ResultSet ;
import java.sql.SQLException ;
import java.util.ArrayList ; 
import model.HocSinh ; 
import model.TaiKhoan;

public class HocSinhDAO {
    public static ArrayList<HocSinh> adminGetAllHocSinh(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>() ; 
        String sql = """
                         select * from HocSinh 
                         """ ; 
            try (PreparedStatement statement = db.getConnection().prepareStatement(sql);
                 ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    HocSinh hocsinh = new HocSinh(
                            rs.getInt("ID_HocSinh"), 
                            rs.getInt("ID_TaiKhoan") , 
                            rs.getString("HoTen") , 
                            rs.getDate("NgaySinh").toLocalDate(),
                            rs.getString("GioiTinh") , 
                            rs.getString("DiaChi") , 
                            rs.getString("SDT_PhuHuynh") , 
                            rs.getString("TruongHoc") , 
                            rs.getString("GhiChu") , 
                            rs.getString("TrangThai") , 
                            rs.getTimestamp("NgayTao").toLocalDateTime()
                    ) ; 
                    hocsinhs.add(hocsinh) ; 
                }
            }
        catch  (SQLException e ) {
            // Exception ignored 
        }
            return hocsinhs ; 
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
    
    public static ArrayList<HocSinh> adminGetHocSinhByID(String id) {
        DBContext db = DBContext.getInstance();
        ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>();

        try {
            String sql = """
                         select * from HocSinh
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
                        rs.getString("TruongHoc"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime()
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

    public static HocSinh getByTaiKhoanId(int idTaiKhoan) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM HocSinh WHERE ID_TaiKhoan = ?";
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idTaiKhoan);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HocSinh hs = new HocSinh();
                    hs.setID_HocSinh(rs.getInt("ID_HocSinh"));
                    hs.setHoTen(rs.getString("HoTen"));
                    //hs.setNgaySinh(rs.getDate("NgaySinh"));
                    hs.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                    return hs;
                }
            }
        }
        return null;
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

            if (hs.getTruongHoc() != null) {
                statement.setString(7, hs.getTruongHoc());
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

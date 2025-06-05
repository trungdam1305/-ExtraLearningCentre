
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.PreparedStatement ;
import java.sql.ResultSet ;
import java.sql.SQLException ;
import java.util.ArrayList ; 
import model.HocSinh ; 

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
    
    public static void main(String[] args) {
        int a = getTotalHocSinh();
        System.out.println(a);
    }
}

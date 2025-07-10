package dal;

/**
 *
 * @author wrx_Chur04
 */

import model.ThongBao;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime ; 

public class ThongBaoDAO {

    public static ArrayList<ThongBao> adminXemThongBao() {
        ArrayList<ThongBao> thongbaos = new ArrayList<ThongBao>();

        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select * from ThongBao 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                ThongBao thongbao = new ThongBao(
                        rs.getInt("ID_ThongBao"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("NoiDung"),
                        rs.getInt("ID_HocPhi"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime()
                ) ; 
                thongbaos.add(thongbao) ; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
                    return null;
        }
        
        if (thongbaos.isEmpty()){
            return null ; 
        } else {
               return thongbaos ; 
        }
    }
    
    public static void insertThongBaoTuVan(String noiDung) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO ThongBao (ID_TaiKhoan, NoiDung, ID_HocPhi, ThoiGian) " + "VALUES (?, ?, ?, GETDATE())";
        
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)){
            ps.setNull(1, java.sql.Types.INTEGER);
            ps.setString(2, noiDung);
            ps.setNull(3, java.sql.Types.INTEGER);
            ps.executeUpdate();
        }
    }
    
    public static ThongBao getThongBaoById(int id) {
        DBContext db = DBContext.getInstance();
        ThongBao tb = null;
        
        try {
            String sql = "SELECT * FROM ThongBao WHERE ID_ThongBao = ?";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                tb = new ThongBao(
                rs.getInt("ID_ThongBao"),
                rs.getInt("ID_TaiKhoan"),
                rs.getString("noiDung"),
                rs.getInt("ID_HocPhi"),
                rs.getTimestamp("ThoiGian").toLocalDateTime()
                );
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return tb;
    }
    
    public static ArrayList<ThongBao> getAllTuVan() {
        ArrayList<ThongBao> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM ThongBao WHERE NoiDung LIKE N'%tư vấn%' ORDER BY ThoiGian DESC";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ThongBao tb = new ThongBao(
                    rs.getInt("ID_ThongBao"),
                    rs.getInt("ID_TaiKhoan"),
                    rs.getString("NoiDung"),
                    rs.getInt("ID_HocPhi"),
                    rs.getTimestamp("ThoiGian").toLocalDateTime()
                );
                list.add(tb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static boolean adminSendNotification(String ID_TaiKhoan , String NoiDung ) {
        int rs = 0 ;
        DBContext db = DBContext.getInstance() ; 
        LocalDateTime now = LocalDateTime.now() ; 
        try {
            String sql = """
                         insert into ThongBao(ID_TaiKhoan , NoiDung , ThoiGian )
                         values ( ?  , ? , ? ) 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1 , ID_TaiKhoan);
            statement.setString(2, NoiDung);
            statement.setTimestamp(3, Timestamp.valueOf(now));
           rs = statement.executeUpdate(); 
          while(rs > 0 ) {
              return true ; 
          }
        } catch (SQLException e ) {
            e.printStackTrace();
            
        }
        return false ; 
    }
}

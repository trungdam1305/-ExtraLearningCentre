
package dao;

/**
 *
 * @author wrx_Chur04
 */
import java.math.BigDecimal;
import java.sql.SQLException ; 
import java.util.ArrayList ; 
import java.sql.ResultSet ; 
import java.sql.PreparedStatement ; 
import model.PhuHuynh ; 
public class PhuHuynhDAO {
    public static ArrayList<PhuHuynh> adminGetPhuHuynhByID(String id) {
        ArrayList<PhuHuynh> phuhuynhs = new ArrayList<PhuHuynh>() ; 
        DBContext db = DBContext.getInstance() ; 
        
        try {
            String sql = """
                         select * from PhuHuynh
                         where ID_TaiKhoan = ? 
                         """ ; 
            
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery() ; 
            
            while(rs.next()){
                PhuHuynh phuhuynh = new PhuHuynh(
                        rs.getInt("ID_PhuHuynh") , 
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getString("HoTen") , 
                        rs.getString("SDT") , 
                        rs.getString("Email") , 
                        rs.getString("DiaChi") , 
                        rs.getString("GhiChu") , 
                        rs.getInt("ID_HocSinh") ,
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime()
                
                
                ) ; 
                phuhuynhs.add(phuhuynh) ; 
            }
        } catch (SQLException e ){
            e.printStackTrace();
            return null ; 
        }
        
        if (phuhuynhs.isEmpty()){
            return null ; 
        } else {
            return phuhuynhs  ; 
        }
    }
    public static boolean adminEnablePhuHuynh(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE PhuHuynh
                         SET TrangThai = 'Active'
                         WHERE ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ) {
            e.printStackTrace();
             
        }
        if (rs == 0 ){
            return false ; 
        } else {
            return true ; 
        }
    }
    
    public static boolean adminDisablePhuHuynh(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE PhuHuynh
                         SET TrangThai = 'Inactive'
                         WHERE ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ) {
            e.printStackTrace();
             
        }
        if (rs == 0 ){
            return false ; 
        } else {
            return true ; 
        }
    }
    
    
    public static boolean adminUpdateInformationOfParent(String sdt , String diachi  , String ghichu , int id){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE PhuHuynh
                         SET
                        SDT = ?,
                        DiaChi = ?,
                        
                        GhiChu = ?
                         WHERE
                         ID_PhuHuynh = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1 , sdt);
            statement.setString(2 , diachi) ; 
            
            statement.setString(3, ghichu);
            statement.setInt(4, id);
            
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ){
            e.printStackTrace();
            return false ; 
        }
        
        if (rs == 0 ) {
            return false ; 
        } else {
               return true ; 
        }
    }
}


package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.math.BigDecimal;
import java.sql.PreparedStatement ;
import java.sql.ResultSet ;
import java.sql.SQLException ; 
import java.util.ArrayList ;
import model.TaiKhoan ; 
public class TaiKhoanDAO {
    
    public static ArrayList<TaiKhoan> adminGetAllTaiKhoan(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<TaiKhoan> taikhoans = new ArrayList<TaiKhoan>() ; 
        
        try {
            String sql  = """
                          select * from TaiKhoan 
                          WHERE UserType != 'Staff' AND UserType != 'Admin'
                          """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            
            while (rs.next()) {
                TaiKhoan tk = new TaiKhoan(
                        rs.getInt("ID_TaiKhoan") ,  
                        rs.getString("Email") , 
                        rs.getString("MatKhau") , 
                        rs.getInt("ID_VaiTro") , 
                        rs.getString("UserType") , 
                        rs.getString("SoDienThoai") , 
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime() 
                        
                
                ) ; 
                taikhoans.add(tk) ; 
            }
        } catch (SQLException e ) {
            
            return null ; 
        }
        if (taikhoans.isEmpty()){
            return null ; 
        } else {
            return taikhoans ; 
        }
    }
    
    public static boolean adminDisableAccountUser(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
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
    
    
    public static boolean adminEnableAccountUser(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
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
    
    public static boolean adminEnableSatff(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE Staff
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
    
    public static boolean adminUpdateInformationAccount(String sdt ,  int id){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
                         SET
                        SoDienThoai = ?
                        
                         WHERE
                         ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1 , sdt);
            
            statement.setInt(2, id);
            
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


package dal;

/**
 *
 * @author wrx_Chur04
 */
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
            //Exception ignored
            return null ; 
        }
        if (taikhoans.isEmpty()){
            return null ; 
        } else {
            return taikhoans ; 
        }
    }
}

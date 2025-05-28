
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.Connection ; 
import java.sql.PreparedStatement ; 
import java.sql.SQLException ; 
import model.TaiKhoan ; 
import java.sql.ResultSet ; 
import java.util.ArrayList ; 
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
            e.printStackTrace();
            return null ; 
        }
        if (taikhoans.isEmpty()){
            return null ; 
        } else {
            return taikhoans ; 
        }
    }
}

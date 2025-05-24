
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.Connection ; 
import java.sql.SQLException ; 
import java.sql.ResultSet ; 
import java.sql.PreparedStatement ; 
import java.util.ArrayList ; 
import model.HocSinh ; 

public class HocSinhDAO {
    public static ArrayList<HocSinh> adminGetAllHocSinh(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<HocSinh> hocsinhs = new ArrayList<HocSinh>() ; 
        
        try {
            String sql = """
                         select * from HocSinh 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            
            while (rs.next()) {
                HocSinh hocsinh = new HocSinh(
                        rs.getInt("ID_HocSinh"), 
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getInt("ID_LopHoc") ,
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
        } catch  (SQLException e ) {
            e.printStackTrace(); 
            return null ; 
        }
        
        if (hocsinhs.isEmpty()){
            return null ; 
        } else {
            return hocsinhs ; 
        }
    }
    
    
}

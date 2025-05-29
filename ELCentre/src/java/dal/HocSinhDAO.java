
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
    
    
}

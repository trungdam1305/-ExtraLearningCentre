
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.util.ArrayList ; 
import java.sql.SQLException ; 
import java.sql.PreparedStatement ; 
import java.sql.ResultSet ; 
import model.KhoaHoc ; 
public class KhoaHocDAO {
    public static ArrayList<KhoaHoc> adminGetAllKhoaHoc(){
        ArrayList<KhoaHoc> khoahocs = new ArrayList<KhoaHoc>() ; 
        DBContext db = DBContext.getInstance() ; 
        try {
            String sql = """
                         select * from KhoaHoc 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                KhoaHoc khoahoc = new KhoaHoc(
                        rs.getInt("ID_KhoaHoc") , 
                        rs.getString("TenKhoaHoc") , 
                        rs.getString("MoTa") , 
                        rs.getDate("ThoiGianBatDau").toLocalDate() , 
                        rs.getDate("ThoiGianKetThuc").toLocalDate() ,  
                        rs.getString("GhiChu") , 
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime()
                
                
                ) ; 
                khoahocs.add(khoahoc) ; 
            }
        } catch (SQLException e){
            e.printStackTrace();
            return null ; 
        }
        
        if (khoahocs.isEmpty()){
            return null ; 
        } else {
            return khoahocs ; 
        }
    }
}

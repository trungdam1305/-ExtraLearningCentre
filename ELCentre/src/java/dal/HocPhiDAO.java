package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import model.HocPhi;

public class HocPhiDAO {

    private HocPhiDAO() {

    }

    public static ArrayList<HocPhi> adminGetHocPhi() {
        DBContext db = DBContext.getInstance();
        ArrayList<HocPhi> hocphis = new ArrayList<HocPhi>();

        try {
            String sql = """
                         select * from HocPhi
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                
                HocPhi hocphi = new HocPhi(
                        rs.getInt("ID_HocPhi"),
                        rs.getInt("ID_HocSinh"),
                        rs.getInt("ID_LopHoc"),
                        rs.getString("MonHoc"),
                        rs.getString("PhuongThucThanhToan"),
                        rs.getString("TinhTrangThanhToan"),
                                    rs.getDate("NgayThanhToan") != null ? rs.getDate("NgayThanhToan").toLocalDate() : null, 
                        rs.getString("GhiChu")
                );

                hocphis.add(hocphi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (hocphis.isEmpty()) {
            return null;
        } else {
              return hocphis;
        }
    }
}


package dal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.LopHoc;

public class LopHocDAO {

    public List<LopHoc> getAllLopHoc() {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT [ID_LopHoc], [TenLopHoc], [ID_KhoaHoc], [SiSo], [ThoiGianHoc], [GhiChu], [TrangThai], [SoTien], [NgayTao] FROM [dbo].[LopHoc]";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                rs.getTimestamp("NgayTao").toLocalDateTime();
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        List<LopHoc> lop = new LopHocDAO().getAllLopHoc();
        for (LopHoc lops : lop){
            System.out.println(lops.getID_KhoaHoc() + " " + lops.getID_LopHoc() + " "+ lops.getTenLopHoc());
        }
    }
}

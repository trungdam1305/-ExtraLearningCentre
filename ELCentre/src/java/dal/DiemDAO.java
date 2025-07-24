
package dal;

import model.Diem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author vkhan
 */
public class DiemDAO {
    public static Diem getDiemByHocSinhAndLop(int idHocSinh, int idLopHoc) {
    String sql = "SELECT * FROM Diem WHERE ID_HocSinh = ? AND ID_LopHoc = ?";
    try (Connection conn = DBContext.getInstance().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, idHocSinh);
        ps.setInt(2, idLopHoc);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                Diem diem = new Diem();
                diem.setID_Diem(rs.getInt("ID_Diem"));
                diem.setID_HocSinh(rs.getInt("ID_HocSinh"));
                diem.setID_LopHoc(rs.getInt("ID_LopHoc"));
                diem.setDiemKiemTra(rs.getBigDecimal("DiemKiemTra"));
                diem.setDiemBaiTap(rs.getBigDecimal("DiemBaiTap"));
                diem.setDiemGiuaKy(rs.getBigDecimal("DiemGiuaKy"));
                diem.setDiemCuoiKy(rs.getBigDecimal("DiemCuoiKy"));
                diem.setDiemTongKet(rs.getBigDecimal("DiemTongKet"));
                diem.setThoiGianCapNhat(rs.getTimestamp("ThoiGianCapNhat").toLocalDateTime());
                return diem;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

}

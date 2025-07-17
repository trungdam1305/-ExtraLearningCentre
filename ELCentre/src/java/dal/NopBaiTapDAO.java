package dal;

import model.NopBaiTapInfo;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NopBaiTapDAO {

    public List<NopBaiTapInfo> getSubmissionsByAssignmentId(int assignmentId) {
        List<NopBaiTapInfo> list = new ArrayList<>();
        String sql = "SELECT hs.HoTen, hs.MaHocSinh, nbt.* FROM NopBaiTap nbt " +
                     "JOIN HocSinh hs ON nbt.ID_HocSinh = hs.ID_HocSinh " +
                     "WHERE nbt.ID_BaiTap = ? ORDER BY nbt.NgayNop";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NopBaiTapInfo sub = new NopBaiTapInfo();
                    sub.setHoTen(rs.getString("HoTen"));
                    sub.setMaHocSinh(rs.getString("MaHocSinh"));
                    sub.setID_HocSinh(rs.getInt("ID_HocSinh"));
                    sub.setID_BaiTap(rs.getInt("ID_BaiTap"));
                    sub.setTepNop(rs.getString("TepNop"));
                    sub.setNgayNop(rs.getDate("NgayNop").toLocalDate());
                    sub.setDiem(rs.getBigDecimal("Diem"));
                    sub.setNhanXet(rs.getString("NhanXet"));
                    list.add(sub);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void updateGradeAndComment(int assignmentId, int studentId, BigDecimal grade, String comment) {
        String sql = "UPDATE NopBaiTap SET Diem = ?, NhanXet = ? WHERE ID_BaiTap = ? AND ID_HocSinh = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, grade);
            ps.setString(2, comment);
            ps.setInt(3, assignmentId);
            ps.setInt(4, studentId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}
package dal;

import model.NopBaiTap; // Import NopBaiTap
import model.NopBaiTapInfo;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
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

    /**
     * Thêm một bài nộp mới vào cơ sở dữ liệu.
     */
    public void addSubmission(NopBaiTap submission) {
        String sql = "INSERT INTO NopBaiTap (ID_HocSinh, ID_BaiTap, TepNop, NgayNop, Diem, NhanXet, ID_LopHoc) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, submission.getID_HocSinh());
            ps.setInt(2, submission.getID_BaiTap());
            ps.setString(3, submission.getTepNop());
            ps.setDate(4, java.sql.Date.valueOf(submission.getNgayNop()));
            ps.setBigDecimal(5, submission.getDiem()); // Can be null
            ps.setString(6, submission.getNhanXet()); // Can be null
            ps.setInt(7, submission.getID_LopHoc());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật thông tin bài nộp đã tồn tại.
     */
    public void updateSubmission(NopBaiTap submission) {
        String sql = "UPDATE NopBaiTap SET TepNop = ?, NgayNop = ?, Diem = ?, NhanXet = ? WHERE ID_HocSinh = ? AND ID_BaiTap = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, submission.getTepNop());
            ps.setDate(2, java.sql.Date.valueOf(submission.getNgayNop()));
            ps.setBigDecimal(3, submission.getDiem());
            ps.setString(4, submission.getNhanXet());
            ps.setInt(5, submission.getID_HocSinh());
            ps.setInt(6, submission.getID_BaiTap());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy bài nộp của một học sinh cho một bài tập cụ thể.
     */
    public NopBaiTap getSubmissionByStudentAndAssignment(int studentId, int assignmentId) {
        String sql = "SELECT * FROM NopBaiTap WHERE ID_HocSinh = ? AND ID_BaiTap = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    NopBaiTap submission = new NopBaiTap();
                    submission.setID_HocSinh(rs.getInt("ID_HocSinh"));
                    submission.setID_BaiTap(rs.getInt("ID_BaiTap"));
                    submission.setTepNop(rs.getString("TepNop"));
                    submission.setNgayNop(rs.getDate("NgayNop").toLocalDate());
                    submission.setDiem(rs.getBigDecimal("Diem"));
                    submission.setNhanXet(rs.getString("NhanXet"));
                    submission.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    return submission;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
}
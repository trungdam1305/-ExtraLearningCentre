/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.DiemDanh;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author admin
 */
public class DiemDanhDAO {
    public List<DiemDanh> getDiemDanhInfoForSchedule(int scheduleId) {
    List<DiemDanh> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();
    String sql = "SELECT hs.ID_HocSinh, hs.HoTen, dd.TrangThai, dd.LyDoVang, dd.TrangThai, dd.ID_DiemDanh, s.ID_Schedule, hs.Avatar " +
                 "FROM LichHoc s " +
                 "JOIN LopHoc lh ON s.ID_LopHoc = lh.ID_LopHoc " +
                 "JOIN HocSinh_LopHoc hslh ON lh.ID_LopHoc = hslh.ID_LopHoc " +
                 "JOIN HocSinh hs ON hslh.ID_HocSinh = hs.ID_HocSinh " +
                 "LEFT JOIN DiemDanh dd ON hs.ID_HocSinh = dd.ID_HocSinh AND s.ID_Schedule = dd.ID_Schedule " +
                 "WHERE s.ID_Schedule = ?";
    try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
        stmt.setInt(1, scheduleId); // Set the scheduleId parameter
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            int attendanceId = rs.getInt("ID_DiemDanh");
            int studentId = rs.getInt("ID_HocSinh");
            String studentName = rs.getString("HoTen");
            String status = rs.getString("TrangThai");
            int scheduleId1 = rs.getInt("ID_Schedule");
            String reason = rs.getString("LyDoVang"); // Get the reason for absence (if applicable)
            String avatar = rs.getString("Avatar");
            // If the attendance status is null, set it to "Chưa điểm danh"
            if (status == null) status = "Chưa điểm danh";
            // Create a new DiemDanh object with all necessary fields and add it to the list
            list.add(new DiemDanh(attendanceId,studentId,scheduleId1, status, reason,studentName, avatar));
        }
    } catch (SQLException ex) {
        ex.printStackTrace(); // Log the exception
        return null; // Return null in case of error
    }
    return list; // Return the list of attendance records
}


    public void saveOrUpdateAttendance(DiemDanh diemDanh) {
        DBContext db = DBContext.getInstance();
        String checkSql = "SELECT ID_DiemDanh FROM DiemDanh WHERE ID_HocSinh = ? AND ID_Schedule = ?";
        String insertSql = "INSERT INTO DiemDanh (ID_HocSinh, ID_Schedule, TrangThai, LyDoVang) VALUES (?, ?, ?, ?)";
        String updateSql = "UPDATE DiemDanh SET TrangThai = ?, LyDoVang = ? WHERE ID_HocSinh = ? AND ID_Schedule = ?";
        try (PreparedStatement checkPs = db.getConnection().prepareStatement(checkSql)) {
            checkPs.setInt(1, diemDanh.getID_HocSinh());
            checkPs.setInt(2, diemDanh.getID_Schedule());
            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    try (PreparedStatement updatePs = db.getConnection().prepareStatement(updateSql)) {
                        updatePs.setString(1, diemDanh.getTrangThai());
                        updatePs.setString(2, diemDanh.getLyDoVang());
                        updatePs.setInt(3, diemDanh.getID_HocSinh());
                        updatePs.setInt(4, diemDanh.getID_Schedule());
                        updatePs.executeUpdate();
                    }
                } else {
                    try (PreparedStatement insertPs = db.getConnection().prepareStatement(insertSql)) {
                        insertPs.setInt(1, diemDanh.getID_HocSinh());
                        insertPs.setInt(2, diemDanh.getID_Schedule());
                        insertPs.setString(3, diemDanh.getTrangThai());
                        insertPs.setString(4, diemDanh.getLyDoVang());
                        insertPs.executeUpdate();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lưu điểm danh: " + e.getMessage());
        }
    }
    
    public Map<String, DiemDanh> getAttendanceMapForClass(int classId) {
    Map<String, DiemDanh> map = new HashMap<>();
    DBContext db = DBContext.getInstance();
    String sql = "SELECT dd.* FROM DiemDanh dd JOIN LichHoc lh ON dd.ID_Schedule = lh.ID_Schedule WHERE lh.ID_LopHoc = ?";
    try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
        stmt.setInt(1, classId);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            DiemDanh d = new DiemDanh();
            d.setID_HocSinh(rs.getInt("ID_HocSinh"));
            d.setID_Schedule(rs.getInt("ID_Schedule"));
            d.setTrangThai(rs.getString("TrangThai"));
            // Tạo một key duy nhất từ ID học sinh và ID lịch học
            String key = d.getID_HocSinh() + "-" + d.getID_Schedule();
            map.put(key, d);
        }
    } catch (Exception e) { e.printStackTrace(); }
    return map;
}
    
    public static void main(String[] args) {
        List<DiemDanh> dd = new ArrayList<>();
        DiemDanhDAO dao = new DiemDanhDAO();
        dd = dao.getDiemDanhInfoForSchedule(1);
        for (DiemDanh dl : dd){
            System.out.println(dl.getID_DiemDanh() + " " + dl.getID_HocSinh() + " " + dl.getTrangThai() + dl.getHoTen());
        }
    }
}

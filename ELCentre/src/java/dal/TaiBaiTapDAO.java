/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.TaoBaiTap;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TaiBaiTapDAO {
    public List<TaoBaiTap> getAssignmentsByClassId(int classId) {
        List<TaoBaiTap> assignmentList = new ArrayList<>();
        String sql = "SELECT * FROM TaoBaiTap WHERE ID_LopHoc = ? ORDER BY NgayTao DESC";
        
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TaoBaiTap bt = new TaoBaiTap();
                    bt.setID_BaiTap(rs.getInt("ID_BaiTap"));
                    bt.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                    bt.setTenBaiTap(rs.getString("TenBaiTap"));
                    bt.setMoTa(rs.getString("MoTa"));
                    bt.setNgayTao(rs.getDate("NgayTao").toLocalDate());
                    bt.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    bt.setDeadline(rs.getDate("Deadline").toLocalDate());
                    bt.setFileName(rs.getString("FileName"));
                    assignmentList.add(bt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return assignmentList;
    }

    /**
     * Thêm một bài tập mới vào cơ sở dữ liệu.
     */
    public void addAssignment(TaoBaiTap assignment) {
    // ✅ SỬA LẠI CÂU LỆNH SQL
    String sql = "INSERT INTO TaoBaiTap (ID_GiaoVien, TenBaiTap, MoTa, NgayTao, ID_LopHoc, Deadline, FileName) VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection conn = DBContext.getInstance().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, assignment.getID_GiaoVien());
        ps.setString(2, assignment.getTenBaiTap());
        ps.setString(3, assignment.getMoTa());
        ps.setDate(4, java.sql.Date.valueOf(assignment.getNgayTao()));
        ps.setInt(5, assignment.getID_LopHoc());
        ps.setDate(6, java.sql.Date.valueOf(assignment.getDeadline()));
        ps.setString(7, assignment.getFileName()); // ✅ THÊM THAM SỐ NÀY
        
        ps.executeUpdate();
        
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
    
        // Thêm phương thức này vào class TaiBaiTapDAO
    public TaoBaiTap getAssignmentById(int assignmentId) {
        String sql = "SELECT * FROM TaoBaiTap WHERE ID_BaiTap = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TaoBaiTap bt = new TaoBaiTap();
                    // Set tất cả các thuộc tính cho bt từ rs...
                    bt.setID_BaiTap(rs.getInt("ID_BaiTap"));
                    bt.setTenBaiTap(rs.getString("TenBaiTap"));
                    bt.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    return bt;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
    
    public static void main(String[] args) {
        TaoBaiTap assignment = new TaoBaiTap();
    assignment.setID_GiaoVien(1); // ID_GiaoVien = 1
    assignment.setTenBaiTap("Bài tập Đại số tuần 4");
    assignment.setMoTa("");
    assignment.setNgayTao(LocalDate.parse("2025-07-09")); // Chuyển chuỗi thành LocalDate
    assignment.setID_LopHoc(1);
    assignment.setDeadline(LocalDate.parse("2025-07-30")); // Chuyển chuỗi thành LocalDate
    assignment.setFileName(null); // Dùng null thay vì khoảng trắng nếu không có file

    TaiBaiTapDAO dao = new TaiBaiTapDAO();
    dao.addAssignment(assignment);
      
    }
}

// Author: trungdam
// Servlet: TaiBaiTapDAO
package dal;

import model.TaoBaiTap;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TaiBaiTapDAO {
    /**
     * Retrieves all assignments for a given class ID, ordered by deadline.
     */
    public List<TaoBaiTap> getAssignmentsByClassId(int classId) {
        List<TaoBaiTap> assignmentList = new ArrayList<>();
        String sql = "SELECT * FROM TaoBaiTap WHERE ID_LopHoc = ? ORDER BY Deadline DESC";
        
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
            System.err.println("Lỗi khi lấy danh sách bài tập theo ID lớp học: " + e.getMessage());
        }
        return assignmentList;
    }

    /**
     * Adds a new assignment to the database.
     */
    public void addAssignment(TaoBaiTap assignment) {
        String sql = "INSERT INTO TaoBaiTap (ID_GiaoVien, TenBaiTap, MoTa, NgayTao, ID_LopHoc, Deadline, FileName) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, assignment.getID_GiaoVien());
            ps.setString(2, assignment.getTenBaiTap());
            ps.setString(3, assignment.getMoTa());
            ps.setDate(4, java.sql.Date.valueOf(assignment.getNgayTao()));
            ps.setInt(5, assignment.getID_LopHoc());
            ps.setDate(6, java.sql.Date.valueOf(assignment.getDeadline()));
            ps.setString(7, assignment.getFileName()); 
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lỗi khi thêm bài tập mới: " + e.getMessage());
        }
    }
    
    /**
     * Retrieves an assignment by its ID.
     */
    public TaoBaiTap getAssignmentById(int assignmentId) {
        String sql = "SELECT * FROM TaoBaiTap WHERE ID_BaiTap = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TaoBaiTap bt = new TaoBaiTap();
                    // Set all properties for the assignment from the ResultSet
                    bt.setID_BaiTap(rs.getInt("ID_BaiTap"));
                    bt.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                    bt.setTenBaiTap(rs.getString("TenBaiTap"));
                    bt.setMoTa(rs.getString("MoTa"));
                    bt.setNgayTao(rs.getDate("NgayTao").toLocalDate());
                    bt.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    bt.setDeadline(rs.getDate("Deadline").toLocalDate());
                    bt.setFileName(rs.getString("FileName"));
                    return bt;
                }
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
            System.err.println("Lỗi khi lấy bài tập theo ID: " + e.getMessage());
        }
        return null;
    }
    
    /**
     * Gets the total number of assignments for a specific class ID.
     */
    public int getTotalAssignmentsByClassId(int classId) {
        String sql = "SELECT COUNT(*) FROM TaoBaiTap WHERE ID_LopHoc = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lỗi khi lấy tổng số bài tập theo ID lớp học: " + e.getMessage());
        }
        return 0;
    }
    
    /**
     * Gets the total number of assignments for a specific class ID, filtered by a search query.
     */
    public int getTotalAssignmentsByClassIdAndSearch(int classId, String searchQuery) {
        String sql = "SELECT COUNT(*) FROM TaoBaiTap WHERE ID_LopHoc = ?";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND TenBaiTap LIKE ?";
        }
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, classId);
            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(2, "%" + searchQuery + "%"); 
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lỗi khi lấy tổng số bài tập theo ID lớp học và tìm kiếm: " + e.getMessage());
        }
        return 0;
    }
    
    /**
     * Retrieves assignments for a specific class ID with pagination.
     */
    public List<TaoBaiTap> getAssignmentsByClassIdPaginated(int classId, int offset, int limit) {
        List<TaoBaiTap> assignmentList = new ArrayList<>();
        // Using OFFSET-FETCH for pagination
        String sql = "SELECT * FROM TaoBaiTap WHERE ID_LopHoc = ? ORDER BY Deadline DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, classId);
            ps.setInt(2, offset);
            ps.setInt(3, limit);
            
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
            System.err.println("Lỗi khi lấy danh sách bài tập theo ID lớp học (phân trang): " + e.getMessage());
        }
        return assignmentList;
    }

    /**
     * Retrieves assignments for a specific class ID with pagination and search functionality.
     */
    public List<TaoBaiTap> getAssignmentsByClassIdPaginatedAndSearch(int classId, String searchQuery, int offset, int limit) {
        List<TaoBaiTap> assignmentList = new ArrayList<>();
        String sql = "SELECT * FROM TaoBaiTap WHERE ID_LopHoc = ?";
        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql += " AND TenBaiTap LIKE ?";
        }
        // Using OFFSET-FETCH for pagination (SQL Server, PostgreSQL).
        sql += " ORDER BY NgayTao DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; 

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int paramIndex = 1;
            ps.setInt(paramIndex++, classId);
            if (searchQuery != null && !searchQuery.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchQuery + "%");
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, limit);

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
            System.err.println("Lỗi khi lấy danh sách bài tập theo ID lớp học và tìm kiếm (phân trang): " + e.getMessage());
        }
        return assignmentList;
    }
}
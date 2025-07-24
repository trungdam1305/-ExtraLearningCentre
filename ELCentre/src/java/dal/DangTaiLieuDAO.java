// Author: trungdam
// Servlet: DangTaiLieuDAO
package dal;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.DangTaiLieu;
import model.LoaiTaiLieu;
import model.MonHoc;

public class DangTaiLieuDAO {

    private final String BASE_SELECT_SQL = """
        SELECT 
            dtl.*, 
            mh.TenMonHoc, 
            ltl.LoaiTaiLieu 
        FROM DangTaiLieu dtl
        LEFT JOIN MonHoc mh ON dtl.ID_MonHoc = mh.ID_MonHoc
        LEFT JOIN LoaiTaiLieu ltl ON dtl.ID_LoaiTaiLieu = ltl.ID_LoaiTaiLieu
        WHERE 1=1 
    """;
    
    /**
     * Retrieves a paginated and filtered list of materials.
     */
    public List<DangTaiLieu> getFilteredMaterials(String keyword, Integer monHocId, Integer loaiTaiLieuId, int page, int pageSize) {
        List<DangTaiLieu> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT_SQL);

        // Append keyword filter if provided. Searches by 'TenTaiLieu' (material name).
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND dtl.TenTaiLieu LIKE ? "); 
            params.add("%" + keyword.trim() + "%");
        }
        // Append subject filter if provided.
        if (monHocId != null && monHocId > 0) {
            sql.append(" AND dtl.ID_MonHoc = ? ");
            params.add(monHocId);
        }
        // Append material type filter if provided.
        if (loaiTaiLieuId != null && loaiTaiLieuId > 0) {
            sql.append(" AND dtl.ID_LoaiTaiLieu = ? ");
            params.add(loaiTaiLieuId);
        }

        // Add pagination (ORDER BY, OFFSET, FETCH NEXT)
        sql.append(" ORDER BY dtl.NgayTao DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize); 
        params.add(pageSize); 

        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) { 
                while (rs.next()) { 
                    list.add(mapResultSetToDangTaiLieu(rs)); 
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy danh sách tài liệu: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * Counts the total number of materials based on keyword, subject, and material type filters.
     */
    public int countFilteredMaterials(String keyword, Integer monHocId, Integer loaiTaiLieuId) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM DangTaiLieu WHERE 1=1 ");

        // Your current keyword filter is on `TenTaiLieu` here. Consistent.
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND TenTaiLieu LIKE ? "); 
            params.add("%" + keyword.trim() + "%");
        }
        if (monHocId != null && monHocId > 0) {
            sql.append(" AND ID_MonHoc = ? ");
            params.add(monHocId);
        }
        if (loaiTaiLieuId != null && loaiTaiLieuId > 0) {
            sql.append(" AND ID_LoaiTaiLieu = ? ");
            params.add(loaiTaiLieuId);
        }

        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i)); 
            }
            try (ResultSet rs = ps.executeQuery()) { 
                if (rs.next()) {
                    return rs.getInt(1); 
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi đếm số tài liệu: " + e.getMessage());
            e.printStackTrace();
        }
        return 0; 
    }
    
    /**
     * Retrieves a list of all subjects (MonHoc) from the database.
     */
    public List<MonHoc> getAllMonHoc() {
        List<MonHoc> list = new ArrayList<>();
        String sql = "SELECT ID_MonHoc, TenMonHoc FROM MonHoc";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) { 
            while (rs.next()) { 
                list.add(new MonHoc(rs.getInt("ID_MonHoc"), rs.getString("TenMonHoc"))); 
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách Môn Học: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * Retrieves a list of all material types (LoaiTaiLieu) from the database.
     */
    public List<LoaiTaiLieu> getAllLoaiTaiLieu() {
        List<LoaiTaiLieu> list = new ArrayList<>();
        String sql = "SELECT ID_LoaiTaiLieu, LoaiTaiLieu FROM LoaiTaiLieu ORDER BY LoaiTaiLieu";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) { 
            while (rs.next()) { 
                list.add(new LoaiTaiLieu(rs.getInt("ID_LoaiTaiLieu"), rs.getString("LoaiTaiLieu"))); 
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách Loại Tài Liệu: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Gets a material by its ID.
     */
    public DangTaiLieu getMaterialById(int materialId) {
        String sql = BASE_SELECT_SQL + " AND dtl.ID_Material = ?";
        
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, materialId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDangTaiLieu(rs);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy chi tiết tài liệu: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Adds a new material to the database.
     */
    public void addMaterial(DangTaiLieu material) throws SQLException {
        String sql = "INSERT INTO DangTaiLieu (ID_GiaoVien, TenTaiLieu, ID_LoaiTaiLieu, DuongDan, NgayTao, ID_MonHoc, GiaTien, Image, NoiDung) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setObject(1, material.getID_GiaoVien()); 
            ps.setString(2, material.getTenTaiLieu());
            ps.setObject(3, material.getID_LoaiTaiLieu()); 
            ps.setString(4, material.getDuongDan()); 
            ps.setObject(5, material.getNgayTao()); 
            ps.setObject(6, material.getID_MonHoc()); 
            ps.setString(7, material.getGiaTien());
            ps.setString(8, material.getImage()); 
            ps.setString(9, material.getNoiDung()); 

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Updates an existing material in the database.
     */
    public void updateMaterial(DangTaiLieu material) throws SQLException {
        String sql = """
            UPDATE DangTaiLieu SET
                ID_GiaoVien = ?,
                TenTaiLieu = ?,
                ID_LoaiTaiLieu = ?,
                DuongDan = ?,
                ID_MonHoc = ?,
                GiaTien = ?,
                Image = ?,
                NoiDung = ?
            WHERE ID_Material = ?
            """;
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setObject(1, material.getID_GiaoVien());
            ps.setString(2, material.getTenTaiLieu());
            ps.setObject(3, material.getID_LoaiTaiLieu());
            ps.setString(4, material.getDuongDan());
            ps.setObject(5, material.getID_MonHoc());
            ps.setString(6, material.getGiaTien());
            ps.setString(7, material.getImage());
            ps.setString(8, material.getNoiDung()); 
            ps.setInt(9, material.getID_Material()); 

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Deletes a material from the database.
     */
    public void deleteMaterial(int materialId) throws SQLException {
        String sql = "DELETE FROM DangTaiLieu WHERE ID_Material = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, materialId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    /**
     * Maps a ResultSet row to a DangTaiLieu object.
     */
    private DangTaiLieu mapResultSetToDangTaiLieu(ResultSet rs) throws SQLException {
        DangTaiLieu dtl = new DangTaiLieu();
        dtl.setID_Material(rs.getInt("ID_Material"));
        dtl.setID_GiaoVien(rs.getObject("ID_GiaoVien") != null ? rs.getInt("ID_GiaoVien") : null);
        dtl.setTenTaiLieu(rs.getString("TenTaiLieu"));
        dtl.setID_LoaiTaiLieu(rs.getObject("ID_LoaiTaiLieu") != null ? rs.getInt("ID_LoaiTaiLieu") : null); 
        dtl.setDuongDan(rs.getString("DuongDan"));
        
        if (rs.getTimestamp("NgayTao") != null) {
            dtl.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
        } else {
            dtl.setNgayTao(null);
        }
        
        dtl.setID_MonHoc(rs.getObject("ID_MonHoc") != null ? rs.getInt("ID_MonHoc") : null); 
        dtl.setGiaTien(rs.getString("GiaTien"));
        dtl.setImage(rs.getString("Image"));
        dtl.setNoiDung(rs.getString("NoiDung")); 

        dtl.setMonHoc(rs.getString("TenMonHoc"));
        dtl.setLoaiTaiLieu(rs.getString("LoaiTaiLieu"));
        
        return dtl;
    }
}
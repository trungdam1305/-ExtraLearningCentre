package dal;

import model.DangTaiLieu;
import model.LoaiTaiLieu;
import model.MonHoc;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DangTaiLieuDAO {

    /**
     * Câu lệnh SQL cơ sở để lấy tài liệu với đầy đủ thông tin tên môn học và loại tài liệu.
     * Sử dụng LEFT JOIN để đảm bảo tài liệu vẫn hiển thị ngay cả khi môn học hoặc loại tài liệu bị null.
     */
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
     * Lấy danh sách tài liệu đã được lọc và phân trang.
     * @param keyword Từ khóa tìm kiếm theo tên tài liệu.
     * @param monHocId ID của môn học để lọc.
     * @param loaiTaiLieuId ID của loại tài liệu để lọc.
     * @param page Trang hiện tại.
     * @param pageSize Số lượng mục trên mỗi trang.
     * @return Danh sách tài liệu.
     */
    public List<DangTaiLieu> getFilteredMaterials(String keyword, Integer monHocId, Integer loaiTaiLieuId, int page, int pageSize) {
        List<DangTaiLieu> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT_SQL);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND dtl.LoaiTaiLieu LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }
        if (monHocId != null && monHocId > 0) {
            sql.append(" AND dtl.ID_MonHoc = ? ");
            params.add(monHocId);
        }
        if (loaiTaiLieuId != null && loaiTaiLieuId > 0) {
            sql.append(" AND dtl.ID_LoaiTaiLieu = ? ");
            params.add(loaiTaiLieuId);
        }

        sql.append(" ORDER BY dtl.NgayTao DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (Connection conn = new DBContext().getConnection();
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
     * Đếm tổng số tài liệu thỏa mãn điều kiện lọc.
     */
    public int countFilteredMaterials(String keyword, Integer monHocId, Integer loaiTaiLieuId) {
        List<Object> params = new ArrayList<>();
        // Việc JOIN không cần thiết cho COUNT, giúp tối ưu hiệu suất
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM DangTaiLieu WHERE 1=1 ");

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

        try (Connection conn = new DBContext().getConnection();
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
     * Lấy tất cả các môn học để hiển thị trong bộ lọc.
     */
    public List<MonHoc> getAllMonHoc() {
        List<MonHoc> list = new ArrayList<>();
        String sql = "SELECT ID_MonHoc, TenMonHoc FROM MonHoc";
        try (Connection conn = new DBContext().getConnection();
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
     * Lấy tất cả các loại tài liệu để hiển thị trong bộ lọc.
     */
    public List<LoaiTaiLieu> getAllLoaiTaiLieu() {
        List<LoaiTaiLieu> list = new ArrayList<>();
        String sql = "SELECT ID_LoaiTaiLieu, LoaiTaiLieu FROM LoaiTaiLieu ORDER BY LoaiTaiLieu";
        try (Connection conn = new DBContext().getConnection();
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
     * Hàm tiện ích để chuyển đổi một hàng trong ResultSet thành đối tượng DangTaiLieu.
     */
    private DangTaiLieu mapResultSetToDangTaiLieu(ResultSet rs) throws SQLException {
        DangTaiLieu dtl = new DangTaiLieu();
        dtl.setID_Material(rs.getInt("ID_Material"));
        dtl.setID_GiaoVien(rs.getObject("ID_GiaoVien") != null ? rs.getInt("ID_GiaoVien") : null);
        dtl.setTenTaiLieu(rs.getString("TenTaiLieu"));
        dtl.setID_LoaiTaiLieu(rs.getInt("ID_LoaiTaiLieu"));
        dtl.setDuongDan(rs.getString("DuongDan"));
        dtl.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
        dtl.setID_MonHoc(rs.getInt("ID_MonHoc"));
        dtl.setGiaTien(rs.getString("GiaTien"));
        dtl.setImage(rs.getString("Image"));
        
        // Các trường được JOIN từ bảng khác
        dtl.setMonHoc(rs.getString("TenMonHoc"));
        dtl.setLoaiTaiLieu(rs.getString("LoaiTaiLieu"));
        
        return dtl;
    }
    public DangTaiLieu getMaterialById(int materialId) {
    // Sử dụng lại câu lệnh SQL cơ sở đã có JOIN
    String sql = BASE_SELECT_SQL + " AND dtl.ID_Material = ?";
    
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, materialId);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                // Dùng lại hàm map tiện ích đã tạo
                return mapResultSetToDangTaiLieu(rs);
            }
        }
    } catch (Exception e) {
        System.err.println("Lỗi khi lấy chi tiết tài liệu: " + e.getMessage());
        e.printStackTrace();
    }
    return null; // Trả về null nếu không tìm thấy hoặc có lỗi
}
}
package dal;

import model.DangTaiLieu;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.KhoaHoc;

public class DangTaiLieuDAO {

    private Connection conn;

    public DangTaiLieuDAO() {
    }
    
    
    public DangTaiLieuDAO(Connection conn) {
        this.conn = conn;
    }

    // Get danh sách tài liệu phân trang (12 item/trang)
    public List<DangTaiLieu> getTaiLieuByPage(int page) {
    List<DangTaiLieu> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();
    String sql = "SELECT * FROM DangTaiLieu ORDER BY NgayTao DESC OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql);) {
        int offset = (page - 1) * 12;
        ps.setInt(1, offset);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DangTaiLieu dtl = new DangTaiLieu();
                dtl.setID_Material(rs.getInt("ID_Material"));
                dtl.setID_GiaoVien(rs.getObject("ID_GiaoVien") != null ? rs.getInt("ID_GiaoVien") : null);
                dtl.setTenTaiLieu(rs.getString("TenTaiLieu"));
                dtl.setLoaiTaiLieu(rs.getString("LoaiTaiLieu"));
                dtl.setDuongDan(rs.getString("DuongDan"));
                dtl.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                dtl.setDanhMuc(rs.getString("DanhMuc"));
                dtl.setGiaTien(rs.getString("GiaTien"));
                dtl.setImage(rs.getString("Image"));
                list.add(dtl);
            }
        }
    } catch (SQLException e) {
        throw new RuntimeException("Lỗi khi lấy tài liệu phân trang", e);
    }
    return list;
}

public int countTaiLieu() {
    DBContext db = DBContext.getInstance();
    String sql = "SELECT COUNT(*) FROM DangTaiLieu";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        throw new RuntimeException("Lỗi khi đếm số tài liệu", e);
    }
    return 0;
}
    
    public static int getTaiLieuToan() {
        ArrayList<DangTaiLieu> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM DangTaiLieu
                        WHERE DanhMuc Collate Latin1_General_CI_AI LIKE '%toan%'
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
             ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
                return tong;
    }
    
    public static int getTaiLieuVan() {
        ArrayList<DangTaiLieu> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM DangTaiLieu
                        WHERE DanhMuc Collate Latin1_General_CI_AI LIKE '%van%'
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
             ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
                return tong;
    }
    
    public static int getTaiLieuAnh() {
        ArrayList<DangTaiLieu> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM DangTaiLieu
                        WHERE DanhMuc Collate Latin1_General_CI_AI LIKE '%anh%'
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
             ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
                return tong;
    }
    
    public List<String> getAllDanhMuc() {
    List<String> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();
    String sql = "SELECT DISTINCT DanhMuc FROM DangTaiLieu WHERE DanhMuc IS NOT NULL";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(rs.getString("DanhMuc"));
        }
    } catch (SQLException e) {
        throw new RuntimeException("Lỗi khi lấy danh sách Danh Mục", e);
    }
    return list;
}
    
    // Search materials by DanhMuc
    public List<DangTaiLieu> searchByDanhMuc(String danhMucKeyword) {
        List<DangTaiLieu> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM DangTaiLieu WHERE DanhMuc LIKE ?";

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql);) {
            
            ps.setString(1, "%" + danhMucKeyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DangTaiLieu dtl = new DangTaiLieu();
                dtl.setID_Material(rs.getInt("ID_Material"));
                dtl.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
                dtl.setTenTaiLieu(rs.getString("TenTaiLieu"));
                dtl.setLoaiTaiLieu(rs.getString("LoaiTaiLieu"));
                dtl.setDuongDan(rs.getString("DuongDan"));
                dtl.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                dtl.setDanhMuc(rs.getString("DanhMuc"));
                dtl.setGiaTien(rs.getString("GiaTien"));
                dtl.setImage(rs.getString("Image"));

                list.add(dtl);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        DangTaiLieuDAO dao = new DangTaiLieuDAO();
        List<DangTaiLieu> dtl = new ArrayList();
        dtl = dao.getTaiLieuByPage(1);
        for(DangTaiLieu dt: dtl){
            System.out.println(dt.getGiaTien() + " " + dt.getTenTaiLieu() + " " + dt.getImage());
        }
    }
    
    
}

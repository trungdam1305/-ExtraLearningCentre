package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.LopHoc;

public class HocSinh_LopHocDAO {
    public static int teacherGetTongSoLopHoc(int id){
        DBContext db = DBContext.getInstance() ; 
        int tong = 0 ; 
        try {
            String sql = """
                            SELECT COUNT(*) FROM HocSinh_LopHoc hslh
                            JOIN HocSinh hs
                            on hslh.ID_HocSinh = hs.ID_HocSinh
                            JOIN TaiKhoan tk 
                            on gv.ID_TaiKhoan = tk.ID_TaiKhoan
                            WHERE gv.ID_TaiKhoan = ?
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery() ; 
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }
        } catch (SQLException e ){
            e.printStackTrace();
            
        }
        return tong ; 
    }   
    
    public static int adminGetSoHocSinhHaiLong() {
        DBContext db = DBContext.getInstance();
        int tong = 0;

        try {
            String sql = """
                         select COUNT (*) 
                         from HocSinh_LopHoc
                         where Status_FeedBack = 1 ; 
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
    
    public static int adminGetSoHocSinhKhongHaiLong() {
        DBContext db = DBContext.getInstance();
        int tong = 0;

        try {
            String sql = """
                         select COUNT (*) 
                         from HocSinh_LopHoc
                         where Status_FeedBack = 0 ; 
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
    
    //Hàm lấy ra lớp học đã đăng ký theo id học sinh
    public static List<LopHoc> getLopHocDaDangKyByHocSinhId(Integer idHocSinh) {
        List<LopHoc> list = new ArrayList<>();
        String sql = """
                     SELECT 
                         lh.ID_LopHoc,
                         lh.ClassCode,
                         lh.TenLopHoc,
                         kh.TenKhoaHoc,
                         lh.SiSo,
                         lh.SiSoToiDa,
                         lh.SiSoToiThieu,
                         lh.ID_Schedule,
                         lh.ID_PhongHoc,
                         lh.GhiChu,
                         lh.TrangThai,
                         lh.SoTien,
                         lh.NgayTao,
                         lh.Image,
                         lh.[Order]
                     FROM HocSinh_LopHoc hslh
                     JOIN LopHoc lh ON hslh.ID_LopHoc = lh.ID_LopHoc
                     JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                     WHERE hslh.ID_HocSinh = ?
        """;
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setClassCode(rs.getString("ClassCode"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static List<LopHoc> getChiTietLopHocByHocSinhId(int idHocSinh) {
        List<LopHoc> list = new ArrayList<>();
        String sql = """
            SELECT lh.ID_LopHoc, lh.MaLop, lh.TenLopHoc, lh.SiSo, lh.GhiChu,
                   gv.HoTen AS TenGiaoVien, kh.TenKhoaHoc
            FROM HocSinh_LopHoc hslh
            JOIN LopHoc lh ON hslh.ID_LopHoc = lh.ID_LopHoc
            JOIN GiaoVien gv ON lh.ID_GiaoVien = gv.ID_GiaoVien
            JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            WHERE hslh.ID_HocSinh = ?
        """;
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LopHoc lop = new LopHoc();
                lop.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lop.setClassCode(rs.getString("MaLop"));
                lop.setTenLopHoc(rs.getString("TenLopHoc"));
                lop.setSiSo(rs.getInt("SiSo"));
                lop.setGhiChu(rs.getString("GhiChu"));
                lop.setTenGiaoVien(rs.getString("TenGiaoVien"));
                lop.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                list.add(lop);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }   
}

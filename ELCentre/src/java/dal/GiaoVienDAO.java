/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.GiaoVien;

public class GiaoVienDAO {
     private Connection conn;
    public static ArrayList<GiaoVien> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();

        try {
            String sql = """
                          select * from GiaoVien 
                          """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien giaovien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getString("TruongGiangDay"),
                        rs.getBigDecimal("Luong"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime()
                ) ; 
                giaoviens.add(giaovien) ; 
            }
        } catch (SQLException e) {
            // Exception ignored    
            return new ArrayList<GiaoVien>();
        }
        
        if (giaoviens.isEmpty()){
            return null ; 
            
        } else {
            return giaoviens ;
        }
    }
    
    public static ArrayList<GiaoVien> HomePageGetGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();

        try {
            String sql = """
                          select * from GiaoVien 
                          """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien giaovien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getString("TruongGiangDay"),
                        rs.getBigDecimal("Luong"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                            rs.getString("Avatar")
                ); 
                giaoviens.add(giaovien) ; 
            }
        } catch (SQLException e) {
            // Exception ignored    
            return new ArrayList<GiaoVien>();
        }
        
        if (giaoviens.isEmpty()){
            return null ; 
            
        } else {
            return giaoviens ;
        }
    }
    
    public GiaoVien getGiaoVienByHoTen(String hoTen) {
    DBContext db = DBContext.getInstance();
    GiaoVien gv = null;
    String sql = "SELECT * FROM GiaoVien WHERE HoTen COLLATE Latin1_General_CI_AI = ?";
    try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
        statement.setString(1, hoTen.trim()); // loại bỏ khoảng trắng đầu cuối trước khi set
        ResultSet rs = statement.executeQuery();

        if (rs.next()) {
            gv = new GiaoVien();
            gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
            gv.setHoTen(rs.getString("HoTen"));
            gv.setChuyenMon(rs.getString("ChuyenMon"));
            gv.setSDT(rs.getString("SDT"));
            gv.setTruongGiangDay(rs.getString("TruongGiangDay"));
            gv.setLuong(rs.getBigDecimal("Luong"));
            gv.setGhiChu(rs.getString("GhiChu"));
            gv.setTrangThai(rs.getString("TrangThai"));
            gv.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
            gv.setAvatar(rs.getString("Avatar"));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return gv;
}

    
    public static void main(String[] args) {
        GiaoVienDAO dao = new GiaoVienDAO();

        // Tên giáo viên cần tìm (có thể thay đổi để test)
        String tenCanTim = "Vũ Văn Chủ";

        GiaoVien gv = dao.getGiaoVienByHoTen(tenCanTim);

        System.out.println(gv.getHoTen() + " " + gv.getChuyenMon() + " " + gv.getAvatar());
        
        
    }

}

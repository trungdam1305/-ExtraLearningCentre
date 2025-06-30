/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import model.HocSinh_SDT;

public class HocSinh_SDTDAO {

    public static ArrayList<HocSinh_SDT> adminGetSoDienThoaiHocSinh() {
        ArrayList<HocSinh_SDT> hocsinhs = new ArrayList<HocSinh_SDT>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select * from HocSinh HS 
                        join TaiKhoan TK 
                        on HS.ID_TaiKhoan = TK.ID_TaiKhoan
                        join TruongHoc TH
                        on TH.ID_TruongHoc = HS.ID_TruongHoc
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HocSinh_SDT hs = new HocSinh_SDT(
                        rs.getInt("ID_HocSinh"),
                        rs.getString("MaHocSinh"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getDate("NgaySinh").toLocalDate(),
                        rs.getString("GioiTinh"),
                        rs.getString("SoDienThoai"),
                        rs.getString("DiaChi"),
                        rs.getString("SDT_PhuHuynh"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("TenTruongHoc"),
                        rs.getString("LopDangHocTrenTruong"),
                        rs.getString("TrangThaiHoc"),
                        rs.getString("Avatar")
                );
                hocsinhs.add(hs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (hocsinhs == null) {
            return null;
        } else {
            return hocsinhs;
        }
    }

    public static ArrayList<HocSinh_SDT> adminGetSoDienThoaiHocSinhByIDTK(String id) {
        ArrayList<HocSinh_SDT> hocsinhs = new ArrayList<HocSinh_SDT>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select * from HocSinh HS 
                        join TaiKhoan TK 
                        on HS.ID_TaiKhoan = TK.ID_TaiKhoan
                        join TruongHoc TH
                        on TH.ID_TruongHoc = HS.ID_TruongHoc
                        where TK.ID_TaiKhoan = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HocSinh_SDT hs = new HocSinh_SDT(
                        rs.getInt("ID_HocSinh"),
                        rs.getString("MaHocSinh"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getDate("NgaySinh").toLocalDate(),
                        rs.getString("GioiTinh"),
                        rs.getString("SoDienThoai"),
                        rs.getString("DiaChi"),
                        rs.getString("SDT_PhuHuynh"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("TenTruongHoc"),
                        rs.getString("LopDangHocTrenTruong"),
                        rs.getString("TrangThaiHoc"),
                        rs.getString("Avatar")
                );
                hocsinhs.add(hs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (hocsinhs == null) {
            return null;
        } else {
            return hocsinhs;
        }
    }

    public static ArrayList<HocSinh_SDT> adminGetHocSinhFilter(String keyword, String trangthai, String khoa) {
    ArrayList<HocSinh_SDT> hocsinhs = new ArrayList<>();
    DBContext db = DBContext.getInstance();

    try {
        String sql = """
            SELECT * 
            FROM HocSinh HS
            JOIN TaiKhoan TK ON HS.ID_TaiKhoan = TK.ID_TaiKhoan
            JOIN TruongHoc TH ON TH.ID_TruongHoc = HS.ID_TruongHoc
            WHERE (HoTen LIKE ? OR MaHocSinh LIKE ? OR SoDienThoai LIKE ?)
              AND TrangThaiHoc LIKE ?
              AND MaHocSinh LIKE ?
        """;

        PreparedStatement statement = db.getConnection().prepareStatement(sql);

        statement.setString(1, "%" + keyword + "%");
        statement.setString(2, "%" + keyword + "%");
        statement.setString(3, "%" + keyword + "%");

        
        statement.setString(4, trangthai);
        statement.setString(5, khoa + "%");

        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            HocSinh_SDT hs = new HocSinh_SDT(
                    rs.getInt("ID_HocSinh"),
                    rs.getString("MaHocSinh"),
                    rs.getInt("ID_TaiKhoan"),
                    rs.getString("HoTen"),
                    rs.getDate("NgaySinh").toLocalDate(),
                    rs.getString("GioiTinh"),
                    rs.getString("SoDienThoai"),
                    rs.getString("DiaChi"),
                    rs.getString("SDT_PhuHuynh"),
                    rs.getInt("ID_TruongHoc"),
                    rs.getString("GhiChu"),
                    rs.getString("TrangThai"),
                    rs.getTimestamp("NgayTao").toLocalDateTime(),
                    rs.getString("TenTruongHoc"),
                    rs.getString("LopDangHocTrenTruong"),
                    rs.getString("TrangThaiHoc"),
                    rs.getString("Avatar")
            );
            hocsinhs.add(hs);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }

    return hocsinhs;
}


    
    

}

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

    public static ArrayList<HocSinh_SDT> adminGetHocSinhByFilter(String keyword, String status, String khoa) {
    ArrayList<HocSinh_SDT> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();

    try {
        StringBuilder sql = new StringBuilder("""
            SELECT *
            FROM HocSinh
            JOIN TaiKhoan ON HocSinh.ID_TaiKhoan = TaiKhoan.ID_TaiKhoan
            JOIN TruongHoc ON TruongHoc.ID_TruongHoc = HocSinh.ID_TruongHoc
            WHERE (HoTen LIKE N? OR MaHocSinh LIKE N? OR SoDienThoai LIKE N?)
        """);

        if (status != null && !status.isEmpty()) {
            sql.append(" AND TrangThaiHoc = N? ");
        }
        if (khoa != null && !khoa.isEmpty()) {
            sql.append(" AND MaHocSinh LIKE N? + '%' ");
        }

        PreparedStatement stmt = db.getConnection().prepareStatement(sql.toString());

        String kw = "%" + keyword + "%";
        int idx = 1;
        stmt.setString(idx++, kw);
        stmt.setString(idx++, kw);
        stmt.setString(idx++, kw);

        if (status != null && !status.isEmpty()) {
            stmt.setString(idx++, status);
        }
        if (khoa != null && !khoa.isEmpty()) {
            stmt.setString(idx++, khoa);
        }

        ResultSet rs = stmt.executeQuery();
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
            list.add(hs);
        }
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }

    return list;
}

    
    

}

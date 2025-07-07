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
import model.GiaoVien_TruongHoc;
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
            if (keyword == null) {
                keyword = "";
            }
            if (trangthai == null) {
                trangthai = "";
            }
            if (khoa == null) {
                khoa = "";
            }
            boolean isAllEmpty = keyword.trim().isEmpty() && trangthai.isEmpty() && khoa.isEmpty();
            
            PreparedStatement statement;

            if (isAllEmpty) {
               String sql = """
                SELECT * 
                FROM HocSinh HS
                JOIN TaiKhoan TK ON HS.ID_TaiKhoan = TK.ID_TaiKhoan
                JOIN TruongHoc TH ON TH.ID_TruongHoc = HS.ID_TruongHoc
            """;
                statement = db.getConnection().prepareStatement(sql);
            } else {
               String sql = """
                SELECT * 
                FROM HocSinh HS
                JOIN TaiKhoan TK ON HS.ID_TaiKhoan = TK.ID_TaiKhoan
                JOIN TruongHoc TH ON TH.ID_TruongHoc = HS.ID_TruongHoc
                WHERE (? = '' OR HoTen LIKE ? OR MaHocSinh LIKE ? OR SoDienThoai LIKE ?)
                  AND (? = '' OR TrangThaiHoc = ?)
                  AND (? = '' OR MaHocSinh LIKE ?)
            """;
                statement = db.getConnection().prepareStatement(sql);

                String keywordLike = "%" + keyword.trim() + "%";
                String khoaLike = khoa + "%";
                statement.setString(1, keyword);
                statement.setString(2, keywordLike);
                statement.setString(3, keywordLike);
                statement.setString(4, keywordLike);

                
                statement.setString(5, trangthai);
                statement.setString(6, trangthai);

                
                statement.setString(7, khoa);
                statement.setString(8, khoaLike);
            }

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

    public static ArrayList<GiaoVien_TruongHoc> adminGetGiaoVienFilter(String keyword, String chuyenmon, String trangthai) {
        ArrayList<GiaoVien_TruongHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        try {
            boolean isAllEmpty = keyword.isEmpty() && chuyenmon.isEmpty() && trangthai.isEmpty();
            String sql;
            PreparedStatement statement;

            if (isAllEmpty) {
                sql = """
                SELECT *
                FROM GiaoVien GV
                JOIN TaiKhoan TK ON GV.ID_TaiKhoan = TK.ID_TaiKhoan
            """;
                statement = db.getConnection().prepareStatement(sql);
            } else {
                sql = """
                SELECT *
                FROM GiaoVien GV
                JOIN TaiKhoan TK ON GV.ID_TaiKhoan = TK.ID_TaiKhoan
                WHERE (? = '' OR HoTen LIKE ?  OR SDT LIKE ?)
                  AND (? = '' OR ChuyenMon = ?)
                  AND (? = '' OR TrangThaiDay = ?)
            """;

                statement = db.getConnection().prepareStatement(sql);

                String keywordLike = "%" + keyword + "%";

                
                statement.setString(1, keyword);
                statement.setString(2, keywordLike);
                statement.setString(3, keywordLike);
                statement.setString(4, keywordLike);

                
                statement.setString(5, chuyenmon);
                statement.setString(6, chuyenmon);

                
                statement.setString(7, trangthai);
                statement.setString(8, trangthai);
            }

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
               
                        GiaoVien_TruongHoc giaovien = new GiaoVien_TruongHoc(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc"),
                        rs.getString("BangCap") , 
                        rs.getString("LopDangDayTrenTruong") , 
                        rs.getString("TrangThaiDay")
                );
                list.add(giaovien);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }


    
    

}

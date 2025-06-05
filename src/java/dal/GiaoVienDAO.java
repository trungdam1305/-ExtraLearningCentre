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
import java.util.List;
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
    //Get All information from teacher contain Avatar
    public ArrayList<GiaoVien> HomePageGetGiaoVien() {
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
    //Get Teacher by Name to have Specialised Teacher
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
    //Get Teacher to have Specialised Teacher
    public ArrayList<GiaoVien> getSpecialised() {
    DBContext db = DBContext.getInstance();
    ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();
    String sql = "SELECT * FROM GiaoVien WHERE GhiChu IS NOT NULL;";
    try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {  // Use while to get all records from database
            GiaoVien gv = new GiaoVien();
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
            giaoviens.add(gv);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return giaoviens;
}

    
    
    public static ArrayList<GiaoVien> adminGetGiaoVienByID(String id) {
        DBContext db = DBContext.getInstance() ; 
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>() ; 
        
        try {
            String sql = """
                         select * from GiaoVien 
                         where ID_TaiKhoan = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery() ; 
            
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
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Avatar")
                ) ; 
                giaoviens.add(giaovien) ; 
            }
             
        } catch (SQLException e ) {
            e.printStackTrace();
            return null ; 
        }
        
        if (giaoviens.isEmpty()){
            return null ; 
        } else {
            return giaoviens ; 
        }
    }
    
    public static boolean adminEnableGiaoVien(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE GiaoVien
                         SET TrangThai = 'Active'
                         WHERE ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ) {
            e.printStackTrace();
             
        }
        if (rs == 0 ){
            return false ; 
        } else {
            return true ; 
        }
    }
    
    public static boolean adminDisableGiaoVien(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE GiaoVien
                         SET TrangThai = 'Inactive'
                         WHERE ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ) {
            e.printStackTrace();
             
        }
        if (rs == 0 ){
            return false ; 
        } else {
            return true ; 
        }
    }
    
    public static int adminGetTongSoGiaoVien(){
        DBContext db = DBContext.getInstance() ; 
        int tong = 0 ; 
        try {
            String sql = """
                         select count(*) from GiaoVien
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
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

    //Debugging DAO
    public static void main(String[] args) {
        GiaoVienDAO dao = new GiaoVienDAO();

        //Just for Testing
        
        ArrayList<GiaoVien> gv = dao.getSpecialised();
        for (GiaoVien g : gv){
        System.out.println(g.getHoTen() + " " + g.getChuyenMon() + " " + g.getAvatar());
        }
        
    }

}

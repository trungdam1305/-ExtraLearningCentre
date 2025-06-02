/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.GiaoVien;

public class GiaoVienDAO {

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
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Avatar")
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
    
    
    public static boolean adminUpdateInformationOfTeacher(String sdt , String truong , BigDecimal luong , String ghichu , int id){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE GiaoVien
                         SET
                        SDT = ?,
                        TruongGiangDay = ?,
                        Luong = ?,
                        GhiChu = ?
                         WHERE
                         ID_GiaoVien = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1 , sdt);
            statement.setString(2 , truong) ; 
            statement.setBigDecimal(3, luong);
            statement.setString(4, ghichu);
            statement.setInt(5, id);
            
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ){
            e.printStackTrace();
            return false ; 
        }
        
        if (rs == 0 ) {
            return false ; 
        } else {
            return true ; 
        }
    }

}

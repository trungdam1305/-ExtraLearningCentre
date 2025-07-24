/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import model.HoTro;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import java.util.List;

public class HoTroDAO {

    public static ArrayList<HoTro> adminGetHoTroDashBoard() {
        DBContext db = DBContext.getInstance();
        ArrayList<HoTro> hotros = new ArrayList<HoTro>();

        try {
            String sql = """
                         select * from HoTro 
                         where DaDuyet = N'Chờ duyệt'
                         order by ThoiGian DESC ; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HoTro hotro = new HoTro(
                        rs.getInt("ID_HoTro"),
                        rs.getString("HoTen"),
                        rs.getString("TenHoTro"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime(),
                        rs.getString("MoTa"),
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getString("DaDuyet") , 
                        rs.getString("PhanHoi") , 
                        rs.getString("VaiTro") , 
                        rs.getString("SoDienThoai") 
                );
                hotros.add(hotro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        
        if (hotros == null ){
            return null ; 
        } else {
            return hotros ; 
        }
    }
    
    public static ArrayList<HoTro> staffGetHoTroDashBoard() {
        DBContext db = DBContext.getInstance();
        ArrayList<HoTro> hotros = new ArrayList<HoTro>();

        try {
            String sql = """
                         select * from HoTro 
                         where DaDuyet = N'Chờ duyệt'
                         and VaiTro != 'Staff'
                         order by ThoiGian DESC ; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HoTro hotro = new HoTro(
                        rs.getInt("ID_HoTro"),
                        rs.getString("HoTen"),
                        rs.getString("TenHoTro"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime(),
                        rs.getString("MoTa"),
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getString("DaDuyet") , 
                        rs.getString("PhanHoi") , 
                        rs.getString("VaiTro") , 
                        rs.getString("SoDienThoai") 
                );
                hotros.add(hotro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        
        if (hotros == null ){
            return null ; 
        } else {
            return hotros ; 
        }
    }
   
    public static boolean adminDanhDauDaDocHoTro(String id_HoTro){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0; 
        try {
            String sql = """
                         UPDATE HoTro
                         SET 
                         DaDuyet = N'Đã duyệt' 
                         where ID_HoTro = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id_HoTro);
            rs = statement.executeUpdate() ; 
            while(rs!= 0 ) {
                return true ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace(); 
            return false ; 
        }
        return false ;
    }
    
    public static boolean duyetHoTroOK(String id_HoTro , String PhanHoi ){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0; 
        try {
            String sql = """
                         UPDATE HoTro
                         SET 
                         DaDuyet = N'Đã duyệt' ,
                         PhanHoi =  ? 
                         where ID_HoTro = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, PhanHoi);
            statement.setString(2, id_HoTro);
            rs = statement.executeUpdate() ; 
            while(rs!= 0 ) {
                return true ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace(); 
            return false ; 
        }
        return false ;
    }
    
    public static boolean duyetHoTroKhongOK(String id_HoTro , String PhanHoi ){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0; 
        try {
            String sql = """
                         UPDATE HoTro
                         SET 
                         DaDuyet = N'Từ chối' ,
                         PhanHoi =  ? 
                         where ID_HoTro = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, PhanHoi);
            statement.setString(2, id_HoTro);
            rs = statement.executeUpdate() ; 
            while(rs!= 0 ) {
                return true ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace(); 
            return false ; 
        }
        return false ;
    }
    
    public static ArrayList<HoTro> getHoTroByIdTaiKhoan(int  ID_TaiKhoan){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<HoTro> hotros = new ArrayList<HoTro>() ; 
        try {
            String sql = """
                         select * from HoTro 
                         where ID_TaiKhoan = ? 
                         order by ThoiGian DESC ; 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, ID_TaiKhoan);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()) {
                HoTro hotro = new HoTro(
                        rs.getInt("ID_HoTro") , 
                        rs.getString("HoTen") , 
                        rs.getString("TenHoTro") , 
                        rs.getTimestamp("ThoiGian").toLocalDateTime() , 
                        rs.getString("MoTa") , 
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getString("DaDuyet") ,
                        rs.getString("PhanHoi")  , 
                        rs.getString("VaiTro") , 
                        rs.getString("SoDienThoai") 
                
                ) ; 
                hotros.add(hotro) ; 
            }
        } catch (SQLException e ) {
            e.printStackTrace();
            return null ; 
        }
        if (hotros == null ) {
            return null ; 
        } else {
            return hotros ; 
        }
    }
    
    
        public static boolean  sendHoTroByIdTaiKhoan(String HoTen , String TenHoTro , String MoTa , String  ID_TaiKhoan){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                        insert into HoTro(HoTen , TenHoTro , ThoiGian , MoTa , ID_TaiKhoan , DaDuyet ) 
                        VALUES ( ? , ?  , ? , ?  , ?  , ? )
                         """ ; 
            
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, HoTen);
            statement.setString(2, TenHoTro);
            statement.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            
            statement.setString(4, MoTa);
            statement.setString(5, ID_TaiKhoan);
            statement.setString(6 , "Chờ duyệt") ; 
             rs = statement.executeUpdate() ; 
            if (rs > 0 ) {
                return true  ; 
            }
        } catch (SQLException e ) {
            e.printStackTrace();
            
        }
        return false ; 
    }

    
    public static boolean  sendHoTroByIdTaiKhoan(String HoTen , String TenHoTro , String MoTa , String  ID_TaiKhoan , String VaiTro , String SoDienThoai){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                        insert into HoTro(HoTen , TenHoTro , ThoiGian , MoTa , ID_TaiKhoan , DaDuyet  , VaiTro , SoDienThoai ) 
                        VALUES ( ? , ?  , ? , ?  , ?  , ?  , ?  , ? )
                         """ ; 
            
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, HoTen);
            statement.setString(2, TenHoTro);
            statement.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            
            statement.setString(4, MoTa);
            statement.setString(5, ID_TaiKhoan);
            statement.setString(6 , "Chờ duyệt") ; 
            statement.setString(7, VaiTro);
            statement.setString(8, SoDienThoai);
             rs = statement.executeUpdate() ; 
            if (rs > 0 ) {
                return true  ; 
            }
        } catch (SQLException e ) {
            e.printStackTrace();
            
        }
        return false ; 
    }
       
    
    
    public static List<HoTro> getHoTroByTaiKhoanId(int idTaiKhoan) {
        List<HoTro> list = new ArrayList<>();
        String sql = "SELECT * FROM HoTro WHERE ID_TaiKhoan = ? ORDER BY ThoiGian DESC";

        try (Connection con = DBContext.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idTaiKhoan);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HoTro ht = new HoTro();
                ht.setID_HoTro(rs.getInt("ID_HoTro"));
                ht.setHoTen(rs.getString("HoTen"));
                ht.setTenHoTro(rs.getString("TenHoTro"));
                ht.setThoiGian(rs.getTimestamp("ThoiGian").toLocalDateTime());
                ht.setMoTa(rs.getString("MoTa"));
                ht.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                ht.setDaDuyet(rs.getString("DaDuyet"));
                ht.setPhanHoi(rs.getString("PhanHoi"));
                list.add(ht);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void insertHoTro(HoTro hoTro) {
        String sql = "INSERT INTO HoTro(HoTen, TenHoTro, ThoiGian, MoTa, ID_TaiKhoan, DaDuyet, PhanHoi) VALUES (?, ?, GETDATE(), ?, ?, ?, ?)";

        try (Connection con = DBContext.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, hoTro.getHoTen());
            ps.setString(2, hoTro.getTenHoTro());
            ps.setString(3, hoTro.getMoTa());
            ps.setInt(4, hoTro.getID_TaiKhoan());
            ps.setString(5, hoTro.getDaDuyet());
            ps.setString(6, hoTro.getPhanHoi());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
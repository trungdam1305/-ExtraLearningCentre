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

public class HoTroDAO {

    public static ArrayList<HoTro> adminGetHoTroDashBoard() {
        DBContext db = DBContext.getInstance();
        ArrayList<HoTro> hotros = new ArrayList<HoTro>();

        try {
            String sql = """
                         select * from HoTro 
                         where DaDuyet = N'Chờ duyệt' ; 
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
                        rs.getString("PhanHoi") 
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
                        rs.getString("PhanHoi")  
                
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
}

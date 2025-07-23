/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.PreparedStatement ;
import java.sql.ResultSet ;
import java.sql.SQLException ; 
import java.util.ArrayList ;
import model.TaiKhoanChiTiet ; 
public class TaiKhoanChiTietDAO {
     public static ArrayList<TaiKhoanChiTiet> adminGetAllTaiKhoanHaveName(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<TaiKhoanChiTiet> taikhoans = new ArrayList<TaiKhoanChiTiet>() ; 
        
        try {
            String sql  = """
                          
                          SELECT 
                              T.ID_TaiKhoan,
                              T.Email,
                          
                              T.UserType,
                              COALESCE(HS.HoTen, GV.HoTen, PH.HoTen , ST.HoTen) AS HoTen , 
                          	T.MatKhau , 
                          	T.ID_VaiTro , 
                          	T.UserType , 
                          	T.SoDienThoai , 
                          	T.TrangThai , 
                          	T.NgayTao 
                          FROM TaiKhoan T
                          LEFT JOIN HocSinh HS ON T.ID_TaiKhoan = HS.ID_TaiKhoan
                          LEFT JOIN GiaoVien GV ON T.ID_TaiKhoan = GV.ID_TaiKhoan
                          LEFT JOIN PhuHuynh PH ON T.ID_TaiKhoan = PH.ID_TaiKhoan 
                          LEFT JOIN Staff ST ON T.ID_TaiKhoan = ST.ID_TaiKhoan 
                          where  T.UserType != 'Admin' 

                          """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            
            while (rs.next()) {
                TaiKhoanChiTiet tk = new TaiKhoanChiTiet(
                        rs.getInt("ID_TaiKhoan") ,  
                        rs.getString("Email") , 
                        rs.getString("HoTen") , 
                        rs.getString("UserType") , 
                        rs.getString("MatKhau") , 
                        rs.getInt("ID_VaiTro") , 
                        
                        rs.getString("SoDienThoai") , 
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime() 
                        
                
                ) ; 
                taikhoans.add(tk) ; 
            }
        } catch (SQLException e ) {
            
            return null ; 
        }
        if (taikhoans.isEmpty()){
            return null ; 
        } else {
             return taikhoans ; 
        }
    }
     
   
}

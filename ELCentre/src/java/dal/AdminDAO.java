/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.util.ArrayList ; 
import java.sql.SQLException ; 
import java.sql.PreparedStatement ; 
import java.sql.ResultSet ; 
import model.Admin ; 
public class AdminDAO {
     public static ArrayList<Admin> getNameAdmin(){
        DBContext  db = DBContext.getInstance() ; 
        ArrayList<Admin> admins = new ArrayList<Admin>() ; 
        try {
            String sql = """
                         select *  from Admin 
                         
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                Admin admin = new Admin(
                        rs.getInt("ID_Admin") , 
                        rs.getInt("ID_TaiKhoan") , 
                           rs.getString("HoTen") , 
                        rs.getString("Avatar")
                ) ; 
                admins.add(admin); 
              
            }
        }catch(SQLException e ){
            e.printStackTrace();
            return null ; 
        }
       if (admins.isEmpty()){
           return null ;
       } else {
           return admins ; 
       }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import jakarta.servlet.jsp.jstl.sql.Result;
import java.util.ArrayList ; 
import java.sql.SQLException ; 
import java.sql.PreparedStatement ; 
import java.sql.ResultSet ; 
import model.UserLogs ; 
public class UserLogsDAO {
    public static ArrayList<UserLogs> adminGetAllUserLogs(){
         ArrayList<UserLogs> userlogss = new ArrayList<UserLogs>() ; 
         DBContext db = DBContext.getInstance() ; 
         try {
             String sql = """
                          select * from UserLogs
                          """ ; 
             PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
             ResultSet rs = statement.executeQuery() ; 
             
             while(rs.next()){
                 UserLogs userlogs = new UserLogs(
                         rs.getInt("ID_Log") , 
                         rs.getInt("ID_TaiKhoan") , 
                         rs.getString("HanhDong") , 
                         rs.getTimestamp("ThoiGian").toLocalDateTime()
                 
                 
                 ) ; 
                 userlogss.add(userlogs) ; 
             }
         } catch (SQLException e ){
             e.printStackTrace();
             return null ; 
         }
         
         if (userlogss.isEmpty()){
             return null ; 
         } else {
             return userlogss ; 
         }
    }
    
    
}

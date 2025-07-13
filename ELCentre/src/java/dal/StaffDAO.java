/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Staff ; 
import java.sql.SQLException ; 
import java.sql.PreparedStatement ; 
import java.sql.ResultSet ; 
import java.util.ArrayList;
public class StaffDAO {
    public static ArrayList<Staff> getNameStaff(int ID_TaiKhoan){
        DBContext  db = DBContext.getInstance() ; 
        ArrayList<Staff> staffs = new ArrayList<Staff>() ; 
        try {
            String sql = """
                         select *  from Staff 
                         where ID_TaiKhoan = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, ID_TaiKhoan);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                Staff staff = new Staff(
                        rs.getInt("ID_Staff") , 
                        rs.getInt("ID_TaiKhoan") , 
                           rs.getString("HoTen") , 
                        rs.getString("Avatar")
                ) ; 
                staffs.add(staff); 
              
            }
        }catch(SQLException e ){
            e.printStackTrace();
            return null ; 
        }
       if (staffs.isEmpty()){
           return null ;
       } else {
           return staffs ; 
       }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class HocSinh_LopHocDAO {
    public static int teacherGetTongSoLopHoc(int id){
        DBContext db = DBContext.getInstance() ; 
        int tong = 0 ; 
        try {
            String sql = """
                            SELECT COUNT(*) FROM HocSinh_LopHoc hslh
                            JOIN HocSinh hs
                            on hslh.ID_HocSinh = hs.ID_HocSinh
                            JOIN TaiKhoan tk 
                            on gv.ID_TaiKhoan = tk.ID_TaiKhoan
                            WHERE gv.ID_TaiKhoan = ?
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, id);
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
}

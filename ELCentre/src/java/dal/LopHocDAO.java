/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.SQLException ; 
import java.sql.ResultSet ; 
import java.sql.PreparedStatement ; 
import model.LopHoc ; 
import java.util.ArrayList ; 
public class LopHocDAO {
    public static int adminGetTongSoLopHoc() {
        DBContext db = DBContext.getInstance();
        int tong = 0;

        try {
            String sql = """
                          select count(*) from LopHoc
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
        return tong;
    }
}

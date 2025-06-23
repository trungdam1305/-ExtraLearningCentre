/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

/**
 *
 * @author admin
 */
public class SliderDAO {
    //Listing all Class from the Database
    public List<Slider> getAllSlider() {
        DBContext db = DBContext.getInstance();
        List<Slider> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Slider]";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Slider sl = new Slider();
                sl.setID_Slider(rs.getInt("ID_Slider"));
                sl.setTitle(rs.getString("Title"));
                sl.setImage(rs.getString("Image"));
                sl.setBackLink(rs.getString("BackLink"));
                list.add(sl);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
                return list;
    }
    
    public static void main(String[] args) {
        SliderDAO dao = new SliderDAO();
        List<Slider> li = new ArrayList<>();
        li = dao.getAllSlider();
        for (Slider sl : li){
              System.out.println(sl.getID_Slider() + sl.getImage());
        }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

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

public class HoTroDAO {

    public static ArrayList<HoTro> adminGetHoTroDashBoard() {
        DBContext db = DBContext.getInstance();
        ArrayList<HoTro> hotros = new ArrayList<HoTro>();

        try {
            String sql = """
                         select * from HoTro 
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
                        rs.getInt("ID_TaiKhoan")
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
}

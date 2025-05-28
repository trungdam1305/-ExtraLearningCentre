/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.GiaoVien;

public class GiaoVienDAO {

    public static ArrayList<GiaoVien> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien> giaoviens = new ArrayList<GiaoVien>();

        try {
            String sql = """
                          select * from GiaoVien 
                          """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien giaovien = new GiaoVien(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getString("TruongGiangDay"),
                        rs.getBigDecimal("Luong"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime()
                ) ; 
                giaoviens.add(giaovien) ; 
            }
        } catch (SQLException e) {
            // Exception ignored    
            return new ArrayList<GiaoVien>();
        }
        
        if (giaoviens.isEmpty()){
            return null ; 
            
        } else {
            return giaoviens ;
        }
    }

}

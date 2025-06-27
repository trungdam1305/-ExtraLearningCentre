/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.KhoiHoc;


public class KhoiHocDAO {
    //List All Grade from the database
    public List<KhoiHoc> getAllKhoiHoc() {
        DBContext db = DBContext.getInstance();
        List<KhoiHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM KhoiHoc";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoiHoc kh = new KhoiHoc();
                kh.setID_Khoi(rs.getInt("ID_Khoi"));
                kh.setTenKhoi(rs.getString("TenKhoi"));
                kh.setStatus_Khoi(rs.getInt("Status_Khoi"));
                list.add(kh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
                    return list;
    }
    
    
    
    
    //Debugging DAO
    public static void main(String[] args) {
        List<KhoiHoc> khoi = new ArrayList<KhoiHoc>();
        KhoiHocDAO dao = new KhoiHocDAO();
        khoi = dao.getAllKhoiHoc();
        for (KhoiHoc kh : khoi){
            System.out.println(kh.getTenKhoi() + " " + kh.getStatus_Khoi());
        }
    } 
}

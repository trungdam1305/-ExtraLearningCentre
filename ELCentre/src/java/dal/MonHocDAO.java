/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.LopHoc;
import model.MonHoc;

/**
 *
 * @author Vuh26
 */
public class MonHocDAO {

    public List<MonHoc> getAll() throws SQLException {
        List<MonHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = "SELECT id, tenMonHoc FROM MonHoc";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                MonHoc mh = new MonHoc();
                mh.setId(rs.getInt("id"));
                mh.setTenMonHoc(rs.getString("tenMonHoc"));
                list.add(mh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

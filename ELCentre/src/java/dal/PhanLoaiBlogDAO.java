// Author: trungdam
// Servlet: PhanLoaiBlogDAO
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PhanLoaiBlog;

/**
 *
 * @author admin
 */
public class PhanLoaiBlogDAO {
    /**
     * Retrieves a list of all blog categories (PhanLoaiBlog) from the database.
     */
    public List<PhanLoaiBlog> getAllPhanLoai() {
    List<PhanLoaiBlog> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();
    String sql = "SELECT ID_PhanLoai, PhanLoai FROM PhanLoaiBlog";
    try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            PhanLoaiBlog pl = new PhanLoaiBlog();
            pl.setID_PhanLoai(rs.getInt("ID_PhanLoai"));
            pl.setPhanLoai(rs.getString("PhanLoai"));
            list.add(pl);
        }
    } catch (SQLException e) { // Catch SQLException specifically for database operations
        System.err.println("Lỗi khi lấy danh sách phân loại blog: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) { // Catch any other unexpected exceptions
        e.printStackTrace();
    }

    return list;
}
}
package dal;

import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import model.TruongHoc;

public class TruongHocDAO {

    public static boolean checkTruongHoc(String truonghoc) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = "SELECT * FROM TruongHoc WHERE LTRIM(RTRIM(TenTruongHoc)) = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, truonghoc.trim());
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
    public static ArrayList<TruongHoc> adminGetTenTruong() {
        DBContext db = DBContext.getInstance() ; 
        ArrayList<TruongHoc> truonghocs = new ArrayList<TruongHoc>() ; 
        try {
            String sql = """
                         SELECT * FROM TruongHoc 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()) {
                TruongHoc truong = new TruongHoc(
                        rs.getInt("ID_TruongHoc") , 
                        rs.getString("TenTruongHoc") , 
                        rs.getString("DiaChi")
                
                ) ; 
                truonghocs.add(truong) ; 
            }
        } catch(SQLException e) {
            e.printStackTrace();
            return null ; 
        }
        if (truonghocs == null) {
            return null ; 
        } else {
            return truonghocs ; 
        }
    }
    
        public static List<TruongHoc> getAllSchools() {
        List<TruongHoc> list = new ArrayList<>();
        String sql = "SELECT ID_TruongHoc, TenTruongHoc FROM TruongHoc";

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TruongHoc t = new TruongHoc();
                t.setID_TruongHoc(rs.getInt("ID_TruongHoc"));
                t.setTenTruongHoc(rs.getString("TenTruongHoc"));
                list.add(t);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public static int getIdByTenTruongHoc(String tenTruong) {
        String sql = "SELECT ID_TruongHoc FROM TruongHoc WHERE TenTruongHoc = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenTruong);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("ID_TruongHoc");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public int getOrInsertTruongHoc(String tenTruongHoc) {
        try (Connection conn = DBContext.getInstance().getConnection()) {
            // Check if exists
            String checkSql = "SELECT ID_TruongHoc FROM TruongHoc WHERE TenTruongHoc = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, tenTruongHoc);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) return rs.getInt("ID_TruongHoc");
            }

            // Insert if not found
            String insertSql = "INSERT INTO TruongHoc (TenTruongHoc) VALUES (?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                insertStmt.setString(1, tenTruongHoc);
                insertStmt.executeUpdate();
                ResultSet rs = insertStmt.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

}

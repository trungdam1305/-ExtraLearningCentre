package dao;

/**
 *
 * @author wrx_Chur04
 */
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

}

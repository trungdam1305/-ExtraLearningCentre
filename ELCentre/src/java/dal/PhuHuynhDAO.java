
package dal;

import java.sql.Types;
import java.math.BigDecimal;
import java.sql.SQLException ; 
import java.util.ArrayList ; 
import java.sql.ResultSet ; 
import java.sql.Timestamp;
import java.sql.PreparedStatement ; 
import model.PhuHuynh ; 
public class PhuHuynhDAO {
    public static ArrayList<PhuHuynh> adminGetPhuHuynhByID(String ID_TaiKhoan) {
        ArrayList<PhuHuynh> phuhuynhs = new ArrayList<PhuHuynh>() ; 
        DBContext db = DBContext.getInstance() ; 
        
        try {
            String sql = """
                         select * from PhuHuynh
                         where ID_TaiKhoan = ? 
                         """ ; 
            
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, ID_TaiKhoan);
            ResultSet rs = statement.executeQuery() ; 
            
            while(rs.next()){
                PhuHuynh phuhuynh = new PhuHuynh(
                        rs.getInt("ID_PhuHuynh") , 
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getString("HoTen") , 
                        rs.getString("SDT") , 
                        rs.getString("Email") , 
                        rs.getString("DiaChi") , 
                        rs.getString("GhiChu") , 
                        
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime()
                
                
                ) ; 
                phuhuynhs.add(phuhuynh) ; 
            }
        } catch (SQLException e ){
            e.printStackTrace();
            return null ; 
        }
        
        if (phuhuynhs.isEmpty()){
            return null ; 
        } else {
            return phuhuynhs  ; 
        }
    }
    public static boolean adminEnablePhuHuynh(String ID_TaiKhoan) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE PhuHuynh
                         SET TrangThai = 'Active'
                         WHERE ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, ID_TaiKhoan);
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ) {
            e.printStackTrace();
             
        }
        if (rs == 0 ){
            return false ; 
        } else {
            return true ; 
        }
    }
    
    public static boolean adminDisablePhuHuynh(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE PhuHuynh
                         SET TrangThai = 'Inactive'
                         WHERE ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ) {
            e.printStackTrace();
             
        }
        if (rs == 0 ){
            return false ; 
        } else {
            return true ; 
        }
    }
    
    
    public static boolean adminUpdateInformationOfParent(String sdt , String diachi  , String ghichu , int id){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE PhuHuynh
                         SET
                        SDT = ?,
                        DiaChi = ?,
                        
                        GhiChu = ?
                         WHERE
                         ID_PhuHuynh = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1 , sdt);
            statement.setString(2 , diachi) ; 
            
            statement.setString(3, ghichu);
            statement.setInt(4, id);
            
            rs = statement.executeUpdate() ; 
        } catch (SQLException e ){
            e.printStackTrace();
            return false ; 
        }
        
        if (rs == 0 ) {
            return false ; 
        } else {
               return true ; 
        }
    }

    public void insertPhuHuynh(PhuHuynh ph) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO PhuHuynh (ID_TaiKhoan, HoTen, Email, SDT, DiaChi, GhiChu, TrangThai, NgayTao)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, ph.getID_TaiKhoan());
            statement.setString(2, ph.getHoTen());

            if (ph.getEmail() != null) {
                statement.setString(3, ph.getEmail());
            } else {
                statement.setNull(3, Types.VARCHAR);
            }

            if (ph.getSDT() != null) {
                statement.setString(4, ph.getSDT());
            } else {
                statement.setNull(4, Types.VARCHAR);
            }

            if (ph.getDiaChi() != null) {
                statement.setString(5, ph.getDiaChi());
            } else {
                statement.setNull(5, Types.VARCHAR);
            }

            if (ph.getGhiChu() != null) {
                statement.setString(6, ph.getGhiChu());
            } else {
                statement.setNull(6, Types.VARCHAR);
            }

            statement.setString(7, ph.getTrangThai());

            if (ph.getNgayTao() != null) {
                statement.setTimestamp(8, Timestamp.valueOf(ph.getNgayTao()));
            } else {
                statement.setNull(8, Types.TIMESTAMP);
            }

            statement.executeUpdate();
        }
    }
}

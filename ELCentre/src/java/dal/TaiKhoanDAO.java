
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.Connection;
import java.math.BigDecimal;
import java.sql.PreparedStatement ;
import java.sql.ResultSet ;
import java.sql.SQLException ; 
import java.util.ArrayList ;
import model.TaiKhoan ; 
public class TaiKhoanDAO {
    
    public static ArrayList<TaiKhoan> adminGetAllTaiKhoan(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<TaiKhoan> taikhoans = new ArrayList<TaiKhoan>() ; 
        
        try {
            String sql  = """
                          select * from TaiKhoan 
                          WHERE  UserType != 'Admin'
                          
                          """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            
            while (rs.next()) {
                TaiKhoan tk = new TaiKhoan(
                        rs.getInt("ID_TaiKhoan") ,  
                        rs.getString("Email") , 
                        rs.getString("MatKhau") , 
                        rs.getInt("ID_VaiTro") , 
                        rs.getString("UserType") , 
                        rs.getString("SoDienThoai") , 
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime() 
                        
                
                ) ; 
                taikhoans.add(tk) ; 
            }
        } catch (SQLException e ) {
            
            return null ; 
        }
        if (taikhoans.isEmpty()){
            return null ; 
        } else {
                        return taikhoans ; 
        }
    }
    
    public static boolean adminDisableAccountUser(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
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
    
    
    public static boolean adminEnableAccountUser(String ID_TaiKhoan) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
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
    
    public static boolean adminEnableSatff(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE Staff
                         SET TrangThai = 'Active'
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
    
    public static boolean adminUpdateInformationAccountMK(String sdt, String matkhau ,  int id){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
                         SET
                         MatKhau = ? ,
                        SoDienThoai = ?
                        
                         WHERE
                         ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, matkhau);
            statement.setString(2 , sdt);
            
            statement.setInt(3, id);
            
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
    
    public static boolean adminUpdateInformationAccount(String sdt,  int id){
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE TaiKhoan
                         SET
                        SoDienThoai = ?
                       
                         WHERE
                         ID_TaiKhoan = ?;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1 , sdt);
            
            statement.setInt(2, id);
            
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
    
    public static String admingetSDTTaiKhoanByID(String id) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                         SELECT SoDienThoai FROM TaiKhoan 
                         where ID_TaiKhoan = ? 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, id);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getString("SoDienThoai"); 
            } else {
                return null; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }
    
    public static int adminGetIDTaiKhoanByEmail(String email){
        DBContext db = DBContext.getInstance() ; 
        try {
            String sql = """
                         select ID_TaiKhoan from TaiKhoan 
                         where Email = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery() ; 
            if (rs.next()){
                return rs.getInt("ID_TaiKhoan") ; 
            } 
        } catch(SQLException e){
            e.printStackTrace();
            
        }
        return -1 ; 
    }
    
    public static String adminGetNameTaiKhoanByID(String ID_TaiKhoan){
        DBContext db = DBContext.getInstance() ; 
        try {
            String sql = """
                         select HoTen from Staff
                         select HoTen from Staff ST 
                        JOIN TaiKhoan TK ON TK.ID_TaiKhoan = ST.ID_TaiKhoan
                        where ST.ID_TaiKhoan = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, ID_TaiKhoan);
            ResultSet rs = statement.executeQuery() ; 
            if (rs.next()){
                return rs.getString("HoTen") ; 
            } 
        } catch(SQLException e){
            e.printStackTrace();
            
        }
        return null  ; 
    }
        
    public static boolean insertPendingAccount(String email, String hashedPassword, String sdt, String hoTen) {
    String sql = "INSERT INTO TaiKhoan (Email, MatKhau, ID_VaiTro, UserType, SoDienThoai, TrangThai, NgayTao) "
               + "VALUES (?, ?, 4, N'HocSinh', ?, N'Pending', GETDATE())";
    try (Connection con = DBContext.getInstance().getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, email);
        ps.setString(2, hashedPassword);
        ps.setString(3, sdt);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    public static ArrayList<TaiKhoan> getPendingAccounts() {
    ArrayList<TaiKhoan> list = new ArrayList<>();
    String sql = "SELECT * FROM TaiKhoan WHERE TrangThai = 'Pending' ORDER BY NgayTao DESC";
    try (Connection con = DBContext.getInstance().getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        
        while (rs.next()) {
            TaiKhoan tk = new TaiKhoan(
                rs.getInt("ID_TaiKhoan"),
                rs.getString("Email"),
                rs.getString("MatKhau"),
                rs.getInt("ID_VaiTro"),
                rs.getString("UserType"),
                rs.getString("SoDienThoai"),
                rs.getString("TrangThai"),
                rs.getTimestamp("NgayTao").toLocalDateTime()
            );
            list.add(tk);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    
    public static boolean updateTrangThai(int id, String newStatus) {
    String sql = "UPDATE TaiKhoan SET TrangThai = ? WHERE ID_TaiKhoan = ?";
    try (Connection con = DBContext.getInstance().getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, newStatus);
        ps.setInt(2, id);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}   

       
}
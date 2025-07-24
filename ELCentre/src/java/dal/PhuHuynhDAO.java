
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException ; 
import java.util.ArrayList ; 
import java.sql.ResultSet ; 
import java.sql.PreparedStatement ; 
import java.util.List;
import model.HocSinh;
import model.PhuHuynh ; 
public class PhuHuynhDAO {
    public static ArrayList<PhuHuynh> adminGetPhuHuynhByID(String ID_TaiKhoan) {
        ArrayList<PhuHuynh> phuhuynhs = new ArrayList<PhuHuynh>() ; 
        DBContext db = DBContext.getInstance() ; 
        
        try {
            String sql = """
                          select * from PhuHuynh PH
                        JOIN TaiKhoan TK 
                        ON TK.ID_TaiKhoan = PH.ID_TaiKhoan
                         where PH.ID_TaiKhoan = ? 
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
                        rs.getTimestamp("NgayTao").toLocalDateTime() ,
                        rs.getString("MatKhau")
                
                
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
    
       

    public static PhuHuynh getPhuHuynhByTaiKhoanId(int idTaiKhoan) {
        String query = "SELECT * FROM PhuHuynh WHERE ID_TaiKhoan = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, idTaiKhoan);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PhuHuynh ph = new PhuHuynh();
                ph.setID_PhuHuynh(rs.getInt("ID_PhuHuynh"));
                ph.setHoTen(rs.getString("HoTen"));
                ph.setEmail(rs.getString("Email"));
                ph.setSDT(rs.getString("SDT"));
                ph.setDiaChi(rs.getString("DiaChi"));
                ph.setAvatar(rs.getString("Avatar"));
                ph.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                return ph;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static int getPhuHuynhIdByTaiKhoanId(int idTaiKhoan) {
        int idPhuHuynh = -1;
        String sql = "SELECT ID_PhuHuynh FROM PhuHuynh WHERE ID_TaiKhoan = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idTaiKhoan);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                idPhuHuynh = rs.getInt("ID_PhuHuynh");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return idPhuHuynh;
    }
    
    public static PhuHuynh getPhuHuynhById(int idPhuHuynh) {
        PhuHuynh ph = null;
        String sql = "SELECT * FROM PhuHuynh WHERE ID_PhuHuynh = ?";
        try (Connection con = DBContext.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPhuHuynh);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ph = new PhuHuynh();
                ph.setID_PhuHuynh(rs.getInt("ID_PhuHuynh"));
                ph.setHoTen(rs.getString("HoTen"));
                ph.setSDT(rs.getString("SDT"));
                ph.setEmail(rs.getString("Email"));
                ph.setDiaChi(rs.getString("DiaChi"));
                ph.setGhiChu(rs.getString("GhiChu"));
                ph.setTrangThai(rs.getString("TrangThai"));
                ph.setAvatar(rs.getString("Avatar"));
                 java.sql.Timestamp sqlNgayTao = rs.getTimestamp("NgayTao");
                if (sqlNgayTao != null) {
                    ph.setNgayTao(sqlNgayTao.toLocalDateTime());
                }
                ph.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ph;
    }
    
    public static List<HocSinh> getListCon(int idPhuHuynh) {
        List<HocSinh> list = new ArrayList<>();
        String sql = "SELECT hs.* FROM HocSinh hs " +
                     "JOIN HocSinh_PhuHuynh hsp ON hs.ID_HocSinh = hsp.ID_HocSinh " +
                     "WHERE hsp.ID_PhuHuynh = ?";
        try (Connection con = DBContext.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idPhuHuynh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HocSinh hs = new HocSinh();
                hs.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hs.setHoTen(rs.getString("hoTen"));
                hs.setNgaySinh(rs.getDate("ngaySinh").toLocalDate());
                hs.setLopDangHocTrenTruong(rs.getString("lopDangHocTrenTruong"));
                hs.setAvatar(rs.getString("avatar"));
                list.add(hs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static boolean updatePhuHuynh(PhuHuynh ph) {
    String sql = "UPDATE PhuHuynh SET hoTen = ?, SDT = ?, email = ?, diaChi = ?, ghiChu = ?, avatar = ? WHERE ID_PhuHuynh = ?";
    try (Connection con = DBContext.getInstance().getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, ph.getHoTen());
        ps.setString(2, ph.getSDT());
        ps.setString(3, ph.getEmail());
        ps.setString(4, ph.getDiaChi());
        ps.setString(5, ph.getGhiChu());
        ps.setString(6, ph.getAvatar());
        ps.setInt(7, ph.getID_PhuHuynh());

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
    public static void main(String[] args) {
    int testId = 1; // ID_PhuHuynh cần kiểm tra

    PhuHuynh ph = getPhuHuynhById(testId);

    if (ph != null) {
        System.out.println("✅ Thông tin phụ huynh:");
        System.out.println("ID_PhuHuynh: " + ph.getID_PhuHuynh());
        System.out.println("Họ tên     : " + ph.getHoTen());
        System.out.println("SĐT        : " + ph.getSDT());
        System.out.println("Email      : " + ph.getEmail());
        System.out.println("Địa chỉ    : " + ph.getDiaChi());
        System.out.println("Ghi chú    : " + ph.getGhiChu());
        System.out.println("Trạng thái : " + ph.getTrangThai());
        System.out.println("Avatar     : " + ph.getAvatar());
        System.out.println("Ngày tạo   : " + ph.getNgayTao());
        System.out.println("ID_Tài khoản: " + ph.getID_TaiKhoan());
    } else {
        System.out.println("❌ Không tìm thấy phụ huynh với ID_PhuHuynh = " + testId);
    }
}

}
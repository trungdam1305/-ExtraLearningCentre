package dal;

/**
 *
 * @author wrx_Chur04
 */
import model.ThongBao;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import model.GiaoVien_ChiTietDay;

public class ThongBaoDAO {

    

    public static void insertThongBaoTuVan(String noiDung) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO ThongBao (ID_TaiKhoan, NoiDung, ID_HocPhi, ThoiGian) " + "VALUES (?, ?, ?, GETDATE())";

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setNull(1, java.sql.Types.INTEGER);
            ps.setString(2, noiDung);
            ps.setNull(3, java.sql.Types.INTEGER);
            ps.executeUpdate();
        }
    }

    public static ThongBao getThongBaoById(int id) {
        DBContext db = DBContext.getInstance();
        ThongBao tb = null;

        try {
            String sql = "SELECT * FROM ThongBao WHERE ID_ThongBao = ?";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tb = new ThongBao(
                        rs.getInt("ID_ThongBao"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("noiDung"),
                        rs.getInt("ID_HocPhi"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime() , 
                        rs.getString("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tb;
    }

    public static ArrayList<ThongBao> getAllTuVan() {
        ArrayList<ThongBao> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM ThongBao WHERE NoiDung LIKE N'%tư vấn%' ORDER BY ThoiGian DESC";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ThongBao tb = new ThongBao(
                        rs.getInt("ID_ThongBao"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("NoiDung"),
                        rs.getInt("ID_HocPhi"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime(),
                        rs.getString("Status")
                );
                list.add(tb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean adminSendNotification(String ID_TaiKhoan, String NoiDung , String status) {
        int rs = 0;
        DBContext db = DBContext.getInstance();
        LocalDateTime now = LocalDateTime.now();
        try {
            String sql = """
                         insert into ThongBao(ID_TaiKhoan , NoiDung , ThoiGian  , Status)
                         values ( ?  , ? , ?  , ?) 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_TaiKhoan);
            statement.setString(2, NoiDung);
            statement.setTimestamp(3, Timestamp.valueOf(now));
            statement.setString(4, status);
            rs = statement.executeUpdate();
            while (rs > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    public static ArrayList<GiaoVien_ChiTietDay> adminGetAllLopHocDangHocToSendThongBao() {
        ArrayList<GiaoVien_ChiTietDay> lophocs = new ArrayList<GiaoVien_ChiTietDay>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select LH.ID_KhoaHoc, LH.ID_LopHoc , GVLH.ID_GiaoVien , GV.HoTen , TH.TenTruongHoc  , LH.TenLopHoc , LH.SiSo  , LH.GhiChu , LH.TrangThai , LH.NgayTao , LH.Image  , KH.TenKhoaHoc , KH.ID_Khoi from GiaoVien_LopHoc GVLH 
                        join LopHoc LH 
                        on GVLH.ID_LopHoc = LH.ID_LopHoc 

                        JOIN GiaoVien GV 
                        ON GVLH.ID_GiaoVien = GV.ID_GiaoVien
                        JOIN TruongHoc TH 
                        ON TH.ID_TruongHoc = GV.ID_TruongHoc
                         JOIN KhoaHoc KH 
                         ON KH.ID_KhoaHoc = LH.ID_KhoaHoc

                        WHERE 
                       LH.TrangThai = N'Đang học'; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                GiaoVien_ChiTietDay giaovien = new GiaoVien_ChiTietDay(
                        rs.getInt("ID_KhoaHoc"),
                        rs.getInt("ID_LopHoc"),
                        rs.getInt("ID_GiaoVien"),
                        rs.getString("HoTen"),
                        rs.getString("TenTruongHoc"),
                        rs.getString("TenLopHoc"),
                        rs.getString("SiSo"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Image"),
                        rs.getInt("ID_Khoi"),
                        rs.getString("TenKhoaHoc")
                );
                lophocs.add(giaovien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (lophocs == null) {
            return null;
        } else {
            return lophocs;
        }
    }

    public static boolean adminSendClassNotification(ArrayList<String> ID_TaiKhoanHS, String NoiDungHS , String Status) {
        int rs = 0;
        DBContext db = DBContext.getInstance();
        LocalDateTime now = LocalDateTime.now();
        try {
            String sql = """
                         insert into ThongBao(ID_TaiKhoan , NoiDung , ThoiGian , Status )
                        values ( ?  , ? , ?  , ?) 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            for (String id : ID_TaiKhoanHS) {
                statement.setString(1, id);
                statement.setString(2, NoiDungHS);
                statement.setTimestamp(3, Timestamp.valueOf(now));
                statement.setString(4, Status);
                statement.addBatch();
            }

            int[] result = statement.executeBatch();
            for (int r : result) {
                if (r > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    public static ArrayList<String> adminGetAllID_HocSinhDangHocToSendNTF() {
        ArrayList<String> listID = new ArrayList<String>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select HS.ID_TaiKhoan from HocSinh HS 
                         join TaiKhoan TK 
                         on  TK.ID_TaiKhoan = HS.ID_TaiKhoan
                         WHERE HS.TrangThaiHoc = N'Đang học'
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                listID.add(rs.getString("ID_TaiKhoan"));
            }
            return listID;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static ArrayList<String> adminGetAllID_GiaoVienDangDayToSendNTF() {
        ArrayList<String> listID = new ArrayList<String>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select GV.ID_TaiKhoan from GiaoVien GV
                         join TaiKhoan TK 
                         on  TK.ID_TaiKhoan = GV.ID_TaiKhoan
                         WHERE GV.TrangThaiDay = N'Đang dạy'
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                listID.add(rs.getString("ID_TaiKhoan"));
            }
            return listID;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    public static boolean adminSendNotificationToAllUser(ArrayList<String> ID_TaiKhoan, String NoiDung , String Status) {
        int rs = 0;
        DBContext db = DBContext.getInstance();
        LocalDateTime now = LocalDateTime.now();
        try {
            String sql = """
                         insert into ThongBao(ID_TaiKhoan , NoiDung , ThoiGian  , Status)
                         values ( ?  , ? , ?  , ?) 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            for (String id : ID_TaiKhoan) {
                statement.setString(1, id);
                statement.setString(2, NoiDung);
                statement.setTimestamp(3, Timestamp.valueOf(now));
                statement.setString(4, Status);
                statement.addBatch();
            }

            int[] result = statement.executeBatch();
            for (int r : result) {
                if (r > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }
    
    

    public static ArrayList<String> adminGetListIDHSbyID_LopHoc(String ID_LopHoc) {
        DBContext db = DBContext.getInstance();
        ArrayList<String> listID = new ArrayList<String>();

        try {
            String sql = """
                        select  HS.ID_TaiKhoan from HocSinh_LopHoc HL 
                        JOIN HocSinh HS
                        ON HS.ID_HocSinh = HL.ID_HocSinh
                        WHERE HL.ID_LopHoc = ?  ; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_LopHoc);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                listID.add(rs.getString("ID_TaiKhoan"));
            }
            return listID;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String adminGetIdGiaoVienToSendNTF(String ID_LopHoc) {
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                        select  GV.ID_TaiKhoan from GiaoVien_LopHoc GL
                        JOIN GiaoVien GV
                        ON GV.ID_GiaoVien = GL.ID_GiaoVien
                        WHERE GL.ID_LopHoc = ? ;
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_LopHoc);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getString("ID_TaiKhoan");
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return null;
    }

    public static ArrayList<String> adminGetListIDHSToSendNTFToAllClass(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<String> listID = new ArrayList<String>() ; 
        
        try {
            String sql = """
                        SELECT DISTINCT HS.ID_TaiKhoan 
                          FROM HocSinh_LopHoc HL 
                          JOIN HocSinh HS ON HS.ID_HocSinh = HL.ID_HocSinh
                          JOIN LopHoc LH ON LH.ID_LopHoc = HL.ID_LopHoc
                          WHERE LH.TrangThai = N'Đang học'; 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            
            ResultSet rs = statement.executeQuery() ;  
            while(rs.next()) {
               listID.add(rs.getString("ID_TaiKhoan") ) ; 
            }
            return listID;
        } catch(SQLException  e ) {
            e.printStackTrace();
            return null ; 
        }
    }
    
    public static ArrayList<String> adminGetListIDGVToSendNTFToAllClass(){
        DBContext db = DBContext.getInstance() ; 
        ArrayList<String> listID = new ArrayList<String>() ; 
        
        try {
            String sql = """
                        SELECT DISTINCT GV.ID_TaiKhoan 
                        FROM GiaoVien_LopHoc GL
                        JOIN GiaoVien GV ON GV.ID_GiaoVien = GL.ID_GiaoVien
                        JOIN LopHoc LH ON LH.ID_LopHoc = GL.ID_LopHoc
                        WHERE LH.TrangThai = N'Đang học';
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            
            ResultSet rs = statement.executeQuery() ;  
            while(rs.next()) {
               listID.add(rs.getString("ID_TaiKhoan") ) ; 
            }
            return listID;
        } catch(SQLException  e ) {
            e.printStackTrace();
            return null ; 
        }
    }
    
    
    public static void main(String[] args) {
        System.out.println(adminGetAllID_HocSinhDangHocToSendNTF().size());
    }
}

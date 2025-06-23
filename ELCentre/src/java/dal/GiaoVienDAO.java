/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.Connection;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien;
import model.GiaoVien_TruongHoc ; 

public class GiaoVienDAO {
     private Connection conn;
    public static ArrayList<GiaoVien_TruongHoc> admminGetAllGiaoVien() {
        DBContext db = DBContext.getInstance();
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>();

        try {
            String sql = """
                          select * from GiaoVien gv JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc
                          """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien_TruongHoc giaovien = new GiaoVien_TruongHoc(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc") , 
                        rs.getString("DiaChi") 
                ) ; 
                giaoviens.add(giaovien) ; 
            }
        } catch (SQLException e) {
            // Exception ignored    
           e.printStackTrace();
            return null ;
        }
        
        if (giaoviens.isEmpty()){
            return null ; 
            
        } else {
            return giaoviens ;
        }
    }
    //Get All information from teacher contain Avatar
    public ArrayList<GiaoVien> HomePageGetGiaoVien() {
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
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc")
                ); 
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
    //Get Teacher by Name to have Specialised Teacher
    public GiaoVien getGiaoVienByHoTen(String hoTen) {
    DBContext db = DBContext.getInstance();
    GiaoVien gv = null;
    String sql = "SELECT * FROM GiaoVien gv JOIN TruongHoc th"
            + "ON gv.ID_TruongHoc = th.ID_TruongHoc"
            + " WHERE HoTen COLLATE Latin1_General_CI_AI = ?";
    try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
        statement.setString(1, hoTen.trim()); // loại bỏ khoảng trắng đầu cuối trước khi set
        ResultSet rs = statement.executeQuery();

        if (rs.next()) {
            gv = new GiaoVien();
            gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
            gv.setHoTen(rs.getString("HoTen"));
            gv.setChuyenMon(rs.getString("ChuyenMon"));
            gv.setSDT(rs.getString("SDT"));
            gv.setTenTruongHoc(rs.getString("TenTruongHoc"));
            gv.setLuong(rs.getBigDecimal("Luong"));
            gv.setIsHot(rs.getInt("IsHot"));
            gv.setTrangThai(rs.getString("TrangThai"));
            gv.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
            gv.setAvatar(rs.getString("Avatar"));
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return gv;
}   
    //Get Teacher to have Specialised Teacher
    public ArrayList<GiaoVien> getSpecialised() {
            DBContext db = DBContext.getInstance();
    ArrayList<GiaoVien> giaoviens = new ArrayList<>();
    String sql = "SELECT gv.*, th.TenTruongHoc FROM GiaoVien gv "
               + "JOIN TruongHoc th ON gv.ID_TruongHoc = th.ID_TruongHoc "
               + "ORDER BY gv.IsHot ASC;";
    try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            GiaoVien gv = new GiaoVien();
            gv.setID_GiaoVien(rs.getInt("ID_GiaoVien"));
            gv.setHoTen(rs.getString("HoTen"));
            gv.setChuyenMon(rs.getString("ChuyenMon"));
            gv.setSDT(rs.getString("SDT"));
            gv.setTenTruongHoc(rs.getString("TenTruongHoc"));
            gv.setLuong(rs.getBigDecimal("Luong"));
            gv.setIsHot(rs.getInt("IsHot"));
            gv.setTrangThai(rs.getString("TrangThai"));
            gv.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
            gv.setAvatar(rs.getString("Avatar"));
            giaoviens.add(gv);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return giaoviens;
}


    
    
    public static ArrayList<GiaoVien_TruongHoc> adminGetGiaoVienByID(String id) {
        DBContext db = DBContext.getInstance() ; 
        ArrayList<GiaoVien_TruongHoc> giaoviens = new ArrayList<GiaoVien_TruongHoc>() ; 
        
        try {
            String sql = """
                         select * from GiaoVien gv JOIN TruongHoc th 
                         ON gv.ID_TruongHoc = th.ID_TruongHoc
                         where ID_TaiKhoan = ? 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, id);
            ResultSet rs = statement.executeQuery() ; 
            
             while (rs.next()) {
                GiaoVien_TruongHoc giaovien = new GiaoVien_TruongHoc(
                        rs.getInt("ID_GiaoVien"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("ChuyenMon"),
                        rs.getString("SDT"),
                        rs.getInt("ID_TruongHoc"),
                        rs.getBigDecimal("Luong"),
                        rs.getInt("IsHot"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Avatar"),
                        rs.getString("TenTruongHoc") , 
                        rs.getString("DiaChi")
                ) ; 
                giaoviens.add(giaovien) ; 
            }
             
        } catch (SQLException e ) {
            e.printStackTrace();
            return null ; 
        }
        
        if (giaoviens.isEmpty()){
            return null ; 
        } else {
            return giaoviens ; 
        }
    }
    
    public static boolean adminEnableGiaoVien(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE GiaoVien
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
    
    public static boolean adminDisableGiaoVien(String id) {
        DBContext db = DBContext.getInstance() ; 
        int rs = 0 ; 
        try {
            String sql = """
                         UPDATE GiaoVien
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
    
    public static int adminGetTongSoGiaoVien(){
        DBContext db = DBContext.getInstance() ; 
        int tong = 0 ; 
        try {
            String sql = """
                         select count(*) from GiaoVien
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }
        } catch (SQLException e ){
            e.printStackTrace();
            
        }
        return tong ; 
    }
    
    
    public static boolean adminUpdateInformationOfTeacher(String sdt, BigDecimal luong, int ishot, int idGiaoVien) {
            DBContext db = DBContext.getInstance() ; 
            int rs = 0 ; 
            
            try {
                String sql = """
                             UPDATE GiaoVien 
                             SET 
                             SDT = ?  , 
                             Luong = ? , 
                             IsHot = ? 
                             where ID_GiaoVien = ? 
                             """ ; 
                PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
                statement.setString(1, sdt);
                statement.setBigDecimal(2, luong);
                statement.setInt(3 , ishot) ; 
                statement.setInt(4, idGiaoVien);
                rs = statement.executeUpdate() ; 
                
            } catch (SQLException e){
                e.printStackTrace();
                
            }
            
            if (rs == 0 ) {
                return false ; 
            } else {
                return true ; 
            }
    }

    
    public double getLuongTheoTaiKhoan(int idTaiKhoan) {
    DBContext db = DBContext.getInstance();
    double luong = -1;

    String sql = "SELECT GiaoVien.Luong FROM GiaoVien join TaiKhoan\n" +
"  ON GiaoVien.ID_TaiKhoan  = TaiKhoan.ID_TaiKhoan\n" +
"  WHERE GiaoVien.ID_TaiKhoan = ?";

    try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
        statement.setInt(1, idTaiKhoan);
        ResultSet rs = statement.executeQuery();

        if (rs.next()) {
            luong = rs.getDouble("Luong"); 
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return luong;
}

    

    //Debugging DAO
    public static void main(String[] args) {
                 GiaoVienDAO dao = new GiaoVienDAO();
                 double a = dao.getLuongTheoTaiKhoan(11);
        System.out.println(a);
    }

}

package dal;

/**
 *
 * @author wrx_Chur04
 */
import model.HocSinh_ChiTietHoc;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import model.GiaoVien;
import model.HocSinh;

public class HocSinh_ChiTietDAO {

    public static ArrayList<HocSinh_ChiTietHoc> adminGetAllLopHocCuaHocSinh(String ID_HocSinh) {
        ArrayList<HocSinh_ChiTietHoc> hocsinhchitiets = new ArrayList<HocSinh_ChiTietHoc>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                         select DISTINCT  LH.ID_KhoaHoc ,  HSLH.ID_LopHoc , HSLH.ID_HocSinh ,GV.ID_GiaoVien  , LH.TenLopHoc   ,  GV.HoTen , LH.GhiChu , LH.TrangThai , LH.SoTien , HP.TinhTrangThanhToan , LH.NgayTao , LH.Image    from HocSinh_LopHoc HSLH
                        join  LopHoc LH
                        on HSLH.ID_LopHoc = LH.ID_LopHoc 
                        JOIN GiaoVien_LopHoc GVLH 
                        on HSLH.ID_LopHoc = GVLH.ID_LopHoc
                        JOIN GiaoVien GV 
                        on GV.ID_GiaoVien = GVLH.ID_GiaoVien
                        JOIN HocPhi HP 
                        on  HP.ID_LopHoc = HSLH.ID_LopHoc
                        WHERE HSLH.ID_HocSinh = ? 
                        and LH.TrangThai = N'Đang học'
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_HocSinh);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                HocSinh_ChiTietHoc hocsinh = new HocSinh_ChiTietHoc(
                        rs.getInt("ID_KhoaHoc"),
                        rs.getInt("ID_LopHoc"),
                        rs.getInt("ID_HocSinh"),
                        rs.getInt("ID_GiaoVien"),
                        rs.getString("TenLopHoc"),
                        
                        rs.getString("HoTen"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        
                        rs.getString("SoTien"),
                        rs.getString("TinhTrangThanhToan") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Image")
                );
                hocsinhchitiets.add(hocsinh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (hocsinhchitiets == null) {
            return null;
        } else {
            return hocsinhchitiets;
        }
    }

    public static ArrayList<GiaoVien> adminGetLopHocCuaGiaoVienSoVoiHocSinh(String ID_HocSinh) {
        ArrayList<GiaoVien> lopdangdaycuaGiaoVien = new ArrayList<GiaoVien>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                     SELECT GV.ID_TruongHoc ,  GV.LopDangDayTrenTruong 
                                         FROM HocSinh_LopHoc HSLH
                                         join  LopHoc LH
                                        on HSLH.ID_LopHoc = LH.ID_LopHoc 
                                        JOIN GiaoVien_LopHoc GVLH 
                                        on HSLH.ID_LopHoc = GVLH.ID_LopHoc
                                        JOIN GiaoVien GV 
                                        on GV.ID_GiaoVien = GVLH.ID_GiaoVien
                                        
                                        WHERE HSLH.ID_HocSinh = ? ;
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_HocSinh);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                GiaoVien giaovien = new GiaoVien(
                        rs.getInt("ID_TruongHoc") , 
                        rs.getString("LopDangDayTrenTruong") 
                ) ; 
                lopdangdaycuaGiaoVien.add(giaovien) ; 
            }
            return lopdangdaycuaGiaoVien;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static boolean updateTruongLopHocSinh(String DiaChi  , String ID_TruongHoc  , String GhiChu , String LopDangHocTrenTruong , String ID_HocSinh) {
        
        DBContext db = DBContext.getInstance() ; 
       int rs = 0 ; 
        try {
            String sql = """
                         update HocSinh 
                         set  DiaChi = ? ,
                         ID_TruongHoc = ? , 
                         GhiChu = ?  , 
                         LopDangHocTrenTruong = ? 
                         where ID_HocSinh = ?   
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, DiaChi);
            statement.setString(2, ID_TruongHoc);
            statement.setString(3, GhiChu);
            statement.setString(4, LopDangHocTrenTruong);
            statement.setString(5, ID_HocSinh);
           
             rs = statement.executeUpdate() ; 
            while(rs > 0 ){
                return true ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace();
           
        }
        return false ; 
    }
    
    public static ArrayList<HocSinh> adminGetLopHocCuaHocSinhSoVoiGiaoVien(String ID_GiaoVien) {
        ArrayList<HocSinh> lopdangdaycuaGiaoVien = new ArrayList<HocSinh>();
        DBContext db = DBContext.getInstance();

        try {
            String sql = """
                     select  HS.ID_TruongHoc , HS.LopDangHocTrenTruong   from HocSinh_LopHoc HSLH
                    join  LopHoc LH
                    on HSLH.ID_LopHoc = LH.ID_LopHoc 
                    JOIN GiaoVien_LopHoc GVLH 
                    on HSLH.ID_LopHoc = GVLH.ID_LopHoc
                    JOIN GiaoVien GV 
                    on GV.ID_GiaoVien = GVLH.ID_GiaoVien

                    join HocSinh HS 
                  ON HS.ID_HocSinh = HSLH.ID_HocSinh
                  WHERE GV.ID_GiaoVien = ? ; 
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_GiaoVien);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                HocSinh hocsinh = new HocSinh(
                        rs.getInt("ID_TruongHoc") , 
                        rs.getString("LopDangHocTrenTruong") 
                ) ; 
                lopdangdaycuaGiaoVien.add(hocsinh) ; 
            }
            return lopdangdaycuaGiaoVien;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
   public static boolean updateTruongLopGiaoVien(String idTruongHoc  , String lopTrenTruong  , String sdt , String hot , String ID_GiaoVien) {
        
        DBContext db = DBContext.getInstance() ; 
       int rs = 0 ; 
        try {
            String sql = """
                         update GiaoVien 
                         set 
                         ID_TruongHoc = ? , 
                         IsHot = ?  , 
                         LopDangDayTrenTruong = ? , 
                         SDT = ? 
                         where ID_GiaoVien = ?   
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, idTruongHoc);
            statement.setString(2, hot);
            statement.setString(3, lopTrenTruong);
            statement.setString(4, sdt);
            statement.setString(5, ID_GiaoVien);
           
             rs = statement.executeUpdate() ; 
            while(rs > 0 ){
                return true ; 
            }
        } catch(SQLException e ) {
            e.printStackTrace();
           
        }
        return false ; 
    }

    
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author wrx_Chur04
 */
import model.HocSinh_ChiTietHoc ; 
import java.util.ArrayList ; 
import java.time.LocalDateTime ; 
import java.sql.ResultSet ; 
import java.sql.SQLException ; 
import java.sql.PreparedStatement ; 

public class HocSinh_ChiTietDAO {
    public static ArrayList<HocSinh_ChiTietHoc> adminGetAllLopHocCuaHocSinh(String  ID_HocSinh){
        ArrayList<HocSinh_ChiTietHoc> hocsinhchitiets = new ArrayList<HocSinh_ChiTietHoc>() ; 
        DBContext db = DBContext.getInstance() ; 
        
        try {
            String sql = """
                         select  LH.ID_KhoaHoc ,  HSLH.ID_LopHoc , HSLH.ID_HocSinh ,GV.ID_GiaoVien  , LH.TenLopHoc , SH.SlotThoiGian  ,  GV.HoTen , LH.GhiChu , LH.TrangThai , LH.SoTien , LH.NgayTao , LH.Image    from HocSinh_LopHoc HSLH
                         join  LopHoc LH
                         on HSLH.ID_LopHoc = LH.ID_LopHoc 
                         JOIN GiaoVien_LopHoc GVLH 
                         on HSLH.ID_LopHoc = GVLH.ID_LopHoc
                         JOIN GiaoVien GV 
                         on GV.ID_GiaoVien = GVLH.ID_GiaoVien
                         JOIN SlotHoc SH 
                         ON SH.ID_SlotHoc = LH.ID_Schedule
                         WHERE HSLH.ID_HocSinh = ? ;
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, ID_HocSinh);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                HocSinh_ChiTietHoc hocsinh = new HocSinh_ChiTietHoc(
                        rs.getInt("ID_KhoaHoc") , 
                        rs.getInt("ID_LopHoc") , 
                        rs.getInt("ID_HocSinh") , 
                        rs.getInt("ID_GiaoVien") , 
                        rs.getString("TenLopHoc") , 
                        rs.getString("SlotThoiGian") , 
                        rs.getString("HoTen") , 
                        rs.getString("GhiChu") , 
                        rs.getString("TrangThai") , 
                        rs.getString("SoTien") , 
                        
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Image")  
                
                
                ) ; 
                hocsinhchitiets.add(hocsinh) ; 
            }
        } catch (SQLException e ) {
            e.printStackTrace();
            return null ; 
        }
        
        if (hocsinhchitiets == null ){
            return null ; 
        } else {
            return hocsinhchitiets ; 
        }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.util.ArrayList ; 
import java.sql.PreparedStatement ; 
import java.sql.ResultSet ; 
import java.sql.SQLException ; 
import model.GiaoVien_ChiTietDay ; 

public class GiaoVien_ChiTietDayDAO {
    public static ArrayList<GiaoVien_ChiTietDay> adminGetAllLopHocGiaoVien (String ID_GiaoVien) {
        ArrayList<GiaoVien_ChiTietDay> giaovienchitiets = new ArrayList<GiaoVien_ChiTietDay>() ; 
        DBContext db = DBContext.getInstance() ; 
        try {
            String sql = """
                         select LH.ID_KhoaHoc, LH.ID_LopHoc , GVLH.ID_GiaoVien , GV.HoTen , TH.TenTruongHoc  , LH.TenLopHoc , LH.SiSo , SL.SlotThoiGian , LH.GhiChu , LH.TrangThai , LH.NgayTao , LH.Image  from GiaoVien_LopHoc GVLH 
                         join LopHoc LH 
                         on GVLH.ID_LopHoc = LH.ID_LopHoc 
                         JOIN SlotHoc SL
                         on SL.ID_SlotHoc = LH.ID_Schedule 
                         JOIN GiaoVien GV 
                         ON GVLH.ID_GiaoVien = GV.ID_GiaoVien
                         JOIN TruongHoc TH 
                         ON TH.ID_TruongHoc = GV.ID_TruongHoc
                         WHERE GV.ID_GiaoVien = ?  ; 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setString(1, ID_GiaoVien);
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                GiaoVien_ChiTietDay giaovien = new GiaoVien_ChiTietDay(
                        rs.getInt("ID_KhoaHoc") , 
                        rs.getInt("ID_LopHoc") , 
                        rs.getInt("ID_GiaoVien") , 
                        rs.getString("HoTen") , 
                        rs.getString("TenTruongHoc") , 
                        rs.getString("TenLopHoc") , 
                        rs.getString("SiSo") , 
                        rs.getString("SlotThoiGian") , 
                        rs.getString("GhiChu") , 
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime() , 
                        rs.getString("Image") 
                ) ; 
                giaovienchitiets.add(giaovien) ; 
            }
       } catch (SQLException e ) {
            e.printStackTrace(); 
            return null ; 
        }
        
        if (giaovienchitiets == null ){
            return null ; 
        } else {
            return giaovienchitiets ; 
        }
    }
    
    
    
    
}

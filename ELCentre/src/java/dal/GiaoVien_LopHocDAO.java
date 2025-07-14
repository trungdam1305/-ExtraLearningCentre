/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.GiaoVien_TruongHoc;
import model.KhoiHoc;

/**
 *
 * @author admin
 */
public class GiaoVien_LopHocDAO {
    //teacher dashboard get all class that the teacher taught
public static int teacherGetTongSoLopHoc(int id){
        DBContext db = DBContext.getInstance() ; 
        int tong = 0 ; 
        try {
            String sql = """
                           SELECT COUNT(*) FROM GiaoVien_LopHoc gvlh
                           JOIN GiaoVien gv
                           on gvlh.ID_GiaoVien = gv.ID_GiaoVien
                           JOIN TaiKhoan tk 
                           on gv.ID_TaiKhoan = tk.ID_TaiKhoan
                           JOIN LopHoc lh
                           on gvlh.ID_LopHoc = lh.ID_LopHoc
                           WHERE gv.ID_TaiKhoan = ?
                           and lh.TrangThai COLLATE Vietnamese_CI_AI = N'Đang học';
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, id);
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
    
    //teacher dashboard get all student that the teacher taught
    public static int teacherGetTongSoHocSinh(int id){
        DBContext db = DBContext.getInstance() ; 
        int tong = 0 ; 
        try {
            String sql = """
                             SELECT COUNT(hslh.ID_HocSinh)
                            FROM HocSinh_LopHoc hslh
                            JOIN LopHoc lh ON hslh.ID_LopHoc = lh.ID_LopHoc
                            JOIN GiaoVien_LopHoc gvlh ON gvlh.ID_LopHoc = lh.ID_LopHoc
                            JOIN GiaoVien gv ON gv.ID_GiaoVien = gvlh.ID_GiaoVien
                            JOIN HocSinh hs ON hslh.ID_HocSinh = hs.ID_HocSinh
                            WHERE gv.ID_TaiKhoan = ?
                              AND lh.TrangThai COLLATE Vietnamese_CI_AI = N'Đang học';
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            statement.setInt(1, id);
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
    
    public static void main(String[] args) {
        GiaoVien_LopHocDAO dao = new GiaoVien_LopHocDAO();
        int a = GiaoVien_LopHocDAO.teacherGetTongSoHocSinh(11);
        System.out.println(a);
    }
}

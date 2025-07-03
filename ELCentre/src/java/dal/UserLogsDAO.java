/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import jakarta.servlet.jsp.jstl.sql.Result;
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.UserLogs;
import model.UserLogView;

public class UserLogsDAO {

    public static ArrayList<UserLogView> adminGetAllUserLogs() {
        ArrayList<UserLogView> userlogviews = new ArrayList<UserLogView>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                          SELECT 
                                U.ID_TaiKhoan,
                                COALESCE(HS.HoTen, GV.HoTen, PH.HoTen , AD.HoTen , ST.HoTen) AS HoTen , 
                                  U.HanhDong , 
                                  U.ThoiGian    
                            FROM UserLogs U
                            JOIN TaiKhoan T ON U.ID_TaiKhoan = T.ID_TaiKhoan
                            LEFT JOIN HocSinh HS ON HS.ID_TaiKhoan = U.ID_TaiKhoan
                            LEFT JOIN GiaoVien GV ON GV.ID_TaiKhoan = U.ID_TaiKhoan
                            LEFT JOIN PhuHuynh PH ON PH.ID_TaiKhoan = U.ID_TaiKhoan
                                                  LEFT JOIN Admin AD ON AD.ID_TaiKhoan = U.ID_TaiKhoan
                                                  LEFT JOIN Staff ST ON ST.ID_TaiKhoan = U.ID_TaiKhoan
                            
                            order by U.ThoiGian DESC
                          """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                UserLogView userlogview = new UserLogView(
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("HanhDong"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime()
                );
                            userlogviews.add(userlogview);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (userlogviews.isEmpty()) {
            return null;
        } else {
               return userlogviews;
        }

    }

}

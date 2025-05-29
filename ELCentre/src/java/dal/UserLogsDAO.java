package dal;

///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dal;
//
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.util.ArrayList;
//import model.Taikhoan;
//
//
///**
// *
// * @author Vuh26
// */
//public class UserLogsDAO {
//     public static ArrayList<Taikhoan> getUsers() {
//        DBContext db = DBContext.getInstance();
//
//        ArrayList<Taikhoan> users = new ArrayList<>();
//
//        try {
//            String sql = """
//                         SELECT ID_TaiKhoan, Email, MatKhau, ID_VaiTro,UserType,SoDienThoai,TrangThai,NgayTao
//                         FROM [ELCentre].[dbo].[TaiKhoan]
//                         LEFT JOIN MemberClubs m ON u.userID = m.userID
//                         """;
//            PreparedStatement statement = db.getConnection().prepareStatement(sql);
//            ResultSet rs = statement.executeQuery();
//            while (rs.next()) {
//                User user = new User(rs.getInt("userID"), rs.getString("studentID"),
//                        rs.getString("fullName"),
//                        rs.getString("email"),
//                        rs.getString("password"),
//                        rs.getString("image"),
//                        rs.getString("role"),
//                        new MemberClub(rs.getInt("userID"),
//                                rs.getInt("clubID"),
//                                rs.getString("roleClub")));
//                users.add(user);
//            }
//        } catch (Exception e) {
//            return null;
//        }
//        return users;
//    }
//}

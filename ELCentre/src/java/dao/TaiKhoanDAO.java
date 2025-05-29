package dao;

import java.sql.*;
import model.TaiKhoan;

public class TaiKhoanDAO {
    public static TaiKhoan login(String email, String password) throws SQLException {
        String sql = """
                     SELECT * FROM TaiKhoan
                     WHERE Email = ? AND Matkhau = ? AND TrangThai = 'HoatDong'
                     """;
        
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                TaiKhoan tk = new TaiKhoan();
                tk.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                tk.setEmail(rs.getString("Email"));
                tk.setMatKhau(rs.getString("MatKhau"));
                tk.setID_VaiTro(rs.getInt("ID_VaiTro"));
                tk.setUserType(rs.getString("UserType"));
                tk.setTrangThai(rs.getString("TrangThai"));
                tk.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                return tk;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public TaiKhoan findOrCreateFacebookUser(String email, String name) {
        try (Connection conn = DBContext.getInstance().getConnection()) {
            String sql = "SELECT * FROM TaiKhoan WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                TaiKhoan user = new TaiKhoan();
                user.setEmail(email);
                user.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                user.setID_VaiTro(rs.getInt("ID_VaiTro"));
                user.setTrangThai(rs.getString("TrangThai"));
                return user;
            } else {
                sql = "INSERT INTO TaiKhoan (Email, MatKhau, ID_VaiTro, TrangThai) VALUES (?, '', 2, 'HoatDong')";
                ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, email);
                ps.executeUpdate();
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) {
                    int newId = keys.getInt(1);
                    TaiKhoan user = new TaiKhoan();
                    user.setEmail(email);
                    user.setID_TaiKhoan(newId);
                    user.setID_VaiTro(2);
                    user.setTrangThai("HoatDong");
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

package dao;

import java.sql.*;
import java.time.LocalDateTime;
import model.TaiKhoan;
import java.sql.Connection;

public class TaiKhoanDAO {
    //Lấy thông tin về tài khoản đăng nhập
    public static TaiKhoan login(String email, String password) throws SQLException {
               String sql = "SELECT * FROM TaiKhoan WHERE Email = ? AND MatKhau = ? AND TrangThai = 'Active'";

        
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
                tk.setSoDienThoai(rs.getString("SoDienThoai"));
                tk.setTrangThai(rs.getString("TrangThai")); 
                tk.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                return tk;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //Đang phát triển
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
                sql = "INSERT INTO TaiKhoan (Email, MatKhau, ID_VaiTro, TrangThai, NgayTao, UserType) VALUES (?, '', 2, 'Active', ?, 'Facebook')";
                ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, email);
                ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
                ps.executeUpdate();

                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) {
                    int newId = keys.getInt(1);
                    TaiKhoan user = new TaiKhoan();
                    user.setEmail(email);
                    user.setID_TaiKhoan(newId);
                    user.setID_VaiTro(2);
                    user.setTrangThai("Active");
                    user.setNgayTao(LocalDateTime.now());
                    user.setUserType("Facebook");
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //Đăng kí tài khoản mới (Đang bị thiếu ) 
    public boolean register(TaiKhoan user) {
        String sql = "INSERT INTO TaiKhoan (Email, MatKhau, ID_VaiTro, TrangThai, NgayTao, UserType, SoDienThoai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getMatKhau()); 
            stmt.setInt(3, user.getID_VaiTro());
            stmt.setString(4, user.getTrangThai());
            stmt.setTimestamp(5, Timestamp.valueOf(user.getNgayTao()));
            stmt.setString(6, user.getUserType());
            stmt.setString(7, user.getSoDienThoai());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace(); 
            return false;
        }
    }
    
    //Kiểm tra mail đã đăng kí trong hệ thống hay chưa
    public boolean checkEmailExists(String email) {
        String sql = "SELECT 1 FROM TaiKhoan WHERE Email = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); 
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    //Lấy ra tên vai trò theo ID_VaiTro
    public String getUserTypeByRoleId(int roleId) {
        String userType = "Local"; 
        try (Connection conn = DBContext.getInstance().getConnection()) {
            String sql = "SELECT TenVaiTro FROM VaiTro WHERE ID_VaiTro = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, roleId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                userType = rs.getString("TenVaiTro");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userType;
    }
    
    //Kiểm tra mail và số điện thoại xác thực cho việc đổi mật khẩu
    public TaiKhoan findByEmailAndPhone(String email, String phone) {
        TaiKhoan user = null;
        String sql = "SELECT * FROM TaiKhoan WHERE Email = ? AND TRIM(SoDienThoai) = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, phone.trim()); // trim để so khớp dữ liệu sạch
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new TaiKhoan();
                user.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                user.setEmail(rs.getString("Email"));
                user.setMatKhau(rs.getString("MatKhau"));
                user.setID_VaiTro(rs.getInt("ID_VaiTro"));
                user.setTrangThai(rs.getString("TrangThai"));
                user.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                user.setUserType(rs.getString("UserType"));
                user.setSoDienThoai(rs.getString("SoDienThoai")); // BỔ SUNG DÒNG NÀY
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Cập nhật mật khẩu mới
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE TaiKhoan SET MatKhau = ? WHERE Email = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public TaiKhoan getTaiKhoanByEmail(String email) {
        TaiKhoan user = null;
        String sql = "SELECT * FROM TaiKhoan WHERE Email = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new TaiKhoan();
                user.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                user.setEmail(rs.getString("Email"));
                user.setMatKhau(rs.getString("MatKhau"));
                //user.setHoTen(rs.getString("HoTen"));
                user.setID_VaiTro(rs.getInt("ID_VaiTro"));
                user.setTrangThai(rs.getString("TrangThai"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    //Nhập dữ liệu tài khoản (Đang bị thiếu join vào các bảng theo từng role)
    public boolean insertTaiKhoan(TaiKhoan user) {
        String sql = "INSERT INTO TaiKhoan (Email, MatKhau, HoTen, ID_VaiTro, TrangThai) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getMatKhau());
            //ps.setString(3, user.getHoTen());
            ps.setInt(4, user.getID_VaiTro());
            ps.setString(5, user.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
              return false;
        }
    }
    
    // 2 hàm bên dưới dùng trong modal đổi mật khẩu của học sinh
    // Kiểm tra mật khẩu
    public static boolean checkPassword(String email, String password) {
        try (Connection con = DBContext.getInstance().getConnection()) {
            String sql = "SELECT * FROM TaiKhoan WHERE Email = ? AND MatKhau = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // update mật khẩu mới
    public static boolean updatePassword(int idTaiKhoan, String newPassword) {
        try (Connection con = DBContext.getInstance().getConnection()) {
            String sql = "UPDATE TaiKhoan SET MatKhau = ? WHERE ID_TaiKhoan = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, idTaiKhoan);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}

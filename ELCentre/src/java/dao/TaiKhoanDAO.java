package dao;

import java.sql.*;
import model.TaiKhoan;
import java.time.LocalDateTime;


public class TaiKhoanDAO {
    private Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://Klynh\\KLYNHYTS:1433;databaseName=SWP;encrypt=true;trustServerCertificate=true";
        String user = "sa";
        String password = "123"; 
        return DriverManager.getConnection(url, user, password);
    }
    
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

    public boolean register(TaiKhoan user) {
        String sql = "INSERT INTO TaiKhoan (Email, MatKhau, ID_VaiTro, TrangThai, NgayTao, UserType) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getMatKhau()); 
            stmt.setInt(3, user.getID_VaiTro());
            stmt.setString(4, user.getTrangThai());
            stmt.setTimestamp(5, Timestamp.valueOf(user.getNgayTao()));
            stmt.setString(6, user.getUserType());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace(); 
            return false;
        }
    }

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
    
    public String getUserTypeByRoleId(int roleId) {
        String userType = "Local"; // fallback
        try (Connection conn = getConnection()) {
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
    
    public TaiKhoan findByEmail(String email) {
        TaiKhoan user = null;
        String sql = "SELECT * FROM TaiKhoan WHERE Email = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE TaiKhoan SET MatKhau = ? WHERE Email = ?";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            // String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            // stmt.setString(1, hashed);
            stmt.setString(1, newPassword); 
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
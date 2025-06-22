package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import model.UserLogs;

public class UserLogsDAO {

    public static boolean insertLoginLog(int idTaiKhoan, String hanhDong) {
        String sql = """
            INSERT INTO UserLogs (ID_TaiKhoan, HanhDong, ThoiGian)
            VALUES (?, ?, ?)
        """;

        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idTaiKhoan);
            stmt.setString(2, hanhDong);
            stmt.setObject(3, LocalDateTime.now());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
                        return false;
        }
    }
    
    public static void insertLog(UserLogs log)  {
        String sql = "INSERT INTO UserLogs (ID_TaiKhoan, HanhDong, ThoiGian) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, log.getID_TaiKhoan());
            stmt.setString(2, log.getHanhDong());
            stmt.setTimestamp(3, Timestamp.valueOf(log.getThoiGian()));
            stmt.executeUpdate();

        } catch (SQLException e) {
              e.printStackTrace();
        }
    }
}

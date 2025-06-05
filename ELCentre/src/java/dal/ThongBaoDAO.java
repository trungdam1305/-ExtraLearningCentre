package dal;

/**
 *
 * @author wrx_Chur04
 */
import model.ThongBao;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ThongBaoDAO {

    public static ArrayList<ThongBao> adminXemThongBao() {
        ArrayList<ThongBao> thongbaos = new ArrayList<ThongBao>();

        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select * from ThongBao 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                ThongBao thongbao = new ThongBao(
                        rs.getInt("ID_ThongBao"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("NoiDung"),
                        rs.getInt("ID_HocPhi"),
                        rs.getTimestamp("ThoiGian").toLocalDateTime()
                ) ; 
                thongbaos.add(thongbao) ; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        
        if (thongbaos.isEmpty()){
            return null ; 
        } else {
            return thongbaos ; 
        }
    }
    
    public static void insertThongBaoTuVan(String noiDung) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO ThongBao (ID_TaiKhoan, NoiDung, ID_HocPhi, ThoiGian) " + "VALUES (?, ?, ?, GETDATE())";
        
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)){
            ps.setNull(1, java.sql.Types.INTEGER);
            ps.setString(2, noiDung);
            ps.setNull(3, java.sql.Types.INTEGER);
            ps.executeUpdate();
        }
    }
}

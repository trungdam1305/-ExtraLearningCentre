package dal;

import model.ThongBao;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;

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
    
    //Hàm nhập thông báo tư vấn
    public static void insertThongBaoTuVan(String noiDung) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = "INSERT INTO ThongBao (ID_TaiKhoan, NoiDung, ThoiGian) " + "VALUES (?, ?, GETDATE())";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)){
            ps.setNull(1, java.sql.Types.INTEGER);
            ps.setString(2, noiDung);
            ps.executeUpdate();
        }
    }
    

    //Hàm lấy thông báo theo id
    public static ThongBao getThongBaoById(int id) {
        DBContext db = DBContext.getInstance();
        ThongBao tb = null;
        try {
            String sql = "SELECT * FROM ThongBao WHERE ID_ThongBao = ?";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                tb = new ThongBao(
                rs.getInt("ID_ThongBao"),
                rs.getInt("ID_TaiKhoan"),
                rs.getString("noiDung"),
                rs.getInt("ID_HocPhi"),
                rs.getTimestamp("ThoiGian").toLocalDateTime()
                );
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return tb;
    }
        
    //Hàm lấy ra tất cả yêu cầu tư 
    public static ArrayList<ThongBao> getAllTuVan() {
        ArrayList<ThongBao> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM ThongBao WHERE NoiDung LIKE N'%tư vấn%' ORDER BY ThoiGian DESC";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ThongBao tb = new ThongBao(
                    rs.getInt("ID_ThongBao"),
                    rs.getInt("ID_TaiKhoan"),
                    rs.getString("NoiDung"),
                    rs.getTimestamp("ThoiGian").toLocalDateTime()
                );
                list.add(tb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //Hàm lấy thông báo theo id tài khoản
    public static List<ThongBao> getThongBaoByTaiKhoanId(int idTaiKhoan) throws SQLException {
         List<ThongBao> list = new ArrayList<>();
         String sql = "SELECT * FROM ThongBao WHERE ID_TaiKhoan = ? ORDER BY ThoiGian DESC";
         try (Connection conn = DBContext.getInstance().getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
              ps.setInt(1, idTaiKhoan);
              ResultSet rs = ps.executeQuery();
              while (rs.next()) {
                 ThongBao tb = new ThongBao();
                 tb.setID_ThongBao(rs.getInt("ID_ThongBao"));
                 tb.setID_TaiKhoan(rs.getInt("ID_TaiKhoan"));
                 tb.setNoiDung(rs.getString("NoiDung"));
                 tb.setThoiGian(rs.getTimestamp("ThoiGian").toLocalDateTime());
                 list.add(tb);
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return list;
     } 
    
    public static void main(String[] args) {
            int idTaiKhoanTest = 14; // Bạn có thể đổi sang ID khác nếu cần kiểm tra

            try {
                List<ThongBao> thongBaoList = ThongBaoDAO.getThongBaoByTaiKhoanId(idTaiKhoanTest);

                if (thongBaoList.isEmpty()) {
                    System.out.println("Không có thông báo nào cho tài khoản ID = " + idTaiKhoanTest);
                } else {
                    System.out.println("Danh sách thông báo của tài khoản ID = " + idTaiKhoanTest + ":");
                    for (ThongBao tb : thongBaoList) {
                        System.out.println("-------------------------------");
                        System.out.println("ID:        " + tb.getID_ThongBao());
                        System.out.println("Tài khoản: " + tb.getID_TaiKhoan());
                        System.out.println("Nội dung:  " + tb.getNoiDung());
                        System.out.println("Thời gian: " + tb.getThoiGian());
                    }
                }

            } catch (Exception e) {
                System.err.println("Đã xảy ra lỗi khi lấy thông báo:");
                e.printStackTrace();
            }
    }    
}

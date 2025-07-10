package dal;

import model.ThongBao;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import model.GiaoVien_ChiTietDay;
import java.util.List;
import java.sql.Connection;
import java.sql.Timestamp;

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
                );
                thongbaos.add(thongbao);
            }
        } catch (SQLException e) {
            e.printStackTrace();
                    return null;
        }

        if (thongbaos.isEmpty()) {
            return null;
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
    
    public static boolean checkRequestExists(int idTaiKhoan, String classCode) {
        String sql = "SELECT 1 FROM ThongBao WHERE ID_TaiKhoan = ? AND NoiDung LIKE ?";
        try (Connection con = DBContext.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idTaiKhoan);
            ps.setString(2, "%" + classCode + "%");
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static boolean adminSendNotification(String ID_TaiKhoan, String NoiDung) {
        int rs = 0;
        DBContext db = DBContext.getInstance();
        LocalDateTime now = LocalDateTime.now();
        try {
            String sql = """
                         insert into ThongBao(ID_TaiKhoan , NoiDung , ThoiGian )
                         values ( ?  , ? , ? ) 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_TaiKhoan);
            statement.setString(2, NoiDung);
            statement.setTimestamp(3, Timestamp.valueOf(now));
            rs = statement.executeUpdate();
            while (rs > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    public static ArrayList<GiaoVien_ChiTietDay> adminGetAllLopHocDangHocToSendThongBao() {
        ArrayList<GiaoVien_ChiTietDay> lophocs = new ArrayList<GiaoVien_ChiTietDay>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         select LH.ID_KhoaHoc, LH.ID_LopHoc , GVLH.ID_GiaoVien , GV.HoTen , TH.TenTruongHoc  , LH.TenLopHoc , LH.SiSo  , LH.GhiChu , LH.TrangThai , LH.NgayTao , LH.Image  , KH.TenKhoaHoc , KH.ID_Khoi from GiaoVien_LopHoc GVLH 
                        join LopHoc LH 
                        on GVLH.ID_LopHoc = LH.ID_LopHoc 

                        JOIN GiaoVien GV 
                        ON GVLH.ID_GiaoVien = GV.ID_GiaoVien
                        JOIN TruongHoc TH 
                        ON TH.ID_TruongHoc = GV.ID_TruongHoc
                         JOIN KhoaHoc KH 
                         ON KH.ID_KhoaHoc = LH.ID_KhoaHoc

                        WHERE 
                       LH.TrangThai = N'Đang học'; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                GiaoVien_ChiTietDay giaovien = new GiaoVien_ChiTietDay(
                        rs.getInt("ID_KhoaHoc"),
                        rs.getInt("ID_LopHoc"),
                        rs.getInt("ID_GiaoVien"),
                        rs.getString("HoTen"),
                        rs.getString("TenTruongHoc"),
                        rs.getString("TenLopHoc"),
                        rs.getString("SiSo"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Image"),
                        rs.getInt("ID_Khoi"),
                        rs.getString("TenKhoaHoc")
                );
                lophocs.add(giaovien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (lophocs == null) {
            return null;
        } else {
            return lophocs;
        }
    }

    public static boolean adminSendClassNotification(ArrayList<String> ID_TaiKhoanHS, String NoiDungHS) {
        int rs = 0;
        DBContext db = DBContext.getInstance();
        LocalDateTime now = LocalDateTime.now();
        try {
            String sql = """
                         insert into ThongBao(ID_TaiKhoan , NoiDung , ThoiGian )
                         values ( ?  , ? , ? ) 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            for (String id : ID_TaiKhoanHS) {
                statement.setString(1, id);
                statement.setString(2, NoiDungHS);
                statement.setTimestamp(3, Timestamp.valueOf(now));
                statement.addBatch();
            }

            int[] result = statement.executeBatch();
            for (int r : result) {
                if (r > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return false;
    }

    public static boolean insertRequestJoinClass(ThongBao tb) {
        String sql = "INSERT INTO ThongBao (ID_TaiKhoan, NoiDung, ThoiGian) VALUES (?, ?, ?)";
        try (Connection con = DBContext.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, tb.getID_TaiKhoan());
            ps.setString(2, tb.getNoiDung());
            ps.setTimestamp(3, Timestamp.valueOf(tb.getThoiGian()));
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
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

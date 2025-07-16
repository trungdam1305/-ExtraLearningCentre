package dal;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import model.HocPhi;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.sql.Date;


public class HocPhiDAO {

    private HocPhiDAO() {

    }

    public static ArrayList<HocPhi> adminGetHocPhi() {
        DBContext db = DBContext.getInstance();
        ArrayList<HocPhi> hocphis = new ArrayList<HocPhi>();

        try {
            String sql = """
                         select * from HocPhi
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                
                HocPhi hocphi = new HocPhi(
                        rs.getInt("ID_HocPhi"),
                        rs.getInt("ID_HocSinh"),
                        rs.getInt("ID_LopHoc"),
                        rs.getString("MonHoc"),
                        rs.getString("PhuongThucThanhToan"),
                        rs.getString("TinhTrangThanhToan"),
                                    rs.getDate("NgayThanhToan") != null ? rs.getDate("NgayThanhToan").toLocalDate() : null, 
                        rs.getString("GhiChu")
                );

                hocphis.add(hocphi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (hocphis.isEmpty()) {
            return null;
        } else {
              return hocphis;
        }
    }
    
    public static List<HocPhi> getHocPhiByHocSinhId(int idHocSinh) {
        List<HocPhi> list = new ArrayList<>();
        String sql = """
            SELECT hp.*, lh.ClassCode, lh.TenLopHoc, lh.SoTien
            FROM HocPhi hp
            JOIN LopHoc lh ON hp.ID_LopHoc = lh.ID_LopHoc
            WHERE hp.ID_HocSinh = ?
        """;
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HocPhi hp = new HocPhi();
                hp.setID_HocPhi(rs.getInt("ID_HocPhi"));
                hp.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hp.setID_LopHoc(rs.getInt("ID_LopHoc"));
                hp.setMonHoc(rs.getString("MonHoc"));
                hp.setPhuongThucThanhToan(rs.getString("PhuongThucThanhToan"));
                hp.setTinhTrangThanhToan(rs.getString("TinhTrangThanhToan"));

                Date sqlDate = rs.getDate("NgayThanhToan");
                if (sqlDate != null) {
                    hp.setNgayThanhToan(sqlDate.toLocalDate());
                }

                hp.setGhiChu(rs.getString("GhiChu"));
                int tongHocPhi = rs.getInt("SoTien");  
                int daDong = rs.getInt("SoTienDaDong"); 

                hp.setTongHocPhi(tongHocPhi);
                hp.setSoTienDaDong(daDong);
                hp.setConThieu(Math.max(0, tongHocPhi - daDong));

                list.add(hp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public static int getTongHocPhiChuaDong(int idHocSinh) {
        String sql = "SELECT SUM(ConThieu) FROM HocPhi WHERE ID_HocSinh = ? AND TinhTrangThanhToan != 'Đã đóng'";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public static List<HocPhi> getLichSuThanhToan(int idHocSinh) {
        List<HocPhi> list = new ArrayList<>();
        String sql = "SELECT * FROM HocPhi WHERE ID_HocSinh = ? AND TinhTrangThanhToan = 'Đã đóng'";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HocPhi hp = new HocPhi();
                hp.setID_HocPhi(rs.getInt("ID_HocPhi"));
                hp.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hp.setID_LopHoc(rs.getInt("ID_LopHoc"));
                hp.setMonHoc(rs.getString("MonHoc"));
                hp.setPhuongThucThanhToan(rs.getString("PhuongThucThanhToan"));
                hp.setTinhTrangThanhToan(rs.getString("TinhTrangThanhToan"));
                LocalDateTime ngay = rs.getTimestamp("NgayThanhToan").toLocalDateTime();
                hp.setNgayThanhToan(ngay != null ? ngay.toLocalDate() : null);
                hp.setGhiChu(rs.getString("GhiChu"));
                list.add(hp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //Kiểm tra dữ liệu
    public static void main(String[] args) {
        int idHocSinh = 17; // Thay ID tương ứng
        List<HocPhi> list = getHocPhiByHocSinhId(idHocSinh);
        if (list.isEmpty()) {
            System.out.println("⚠️ Không tìm thấy học phí cho học sinh ID: " + idHocSinh);
            return;
        }

        int tong = 0, daDong = 0;
        for (HocPhi hp : list) {
            System.out.println("📘 Môn: " + hp.getMonHoc());
            System.out.println(" - Tổng học phí: " + hp.getTongHocPhi());
            System.out.println(" - Đã đóng: " + hp.getSoTienDaDong());
            System.out.println(" - Còn thiếu: " + hp.getConThieu());
            System.out.println();
            tong += hp.getTongHocPhi();
            daDong += hp.getSoTienDaDong();
        }
        int conThieu = Math.max(0, tong - daDong);
        System.out.println("📊 TỔNG CỘNG:");
        System.out.println(" - Tổng học phí: " + tong);
        System.out.println(" - Đã đóng: " + daDong);
        System.out.println(" - Còn thiếu: " + conThieu);
    }

}
    
    
    


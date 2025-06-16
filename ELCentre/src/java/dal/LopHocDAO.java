
package dal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.LopHoc;
import model.LopHocTheoNhomDTO;

public class LopHocDAO {

    //Listing all Class from the Database
    public List<LopHoc> getAllLopHoc() {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc]";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
                    return list;
    }
    
    //Call the Sum of Class 
    public static int getTotalLopHoc() {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = """
            SELECT COUNT(*) FROM LopHoc
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            rs.close();
            statement.close();
        } catch (Exception e) {
            return 0; // hoặc có thể trả về -1 để phân biệt có lỗi
        }
        return total;
    }
    public static int adminGetTongSoLopHoc() {
        DBContext db = DBContext.getInstance();
        int tong = 0;

        try {
            String sql = """
                          select count(*) from LopHoc
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
                    return tong;
    }
    
    public List<LopHocTheoNhomDTO> getTongLopHocTheoNhomMonHoc() {
    List<LopHocTheoNhomDTO> result = new ArrayList<>();
    String sql = "	SELECT \n" +
"    khoc.ID_Khoi,\n" +
"    khoc.TenKhoi,\n" +
"    CASE \n" +
"        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%' THEN N'Toán'\n" +
"        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%' THEN N'Văn'\n" +
"        ELSE N'Khác'\n" +
"    END AS NhomMonHoc,\n" +
"    COUNT(l.ID_LopHoc) AS TongSoLopHoc\n" +
"FROM \n" +
"    dbo.KhoiHoc khoc\n" +
"INNER JOIN \n" +
"    dbo.KhoaHoc khoah ON khoc.ID_Khoi = khoah.ID_Khoi\n" +
"LEFT JOIN \n" +
"    dbo.LopHoc l ON khoah.ID_KhoaHoc = l.ID_KhoaHoc\n" +
"GROUP BY \n" +
"    khoc.ID_Khoi, \n" +
"    khoc.TenKhoi,\n" +
"    CASE \n" +
"        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%' THEN N'Toán'\n" +
"        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%' THEN N'Văn'\n" +
"        ELSE N'Khác'\n" +
"    END\n" +
"ORDER BY \n" +
"    khoc.ID_Khoi,\n" +
"    NhomMonHoc;";

    try (Connection conn = DBContext.getInstance().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            int idKhoi = rs.getInt("ID_Khoi");
            String tenKhoi = rs.getString("TenKhoi");
            String nhomMonHoc = rs.getString("NhomMonHoc");
            int tongSoLopHoc = rs.getInt("TongSoLopHoc");

            LopHocTheoNhomDTO dto = new LopHocTheoNhomDTO(idKhoi, tenKhoi, nhomMonHoc, tongSoLopHoc);
            result.add(dto);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

             return result;
}

    
    //Debugging
    public static void main(String[] args) {
        List<LopHoc> lop = new LopHocDAO().getAllLopHoc();
        for (LopHoc lops : lop){
            System.out.println(lops);
            System.out.println(lops.getID_KhoaHoc() + " " + lops.getID_LopHoc() + " "+ lops.getTenLopHoc() + " " + lops.getThoiGianHoc());
        }
        
    }
    
      public static List<LopHoc> getLopHocByIdKhoa(int idKhoaHoc) {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc] WHERE ID_KhoaHoc = ?";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idKhoaHoc);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

                    return list;
    }
    
     public static List<LopHoc> getLopHocByIdKhoi(int idKhoiHoc) {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc] WHERE ID_Khoi = ?";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idKhoiHoc);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

             return list;
    }
    
}

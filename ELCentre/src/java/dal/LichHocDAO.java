/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import model.LichHoc;

public class LichHocDAO {

    public static ArrayList<LichHoc> adminGetAllLichHoc(String ngayHienTai) {
        ArrayList<LichHoc> lichhocs = new ArrayList<LichHoc>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                          select * from LichHoc
                         where NgayHoc >= ? 
                          """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ngayHienTai);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                LichHoc lichhoc = new LichHoc(
                        rs.getInt("ID_Schedule"),
                        rs.getDate("NgayHoc").toLocalDate(),
                        rs.getString("GioHoc"),
                        rs.getInt("ID_LopHoc"),
                        rs.getString("GhiChu")
                );
                lichhocs.add(lichhoc);

            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (lichhocs.isEmpty()) {
            return null;
        } else {
            return lichhocs;
        }

    }


    public static List<LichHoc> getUpcomingByHocSinh(int idHocSinh) throws SQLException {
        List<LichHoc> list = new ArrayList<>();
        String sql = """
            SELECT lh.*, l.TenLop FROM LichHoc lh
            JOIN LopHoc l ON lh.ID_LopHoc = l.ID_LopHoc
            JOIN DangKyLopHoc dk ON dk.ID_LopHoc = l.ID_LopHoc
            WHERE dk.ID_HocSinh = ?
              AND lh.NgayHoc BETWEEN GETDATE() AND DATEADD(DAY, 7, GETDATE())
            ORDER BY lh.NgayHoc ASC
        """;
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LichHoc lich = new LichHoc();
                    lich.setID_LichHoc(rs.getInt("ID_LichHoc"));
                    lich.setNgayHoc(rs.getDate("NgayHoc"));
                    lich.setSlot(rs.getString("Slot"));
                    lich.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    lich.setTenLop(rs.getString("TenLop")); // bạn cần thêm field này trong model nếu chưa có
                    list.add(lich);
                }
            }
        }
        return list;
    }
   
}

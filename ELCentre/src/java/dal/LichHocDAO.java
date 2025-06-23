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
import java.time.LocalDate;
import java.util.List;
import model.LichHoc;
import java.sql.Date;
import java.time.DayOfWeek;

public class LichHocDAO {

    public static ArrayList<LichHoc> adminGetAllLichHoc(String ngayHienTai) {
        ArrayList<LichHoc> lichhocs = new ArrayList<LichHoc>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                          select * from LichHoc
                         where NgayHoc <= ? 
                          """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ngayHienTai);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                LichHoc lichhoc = new LichHoc(
                        rs.getInt("ID_Schedule"),
                        rs.getDate("NgayHoc").toLocalDate(),
                        rs.getInt("ID_SlotHoc"),
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
    
    
    public static List<LichHoc> getLichHocTrongTuan(int idTaiKhoan, LocalDate startDate, LocalDate endDate) {
    List<LichHoc> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();

    String sql = """
        SELECT * 
        FROM LichHoc lh
        join LopHoc lop 
        ON lh.ID_LopHoc = lop.ID_LopHoc
        JOIN SlotHoc sl
        ON lh.ID_SlotHoc = sl.ID_SlotHoc
        JOIN GiaoVien_LopHoc gvlh
        ON gvlh.ID_LopHoc = lop.ID_LopHoc
        JOIN GiaoVien gv 
        ON gv.ID_GiaoVien = gvlh.ID_GiaoVien
        WHERE gv.ID_TaiKhoan = ? 
        AND NgayHoc BETWEEN ? AND ?
        ORDER BY NgayHoc, sl.ID_SlotHoc;
    """;

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
        ps.setInt(1, idTaiKhoan); // tham số 1: ID_TaiKhoan
        ps.setDate(2, Date.valueOf(startDate)); // tham số 2: startDate
        ps.setDate(3, Date.valueOf(endDate));   // tham số 3: endDate

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            LichHoc lh = new LichHoc();
            lh.setID_Schedule(rs.getInt("ID_Schedule"));
            lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
            lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
            lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
            lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
            lh.setTenLopHoc(rs.getString("TenLopHoc"));
            lh.setGhiChu(rs.getString("GhiChu"));
            list.add(lh);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

    public static void main(String[] args) {
 // Gọi DAO để lấy dữ liệu thời khóa biểu trong tuần hiện tại
LocalDate startOfWeek = LocalDate.now().with(DayOfWeek.MONDAY);
LocalDate endOfWeek = LocalDate.now().with(DayOfWeek.SUNDAY);

List<LichHoc> lichHocList = LichHocDAO.getLichHocTrongTuan(11,startOfWeek, endOfWeek);

// In ra để kiểm tra
for (LichHoc lh : lichHocList) {
    System.out.println("ID Schedule: " + lh.getID_Schedule());
    System.out.println("Ngày học: " + lh.getNgayHoc());
    System.out.println("Ca học: " + lh.getID_SlotHoc());
    System.out.println("Lớp học: " + lh.getTenLopHoc());
    System.out.println("Slot" + lh.getSlotThoiGian());
    System.out.println("------------------------");
    }


}
}
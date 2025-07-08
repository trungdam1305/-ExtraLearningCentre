/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author wrx_Chur04
 */

import java.sql.Connection;
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

    // Lấy lịch học theo ID
    public LichHoc getLichHocById(int idSchedule) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.*, sh.SlotThoiGian
            FROM [dbo].[LichHoc] lh
            LEFT JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            WHERE lh.ID_Schedule = ?
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idSchedule);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                LichHoc lichHoc = new LichHoc();
                lichHoc.setID_Schedule(rs.getInt("ID_Schedule"));
                lichHoc.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lichHoc.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lichHoc.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lichHoc.setGhiChu(rs.getString("GhiChu"));
                lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                return lichHoc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
            ps.setInt(1, idTaiKhoan); // param1 1: ID_TaiKhoan
            ps.setDate(2, Date.valueOf(startDate)); // param 2: startDate
            ps.setDate(3, Date.valueOf(endDate));   // param 3: endDate

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

    

    public List<LichHoc> getLichHocByLopHoc(int idLopHoc) {
        List<LichHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.ID_PhongHoc, lh.GhiChu, 
                   sh.SlotThoiGian, lop.TenLopHoc
            FROM [dbo].[LichHoc] lh
            JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN [dbo].[LopHoc] lop ON lh.ID_LopHoc = lop.ID_LopHoc
            WHERE lh.ID_LopHoc = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LichHoc lichHoc = new LichHoc();
                lichHoc.setID_Schedule(rs.getInt("ID_Schedule"));
                lichHoc.setNgayHoc(rs.getDate("NgayHoc") != null ? rs.getDate("NgayHoc").toLocalDate() : null);
                lichHoc.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lichHoc.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lichHoc.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                lichHoc.setGhiChu(rs.getString("GhiChu"));
                lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lichHoc.setTenLopHoc(rs.getString("TenLopHoc"));
                list.add(lichHoc);
            }
            System.out.println("getLichHocByLopHoc: Retrieved " + list.size() + " schedules for ID_LopHoc=" + idLopHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in getLichHocByLopHoc: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Xóa lịch học
    public boolean deleteLichHoc(int idSchedule) {
        DBContext db = DBContext.getInstance();
        String sql = """
            DELETE FROM [dbo].[LichHoc]
            WHERE ID_Schedule = ?
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, idSchedule);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Thêm lịch học mới
    public LichHoc addLichHoc(LocalDate ngayHoc, int idSlotHoc, String ghiChu) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO [dbo].[LichHoc] (NgayHoc, ID_SlotHoc, GhiChu)
            VALUES (?, ?, ?)
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmt.setInt(2, idSlotHoc);
            stmt.setString(3, ghiChu);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    LichHoc lichHoc = new LichHoc();
                    lichHoc.setID_Schedule(rs.getInt(1));
                    lichHoc.setNgayHoc(ngayHoc);
                    lichHoc.setID_SlotHoc(idSlotHoc);
                    lichHoc.setGhiChu(ghiChu);
                    // Lấy SlotThoiGian
                    String sqlSelect = """
                        SELECT SlotThoiGian FROM [dbo].[SlotHoc] WHERE ID_SlotHoc = ?
                    """;
                    try (PreparedStatement selectStmt = conn.prepareStatement(sqlSelect)) {
                        selectStmt.setInt(1, idSlotHoc);
                        ResultSet rsSelect = selectStmt.executeQuery();
                        if (rsSelect.next()) {
                            lichHoc.setSlotThoiGian(rsSelect.getString("SlotThoiGian"));
                        }
                    }
                    return lichHoc;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật lịch học
    public boolean updateLichHoc(int idSchedule, LocalDate ngayHoc, int idSlotHoc, String ghiChu) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE [dbo].[LichHoc]
            SET NgayHoc = ?, ID_SlotHoc = ?, GhiChu = ?
            WHERE ID_Schedule = ?
        """;
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmt.setInt(2, idSlotHoc);
            stmt.setString(3, ghiChu);
            stmt.setInt(4, idSchedule);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

     public List<LichHoc> getLichHocByMonth1(int year, int month) {
        List<LichHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT 
                lh.ID_Schedule,
                lh.NgayHoc,
                lh.ID_SlotHoc,
                lh.ID_LopHoc,
                lh.ID_PhongHoc,
                lh.GhiChu,
                sh.SlotThoiGian,
                cl.TenLopHoc,
                ph.TenPhongHoc
            FROM 
                [dbo].[LichHoc] lh
                INNER JOIN [dbo].[SlotHoc] sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
                INNER JOIN [dbo].[LopHoc] cl ON lh.ID_LopHoc = cl.ID_LopHoc
                INNER JOIN [dbo].[PhongHoc] ph ON lh.ID_PhongHoc = ph.ID_PhongHoc
            WHERE 
                YEAR(lh.NgayHoc) = ? 
                AND MONTH(lh.NgayHoc) = ?
                AND cl.TrangThai = N'Đang học'
            ORDER BY 
                lh.NgayHoc, sh.SlotThoiGian
            """;

        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, year);
            stmt.setInt(2, month);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    LichHoc lichHoc = new LichHoc();
                    lichHoc.setID_Schedule(rs.getInt("ID_Schedule"));
                    lichHoc.setNgayHoc(rs.getDate("NgayHoc") != null ? rs.getDate("NgayHoc").toLocalDate() : null);
                    lichHoc.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                    lichHoc.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    lichHoc.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
                    lichHoc.setGhiChu(rs.getString("GhiChu"));
                    lichHoc.setSlotThoiGian(rs.getString("SlotThoiGian"));
                    lichHoc.setTenLopHoc(rs.getString("TenLopHoc"));
                    lichHoc.setTenPhongHoc(rs.getString("TenPhongHoc"));
                    list.add(lichHoc);
                }
                System.out.println("getLichHocByMonth1: Retrieved " + list.size() + " schedules for year=" + year + ", month=" + month);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getLichHocByMonth1: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Xóa tất cả lịch học của một ngày
    public boolean deleteLichHocByDate1(LocalDate date) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM [dbo].[LichHoc] WHERE NgayHoc = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(date));
            int rowsAffected = stmt.executeUpdate();
            System.out.println("deleteLichHocByDate1: Deleted " + rowsAffected + " schedules for date=" + date);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteLichHocByDate1: " + e.getMessage() + 
                               " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
    }
    
    public static void main(String[] args) {
        LichHocDAO dao = new LichHocDAO();

        int year = 2025;
        int month = 7; // Tháng 7

        List<LichHoc> lichHocList = dao.getLichHocByMonth1(year, month);

        if (lichHocList.isEmpty()) {
            System.out.println("Không có lịch học nào trong tháng " + month + "/" + year);
        } else {
            System.out.println("Danh sách lịch học trong tháng " + month + "/" + year + ":");
            for (LichHoc lh : lichHocList) {
                System.out.println("ID: " + lh.getID_Schedule()
                        + ", Ngày học: " + lh.getNgayHoc()
                        + ", Slot: " + lh.getSlotThoiGian()
                        + ", Lớp: " + lh.getTenLopHoc()
                        + ", Phòng: " + lh.getTenPhongHoc()
                        + ", Ghi chú: " + lh.getGhiChu());
            }
        }
    }
}
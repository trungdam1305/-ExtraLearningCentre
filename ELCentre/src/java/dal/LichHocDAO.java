// Author: trungdam
// Servlet: LichHocDAO
package dal;

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
import java.util.HashMap;
import java.util.Map;
import model.PhongHoc;


public class LichHocDAO {

    public static ArrayList<LichHoc> adminGetAllLichHoc(String ngayHienTai) {
        ArrayList<LichHoc> lichhocs = new ArrayList<>();
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

    /**
     * Retrieves a schedule by its ID.
     */
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

    /**
     * Retrieves a list of schedules for a teacher within a specific week.
     */
    public static List<LichHoc> getLichHocTrongTuan(int idTaiKhoan, LocalDate startDate, LocalDate endDate) {
        List<LichHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        // Get the current server date once for comparison
        LocalDate homNay = LocalDate.now();

        String sql = """
                    SELECT
                    lh.*,
                    lop.TenLopHoc,
                    sl.SlotThoiGian,
                    ph.TenPhongHoc
                    FROM
                    LichHoc lh
                    JOIN
                    LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
                    JOIN
                    SlotHoc sl ON lh.ID_SlotHoc = sl.ID_SlotHoc
                    JOIN
                    GiaoVien_LopHoc gvlh ON gvlh.ID_LopHoc = lop.ID_LopHoc
                    JOIN
                    GiaoVien gv ON gv.ID_GiaoVien = gvlh.ID_GiaoVien
                    JOIN 
                    PhongHoc ph on lh.ID_PhongHoc = ph.ID_PhongHoc
                    WHERE
                    gv.ID_TaiKhoan = ?
                    AND lh.NgayHoc BETWEEN ? AND ?
                    ORDER BY
                    lh.NgayHoc, sl.ID_SlotHoc;
                    """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, idTaiKhoan);
            ps.setDate(2, java.sql.Date.valueOf(startDate));
            ps.setDate(3, java.sql.Date.valueOf(endDate));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LichHoc lh = new LichHoc();
                    lh.setID_Schedule(rs.getInt("ID_Schedule"));
                    lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                    lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                    lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                    lh.setTenLopHoc(rs.getString("TenLopHoc"));
                    lh.setGhiChu(rs.getString("GhiChu"));
                    lh.setTenPhongHoc(rs.getString("TenPhongHoc"));
                    lh.setDaDiemDanh(rs.getBoolean("DaDiemDanh"));

                    // Logic to set 'coTheSua' (can be edited/attended)
                    if (lh.getNgayHoc() != null && lh.getNgayHoc().isEqual(homNay)) {
                        lh.setCoTheSua(true); 
                    } else {
                        lh.setCoTheSua(false); 
                    }

                    list.add(lh);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy lịch học trong tuần: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves a list of schedules for a specific class.
     */
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
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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
    
    /**
     * Deletes a schedule by its ID.
     */
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

    /**
     * Adds a new schedule to the database.
     */
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
                    // Fetch SlotThoiGian for the newly added schedule
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

    /**
     * Updates an existing schedule in the database.
     */
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

    /**
     * Marks an attendance record as completed for a schedule.
     */
    public void markAttendanceAsCompleted(int scheduleId) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE LichHoc SET daDiemDanh = 1 WHERE ID_Schedule = ?";
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setInt(1, scheduleId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật trạng thái đã điểm danh: " + e.getMessage());
        }
    }

    /**
     * Updates the note for a specific schedule.
     */
    public void updateNote(int scheduleId, String newNote) {
        String sql = "UPDATE LichHoc SET GhiChu = ? WHERE ID_Schedule = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newNote);
            ps.setInt(2, scheduleId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves all schedules for a given class, ordered by date.
     */
    public List<LichHoc> getAllSchedulesForClass(int classId) {
        List<LichHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM LichHoc WHERE ID_LopHoc = ? ORDER BY NgayHoc";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LichHoc lh = new LichHoc();
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                list.add(lh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves schedules for a teacher on a specific date.
     */
    public List<LichHoc> getLichHocTrongNgay(int idTaiKhoan, LocalDate filterDate) {
        List<LichHoc> list = new ArrayList<>();

        String sql = """
                     SELECT lh.*, sl.SlotThoiGian, lop.TenLopHoc, ph.TenPhongHoc
                     FROM LichHoc lh
                     JOIN LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
                     JOIN SlotHoc sl ON lh.ID_SlotHoc = sl.ID_SlotHoc
                     JOIN GiaoVien_LopHoc gvlh ON gvlh.ID_LopHoc = lop.ID_LopHoc
                     JOIN GiaoVien gv ON gv.ID_GiaoVien = gvlh.ID_GiaoVien
                     JOIN PhongHoc ph on lop.ID_PhongHoc = ph.ID_PhongHoc
                     WHERE gv.ID_TaiKhoan = ? AND lh.NgayHoc = ?
                     ORDER BY sl.ID_SlotHoc
                     """;

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idTaiKhoan);
            ps.setDate(2, java.sql.Date.valueOf(filterDate));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LichHoc lh = new LichHoc();

                lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setTenPhongHoc(rs.getString("TenPhongHoc"));

                list.add(lh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves upcoming schedules for a student.
     */
    public static List<LichHoc> getUpcomingScheduleByHocSinhId(Integer idHocSinh) {
        List<LichHoc> list = new ArrayList<>();
        String sql = """
                    SELECT lh.ID_Schedule, lh.NgayHoc, lh.ID_SlotHoc, lh.ID_LopHoc, lh.GhiChu,
                            sh.SlotThoiGian, l.TenLopHoc
                    FROM HocSinh_LopHoc hslh
                    JOIN LichHoc lh ON hslh.ID_LopHoc = lh.ID_LopHoc
                    JOIN SlotHoc sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
                    JOIN LopHoc l ON lh.ID_LopHoc = l.ID_LopHoc
                    WHERE hslh.ID_HocSinh = ?
                    AND lh.NgayHoc >= CAST(GETDATE() AS DATE)
                    ORDER BY lh.NgayHoc ASC, sh.SlotThoiGian ASC;
                    """;
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LichHoc lh = new LichHoc();
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                list.add(lh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves schedules for a specific month and year.
     */
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

        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    /**
     * Deletes schedules for a specific date if the date is not in the past.
     */
    public boolean deleteLichHocByDate1(LocalDate date) {
        LocalDate today = LocalDate.now();
        if (date.isBefore(today)) {
            System.out.println("deleteLichHocByDate1: Cannot delete past schedules (date: " + date + ")");
            return false;
        }

        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM [dbo].[LichHoc] WHERE NgayHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, java.sql.Date.valueOf(date));
            int rowsAffected = stmt.executeUpdate();
            System.out.println("deleteLichHocByDate1: Deleted " + rowsAffected + " schedules for date=" + date);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteLichHocByDate1: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves all schedules for a student.
     */
    public static List<LichHoc> getLichHocByHocSinhId(int idHocSinh) {
        List<LichHoc> list = new ArrayList<>();
        String sql = """
            SELECT lh.NgayHoc, sh.SlotThoiGian, lp.TenLopHoc, ph.TenPhongHoc, lh.GhiChu
            FROM HocSinh_LopHoc hslh
            JOIN LichHoc lh ON hslh.ID_LopHoc = lh.ID_LopHoc
            JOIN SlotHoc sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN LopHoc lp ON lh.ID_LopHoc = lp.ID_LopHoc
            JOIN PhongHoc ph ON lh.ID_PhongHoc = ph.ID_PhongHoc
            WHERE hslh.ID_HocSinh = ?
            ORDER BY lh.NgayHoc ASC, sh.ID_SlotHoc ASC
        """;
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LichHoc lich = new LichHoc();
                lich.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                lich.setSlotThoiGian(rs.getString("SlotThoiGian"));
                lich.setTenLopHoc(rs.getString("TenLopHoc"));
                lich.setTenPhongHoc(rs.getString("TenPhongHoc"));
                lich.setGhiChu(rs.getString("GhiChu"));
                list.add(lich);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves schedules for a student within a specific week, including attendance status.
     */
    public List<LichHoc> HSgetLichHocTrongTuan(int idHocSinh, LocalDate startDate, LocalDate endDate) {
        List<LichHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();

        String sql = """
                    SELECT 
                        lh.*, 
                        lop.TenLopHoc, 
                        sl.SlotThoiGian, 
                        ph.TenPhongHoc, 
                        lop.GhiChu,
                        dd.TrangThai AS TrangThaiDiemDanh 
                    FROM LichHoc lh
                    JOIN LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
                    JOIN SlotHoc sl ON lh.ID_SlotHoc = sl.ID_SlotHoc
                    JOIN HocSinh_LopHoc hslh ON lh.ID_LopHoc = hslh.ID_LopHoc
                    JOIN PhongHoc ph ON lop.ID_PhongHoc = ph.ID_PhongHoc
                    LEFT JOIN DiemDanh dd ON lh.ID_Schedule = dd.ID_Schedule AND dd.ID_HocSinh = ?
                    WHERE 
                        hslh.ID_HocSinh = ?
                        AND lh.NgayHoc BETWEEN ? AND ?
                    ORDER BY 
                        lh.NgayHoc, sl.ID_SlotHoc;
                    """;

        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ps.setInt(2, idHocSinh);
            ps.setDate(3, java.sql.Date.valueOf(startDate));
            ps.setDate(4, java.sql.Date.valueOf(endDate));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LichHoc lh = new LichHoc();
                    lh.setID_Schedule(rs.getInt("ID_Schedule"));
                    lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                    lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                    lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                    lh.setTenLopHoc(rs.getString("TenLopHoc"));
                    lh.setGhiChu(rs.getString("GhiChu"));
                    lh.setTenPhongHoc(rs.getString("TenPhongHoc"));

                    String trangThai = rs.getString("TrangThaiDiemDanh");
                    lh.setTrangThaiDiemDanh(trangThai);

                    list.add(lh);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi lấy lịch học trong tuần: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves schedules for a specific class within a specific week.
     */
    public List<LichHoc> getLichHocTrongTuanForClass(int classId, LocalDate startDate, LocalDate endDate) {
        List<LichHoc> list = new ArrayList<>();
        String sql = """
                    SELECT lh.*, lop.TenLopHoc, ph.TenPhongHoc, sl.SlotThoiGian, kh.TenKhoaHoc
                    FROM LichHoc lh
                    JOIN LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
                    JOIN PhongHoc ph ON lop.ID_PhongHoc = ph.ID_PhongHoc
                    JOIN SlotHoc sl ON lh.ID_SlotHoc = sl.ID_SlotHoc
                    JOIN KhoaHoc kh on lop.ID_KhoaHoc = kh.ID_KhoaHoc
                    WHERE lh.ID_LopHoc = ? AND lh.NgayHoc BETWEEN ? AND ?
                    ORDER BY lh.NgayHoc, sl.ID_SlotHoc
                    """;

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, classId);
            ps.setDate(2, java.sql.Date.valueOf(startDate));
            ps.setDate(3, java.sql.Date.valueOf(endDate));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LichHoc lh = new LichHoc();

                    lh.setID_Schedule(rs.getInt("ID_Schedule"));
                    lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                    lh.setID_SlotHoc(rs.getInt("ID_SlotHoc"));
                    lh.setNgayHoc(rs.getDate("NgayHoc").toLocalDate());
                    lh.setGhiChu(rs.getString("GhiChu"));
                    lh.setDaDiemDanh(rs.getBoolean("daDiemDanh"));

                    lh.setTenLopHoc(rs.getString("TenLopHoc"));
                    lh.setTenPhongHoc(rs.getString("TenPhongHoc"));
                    lh.setSlotThoiGian(rs.getString("SlotThoiGian"));
                    lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                    list.add(lh);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        List<LichHoc> list = new ArrayList<>();
        LichHocDAO dao = new LichHocDAO();
        LocalDate today = LocalDate.now();
        LocalDate startOfCurrentWeek = today.with(DayOfWeek.MONDAY); // Get Monday of the current week
        LocalDate endOfCurrentWeek = startOfCurrentWeek.plusDays(6);
        list = dao.getLichHocTrongTuanForClass(1, startOfCurrentWeek, endOfCurrentWeek);
        for (LichHoc l : list) {
            System.out.println(l.getTenLopHoc() + l.getTenPhongHoc() + l.getDayOfMonth());
        }
    }

    /**
     * Checks for schedule conflicts for a student when adding them to a new class.
     */
    public String hasScheduleConflictForStudent(int idHocSinh, int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String sql = """
        SELECT TOP 1 lop.TenLopHoc
        FROM HocSinh_LopHoc hslh
        JOIN LichHoc lh ON hslh.ID_LopHoc = lh.ID_LopHoc
        JOIN LichHoc newLh ON newLh.ID_LopHoc = ?
        JOIN LopHoc lop ON hslh.ID_LopHoc = lop.ID_LopHoc
        WHERE hslh.ID_HocSinh = ?
        AND lh.NgayHoc = newLh.NgayHoc
        AND lh.ID_SlotHoc = newLh.ID_SlotHoc
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            stmt.setInt(2, idHocSinh);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("TenLopHoc"); 
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in hasScheduleConflictForStudent: " + e.getMessage());
            e.printStackTrace();
        }
        return null; 
    }

    /**
     * Retrieves the nearest future schedule date for a given class.
     */
    public LocalDate getNearestFutureDate(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT TOP 1 NgayHoc FROM LichHoc WHERE ID_LopHoc = ? AND NgayHoc > GETDATE() ORDER BY NgayHoc ASC";
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDate("NgayHoc").toLocalDate();
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getNearestFutureDate: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
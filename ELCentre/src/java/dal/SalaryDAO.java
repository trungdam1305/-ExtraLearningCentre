package dal;

import model.SalaryInfo;
import model.TeacherSalary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class SalaryDAO {

    // Lấy thông tin giáo viên
    public static class TeacherInfo {

        public String hoTen;
        public double luongCoBan;

        public TeacherInfo(String hoTen, double luongCoBan) {
            this.hoTen = hoTen;
            this.luongCoBan = luongCoBan;
        }
    }

    public TeacherInfo getTeacherInfo(int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT HoTen, Luong 
            FROM GiaoVien 
            WHERE ID_GiaoVien = ?
            """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("getTeacherInfo: Found teacher ID_GiaoVien=" + idGiaoVien + ", HoTen=" + rs.getString("HoTen"));
                return new TeacherInfo(rs.getString("HoTen"), rs.getDouble("Luong"));
            } else {
                System.out.println("getTeacherInfo: No teacher found for ID_GiaoVien=" + idGiaoVien);
                return null;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getTeacherInfo: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return null;
        }
    }

    // Tính lương dự tính
    public List<SalaryInfo> calculateTeacherSalary(int idGiaoVien, String startDate, String endDate) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT glh.ID_GiaoVien, glh.ID_LopHoc, l.TenLopHoc, l.SiSo, l.SoTien, 
                   COUNT(lh.ID_Schedule) AS SoBuoiDay
            FROM GiaoVien_LopHoc glh
            LEFT JOIN LichHoc lh ON glh.ID_LopHoc = lh.ID_LopHoc
            JOIN GiaoVien g ON glh.ID_GiaoVien = g.ID_GiaoVien
            JOIN LopHoc l ON glh.ID_LopHoc = l.ID_LopHoc
            WHERE glh.ID_GiaoVien = ? AND lh.NgayHoc BETWEEN ? AND ? AND l.TrangThai = N'Đang học'
            GROUP BY glh.ID_GiaoVien, glh.ID_LopHoc, l.TenLopHoc, l.SiSo, l.SoTien
            HAVING COUNT(lh.ID_Schedule) > 0
            """;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<SalaryInfo> salaryList = new ArrayList<>();

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);

            // Xác định chu kỳ lương
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cal = Calendar.getInstance();
            if (startDate == null || startDate.isEmpty()) {
                cal.add(Calendar.MONTH, -1);
                cal.set(Calendar.DAY_OF_MONTH, 15);
                startDate = sdf.format(cal.getTime());
            }
            if (endDate == null || endDate.isEmpty()) {
                cal = Calendar.getInstance();
                cal.add(Calendar.MONTH, 1);
                cal.set(Calendar.DAY_OF_MONTH, 15);
                Date futureDate = cal.getTime();
                Date currentDate = new Date();
                endDate = sdf.format(futureDate.after(currentDate) ? currentDate : futureDate);
            }

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idGiaoVien);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            rs = stmt.executeQuery();

            TeacherInfo teacherInfo = getTeacherInfo(idGiaoVien);
            double luongCoBan = teacherInfo != null ? teacherInfo.luongCoBan : 0;

            while (rs.next()) {
                int idLopHoc = rs.getInt("ID_LopHoc");
                String tenLopHoc = rs.getString("TenLopHoc");
                int siSo = rs.getInt("SiSo");
                String soTienStr = rs.getString("SoTien");
                int soBuoiDay = rs.getInt("SoBuoiDay");

                // Lấy học phí
                double hocPhi = 50000;
                if (soTienStr != null && !soTienStr.isEmpty()) {
                    try {
                        hocPhi = Double.parseDouble(soTienStr);
                    } catch (NumberFormatException e) {
                        logAction(1, "Lỗi định dạng học phí cho lớp " + idLopHoc + ": " + soTienStr);
                    }
                }

                // Tính tỷ lệ chia
                double tyLeChia;
                if (siSo >= 1 && siSo <= 9) {
                    tyLeChia = 0.50;
                } else if (siSo <= 19) {
                    tyLeChia = 0.55;
                } else if (siSo <= 29) {
                    tyLeChia = 0.60;
                } else if (siSo <= 40) {
                    tyLeChia = 0.65;
                } else {
                    logAction(1, "Sĩ số không hợp lệ cho lớp " + idLopHoc + ": " + siSo);
                    continue;
                }

                // Tính lương dự tính
                double doanhThu = siSo * hocPhi * soBuoiDay;
                double luongDuTinh = luongCoBan + (doanhThu * tyLeChia);

                salaryList.add(new SalaryInfo(idGiaoVien, idLopHoc, tenLopHoc, soBuoiDay, siSo, hocPhi, luongDuTinh));
                System.out.println("calculateTeacherSalary: Added salary for ID_GiaoVien=" + idGiaoVien
                        + ", ID_LopHoc=" + idLopHoc + ", SiSo=" + siSo + ", LuongDuTinh=" + luongDuTinh);
            }

            conn.commit();
            System.out.println("calculateTeacherSalary: Completed for ID_GiaoVien=" + idGiaoVien
                    + ", StartDate=" + startDate + ", EndDate=" + endDate
                    + ", Result=" + (salaryList.isEmpty() ? "No data" : salaryList.size() + " records"));
            return salaryList;

        } catch (SQLException e) {
            System.out.println("SQL Error in calculateTeacherSalary: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.out.println("Rollback Error in calculateTeacherSalary: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }
            throw new SQLException("Lỗi cơ sở dữ liệu khi tính lương giáo viên: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("Close Error in calculateTeacherSalary: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    // Lưu lương vào LuongGiaoVien

    public void saveTeacherSalary(int idGiaoVien, String startDate, String endDate, List<SalaryInfo> salaryList,
            double bonusPenalty) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO LuongGiaoVien (ID_GiaoVien, ID_LopHoc, ChuKyBatDau, ChuKyKetThuc, 
                                       SoBuoiDay, LuongDuTinh, TrangThai, NgayCapNhat, ThuongPhat)
            VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)
            """;
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = db.getConnection();
            conn.setAutoCommit(false);
            stmt = conn.prepareStatement(sql);

            for (SalaryInfo salary : salaryList) {
                stmt.setInt(1, salary.getIdGiaoVien());
                stmt.setInt(2, salary.getIdLopHoc());
                stmt.setString(3, startDate);
                stmt.setString(4, endDate);
                stmt.setInt(5, salary.getSoBuoiDay());
                stmt.setDouble(6, salary.getLuongDuTinh());
                stmt.setString(7, "Pending");
                stmt.setDouble(8, bonusPenalty / salaryList.size());
                stmt.executeUpdate();
                System.out.println("saveTeacherSalary: Saved salary for ID_GiaoVien=" + salary.getIdGiaoVien()
                        + ", ID_LopHoc=" + salary.getIdLopHoc() + ", LuongDuTinh=" + salary.getLuongDuTinh());
            }

            logAction(1, "Lưu lương giáo viên ID_GiaoVien=" + idGiaoVien + " với thưởng/phạt: " + bonusPenalty);
            conn.commit();
            System.out.println("saveTeacherSalary: Completed for ID_GiaoVien=" + idGiaoVien);

        } catch (SQLException e) {
            System.out.println("SQL Error in saveTeacherSalary: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.out.println("Rollback Error in saveTeacherSalary: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException("Lỗi cơ sở dữ liệu khi lưu lương giáo viên: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("Close Error in saveTeacherSalary: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    // Ghi log vào UserLogs
    public void logAction(int adminId, String action) {
        DBContext db = DBContext.getInstance();
        String sql = """
            INSERT INTO UserLogs (ID_TaiKhoan, HanhDong, ThoiGian)
            VALUES (?, ?, GETDATE())
            """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adminId);
            stmt.setString(2, action);
            stmt.executeUpdate();
            System.out.println("logAction: Logged action for ID_TaiKhoan=" + adminId + ", HanhDong=" + action);
        } catch (SQLException e) {
            System.out.println("SQL Error in logAction: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
    }
}

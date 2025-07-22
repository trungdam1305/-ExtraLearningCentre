package dal;

import model.SalaryInfo;
import model.TeacherSalary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
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

            // Tự động tính startDate và endDate từ ngày 15 tháng này đến 14 tháng sau nếu không có tham số
            LocalDate now = LocalDate.now(); // Ngày hiện tại (22/07/2025)
            LocalDate defaultStart = now.withDayOfMonth(15); // Ngày 15 của tháng hiện tại
            LocalDate defaultEnd = defaultStart.plusMonths(1).withDayOfMonth(14); // Ngày 14 của tháng sau

            String calculatedStartDate = defaultStart.toString(); // yyyy-MM-dd (2025-07-15)
            String calculatedEndDate = defaultEnd.toString();     // yyyy-MM-dd (2025-08-14)

            // Sử dụng giá trị từ tham số nếu có, nếu không dùng giá trị tự động
            startDate = (startDate != null && !startDate.isEmpty()) ? startDate : calculatedStartDate;
            endDate = (endDate != null && !endDate.isEmpty()) ? endDate : calculatedEndDate;

            System.out.println("calculateTeacherSalary: Using StartDate=" + startDate + ", EndDate=" + endDate);

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
            double bonusPenalty) throws SQLException {
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
            if (conn == null) {
                throw new SQLException("Không thể mở kết nối cơ sở dữ liệu!");
            }
            conn.setAutoCommit(false);

            System.out.println("saveTeacherSalary: Starting transaction for ID_GiaoVien=" + idGiaoVien);

            // Kiểm tra xem chu kỳ đã được thanh toán chưa
            if (isCyclePaid(idGiaoVien, startDate, endDate)) {
                throw new SQLException("Không thể tạo lương mới: Chu kỳ " + startDate + " đến " + endDate + " đã được thanh toán!");
            }

            // Khởi tạo PreparedStatement trước vòng lặp
            stmt = conn.prepareStatement(sql);
            if (stmt == null) {
                throw new SQLException("Không thể chuẩn bị câu lệnh SQL: " + sql);
            }

            for (SalaryInfo salary : salaryList) {
                stmt.setInt(1, salary.getIdGiaoVien());
                stmt.setInt(2, salary.getIdLopHoc());
                stmt.setString(3, startDate);
                stmt.setString(4, endDate);
                stmt.setInt(5, salary.getSoBuoiDay());
                stmt.setDouble(6, salary.getLuongDuTinh());
                stmt.setString(7, "Pending");
                stmt.setDouble(8, bonusPenalty);
                int rowsAffected = stmt.executeUpdate();
                System.out.println("saveTeacherSalary: Inserted record for ID_GiaoVien=" + salary.getIdGiaoVien()
                        + ", ID_LopHoc=" + salary.getIdLopHoc() + ", rowsAffected=" + rowsAffected
                        + ", ThuongPhat=" + bonusPenalty);
            }

            logAction(1, "Lưu lương giáo viên ID_GiaoVien=" + idGiaoVien + " với thưởng/phạt: " + bonusPenalty);
            conn.commit();
            System.out.println("saveTeacherSalary: Transaction committed for ID_GiaoVien=" + idGiaoVien);

        } catch (SQLException e) {
            System.out.println("SQL Error in saveTeacherSalary: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                    System.out.println("saveTeacherSalary: Transaction rolled back due to error");
                } catch (SQLException ex) {
                    System.out.println("Rollback Error in saveTeacherSalary: " + ex.getMessage());
                    ex.printStackTrace();
                }
            }
            throw e; // Ném ngoại lệ để xử lý ở Servlet
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                    System.out.println("PreparedStatement closed successfully");
                }
                if (conn != null) {
                    conn.close();
                    System.out.println("Connection closed successfully");
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

    /**
     * Kiểm tra xem chu kỳ đã được thanh toán chưa.
     * @param idGiaoVien ID của giáo viên
     * @param startDate Ngày bắt đầu chu kỳ
     * @param endDate Ngày kết thúc chu kỳ
     * @return true nếu có bản ghi với trạng thái "Paid", false nếu không
     */
    public boolean isCyclePaid(int idGiaoVien, String startDate, String endDate) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(*) 
            FROM LuongGiaoVien 
            WHERE ID_GiaoVien = ? AND ChuKyBatDau = ? AND ChuKyKetThuc = ? AND TrangThai = 'Paid'
            """;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idGiaoVien);
            stmt.setString(2, startDate);
            stmt.setString(3, endDate);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("isCyclePaid: Checked cycle " + startDate + " to " + endDate + 
                                  ", Found " + count + " paid record(s)");
                return count > 0;
            }
            return false;

        } catch (SQLException e) {
            System.out.println("SQL Error in isCyclePaid: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Close Error in isCyclePaid: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    /**
     * Lấy bản ghi lương mới nhất của giáo viên, không phụ thuộc vào chu kỳ.
     * @param idGiaoVien ID của giáo viên
     * @return SalaryInfo chứa thông tin lương mới nhất, hoặc null nếu không có
     */
    public SalaryInfo getLatestSalaryForTeacher(int idGiaoVien) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT TOP 1 ID_Luong, ID_GiaoVien, ID_LopHoc, ChuKyBatDau, ChuKyKetThuc, 
                   SoBuoiDay, LuongDuTinh, ThuongPhat
            FROM LuongGiaoVien 
            WHERE ID_GiaoVien = ?
            ORDER BY ID_Luong DESC
            """;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idGiaoVien);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int idLuong = rs.getInt("ID_Luong");
                int idLopHoc = rs.getInt("ID_LopHoc");
                String tenLopHoc = getClassName(idLopHoc); // Lấy tên lớp từ LopHoc
                String chuKyBatDau = rs.getString("ChuKyBatDau");
                String chuKyKetThuc = rs.getString("ChuKyKetThuc");
                int soBuoiDay = rs.getInt("SoBuoiDay");
                double luongDuTinh = rs.getDouble("LuongDuTinh");
                double thuongPhat = rs.getDouble("ThuongPhat");

                SalaryInfo salary = new SalaryInfo(idGiaoVien, idLopHoc, tenLopHoc, soBuoiDay, 0, 0, luongDuTinh)
                        .setIdLuong(idLuong)
                        .setChuKyBatDau(chuKyBatDau)
                        .setChuKyKetThuc(chuKyKetThuc)
                        .setThuongPhat(thuongPhat);
                System.out.println("getLatestSalaryForTeacher: Found latest salary ID_Luong=" + idLuong + 
                                  ", ID_LopHoc=" + idLopHoc + ", LuongDuTinh=" + luongDuTinh + 
                                  ", ThuongPhat=" + thuongPhat);
                return salary;
            } else {
                System.out.println("getLatestSalaryForTeacher: No salary found for ID_GiaoVien=" + idGiaoVien);
                return null;
            }

        } catch (SQLException e) {
            System.out.println("SQL Error in getLatestSalaryForTeacher: " + e.getMessage() +
                              " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Close Error in getLatestSalaryForTeacher: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    /**
     * Cập nhật trạng thái thành "Paid" cho tất cả bản ghi lương có cùng chu kỳ.
     * @param idGiaoVien ID của giáo viên
     * @param chuKyBatDau Ngày bắt đầu chu kỳ
     * @param chuKyKetThuc Ngày kết thúc chu kỳ
     * @return Số lượng bản ghi được cập nhật
     * @throws SQLException Nếu có lỗi cơ sở dữ liệu
     */
    public int markSalariesAsPaid(int idGiaoVien, String chuKyBatDau, String chuKyKetThuc) throws SQLException {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE LuongGiaoVien 
            SET TrangThai = 'Paid'
            WHERE ID_GiaoVien = ? AND ChuKyBatDau = ? AND ChuKyKetThuc = ?
            """;
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idGiaoVien);
            stmt.setString(2, chuKyBatDau);
            stmt.setString(3, chuKyKetThuc);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("markSalariesAsPaid: Updated " + rowsAffected + " record(s) to 'Paid' for ID_GiaoVien=" + idGiaoVien + 
                              ", ChuKyBatDau=" + chuKyBatDau + ", ChuKyKetThuc=" + chuKyKetThuc);
            return rowsAffected;
        } catch (SQLException e) {
            System.out.println("SQL Error in markSalariesAsPaid: " + e.getMessage() +
                              " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Close Error in markSalariesAsPaid: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    /**
     * Kiểm tra trạng thái của một bản ghi lương.
     * @param idLuong ID của bản ghi lương
     * @return true nếu trạng thái là "Paid", false nếu không
     */
    public boolean isSalaryPaid(int idLuong) {
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT TrangThai 
            FROM LuongGiaoVien 
            WHERE ID_Luong = ?
            """;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idLuong);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String trangThai = rs.getString("TrangThai");
                boolean isPaid = "Paid".equalsIgnoreCase(trangThai);
                System.out.println("isSalaryPaid: Checked ID_Luong=" + idLuong + ", TrangThai=" + trangThai + ", IsPaid=" + isPaid);
                return isPaid;
            }
            return false;

        } catch (SQLException e) {
            System.out.println("SQL Error in isSalaryPaid: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Close Error in isSalaryPaid: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }

    /**
     * Lấy tên lớp học dựa trên ID_LopHoc.
     * @param idLopHoc ID của lớp học
     * @return Tên lớp học hoặc "Không xác định" nếu không tìm thấy
     */
    private String getClassName(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT TenLopHoc FROM LopHoc WHERE ID_LopHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("TenLopHoc");
            }
            return "Không xác định";
        } catch (SQLException e) {
            System.out.println("SQL Error in getClassName: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Không xác định";
        }
    }
}
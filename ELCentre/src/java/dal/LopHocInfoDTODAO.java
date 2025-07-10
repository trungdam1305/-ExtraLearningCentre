package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.LopHocInfoDTO;

public class LopHocInfoDTODAO {

    // Lớp để trả về kết quả của các thao tác như add, update, delete với thông tin lỗi
    public static class OperationResult {
        private boolean success;
        private String errorMessage;

        public OperationResult(boolean success, String errorMessage) {
            this.success = success;
            this.errorMessage = errorMessage;
        }

        public boolean isSuccess() {
            return success;
        }

        public String getErrorMessage() {
            return errorMessage;
        }
    }

    // Lớp để trả về kết quả của addLopHoc và updateLopHoc với thông tin lỗi cụ thể
    public static class AddLopHocResult {
        private LopHocInfoDTO lopHoc;
        private String errorMessage;

        public AddLopHocResult(LopHocInfoDTO lopHoc, String errorMessage) {
            this.lopHoc = lopHoc;
            this.errorMessage = errorMessage;
        }

        public LopHocInfoDTO getLopHoc() {
            return lopHoc;
        }

        public String getErrorMessage() {
            return errorMessage;
        }
    }

    // Kiểm tra trùng tên lớp học hoặc mã lớp học trong cùng khóa học
    public boolean isDuplicateClass(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, boolean isUpdate, int idLopHoc) {
        if (isUpdate) {
            return false; // Bỏ qua kiểm tra trùng lặp khi cập nhật
        }
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM LopHoc WHERE (TenLopHoc = ? OR ClassCode = ?) AND ID_KhoaHoc = ? AND ID_Khoi = ?";
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, tenLopHoc);
            statement.setString(2, classCode);
            statement.setInt(3, idKhoaHoc);
            statement.setInt(4, idKhoi);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                boolean isDuplicate = rs.getInt(1) > 0;
                System.out.println("isDuplicateClass: TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode
                        + ", ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi + ", Duplicate=" + isDuplicate);
                return isDuplicate;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in isDuplicateClass: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra trùng lịch học (phòng học, slot học, ngày học)
    public String checkScheduleConflict(List<Integer> idPhongHocList, List<Integer> idSlotHocList, List<LocalDate> ngayHocList, Integer excludeIdLopHoc) {
        StringBuilder errorMessage = new StringBuilder();
        DBContext db = DBContext.getInstance();
        String sql = """
        SELECT lh.ID_Schedule, lh.ID_LopHoc, lop.TenLopHoc, lh.NgayHoc, ph.TenPhongHoc, sh.SlotThoiGian
        FROM LichHoc lh
        JOIN LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
        JOIN PhongHoc ph ON lh.ID_PhongHoc = ph.ID_PhongHoc
        JOIN SlotHoc sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
        WHERE lh.ID_PhongHoc = ? AND lh.ID_SlotHoc = ? AND lh.NgayHoc = ?
        """ + (excludeIdLopHoc != null ? "AND lh.ID_LopHoc != ?" : "");
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            LocalDate today = LocalDate.now();
            for (int i = 0; i < idPhongHocList.size(); i++) {
                // Bỏ qua lịch học trong quá khứ
                if (ngayHocList.get(i).isBefore(today)) {
                    continue;
                }
                stmt.setInt(1, idPhongHocList.get(i));
                stmt.setInt(2, idSlotHocList.get(i));
                stmt.setDate(3, java.sql.Date.valueOf(ngayHocList.get(i)));
                if (excludeIdLopHoc != null) {
                    stmt.setInt(4, excludeIdLopHoc);
                }

                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String tenLopHoc = rs.getString("TenLopHoc");
                    String tenPhongHoc = rs.getString("TenPhongHoc");
                    String slotThoiGian = rs.getString("SlotThoiGian");
                    LocalDate ngayHoc = ngayHocList.get(i);
                    errorMessage.append(String.format("Xung đột lịch học: Phòng %s, slot %s, ngày %s đã được sử dụng bởi lớp %s. ",
                            tenPhongHoc, slotThoiGian, ngayHoc.toString(), tenLopHoc));
                }
            }

            System.out.println("checkScheduleConflict: Checked for ID_LopHoc=" + (excludeIdLopHoc != null ? excludeIdLopHoc : "none")
                    + ", Result=" + (errorMessage.length() > 0 ? errorMessage.toString() : "No conflicts"));
            return errorMessage.length() > 0 ? errorMessage.toString() : null;
        } catch (SQLException e) {
            System.out.println("SQL Error in checkScheduleConflict: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi kiểm tra xung đột lịch học: " + e.getMessage();
        }
    }

    // Kiểm tra xung đột lịch học của giáo viên và học sinh
    public String checkTeacherStudentScheduleConflict(int idLopHoc, List<Integer> idPhongHocList, List<Integer> idSlotHocList, List<LocalDate> ngayHocList) {
        StringBuilder errorMessage = new StringBuilder();
        DBContext db = DBContext.getInstance();
        LocalDate today = LocalDate.now();

        // Lấy danh sách giáo viên của lớp
        String sqlTeachers = "SELECT ID_GiaoVien FROM GiaoVien_LopHoc WHERE ID_LopHoc = ?";
        List<Integer> teacherIds = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sqlTeachers)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                teacherIds.add(rs.getInt("ID_GiaoVien"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in checkTeacherStudentScheduleConflict (teachers): " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi lấy danh sách giáo viên: " + e.getMessage();
        }

        // Kiểm tra xung đột lịch học của giáo viên
        if (!teacherIds.isEmpty()) {
            String sqlTeacherConflict = """
            SELECT lh.ID_LopHoc, lop.TenLopHoc, lh.NgayHoc, ph.TenPhongHoc, sh.SlotThoiGian, gv.HoTen
            FROM LichHoc lh
            JOIN LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
            JOIN PhongHoc ph ON lh.ID_PhongHoc = ph.ID_PhongHoc
            JOIN SlotHoc sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien
            WHERE glh.ID_GiaoVien = ? AND lh.ID_SlotHoc = ? AND lh.NgayHoc = ? AND lh.ID_LopHoc != ?
        """;
            try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sqlTeacherConflict)) {
                for (Integer idGiaoVien : teacherIds) {
                    for (int i = 0; i < idSlotHocList.size(); i++) {
                        // Bỏ qua lịch học trong quá khứ
                        if (ngayHocList.get(i).isBefore(today)) {
                            continue;
                        }
                        stmt.setInt(1, idGiaoVien);
                        stmt.setInt(2, idSlotHocList.get(i));
                        stmt.setDate(3, java.sql.Date.valueOf(ngayHocList.get(i)));
                        stmt.setInt(4, idLopHoc);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            String tenLopHoc = rs.getString("TenLopHoc");
                            String tenPhongHoc = rs.getString("TenPhongHoc");
                            String slotThoiGian = rs.getString("SlotThoiGian");
                            String hoTenGiaoVien = rs.getString("HoTen");
                            LocalDate ngayHoc = ngayHocList.get(i);
                            errorMessage.append(String.format("Xung đột lịch học giáo viên: Giáo viên %s có lớp %s vào slot %s, ngày %s tại phòng %s. ",
                                    hoTenGiaoVien, tenLopHoc, slotThoiGian, ngayHoc.toString(), tenPhongHoc));
                        }
                    }
                }
            } catch (SQLException e) {
                System.out.println("SQL Error in checkTeacherStudentScheduleConflict (teacher conflict): " + e.getMessage()
                        + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
                return "Lỗi cơ sở dữ liệu khi kiểm tra xung đột lịch học giáo viên: " + e.getMessage();
            }
        }

        // Lấy danh sách học sinh của lớp
        String sqlStudents = "SELECT ID_HocSinh FROM HocSinh_LopHoc WHERE ID_LopHoc = ?";
        List<Integer> studentIds = new ArrayList<>();
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sqlStudents)) {
            stmt.setInt(1, idLopHoc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                studentIds.add(rs.getInt("ID_HocSinh"));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in checkTeacherStudentScheduleConflict (students): " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi lấy danh sách học sinh: " + e.getMessage();
        }

        // Kiểm tra xung đột lịch học của học sinh
        if (!studentIds.isEmpty()) {
            String sqlStudentConflict = """
            SELECT lh.ID_LopHoc, lop.TenLopHoc, lh.NgayHoc, ph.TenPhongHoc, sh.SlotThoiGian, hs.HoTen
            FROM LichHoc lh
            JOIN LopHoc lop ON lh.ID_LopHoc = lop.ID_LopHoc
            JOIN PhongHoc ph ON lh.ID_PhongHoc = ph.ID_PhongHoc
            JOIN SlotHoc sh ON lh.ID_SlotHoc = sh.ID_SlotHoc
            JOIN HocSinh_LopHoc hslh ON lh.ID_LopHoc = hslh.ID_LopHoc
            JOIN HocSinh hs ON hslh.ID_HocSinh = hs.ID_HocSinh
            WHERE hslh.ID_HocSinh = ? AND lh.ID_SlotHoc = ? AND lh.NgayHoc = ? AND lh.ID_LopHoc != ?
        """;
            try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sqlStudentConflict)) {
                for (Integer idHocSinh : studentIds) {
                    for (int i = 0; i < idSlotHocList.size(); i++) {
                        // Bỏ qua lịch học trong quá khứ
                        if (ngayHocList.get(i).isBefore(today)) {
                            continue;
                        }
                        stmt.setInt(1, idHocSinh);
                        stmt.setInt(2, idSlotHocList.get(i));
                        stmt.setDate(3, java.sql.Date.valueOf(ngayHocList.get(i)));
                        stmt.setInt(4, idLopHoc);
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            String tenLopHoc = rs.getString("TenLopHoc");
                            String tenPhongHoc = rs.getString("TenPhongHoc");
                            String slotThoiGian = rs.getString("SlotThoiGian");
                            String hoTenHocSinh = rs.getString("HoTen");
                            LocalDate ngayHoc = ngayHocList.get(i);
                            errorMessage.append(String.format("Xung đột lịch học học sinh: Học sinh %s có lớp %s vào slot %s, ngày %s tại phòng %s. ",
                                    hoTenHocSinh, tenLopHoc, slotThoiGian, ngayHoc.toString(), tenPhongHoc));
                        }
                    }
                }
            } catch (SQLException e) {
                System.out.println("SQL Error in checkTeacherStudentScheduleConflict (student conflict): " + e.getMessage()
                        + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
                return "Lỗi cơ sở dữ liệu khi kiểm tra xung đột lịch học học sinh: " + e.getMessage();
            }
        }

        System.out.println("checkTeacherStudentScheduleConflict: Checked for ID_LopHoc=" + idLopHoc
                + ", Result=" + (errorMessage.length() > 0 ? errorMessage.toString() : "No conflicts"));
        return errorMessage.length() > 0 ? errorMessage.toString() : null;
    }

    // Kiểm tra trùng lịch học của phòng học (không loại trừ lớp học, dùng khi thêm mới)
    public String checkScheduleConflict(List<Integer> idPhongHocList, List<Integer> idSlotHocList, List<LocalDate> ngayHocList) {
        return checkScheduleConflict(idPhongHocList, idSlotHocList, ngayHocList, null);
    }

    // Kiểm tra dữ liệu đầu vào trước khi thêm hoặc cập nhật lớp học
    public String validateLopHocInput(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi,
            List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs,
            int siSoToiDa, int order, int soTien, String ghiChu, int siSoToiThieu,
            boolean isUpdate, int idLopHoc) {
        DBContext db = DBContext.getInstance();
        Connection connection = null;

        try {
            connection = db.getConnection();

            // Kiểm tra TenLopHoc
            if (!isUpdate) {
                if (tenLopHoc == null || tenLopHoc.trim().isEmpty()) {
                    return "Tên lớp học không được để trống!";
                }
                if (tenLopHoc.length() > 100) {
                    return "Tên lớp học quá dài (tối đa 100 ký tự)!";
                }
            }

            // Kiểm tra ClassCode
            if (!isUpdate) {
                if (classCode == null || classCode.trim().isEmpty()) {
                    return "Mã lớp học không được để trống!";
                }
                if (classCode.length() > 20) {
                    return "Mã lớp học quá dài (tối đa 20 ký tự)!";
                }
            }

            // Kiểm tra trùng tên lớp học hoặc mã lớp học
            if (isDuplicateClass(tenLopHoc, classCode, idKhoaHoc, idKhoi, isUpdate, idLopHoc)) {
                return "Tên lớp học hoặc mã lớp học đã tồn tại trong khóa học này!";
            }

            // Kiểm tra ID_KhoaHoc và ID_Khoi
            String sqlKhoaHoc = "SELECT ID_Khoi FROM KhoaHoc WHERE ID_KhoaHoc = ?";
            try (PreparedStatement stmt = connection.prepareStatement(sqlKhoaHoc)) {
                stmt.setInt(1, idKhoaHoc);
                ResultSet rs = stmt.executeQuery();
                if (!rs.next()) {
                    return "Khóa học không tồn tại!";
                }
                if (rs.getInt("ID_Khoi") != idKhoi) {
                    return "ID_Khoi không khớp với khóa học!";
                }
            }

            // Kiểm tra siSoToiDa
            if (siSoToiDa <= 0) {
                return "Sĩ số tối đa phải lớn hơn 0!";
            }

            // Kiểm tra siSoToiThieu
            if (siSoToiThieu < 0) {
                return "Sĩ số tối thiểu không được nhỏ hơn 0!";
            }
            if (siSoToiThieu > siSoToiDa) {
                return "Sĩ số tối thiểu không được lớn hơn sĩ số tối đa!";
            }

            // Kiểm tra order
            if (order < 0) {
                return "Thứ tự không được nhỏ hơn 0!";
            }

            // Kiểm tra soTien
            if (soTien < 0) {
                return "Học phí không được nhỏ hơn 0!";
            }
            String soTienStr = String.valueOf(soTien);
            if (soTienStr.length() > 10) {
                return "Học phí quá dài (tối đa 10 ký tự)!";
            }

            // Kiểm tra ghiChu
            if (ghiChu != null && ghiChu.length() > 500) {
                return "Ghi chú quá dài (tối đa 500 ký tự)!";
            }

            // Kiểm tra dữ liệu lịch học
            if (ngayHocs == null || idSlotHocs == null || idPhongHocs == null
                    || ngayHocs.size() != idSlotHocs.size() || ngayHocs.size() != idPhongHocs.size()) {
                return "Dữ liệu lịch học không hợp lệ!";
            }
            if (ngayHocs.isEmpty()) {
                return "Danh sách lịch học không được rỗng!";
            }

            // Kiểm tra định dạng ngày
            for (String ngayHoc : ngayHocs) {
                try {
                    LocalDate.parse(ngayHoc);
                } catch (Exception e) {
                    return "Ngày học không hợp lệ: " + ngayHoc + ". Định dạng phải là YYYY-MM-DD!";
                }
            }

            // Kiểm tra ID_SlotHoc
            String sqlSlotHoc = "SELECT COUNT(*) FROM SlotHoc WHERE ID_SlotHoc = ?";
            for (Integer idSlotHoc : idSlotHocs) {
                try (PreparedStatement stmt = connection.prepareStatement(sqlSlotHoc)) {
                    stmt.setInt(1, idSlotHoc);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) == 0) {
                        return "Slot học không tồn tại: " + idSlotHoc;
                    }
                }
            }

            // Kiểm tra ID_PhongHoc
            String sqlPhongHoc = "SELECT COUNT(*) FROM PhongHoc WHERE ID_PhongHoc = ?";
            for (Integer idPhongHoc : idPhongHocs) {
                try (PreparedStatement stmt = connection.prepareStatement(sqlPhongHoc)) {
                    stmt.setInt(1, idPhongHoc);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) == 0) {
                        return "Phòng học không tồn tại: " + idPhongHoc;
                    }
                }
            }

            // Kiểm tra trigger LimitClassesPerTimeSlot
            String sqlCountClasses = "SELECT COUNT(DISTINCT ID_LopHoc) FROM LichHoc WHERE ID_SlotHoc = ? AND NgayHoc = ?";
            for (int i = 0; i < idSlotHocs.size(); i++) {
                try (PreparedStatement stmt = connection.prepareStatement(sqlCountClasses)) {
                    stmt.setInt(1, idSlotHocs.get(i));
                    stmt.setDate(2, java.sql.Date.valueOf(ngayHocs.get(i)));
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) >= 10) {
                        return "Đã đạt giới hạn 10 lớp cho slot " + idSlotHocs.get(i) + " vào ngày " + ngayHocs.get(i);
                    }
                }
            }

            return null; // Không có lỗi
        } catch (SQLException e) {
            System.out.println("SQL Error in validateLopHocInput: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi kiểm tra dữ liệu đầu vào: " + e.getMessage();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Connection Close Error in validateLopHocInput: " + e.getMessage()
                        + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
            }
        }
    }

    // Kiểm tra dữ liệu liên quan trong các bảng tham chiếu
    public String checkRelatedRecords(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String[] tables = {
            "LichHoc", "GiaoVien_LopHoc", "HocSinh_LopHoc", "DangKyLopHoc",
            "HocPhi", "Diem", "TaoBaiTap"
        };
        String sql = "SELECT COUNT(*) FROM %s WHERE ID_LopHoc = ?";
        try (Connection conn = db.getConnection()) {
            for (String table : tables) {
                try (PreparedStatement stmt = conn.prepareStatement(String.format(sql, table))) {
                    stmt.setInt(1, idLopHoc);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        return "Không thể xóa lớp học vì có dữ liệu liên quan trong bảng " + table + "!";
                    }
                }
            }
            return null; // Không có dữ liệu liên quan
        } catch (SQLException e) {
            System.out.println("SQL Error in checkRelatedRecords: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi kiểm tra dữ liệu liên quan: " + e.getMessage();
        }
    }

    public OperationResult deleteLopHoc(int idLopHoc) {
        DBContext db = DBContext.getInstance();

        // Kiểm tra lớp học có tồn tại
        String checkExistSql = "SELECT TrangThai FROM LopHoc WHERE ID_LopHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement checkStmt = conn.prepareStatement(checkExistSql)) {
            checkStmt.setInt(1, idLopHoc);
            ResultSet rs = checkStmt.executeQuery();
            if (!rs.next()) {
                System.out.println("deleteLopHoc: Class not found for ID_LopHoc=" + idLopHoc);
                return new OperationResult(false, "Lớp học không tồn tại!");
            }
            String trangThai = rs.getString("TrangThai");
            if (!"Chưa học".equalsIgnoreCase(trangThai)) {
                System.out.println("deleteLopHoc: Cannot delete class ID_LopHoc=" + idLopHoc + " due to invalid status: " + trangThai);
                return new OperationResult(false, "Không thể xóa lớp học vì trạng thái không phù hợp (" + trangThai + ")!");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteLopHoc (check existence): " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return new OperationResult(false, "Lỗi cơ sở dữ liệu khi kiểm tra lớp học: " + e.getMessage());
        }

        // Kiểm tra dữ liệu liên quan
        String relatedRecordsError = checkRelatedRecords(idLopHoc);
        if (relatedRecordsError != null) {
            System.out.println("deleteLopHoc: Cannot delete due to related records - " + relatedRecordsError);
            return new OperationResult(false, relatedRecordsError);
        }

        // Thực hiện xóa
        String sql = "DELETE FROM LopHoc WHERE ID_LopHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, idLopHoc);
            int rs = statement.executeUpdate();
            if (rs > 0) {
                System.out.println("deleteLopHoc: Deleted " + rs + " rows for ID_LopHoc=" + idLopHoc);
                return new OperationResult(true, null);
            } else {
                System.out.println("deleteLopHoc: No rows deleted for ID_LopHoc=" + idLopHoc);
                return new OperationResult(false, "Không thể xóa lớp học, kiểm tra ID!");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteLopHoc: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return new OperationResult(false, "Lỗi cơ sở dữ liệu khi xóa lớp học: " + e.getMessage());
        }
    }

    public List<LopHocInfoDTO> getLopHocInfoList(String searchQuery, String statusFilter, int page, int pageSize,
            int idKhoaHoc, int idKhoi, String sortColumn, String sortOrder,
            String teacherFilter, String feeFilter, String orderFilter) {
        List<LopHocInfoDTO> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("""
            SELECT 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.[Order],
                STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                (SELECT TOP 1 gv.HoTen 
                 FROM GiaoVien_LopHoc glh 
                 JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                 WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                 ORDER BY glh.ID_GiaoVien DESC) AS TenGiaoVien,
                (SELECT TOP 1 gv.Avatar 
                 FROM GiaoVien_LopHoc glh 
                 JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                 WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                 ORDER BY glh.ID_GiaoVien DESC) AS AvatarGiaoVien,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
            FROM 
                LopHoc lh
            JOIN 
                KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN 
                LichHoc lich ON lh.ID_LopHoc = lich.ID_LopHoc
            LEFT JOIN 
                SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            LEFT JOIN 
                PhongHoc ph ON lich.ID_PhongHoc = ph.ID_PhongHoc
            WHERE 
                lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """);

        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql.append(" AND (lh.TenLopHoc LIKE ? OR lh.ClassCode LIKE ?) ");
            params.add("%" + searchQuery.trim() + "%");
            params.add("%" + searchQuery.trim() + "%");
            System.out.println("getLopHocInfoList: Applying searchQuery filter: " + searchQuery);
        }

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND lh.TrangThai = ? ");
            params.add(statusFilter.trim());
            System.out.println("getLopHocInfoList: Applying statusFilter: " + statusFilter);
        }

        if (teacherFilter != null && !teacherFilter.trim().isEmpty()) {
            try {
                int idGiaoVien = Integer.parseInt(teacherFilter);
                sql.append(" AND EXISTS (SELECT 1 FROM GiaoVien_LopHoc glh WHERE glh.ID_LopHoc = lh.ID_LopHoc AND glh.ID_GiaoVien = ?) ");
                params.add(idGiaoVien);
                System.out.println("getLopHocInfoList: Applying teacherFilter: ID_GiaoVien=" + idGiaoVien);
            } catch (NumberFormatException e) {
                System.out.println("getLopHocInfoList: Invalid teacherFilter: " + teacherFilter + " (not a valid integer)");
            }
        }

        if (feeFilter != null && !feeFilter.trim().isEmpty()) {
            switch (feeFilter) {
                case "0-50000":
                    sql.append(" AND lh.SoTien BETWEEN ? AND ? ");
                    params.add(0);
                    params.add(50000);
                    System.out.println("getLopHocInfoList: Applying feeFilter: 0-50000");
                    break;
                case "50000-100000":
                    sql.append(" AND lh.SoTien BETWEEN ? AND ? ");
                    params.add(50000);
                    params.add(100000);
                    System.out.println("getLopHocInfoList: Applying feeFilter: 50000-100000");
                    break;
                case "100000-200000":
                    sql.append(" AND lh.SoTien BETWEEN ? AND ? ");
                    params.add(100000);
                    params.add(200000);
                    System.out.println("getLopHocInfoList: Applying feeFilter: 100000-200000");
                    break;
                default:
                    System.out.println("getLopHocInfoList: Invalid feeFilter: " + feeFilter);
                    break;
            }
        }

        if (orderFilter != null && !orderFilter.trim().isEmpty()) {
            try {
                int orderValue = Integer.parseInt(orderFilter);
                if (orderValue >= 1 && orderValue <= 5) {
                    sql.append(" AND lh.[Order] = ? ");
                    params.add(orderValue);
                    System.out.println("getLopHocInfoList: Applying orderFilter: " + orderValue);
                } else {
                    System.out.println("getLopHocInfoList: Invalid orderFilter value: " + orderFilter + " (must be 1, 2, 3, 4, or 5)");
                }
            } catch (NumberFormatException e) {
                System.out.println("getLopHocInfoList: Invalid orderFilter: " + orderFilter + " (not a valid integer)");
            }
        }

        sql.append("""
            GROUP BY 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.[Order],
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
        """);

        if (sortColumn != null && !sortColumn.isEmpty()) {
            sql.append(" ORDER BY lh.").append(sortColumn);
            sql.append(sortOrder != null && sortOrder.equalsIgnoreCase("desc") ? " DESC" : " ASC");
            System.out.println("getLopHocInfoList: Sorting by " + sortColumn + " " + sortOrder);
        } else {
            sql.append(" ORDER BY lh.ID_LopHoc DESC");
            System.out.println("getLopHocInfoList: Default sorting by ID_LopHoc DESC");
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        int offset = (page - 1) * pageSize;
        params.add(offset);
        params.add(pageSize);

        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHocInfoDTO info = new LopHocInfoDTO();
                info.setIdLopHoc(rs.getInt("ID_LopHoc"));
                info.setClassCode(rs.getString("ClassCode"));
                info.setTenLopHoc(rs.getString("TenLopHoc"));
                info.setSiSo(rs.getInt("SiSo") != 0 ? rs.getInt("SiSo") : 0);
                info.setSiSoToiDa(rs.getInt("SiSoToiDa") != 0 ? rs.getInt("SiSoToiDa") : 0);
                info.setSiSoToiThieu(rs.getInt("SiSoToiThieu") != 0 ? rs.getInt("SiSoToiThieu") : 0);
                info.setOrder(rs.getInt("Order"));
                info.setThoiGianHoc(rs.getString("ThoiGianHoc") != null ? rs.getString("ThoiGianHoc") : "");
                info.setTenGiaoVien(rs.getString("TenGiaoVien") != null ? rs.getString("TenGiaoVien") : "");
                info.setGhiChu(rs.getString("GhiChu") != null ? rs.getString("GhiChu") : "");
                info.setTrangThai(rs.getString("TrangThai"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    info.setNgayTao(ts.toLocalDateTime());
                }
                String soTienStr = rs.getString("SoTien");
                info.setSoTien(soTienStr != null && !soTienStr.isEmpty() ? Integer.parseInt(soTienStr) : 0);
                info.setAvatarGiaoVien(rs.getString("AvatarGiaoVien") != null ? rs.getString("AvatarGiaoVien") : "");
                list.add(info);
            }
            System.out.println("getLopHocInfoList: Retrieved " + list.size() + " classes for ID_KhoaHoc=" + idKhoaHoc
                    + ", ID_Khoi=" + idKhoi + ", searchQuery=" + searchQuery + ", statusFilter=" + statusFilter
                    + ", teacherFilter=" + teacherFilter + ", feeFilter=" + feeFilter + ", orderFilter=" + orderFilter
                    + ", sortColumn=" + sortColumn + ", sortOrder=" + sortOrder + ", page=" + page + ", pageSize=" + pageSize);
        } catch (SQLException e) {
            System.out.println("SQL Error in getLopHocInfoList: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }

        return list;
    }

    public int countClasses(String searchQuery, String statusFilter, int idKhoaHoc, int idKhoi, String teacherFilter, String feeFilter, String orderFilter) {
        int count = 0;
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(DISTINCT l.ID_LopHoc) 
            FROM [dbo].[LopHoc] l
            INNER JOIN [dbo].[KhoaHoc] k ON l.ID_KhoaHoc = k.ID_KhoaHoc
            LEFT JOIN [dbo].[GiaoVien_LopHoc] glh ON l.ID_LopHoc = glh.ID_LopHoc
            WHERE l.ID_KhoaHoc = ? AND k.ID_Khoi = ?
        """);
        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);

        if (searchQuery != null && !searchQuery.isEmpty()) {
            sql.append(" AND (l.TenLopHoc LIKE ? OR l.ClassCode LIKE ?) ");
            params.add("%" + searchQuery + "%");
            params.add("%" + searchQuery + "%");
            System.out.println("countClasses: Applying searchQuery filter: " + searchQuery);
        }

        if (statusFilter != null && !statusFilter.isEmpty()) {
            sql.append(" AND l.TrangThai = ? ");
            params.add(statusFilter);
            System.out.println("countClasses: Applying statusFilter: " + statusFilter);
        }

        if (teacherFilter != null && !teacherFilter.isEmpty()) {
            try {
                int idGiaoVien = Integer.parseInt(teacherFilter);
                sql.append(" AND glh.ID_GiaoVien = ? ");
                params.add(idGiaoVien);
                System.out.println("countClasses: Applying teacherFilter: ID_GiaoVien=" + idGiaoVien);
            } catch (NumberFormatException e) {
                System.out.println("countClasses: Invalid teacherFilter: " + teacherFilter + " (not a valid integer)");
            }
        }

        if (feeFilter != null && !feeFilter.isEmpty()) {
            switch (feeFilter) {
                case "0-50000":
                    sql.append(" AND l.SoTien BETWEEN ? AND ? ");
                    params.add(0);
                    params.add(50000);
                    System.out.println("countClasses: Applying feeFilter: 0-50000");
                    break;
                case "50000-100000":
                    sql.append(" AND l.SoTien BETWEEN ? AND ? ");
                    params.add(50000);
                    params.add(100000);
                    System.out.println("countClasses: Applying feeFilter: 50000-100000");
                    break;
                case "100000-200000":
                    sql.append(" AND l.SoTien BETWEEN ? AND ? ");
                    params.add(100000);
                    params.add(200000);
                    System.out.println("countClasses: Applying feeFilter: 100000-200000");
                    break;
                default:
                    System.out.println("countClasses: Invalid feeFilter: " + feeFilter);
                    break;
            }
        }

        if (orderFilter != null && !orderFilter.isEmpty()) {
            try {
                int orderValue = Integer.parseInt(orderFilter);
                if (orderValue >= 1 && orderValue <= 5) {
                    sql.append(" AND l.[Order] = ? ");
                    params.add(orderValue);
                    System.out.println("countClasses: Applying orderFilter: " + orderValue);
                } else {
                    System.out.println("countClasses: Invalid orderFilter value: " + orderFilter + " (must be 1, 2, 3, 4, or 5)");
                }
            } catch (NumberFormatException e) {
                System.out.println("countClasses: Invalid orderFilter: " + orderFilter + " (not a valid integer)");
            }
        }

        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("countClasses: Counted " + count + " classes for ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi
                    + ", searchQuery=" + searchQuery + ", statusFilter=" + statusFilter + ", teacherFilter=" + teacherFilter
                    + ", feeFilter=" + feeFilter + ", orderFilter=" + orderFilter);
        } catch (SQLException e) {
            System.out.println("SQL Error in countClasses: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return count;
    }

    public int countClassesInSlot(int idSlotHoc, String ngayHoc) {
        int count = 0;
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(DISTINCT ID_LopHoc)
            FROM LichHoc
            WHERE ID_SlotHoc = ? AND NgayHoc = ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, idSlotHoc);
            statement.setDate(2, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("countClassesInSlot: Counted " + count + " classes for ID_SlotHoc=" + idSlotHoc + ", NgayHoc=" + ngayHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in countClassesInSlot: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return count;
    }

    public LopHocInfoDTO getLopHocInfoById(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String sqlSelect = """
            SELECT 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.[Order],
                STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                (SELECT TOP 1 gv.HoTen 
                 FROM GiaoVien_LopHoc glh 
                 JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                 WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                 ORDER BY glh.ID_GiaoVien DESC) AS TenGiaoVien,
                (SELECT TOP 1 gv.Avatar 
                 FROM GiaoVien_LopHoc glh 
                 JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                 WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                 ORDER BY glh.ID_GiaoVien DESC) AS AvatarGiaoVien,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
            FROM 
                LopHoc lh
            JOIN 
                KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN 
                LichHoc lich ON lh.ID_LopHoc = lich.ID_LopHoc
            LEFT JOIN 
                SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            LEFT JOIN 
                PhongHoc ph ON lich.ID_PhongHoc = ph.ID_PhongHoc
            WHERE 
                lh.ID_LopHoc = ?
            GROUP BY 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.[Order],
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
        """;
        try (Connection conn = db.getConnection(); PreparedStatement statement = conn.prepareStatement(sqlSelect)) {
            statement.setInt(1, idLopHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                LopHocInfoDTO info = new LopHocInfoDTO();
                info.setIdLopHoc(rs.getInt("ID_LopHoc"));
                info.setClassCode(rs.getString("ClassCode"));
                info.setTenLopHoc(rs.getString("TenLopHoc"));
                info.setSiSo(rs.getInt("SiSo") != 0 ? rs.getInt("SiSo") : 0);
                info.setSiSoToiDa(rs.getInt("SiSoToiDa") != 0 ? rs.getInt("SiSoToiDa") : 0);
                info.setSiSoToiThieu(rs.getInt("SiSoToiThieu") != 0 ? rs.getInt("SiSoToiThieu") : 0);
                info.setOrder(rs.getInt("Order"));
                info.setThoiGianHoc(rs.getString("ThoiGianHoc") != null ? rs.getString("ThoiGianHoc") : "");
                info.setTenGiaoVien(rs.getString("TenGiaoVien") != null ? rs.getString("TenGiaoVien") : "");
                info.setGhiChu(rs.getString("GhiChu") != null ? rs.getString("GhiChu") : "");
                info.setTrangThai(rs.getString("TrangThai"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    info.setNgayTao(ts.toLocalDateTime());
                }
                String soTienStr = rs.getString("SoTien");
                info.setSoTien(soTienStr != null && !soTienStr.isEmpty() ? Integer.parseInt(soTienStr) : 0);
                info.setAvatarGiaoVien(rs.getString("AvatarGiaoVien") != null ? rs.getString("AvatarGiaoVien") : "");
                System.out.println("getLopHocInfoById: Retrieved class for ID_LopHoc=" + idLopHoc);
                return info;
            }
            System.out.println("getLopHocInfoById: No class found for ID_LopHoc=" + idLopHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in getLopHocInfoById: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateSiSo(int idLopHoc, int siSo) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE LopHoc
            SET SiSo = ?
            WHERE ID_LopHoc = ?
        """;
        try (Connection conn = db.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, siSo);
            stmt.setInt(2, idLopHoc);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updateSiSo: Updated " + rowsAffected + " rows for ID_LopHoc=" + idLopHoc + ", SiSo=" + siSo);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in updateSiSo: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
    }

    private String mapTrangThai(String trangThai) {
        if (trangThai == null) {
            return "Chưa học";
        }
        switch (trangThai.trim()) {
            case "Đang học":
                return "Đang học";
            case "Kết thúc":
                return "Kết thúc";
            case "Chưa học":
                return "Chưa học";
            default:
                return "Chưa học";
        }
    }

    public AddLopHocResult addLopHoc(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, int siSo,
            List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs,
            String ghiChu, String trangThai, int soTien, String image, int siSoToiDa, int order, int siSoToiThieu) {
        String validationError = validateLopHocInput(tenLopHoc, classCode, idKhoaHoc, idKhoi, idSlotHocs, ngayHocs,
                idPhongHocs, siSoToiDa, order, soTien, ghiChu, siSoToiThieu, false, 0);
        if (validationError != null) {
            return new AddLopHocResult(null, validationError);
        }

        // Chuyển đổi danh sách ngày học sang List<LocalDate> để kiểm tra xung đột
        List<LocalDate> ngayHocList = new ArrayList<>();
        for (String ngayHoc : ngayHocs) {
            ngayHocList.add(LocalDate.parse(ngayHoc));
        }

        // Kiểm tra xung đột lịch học phòng
        String scheduleConflictError = checkScheduleConflict(idPhongHocs, idSlotHocs, ngayHocList);
        if (scheduleConflictError != null) {
            return new AddLopHocResult(null, scheduleConflictError);
        }

        DBContext db = DBContext.getInstance();
        LocalDateTime ngayTao = LocalDateTime.now();
        Connection connection = null;

        String mappedTrangThai = mapTrangThai(trangThai);
        System.out.println("addLopHoc: Mapping TrangThai from '" + trangThai + "' to '" + mappedTrangThai + "'");

        try {
            connection = db.getConnection();
            connection.setAutoCommit(false);

            String sqlInsert = """
                INSERT INTO LopHoc (
                    ClassCode, TenLopHoc, ID_KhoaHoc, SiSo, GhiChu,
                    TrangThai, SoTien, NgayTao, Image, SiSoToiDa, [Order], SiSoToiThieu
                ) OUTPUT INSERTED.ID_LopHoc
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            try (PreparedStatement statement = connection.prepareStatement(sqlInsert)) {
                statement.setString(1, classCode);
                statement.setString(2, tenLopHoc);
                statement.setInt(3, idKhoaHoc);
                statement.setInt(4, siSo);
                statement.setString(5, ghiChu);
                statement.setString(6, mappedTrangThai);
                statement.setString(7, String.valueOf(soTien));
                statement.setTimestamp(8, Timestamp.valueOf(ngayTao));
                statement.setString(9, image);
                statement.setInt(10, siSoToiDa);
                statement.setInt(11, order);
                statement.setInt(12, siSoToiThieu);
                ResultSet rs = statement.executeQuery();
                int newId = -1;
                if (rs.next()) {
                    newId = rs.getInt("ID_LopHoc");
                    System.out.println("addLopHoc: Generated ID_LopHoc=" + newId + " for TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode);
                } else {
                    System.out.println("addLopHoc: Failed to insert into LopHoc or retrieve ID_LopHoc for TenLopHoc=" + tenLopHoc + ", ID_KhoaHoc=" + idKhoaHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể chèn vào bảng LopHoc hoặc lấy ID lớp học!");
                }

                if (newId <= 0) {
                    System.out.println("addLopHoc: Invalid ID_LopHoc=" + newId + " for TenLopHoc=" + tenLopHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "ID lớp học không hợp lệ!");
                }

                for (int i = 0; i < idSlotHocs.size(); i++) {
                    String sqlLichHoc = """
                        INSERT INTO LichHoc (NgayHoc, ID_SlotHoc, GhiChu, ID_LopHoc, ID_PhongHoc)
                        VALUES (?, ?, ?, ?, ?)
                    """;
                    try (PreparedStatement stmtLichHoc = connection.prepareStatement(sqlLichHoc)) {
                        stmtLichHoc.setDate(1, java.sql.Date.valueOf(ngayHocs.get(i)));
                        stmtLichHoc.setInt(2, idSlotHocs.get(i));
                        stmtLichHoc.setString(3, ghiChu);
                        stmtLichHoc.setInt(4, newId);
                        stmtLichHoc.setInt(5, idPhongHocs.get(i));
                        int lichHocRs = stmtLichHoc.executeUpdate();
                        if (lichHocRs == 0) {
                            System.out.println("addLopHoc: Failed to insert into LichHoc for ID_LopHoc=" + newId + ", ID_SlotHoc=" + idSlotHocs.get(i) + ", NgayHoc=" + ngayHocs.get(i));
                            connection.rollback();
                            return new AddLopHocResult(null, "Không thể chèn vào bảng LichHoc cho slot " + idSlotHocs.get(i) + " ngày " + ngayHocs.get(i) + "!");
                        }
                    }
                }

                String sqlSelect = """
                    SELECT 
                        lh.ID_LopHoc,
                        lh.ClassCode,
                        lh.TenLopHoc,
                        lh.SiSo,
                        lh.SiSoToiDa,
                        lh.SiSoToiThieu,
                        lh.[Order],
                        STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                        (SELECT TOP 1 gv.HoTen 
                         FROM GiaoVien_LopHoc glh 
                         JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                         WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                         ORDER BY glh.ID_GiaoVien DESC) AS TenGiaoVien,
                        (SELECT TOP 1 gv.Avatar 
                         FROM GiaoVien_LopHoc glh 
                         JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                         WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                         ORDER BY glh.ID_GiaoVien DESC) AS AvatarGiaoVien,
                        lh.GhiChu,
                        lh.TrangThai,
                        lh.NgayTao,
                        lh.SoTien
                    FROM 
                        LopHoc lh
                    JOIN 
                        KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                    LEFT JOIN 
                        LichHoc lich ON lh.ID_LopHoc = lich.ID_LopHoc
                    LEFT JOIN 
                        SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
                    LEFT JOIN 
                        PhongHoc ph ON lich.ID_PhongHoc = ph.ID_PhongHoc
                    WHERE 
                        lh.ID_LopHoc = ?
                    GROUP BY 
                        lh.ID_LopHoc,
                        lh.ClassCode,
                        lh.TenLopHoc,
                        lh.SiSo,
                        lh.SiSoToiDa,
                        lh.SiSoToiThieu,
                        lh.[Order],
                        lh.GhiChu,
                        lh.TrangThai,
                        lh.NgayTao,
                        lh.SoTien
                """;
                try (PreparedStatement selectStmt = connection.prepareStatement(sqlSelect)) {
                    selectStmt.setInt(1, newId);
                    ResultSet rsSelect = selectStmt.executeQuery();
                    if (rsSelect.next()) {
                        LopHocInfoDTO info = new LopHocInfoDTO();
                        info.setIdLopHoc(rsSelect.getInt("ID_LopHoc"));
                        info.setClassCode(rsSelect.getString("ClassCode"));
                        info.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                        info.setSiSo(rsSelect.getInt("SiSo") != 0 ? rsSelect.getInt("SiSo") : 0);
                        info.setSiSoToiDa(rsSelect.getInt("SiSoToiDa") != 0 ? rsSelect.getInt("SiSoToiDa") : 0);
                        info.setSiSoToiThieu(rsSelect.getInt("SiSoToiThieu") != 0 ? rsSelect.getInt("SiSoToiThieu") : 0);
                        info.setOrder(rsSelect.getInt("Order"));
                        info.setThoiGianHoc(rsSelect.getString("ThoiGianHoc") != null ? rsSelect.getString("ThoiGianHoc") : "");
                        info.setTenGiaoVien(rsSelect.getString("TenGiaoVien") != null ? rsSelect.getString("TenGiaoVien") : "");
                        info.setGhiChu(rsSelect.getString("GhiChu") != null ? rsSelect.getString("GhiChu") : "");
                        info.setTrangThai(rsSelect.getString("TrangThai"));
                        Timestamp ts = rsSelect.getTimestamp("NgayTao");
                        if (ts != null) {
                            info.setNgayTao(ts.toLocalDateTime());
                        }
                        String soTienStr = rsSelect.getString("SoTien");
                        info.setSoTien(soTienStr != null && !soTienStr.isEmpty() ? Integer.parseInt(soTienStr) : 0);
                        info.setAvatarGiaoVien(rsSelect.getString("AvatarGiaoVien") != null ? rsSelect.getString("AvatarGiaoVien") : "");
                        connection.commit();
                        System.out.println("addLopHoc: Successfully added class - ID_LopHoc=" + newId + ", TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode);
                        return new AddLopHocResult(info, null);
                    } else {
                        System.out.println("addLopHoc: Failed to retrieve class info for ID_LopHoc=" + newId);
                        connection.rollback();
                        return new AddLopHocResult(null, "Không thể lấy thông tin lớp học vừa tạo!");
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in addLopHoc: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                System.out.println("Rollback Error in addLopHoc: " + ex.getMessage()
                        + " [SQLState: " + ex.getSQLState() + ", ErrorCode: " + ex.getErrorCode() + "]");
                ex.printStackTrace();
            }
            e.printStackTrace();
            return new AddLopHocResult(null, "Lỗi cơ sở dữ liệu khi thêm lớp học: " + e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Connection Close Error in addLopHoc: " + e.getMessage()
                        + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
            }
        }
    }

    public AddLopHocResult updateLopHoc(int idLopHoc, String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi,
            int siSo, List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs,
            String ghiChu, String trangThai, int soTien, String image, int siSoToiDa, int order, int siSoToiThieu) {
        String validationError = validateLopHocInput(tenLopHoc, classCode, idKhoaHoc, idKhoi, idSlotHocs, ngayHocs,
                idPhongHocs, siSoToiDa, order, soTien, ghiChu, siSoToiThieu, true, idLopHoc);
        if (validationError != null) {
            return new AddLopHocResult(null, validationError);
        }

        // Chuyển đổi danh sách ngày học sang List<LocalDate> để kiểm tra xung đột
        List<LocalDate> ngayHocList = new ArrayList<>();
        for (String ngayHoc : ngayHocs) {
            ngayHocList.add(LocalDate.parse(ngayHoc));
        }

        // Kiểm tra xung đột lịch học phòng
        String scheduleConflictError = checkScheduleConflict(idPhongHocs, idSlotHocs, ngayHocList, idLopHoc);
        if (scheduleConflictError != null) {
            return new AddLopHocResult(null, scheduleConflictError);
        }

        // Kiểm tra xung đột lịch học của giáo viên và học sinh
        String teacherStudentConflictError = checkTeacherStudentScheduleConflict(idLopHoc, idPhongHocs, idSlotHocs, ngayHocList);
        if (teacherStudentConflictError != null) {
            return new AddLopHocResult(null, teacherStudentConflictError);
        }

        DBContext db = DBContext.getInstance();
        Connection connection = null;
        LocalDate today = LocalDate.now();

        String mappedTrangThai = mapTrangThai(trangThai);
        System.out.println("updateLopHoc: Mapping TrangThai from '" + trangThai + "' to '" + mappedTrangThai + "'");

        try {
            connection = db.getConnection();
            connection.setAutoCommit(false);

            // Cập nhật thông tin lớp học
            String sqlUpdate = """
            UPDATE LopHoc
            SET GhiChu = ?, TrangThai = ?, SoTien = ?, Image = ?, SiSoToiDa = ?, [Order] = ?, SiSoToiThieu = ?
            WHERE ID_LopHoc = ?
        """;
            try (PreparedStatement statement = connection.prepareStatement(sqlUpdate)) {
                statement.setString(1, ghiChu);
                statement.setString(2, mappedTrangThai);
                statement.setString(3, String.valueOf(soTien));
                statement.setString(4, image);
                statement.setInt(5, siSoToiDa);
                statement.setInt(6, order);
                statement.setInt(7, siSoToiThieu);
                statement.setInt(8, idLopHoc);
                int rs = statement.executeUpdate();
                if (rs == 0) {
                    System.out.println("updateLopHoc: Failed to update LopHoc for ID_LopHoc=" + idLopHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể cập nhật bảng LopHoc!");
                }
            }

            // Xóa lịch học trong tương lai
            String sqlDeleteLichHoc = "DELETE FROM LichHoc WHERE ID_LopHoc = ? AND NgayHoc >= ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(sqlDeleteLichHoc)) {
                deleteStmt.setInt(1, idLopHoc);
                deleteStmt.setDate(2, java.sql.Date.valueOf(today));
                int rowsDeleted = deleteStmt.executeUpdate();
                System.out.println("updateLopHoc: Deleted " + rowsDeleted + " future schedules for ID_LopHoc=" + idLopHoc);
            }

            // Thêm lịch học mới từ danh sách gửi lên (bao gồm lịch học quá khứ và tương lai)
            for (int i = 0; i < idSlotHocs.size(); i++) {
                String sqlLichHoc = """
                INSERT INTO LichHoc (NgayHoc, ID_SlotHoc, GhiChu, ID_LopHoc, ID_PhongHoc)
                VALUES (?, ?, ?, ?, ?)
            """;
                try (PreparedStatement stmtLichHoc = connection.prepareStatement(sqlLichHoc)) {
                    stmtLichHoc.setDate(1, java.sql.Date.valueOf(ngayHocs.get(i)));
                    stmtLichHoc.setInt(2, idSlotHocs.get(i));
                    stmtLichHoc.setString(3, ghiChu);
                    stmtLichHoc.setInt(4, idLopHoc);
                    stmtLichHoc.setInt(5, idPhongHocs.get(i));
                    int lichHocRs = stmtLichHoc.executeUpdate();
                    if (lichHocRs == 0) {
                        System.out.println("updateLopHoc: Failed to insert into LichHoc for ID_LopHoc=" + idLopHoc
                                + ", ID_SlotHoc=" + idSlotHocs.get(i) + ", NgayHoc=" + ngayHocs.get(i));
                        connection.rollback();
                        return new AddLopHocResult(null, "Không thể chèn vào bảng LichHoc cho slot "
                                + idSlotHocs.get(i) + " ngày " + ngayHocs.get(i) + "!");
                    }
                }
            }

            // Lấy thông tin lớp học vừa cập nhật
            String sqlSelect = """
            SELECT 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.[Order],
                STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                (SELECT TOP 1 gv.HoTen 
                 FROM GiaoVien_LopHoc glh 
                 JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                 WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                 ORDER BY glh.ID_GiaoVien DESC) AS TenGiaoVien,
                (SELECT TOP 1 gv.Avatar 
                 FROM GiaoVien_LopHoc glh 
                 JOIN GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien 
                 WHERE glh.ID_LopHoc = lh.ID_LopHoc 
                 ORDER BY glh.ID_GiaoVien DESC) AS AvatarGiaoVien,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
            FROM 
                LopHoc lh
            JOIN 
                KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN 
                LichHoc lich ON lh.ID_LopHoc = lich.ID_LopHoc
            LEFT JOIN 
                SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            LEFT JOIN 
                PhongHoc ph ON lich.ID_PhongHoc = ph.ID_PhongHoc
            WHERE 
                lh.ID_LopHoc = ?
            GROUP BY 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.[Order],
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
        """;
            try (PreparedStatement selectStmt = connection.prepareStatement(sqlSelect)) {
                selectStmt.setInt(1, idLopHoc);
                ResultSet rsSelect = selectStmt.executeQuery();
                if (rsSelect.next()) {
                    LopHocInfoDTO info = new LopHocInfoDTO();
                    info.setIdLopHoc(rsSelect.getInt("ID_LopHoc"));
                    info.setClassCode(rsSelect.getString("ClassCode"));
                    info.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                    info.setSiSo(rsSelect.getInt("SiSo") != 0 ? rsSelect.getInt("SiSo") : 0);
                    info.setSiSoToiDa(rsSelect.getInt("SiSoToiDa") != 0 ? rsSelect.getInt("SiSoToiDa") : 0);
                    info.setSiSoToiThieu(rsSelect.getInt("SiSoToiThieu") != 0 ? rsSelect.getInt("SiSoToiThieu") : 0);
                    info.setOrder(rsSelect.getInt("Order"));
                    info.setThoiGianHoc(rsSelect.getString("ThoiGianHoc") != null ? rsSelect.getString("ThoiGianHoc") : "");
                    info.setTenGiaoVien(rsSelect.getString("TenGiaoVien") != null ? rsSelect.getString("TenGiaoVien") : "");
                    info.setGhiChu(rsSelect.getString("GhiChu") != null ? rsSelect.getString("GhiChu") : "");
                    info.setTrangThai(rsSelect.getString("TrangThai"));
                    Timestamp ts = rsSelect.getTimestamp("NgayTao");
                    if (ts != null) {
                        info.setNgayTao(ts.toLocalDateTime());
                    }
                    String soTienStr = rsSelect.getString("SoTien");
                    info.setSoTien(soTienStr != null && !soTienStr.isEmpty() ? Integer.parseInt(soTienStr) : 0);
                    info.setAvatarGiaoVien(rsSelect.getString("AvatarGiaoVien") != null ? rsSelect.getString("AvatarGiaoVien") : "");
                    connection.commit();
                    System.out.println("updateLopHoc: Successfully updated class - ID_LopHoc=" + idLopHoc
                            + ", TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode);
                    return new AddLopHocResult(info, null);
                } else {
                    System.out.println("updateLopHoc: Failed to retrieve class info for ID_LopHoc=" + idLopHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể lấy thông tin lớp học vừa cập nhật!");
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in updateLopHoc: " + e.getMessage()
                    + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                System.out.println("Rollback Error in updateLopHoc: " + ex.getMessage()
                        + " [SQLState: " + ex.getSQLState() + ", ErrorCode: " + ex.getErrorCode() + "]");
                ex.printStackTrace();
            }
            e.printStackTrace();
            return new AddLopHocResult(null, "Lỗi cơ sở dữ liệu khi cập nhật lớp học: " + e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Connection Close Error in updateLopHoc: " + e.getMessage()
                        + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
            }
        }
    }

    public List<LopHocInfoDTO> getClassesByTeacherId(int idGiaoVien) {
        List<LopHocInfoDTO> classList = new ArrayList<>();
        String sql = """
            SELECT 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.ID_KhoaHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.GhiChu,
                lh.TrangThai,
                lh.SoTien,
                lh.NgayTao,
                lh.Image,
                lh.[Order],
                kh.ID_Khoi,
                g.HoTen AS TenGiaoVien,
                STRING_AGG(sh.SlotThoiGian + ' (' + CONVERT(varchar, lich.NgayHoc, 103) + ')', ';') AS ThoiGianHoc
            FROM 
                [dbo].[LopHoc] lh
            JOIN 
                [dbo].[GiaoVien_LopHoc] glh ON lh.ID_LopHoc = glh.ID_LopHoc
            JOIN 
                [dbo].[GiaoVien] g ON glh.ID_GiaoVien = g.ID_GiaoVien
            JOIN 
                [dbo].[KhoaHoc] kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN 
                [dbo].[LichHoc] lich ON lh.ID_LopHoc = lich.ID_LopHoc
            LEFT JOIN 
                [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE 
                glh.ID_GiaoVien = ? 
                AND lh.TrangThai = N'Đang học'
            GROUP BY 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.ID_KhoaHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.SiSoToiThieu,
                lh.GhiChu,
                lh.TrangThai,
                lh.SoTien,
                lh.NgayTao,
                lh.Image,
                lh.[Order],
                kh.ID_Khoi,
                g.HoTen
        """;

        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idGiaoVien);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                LopHocInfoDTO lopHoc = new LopHocInfoDTO();
                lopHoc.setIdLopHoc(rs.getInt("ID_LopHoc"));
                lopHoc.setClassCode(rs.getString("ClassCode"));
                lopHoc.setTenLopHoc(rs.getString("TenLopHoc"));
                lopHoc.setIdKhoaHoc(rs.getInt("ID_KhoaHoc"));
                lopHoc.setSiSo(rs.getInt("SiSo"));
                lopHoc.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lopHoc.setSiSoToiThieu(rs.getInt("SiSoToiThieu"));
                lopHoc.setGhiChu(rs.getString("GhiChu"));
                lopHoc.setTrangThai(rs.getString("TrangThai"));
                // Chuyển đổi SoTien từ nvarchar sang int
                String soTienStr = rs.getString("SoTien");
                try {
                    lopHoc.setSoTien(soTienStr != null ? Integer.parseInt(soTienStr) : 0);
                } catch (NumberFormatException e) {
                    System.out.println("Error parsing SoTien: " + soTienStr);
                    lopHoc.setSoTien(0);
                }
                // Chuyển đổi từ java.sql.Timestamp sang LocalDateTime
                if (rs.getTimestamp("NgayTao") != null) {
                    lopHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                }
                lopHoc.setOrder(rs.getInt("Order"));
                lopHoc.setAvatarGiaoVien(rs.getString("Image"));
                lopHoc.setIdKhoi(rs.getInt("ID_Khoi"));
                lopHoc.setTenGiaoVien(rs.getString("TenGiaoVien"));
                lopHoc.setThoiGianHoc(rs.getString("ThoiGianHoc"));

                classList.add(lopHoc);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in getClassesByTeacherId: " + e.getMessage());
            e.printStackTrace();
        }

        return classList;
    }
    
    public List<LopHocInfoDTO> getClassesByStudentId(int idHocSinh) {
    List<LopHocInfoDTO> classList = new ArrayList<>();
    String sql = """
        SELECT 
            lh.ID_LopHoc,
            lh.ClassCode,
            lh.TenLopHoc,
            lh.ID_KhoaHoc,
            lh.SiSo,
            lh.SiSoToiDa,
            lh.SiSoToiThieu,
            lh.GhiChu,
            lh.TrangThai,
            lh.SoTien,
            lh.NgayTao,
            lh.Image,
            lh.[Order],
            kh.ID_Khoi,
            g.HoTen AS TenGiaoVien,
            STRING_AGG(sh.SlotThoiGian + ' (' + CONVERT(varchar, lich.NgayHoc, 103) + ')', ';') AS ThoiGianHoc
        FROM 
            [dbo].[LopHoc] lh
        JOIN 
            [dbo].[HocSinh_LopHoc] hslh ON lh.ID_LopHoc = hslh.ID_LopHoc
        JOIN 
            [dbo].[KhoaHoc] kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
        LEFT JOIN 
            [dbo].[GiaoVien_LopHoc] glh ON lh.ID_LopHoc = glh.ID_LopHoc
        LEFT JOIN 
            [dbo].[GiaoVien] g ON glh.ID_GiaoVien = g.ID_GiaoVien
        LEFT JOIN 
            [dbo].[LichHoc] lich ON lh.ID_LopHoc = lich.ID_LopHoc
        LEFT JOIN 
            [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
        WHERE 
            hslh.ID_HocSinh = ? 
            AND lh.TrangThai = N'Đang học'
        GROUP BY 
            lh.ID_LopHoc,
            lh.ClassCode,
            lh.TenLopHoc,
            lh.ID_KhoaHoc,
            lh.SiSo,
            lh.SiSoToiDa,
            lh.SiSoToiThieu,
            lh.GhiChu,
            lh.TrangThai,
            lh.SoTien,
            lh.NgayTao,
            lh.Image,
            lh.[Order],
            kh.ID_Khoi,
            g.HoTen
    """;

    try (Connection conn = DBContext.getInstance().getConnection(); 
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idHocSinh);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            LopHocInfoDTO lopHoc = new LopHocInfoDTO();
            lopHoc.setIdLopHoc(rs.getInt("ID_LopHoc"));
            lopHoc.setClassCode(rs.getString("ClassCode"));
            lopHoc.setTenLopHoc(rs.getString("TenLopHoc"));
            lopHoc.setIdKhoaHoc(rs.getInt("ID_KhoaHoc"));
            lopHoc.setSiSo(rs.getInt("SiSo"));
            lopHoc.setSiSoToiDa(rs.getInt("SiSoToiDa"));
            lopHoc.setSiSoToiThieu(rs.getInt("SiSoToiThieu"));
            lopHoc.setGhiChu(rs.getString("GhiChu"));
            lopHoc.setTrangThai(rs.getString("TrangThai"));
            // Chuyển đổi SoTien từ nvarchar sang int
            String soTienStr = rs.getString("SoTien");
            try {
                lopHoc.setSoTien(soTienStr != null ? Integer.parseInt(soTienStr) : 0);
            } catch (NumberFormatException e) {
                System.out.println("Error parsing SoTien: " + soTienStr);
                lopHoc.setSoTien(0);
            }
            // Chuyển đổi từ java.sql.Timestamp sang LocalDateTime
            if (rs.getTimestamp("NgayTao") != null) {
                lopHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
            }
            lopHoc.setOrder(rs.getInt("Order"));
            lopHoc.setAvatarGiaoVien(rs.getString("Image"));
            lopHoc.setIdKhoi(rs.getInt("ID_Khoi"));
            lopHoc.setTenGiaoVien(rs.getString("TenGiaoVien"));
            lopHoc.setThoiGianHoc(rs.getString("ThoiGianHoc"));

            classList.add(lopHoc);
        }
    } catch (SQLException e) {
        System.out.println("SQL Error in getClassesByStudentId: " + e.getMessage());
        e.printStackTrace();
    }

    return classList;
}

    public static void main(String[] args) {
        LopHocInfoDTODAO dao = new LopHocInfoDTODAO();
        int testIdGiaoVien = 3;

        List<LopHocInfoDTO> list = dao.getClassesByStudentId(testIdGiaoVien);
        if (list.isEmpty()) {
            System.out.println("Không có lớp học nào cho giáo viên ID = " + testIdGiaoVien);
        } else {
            System.out.println("Danh sách lớp học giáo viên ID = " + testIdGiaoVien + ":");
            for (LopHocInfoDTO dto : list) {
                System.out.println("- " + dto.getTenLopHoc() + " | " + dto.getThoiGianHoc() + " | GV: " + dto.getTenGiaoVien());
            }
        }
    }
}
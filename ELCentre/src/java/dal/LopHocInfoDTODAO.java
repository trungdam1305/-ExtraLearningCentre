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
    public boolean isDuplicateClass(String tenLopHoc, String classCode, int idKhoaHoc) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM LopHoc WHERE (TenLopHoc = ? OR ClassCode = ?) AND ID_KhoaHoc = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, tenLopHoc);
            statement.setString(2, classCode);
            statement.setInt(3, idKhoaHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                boolean isDuplicate = rs.getInt(1) > 0;
                System.out.println("isDuplicateClass: TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode + ", ID_KhoaHoc=" + idKhoaHoc + ", Duplicate=" + isDuplicate);
                return isDuplicate;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in isDuplicateClass: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra dữ liệu đầu vào trước khi thêm hoặc cập nhật lớp học
    public String validateLopHocInput(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs, int siSoToiDa, int order, int soTien, String ghiChu) {
        DBContext db = DBContext.getInstance();
        Connection connection = null;

        try {
            connection = db.getConnection();

            // Kiểm tra TenLopHoc
            if (tenLopHoc == null || tenLopHoc.trim().isEmpty()) {
                return "Tên lớp học không được để trống!";
            }
            if (tenLopHoc.length() > 100) {
                return "Tên lớp học quá dài (tối đa 100 ký tự)!";
            }

            // Kiểm tra ClassCode
            if (classCode == null || classCode.trim().isEmpty()) {
                return "Mã lớp học không được để trống!";
            }
            if (classCode.length() > 20) {
                return "Mã lớp học quá dài (tối đa 20 ký tự)!";
            }

            // Kiểm tra trùng tên lớp học hoặc mã lớp học
            if (isDuplicateClass(tenLopHoc.trim(), classCode.trim(), idKhoaHoc)) {
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
            if (ngayHocs == null || idSlotHocs == null || idPhongHocs == null || 
                ngayHocs.size() != idSlotHocs.size() || ngayHocs.size() != idPhongHocs.size()) {
                return "Dữ liệu lịch học không hợp lệ!";
            }
            if (ngayHocs.isEmpty()) {
                return "Danh sách lịch học không được rỗng!";
            }

            // Kiểm tra định dạng ngày và ngày trong tương lai
            for (String ngayHoc : ngayHocs) {
                try {
                    LocalDate date = LocalDate.parse(ngayHoc);
                    if (date.isBefore(LocalDate.now())) {
                        return "Ngày học không được trong quá khứ: " + ngayHoc;
                    }
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
            System.out.println("SQL Error in validateLopHocInput: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi kiểm tra dữ liệu đầu vào: " + e.getMessage();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                System.out.println("Connection Close Error in validateLopHocInput: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
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
            System.out.println("SQL Error in checkRelatedRecords: " + e.getMessage() + 
                               " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return "Lỗi cơ sở dữ liệu khi kiểm tra dữ liệu liên quan: " + e.getMessage();
        }
    }

    public OperationResult deleteLopHoc(int idLopHoc) {
        DBContext db = DBContext.getInstance();

        // Kiểm tra lớp học có tồn tại
        String checkExistSql = "SELECT TrangThai FROM LopHoc WHERE ID_LopHoc = ?";
        try (Connection conn = db.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkExistSql)) {
            checkStmt.setInt(1, idLopHoc);
            ResultSet rs = checkStmt.executeQuery();
            if (!rs.next()) {
                System.out.println("deleteLopHoc: Class not found for ID_LopHoc=" + idLopHoc);
                return new OperationResult(false, "Lớp học không tồn tại!");
            }
            // Kiểm tra trạng thái nếu cần (chỉ xóa khi trạng thái là "Chưa học")
            String trangThai = rs.getString("TrangThai");
            if (!"Chưa học".equalsIgnoreCase(trangThai)) {
                System.out.println("deleteLopHoc: Cannot delete class ID_LopHoc=" + idLopHoc + " due to invalid status: " + trangThai);
                return new OperationResult(false, "Không thể xóa lớp học vì trạng thái không phù hợp (" + trangThai + ")!");
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteLopHoc (check existence): " + e.getMessage() + 
                               " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
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
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
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
            System.out.println("SQL Error in deleteLopHoc: " + e.getMessage() + 
                               " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return new OperationResult(false, "Lỗi cơ sở dữ liệu khi xóa lớp học: " + e.getMessage());
        }
    }

    public List<LopHocInfoDTO> getLopHocInfoList(String name, String statusFilter, int page, int pageSize, int idKhoaHoc, int idKhoi, String sortColumn, String sortOrder) {
        List<LopHocInfoDTO> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("""
            SELECT 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                STRING_AGG(gv.HoTen, ', ') AS TenGiaoVien,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien,
                STRING_AGG(gv.Avatar, ', ') AS AvatarGiaoVien
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
            LEFT JOIN 
                GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            LEFT JOIN 
                GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien
            WHERE 
                lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """);
        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND lh.TenLopHoc LIKE ? ");
            params.add("%" + name.trim() + "%");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND lh.TrangThai = ? ");
            params.add(statusFilter.trim());
        }

        sql.append("""
            GROUP BY 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
        """);

        if (sortColumn != null && !sortColumn.isEmpty()) {
            sql.append(" ORDER BY ").append(sortColumn);
            if (sortOrder != null && sortOrder.equalsIgnoreCase("desc")) {
                sql.append(" DESC");
            } else {
                sql.append(" ASC");
            }
        } else {
            sql.append(" ORDER BY lh.ID_LopHoc DESC");
        }
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        int offset = (page - 1) * pageSize;
        params.add(offset);
        params.add(pageSize);

        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql.toString())) {
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
            System.out.println("getLopHocInfoList: Retrieved " + list.size() + " classes for ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi + ", name=" + name + ", status=" + statusFilter);
        } catch (SQLException e) {
            System.out.println("SQL Error in getLopHocInfoList: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return list;
    }

    public List<LopHocInfoDTO> getLopHocInfoList(String name, String statusFilter, int page, int pageSize, int idKhoaHoc, int idKhoi) {
        return getLopHocInfoList(name, statusFilter, page, pageSize, idKhoaHoc, idKhoi, null, null);
    }

    public int countClasses(String name, String statusFilter, int idKhoaHoc, int idKhoi) {
        int count = 0;
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(*) 
            FROM [dbo].[LopHoc] l
            INNER JOIN [dbo].[KhoaHoc] k ON l.ID_KhoaHoc = k.ID_KhoaHoc
            WHERE l.ID_KhoaHoc = ? AND k.ID_Khoi = ?
            """ + (name != null && !name.isEmpty() ? "AND l.TenLopHoc LIKE ? " : "") +
            (statusFilter != null && !statusFilter.isEmpty() ? "AND l.TrangThai = ? " : "");
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, idKhoaHoc);
            ps.setInt(paramIndex++, idKhoi);
            if (name != null && !name.isEmpty()) {
                ps.setString(paramIndex++, "%" + name + "%");
            }
            if (statusFilter != null && !statusFilter.isEmpty()) {
                ps.setString(paramIndex++, statusFilter);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("countClasses: Counted " + count + " classes for ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi + ", name=" + name + ", status=" + statusFilter);
        } catch (SQLException e) {
            System.out.println("SQL Error in countClasses: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
        }
        return count;
    }

    public int countClassesInSlot(int idSlotHoc, String ngayHoc) {
        int count = 0;
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(DISTINCT lh.ID_LopHoc)
            FROM LichHoc lh
            WHERE lh.ID_SlotHoc = ? AND lh.NgayHoc = ?
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, idSlotHoc);
            statement.setDate(2, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            System.out.println("countClassesInSlot: Counted " + count + " classes for ID_SlotHoc=" + idSlotHoc + ", NgayHoc=" + ngayHoc);
        } catch (SQLException e) {
            System.out.println("SQL Error in countClassesInSlot: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
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
                STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                STRING_AGG(gv.HoTen, ', ') AS TenGiaoVien,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien,
                STRING_AGG(gv.Avatar, ', ') AS AvatarGiaoVien
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
            LEFT JOIN 
                GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
            LEFT JOIN 
                GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien
            WHERE 
                lh.ID_LopHoc = ?
            GROUP BY 
                lh.ID_LopHoc,
                lh.ClassCode,
                lh.TenLopHoc,
                lh.SiSo,
                lh.SiSoToiDa,
                lh.GhiChu,
                lh.TrangThai,
                lh.NgayTao,
                lh.SoTien
        """;
        try (Connection conn = db.getConnection();
             PreparedStatement statement = conn.prepareStatement(sqlSelect)) {
            statement.setInt(1, idLopHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                LopHocInfoDTO info = new LopHocInfoDTO();
                info.setIdLopHoc(rs.getInt("ID_LopHoc"));
                info.setClassCode(rs.getString("ClassCode"));
                info.setTenLopHoc(rs.getString("TenLopHoc"));
                info.setSiSo(rs.getInt("SiSo") != 0 ? rs.getInt("SiSo") : 0);
                info.setSiSoToiDa(rs.getInt("SiSoToiDa") != 0 ? rs.getInt("SiSoToiDa") : 0);
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
            System.out.println("SQL Error in getLopHocInfoById: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
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
        try (Connection conn = db.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, siSo);
            stmt.setInt(2, idLopHoc);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("updateSiSo: Updated " + rowsAffected + " rows for ID_LopHoc=" + idLopHoc + ", SiSo=" + siSo);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in updateSiSo: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            e.printStackTrace();
            return false;
        }
    }

    // Phương thức ánh xạ trạng thái
    private String mapTrangThai(String trangThai) {
        if (trangThai == null) {
            return "Chưa học";
        }
        switch (trangThai.trim().toLowerCase()) {
            case "active":
                return "Đang học";
            case "finished":
                return "Kết thúc";
            case "inactive":
                return "Chưa học";
            default:
                return "Chưa học"; // Mặc định nếu trạng thái không khớp
        }
    }

    public AddLopHocResult addLopHoc(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, int siSo, List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs, String ghiChu, String trangThai, int soTien, String image, int siSoToiDa, int order) {
        // Kiểm tra đầu vào
        String validationError = validateLopHocInput(tenLopHoc, classCode, idKhoaHoc, idKhoi, idSlotHocs, ngayHocs, idPhongHocs, siSoToiDa, order, soTien, ghiChu);
        if (validationError != null) {
            return new AddLopHocResult(null, validationError);
        }

        DBContext db = DBContext.getInstance();
        LocalDateTime ngayTao = LocalDateTime.now();
        Connection connection = null;

        // Ánh xạ trạng thái
        String mappedTrangThai = mapTrangThai(trangThai);
        System.out.println("addLopHoc: Mapping TrangThai from '" + trangThai + "' to '" + mappedTrangThai + "'");

        try {
            connection = db.getConnection();
            connection.setAutoCommit(false);

            // Chèn vào bảng LopHoc
            String sqlInsert = """
                INSERT INTO LopHoc (
                    ClassCode, TenLopHoc, ID_KhoaHoc, SiSo, GhiChu,
                    TrangThai, SoTien, NgayTao, Image, SiSoToiDa, [Order]
                ) OUTPUT INSERTED.ID_LopHoc
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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

                // Kiểm tra newId
                if (newId <= 0) {
                    System.out.println("addLopHoc: Invalid ID_LopHoc=" + newId + " for TenLopHoc=" + tenLopHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "ID lớp học không hợp lệ!");
                }

                // Chèn vào bảng LichHoc
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

                // Lấy thông tin lớp học vừa thêm
                String sqlSelect = """
                    SELECT 
                        lh.ID_LopHoc,
                        lh.ClassCode,
                        lh.TenLopHoc,
                        lh.SiSo,
                        lh.SiSoToiDa,
                        STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                        STRING_AGG(gv.HoTen, ', ') AS TenGiaoVien,
                        lh.GhiChu,
                        lh.TrangThai,
                        lh.NgayTao,
                        lh.SoTien,
                        STRING_AGG(gv.Avatar, ', ') AS AvatarGiaoVien
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
                    LEFT JOIN 
                        GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
                    LEFT JOIN 
                        GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien
                    WHERE 
                        lh.ID_LopHoc = ?
                    GROUP BY 
                        lh.ID_LopHoc,
                        lh.ClassCode,
                        lh.TenLopHoc,
                        lh.SiSo,
                        lh.SiSoToiDa,
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
            System.out.println("SQL Error in addLopHoc: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                System.out.println("Rollback Error in addLopHoc: " + ex.getMessage() + " [SQLState: " + ex.getSQLState() + ", ErrorCode: " + ex.getErrorCode() + "]");
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
                System.out.println("Connection Close Error in addLopHoc: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
            }
        }
    }

    public AddLopHocResult updateLopHoc(int idLopHoc, String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, int siSo, List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs, String ghiChu, String trangThai, int soTien, String image, int siSoToiDa, int order) {
        // Kiểm tra đầu vào
        String validationError = validateLopHocInput(tenLopHoc, classCode, idKhoaHoc, idKhoi, idSlotHocs, ngayHocs, idPhongHocs, siSoToiDa, order, soTien, ghiChu);
        if (validationError != null) {
            return new AddLopHocResult(null, validationError);
        }

        DBContext db = DBContext.getInstance();
        Connection connection = null;

        // Ánh xạ trạng thái
        String mappedTrangThai = mapTrangThai(trangThai);
        System.out.println("updateLopHoc: Mapping TrangThai from '" + trangThai + "' to '" + mappedTrangThai + "'");

        try {
            connection = db.getConnection();
            connection.setAutoCommit(false);

            // Kiểm tra trùng tên lớp học hoặc mã lớp học
            String sqlCheckDuplicate = "SELECT ID_LopHoc FROM LopHoc WHERE (TenLopHoc = ? OR ClassCode = ?) AND ID_KhoaHoc = ? AND ID_LopHoc != ?";
            try (PreparedStatement checkStmt = connection.prepareStatement(sqlCheckDuplicate)) {
                checkStmt.setString(1, tenLopHoc);
                checkStmt.setString(2, classCode);
                checkStmt.setInt(3, idKhoaHoc);
                checkStmt.setInt(4, idLopHoc);
                ResultSet rsCheck = checkStmt.executeQuery();
                if (rsCheck.next()) {
                    System.out.println("updateLopHoc: Duplicate class name or code - TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode + ", ID_KhoaHoc=" + idKhoaHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "Tên lớp học hoặc mã lớp học đã tồn tại trong khóa học này!");
                }
            }

            // Cập nhật bảng LopHoc
            String sqlUpdate = """
                UPDATE LopHoc
                SET ClassCode = ?, TenLopHoc = ?, ID_KhoaHoc = ?, SiSo = ?, GhiChu = ?,
                    TrangThai = ?, SoTien = ?, Image = ?, SiSoToiDa = ?, [Order] = ?
                WHERE ID_LopHoc = ?
            """;
            try (PreparedStatement statement = connection.prepareStatement(sqlUpdate)) {
                statement.setString(1, classCode);
                statement.setString(2, tenLopHoc);
                statement.setInt(3, idKhoaHoc);
                statement.setInt(4, siSo);
                statement.setString(5, ghiChu);
                statement.setString(6, mappedTrangThai);
                statement.setString(7, String.valueOf(soTien));
                statement.setString(8, image);
                statement.setInt(9, siSoToiDa);
                statement.setInt(10, order);
                statement.setInt(11, idLopHoc);
                int rs = statement.executeUpdate();
                if (rs == 0) {
                    System.out.println("updateLopHoc: Failed to update LopHoc for ID_LopHoc=" + idLopHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể cập nhật bảng LopHoc!");
                }
            }

            // Xóa lịch học cũ
            String sqlDeleteLichHoc = "DELETE FROM LichHoc WHERE ID_LopHoc = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(sqlDeleteLichHoc)) {
                deleteStmt.setInt(1, idLopHoc);
                deleteStmt.executeUpdate();
            }

            // Chèn lịch học mới
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
                        System.out.println("updateLopHoc: Failed to insert into LichHoc for ID_LopHoc=" + idLopHoc + ", ID_SlotHoc=" + idSlotHocs.get(i) + ", NgayHoc=" + ngayHocs.get(i));
                        connection.rollback();
                        return new AddLopHocResult(null, "Không thể chèn vào bảng LichHoc cho slot " + idSlotHocs.get(i) + " ngày " + ngayHocs.get(i) + "!");
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
                    STRING_AGG(CONCAT(lich.NgayHoc, ' ', sh.SlotThoiGian, ' (', ph.TenPhongHoc, ')'), '; ') AS ThoiGianHoc,
                    STRING_AGG(gv.HoTen, ', ') AS TenGiaoVien,
                    lh.GhiChu,
                    lh.TrangThai,
                    lh.NgayTao,
                    lh.SoTien,
                    STRING_AGG(gv.Avatar, ', ') AS AvatarGiaoVien
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
                LEFT JOIN 
                    GiaoVien_LopHoc glh ON lh.ID_LopHoc = glh.ID_LopHoc
                LEFT JOIN 
                    GiaoVien gv ON glh.ID_GiaoVien = gv.ID_GiaoVien
                WHERE 
                    lh.ID_LopHoc = ?
                GROUP BY 
                    lh.ID_LopHoc,
                    lh.ClassCode,
                    lh.TenLopHoc,
                    lh.SiSo,
                    lh.SiSoToiDa,
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
                    System.out.println("updateLopHoc: Successfully updated class - ID_LopHoc=" + idLopHoc + ", TenLopHoc=" + tenLopHoc + ", ClassCode=" + classCode);
                    return new AddLopHocResult(info, null);
                } else {
                    System.out.println("updateLopHoc: Failed to retrieve class info for ID_LopHoc=" + idLopHoc);
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể lấy thông tin lớp học vừa cập nhật!");
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in updateLopHoc: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                System.out.println("Rollback Error in updateLopHoc: " + ex.getMessage() + " [SQLState: " + ex.getSQLState() + ", ErrorCode: " + ex.getErrorCode() + "]");
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
                System.out.println("Connection Close Error in updateLopHoc: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
                e.printStackTrace();
            }
        }
    }
}
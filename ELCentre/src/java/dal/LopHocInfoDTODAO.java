package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.LopHocInfoDTO;
import model.LichHoc;
import model.PhongHoc;

public class LopHocInfoDTODAO {

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

    private Connection getConnection() {
        return DBContext.getInstance().getConnection();
    }

    public boolean isDuplicateClass(String tenLopHoc, String classCode, int idKhoaHoc, int idLopHoc, boolean isUpdate) {
        String sql = "SELECT COUNT(*) FROM LopHoc WHERE (TenLopHoc = ? OR ClassCode = ?) AND ID_KhoaHoc = ? AND ID_LopHoc != ?";
        try (Connection conn = getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, tenLopHoc);
            statement.setString(2, classCode);
            statement.setInt(3, idKhoaHoc);
            statement.setInt(4, isUpdate ? idLopHoc : 0);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }

    private String validateLopHocInput(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, int siSoToiDa, int idLopHoc, boolean isUpdate, List<String> ngayHocs, List<Integer> idSlotHocs, List<Integer> idPhongHocs) {
        // Validate database-related constraints
        PhongHocDAO phongHocDAO = new PhongHocDAO();
        Map<Integer, PhongHoc> phongHocMap = new HashMap<>();
        Map<String, List<PhongHoc>> availabilityCache = new HashMap<>();
        for (Integer idPhongHoc : idPhongHocs) {
            if (!phongHocMap.containsKey(idPhongHoc)) {
                PhongHoc phongHoc = phongHocDAO.getPhongHocById(idPhongHoc);
                if (phongHoc == null) {
                    return "Phòng học ID " + idPhongHoc + " không tồn tại!";
                }
                phongHocMap.put(idPhongHoc, phongHoc);
            }
        }
        for (int i = 0; i < ngayHocs.size(); i++) {
            String ngayHoc = ngayHocs.get(i);
            int idSlotHoc = idSlotHocs.get(i);
            int idPhongHoc = idPhongHocs.get(i);
            String cacheKey = ngayHoc + "_" + idSlotHoc;
            List<PhongHoc> availableRooms;
            if (availabilityCache.containsKey(cacheKey)) {
                availableRooms = availabilityCache.get(cacheKey);
            } else {
                availableRooms = phongHocDAO.checkRoomAvailability(LocalDate.parse(ngayHoc), idSlotHoc);
                availabilityCache.put(cacheKey, availableRooms);
            }
            if (!availableRooms.stream().anyMatch(ph -> ph.getID_PhongHoc() == idPhongHoc)) {
                return "Phòng học ID " + idPhongHoc + " không trống vào ngày " + ngayHoc + ", slot " + idSlotHoc + "!";
            }
            PhongHoc phongHoc = phongHocMap.get(idPhongHoc);
            if (siSoToiDa > phongHoc.getSucChua()) {
                return "Sĩ số tối đa (" + siSoToiDa + ") không được lớn hơn sức chứa (" + phongHoc.getSucChua() + ") của phòng học!";
            }
        }
        if (isDuplicateClass(tenLopHoc, classCode, idKhoaHoc, idLopHoc, isUpdate)) {
            return "Tên lớp học hoặc mã lớp học đã tồn tại trong khóa học này!";
        }
        return null;
    }

    public String checkRelatedRecords(int idLopHoc) {
        String[] tables = {
            "LichHoc", "GiaoVien_LopHoc", "HocSinh_LopHoc", "DangKyLopHoc",
            "HocPhi", "Diem", "TaoBaiTap"
        };
        String sql = "SELECT COUNT(*) FROM %s WHERE ID_LopHoc = ?";
        try (Connection conn = getConnection()) {
            for (String table : tables) {
                try (PreparedStatement stmt = conn.prepareStatement(String.format(sql, table))) {
                    stmt.setInt(1, idLopHoc);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        return "Không thể xóa lớp học vì có dữ liệu liên quan trong bảng " + table + "!";
                    }
                }
            }
            return null;
        } catch (SQLException e) {
            return "Lỗi cơ sở dữ liệu khi kiểm tra dữ liệu liên quan: " + e.getMessage();
        }
    }

    public OperationResult deleteLopHoc(int idLopHoc) {
        String checkExistSql = "SELECT TrangThai FROM LopHoc WHERE ID_LopHoc = ?";
        try (Connection conn = getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkExistSql)) {
            checkStmt.setInt(1, idLopHoc);
            ResultSet rs = checkStmt.executeQuery();
            if (!rs.next()) {
                return new OperationResult(false, "Lớp học không tồn tại!");
            }
            String trangThai = rs.getString("TrangThai");
            if (!"Chưa học".equalsIgnoreCase(trangThai)) {
                return new OperationResult(false, "Không thể xóa lớp học vì trạng thái không phù hợp (" + trangThai + ")!");
            }
        } catch (SQLException e) {
            return new OperationResult(false, "Lỗi cơ sở dữ liệu khi kiểm tra lớp học: " + e.getMessage());
        }

        String relatedRecordsError = checkRelatedRecords(idLopHoc);
        if (relatedRecordsError != null) {
            return new OperationResult(false, relatedRecordsError);
        }

        String sql = "DELETE FROM LopHoc WHERE ID_LopHoc = ?";
        try (Connection conn = getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, idLopHoc);
            int rs = statement.executeUpdate();
            if (rs > 0) {
                return new OperationResult(true, null);
            } else {
                return new OperationResult(false, "Không thể xóa lớp học, kiểm tra ID!");
            }
        } catch (SQLException e) {
            return new OperationResult(false, "Lỗi cơ sở dữ liệu khi xóa lớp học: " + e.getMessage());
        }
    }

    public List<LopHocInfoDTO> getLopHocInfoList(String name, String statusFilter, int page, int pageSize, int idKhoaHoc, int idKhoi, String sortColumn, String sortOrder) {
        List<LopHocInfoDTO> list = new ArrayList<>();
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

        try (Connection conn = getConnection();
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
        } catch (SQLException e) {
            return new ArrayList<>();
        }
        return list;
    }

    public List<LopHocInfoDTO> getLopHocInfoList(String name, String statusFilter, int page, int pageSize, int idKhoaHoc, int idKhoi) {
        return getLopHocInfoList(name, statusFilter, page, pageSize, idKhoaHoc, idKhoi, null, null);
    }

    public int countClasses(String name, String statusFilter, int idKhoaHoc, int idKhoi) {
        int count = 0;
        String sql = """
            SELECT COUNT(*) 
            FROM [dbo].[LopHoc] l
            INNER JOIN [dbo].[KhoaHoc] k ON l.ID_KhoaHoc = k.ID_KhoaHoc
            WHERE l.ID_KhoaHoc = ? AND k.ID_Khoi = ?
            """ + (name != null && !name.isEmpty() ? "AND l.TenLopHoc LIKE ? " : "") +
            (statusFilter != null && !statusFilter.isEmpty() ? "AND l.TrangThai = ? " : "");
        try (Connection conn = getConnection();
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
        } catch (SQLException e) {
            return 0;
        }
        return count;
    }

    public int countClassesInSlot(int idSlotHoc, String ngayHoc) {
        int count = 0;
        String sql = """
            SELECT COUNT(DISTINCT lh.ID_LopHoc)
            FROM LichHoc lh
            WHERE lh.ID_SlotHoc = ? AND lh.NgayHoc = ?
        """;
        try (Connection conn = getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, idSlotHoc);
            statement.setDate(2, java.sql.Date.valueOf(ngayHoc));
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            return 0;
        }
        return count;
    }

    public LopHocInfoDTO getLopHocInfoById(int idLopHoc) {
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
        try (Connection conn = getConnection();
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
                return info;
            }
        } catch (SQLException e) {
            return null;
        }
        return null;
    }

    public boolean updateSiSo(int idLopHoc, int siSo) {
        String sql = """
            UPDATE LopHoc
            SET SiSo = ?
            WHERE ID_LopHoc = ?
        """;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, siSo);
            stmt.setInt(2, idLopHoc);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        }
    }

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
                return "Chưa học";
        }
    }

    public AddLopHocResult addLopHoc(String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, int siSo, List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs, String ghiChu, String trangThai, int soTien, String image, int siSoToiDa, int order) {
        String validationError = validateLopHocInput(tenLopHoc, classCode, idKhoaHoc, idKhoi, siSoToiDa, 0, false, ngayHocs, idSlotHocs, idPhongHocs);
        if (validationError != null) {
            return new AddLopHocResult(null, validationError);
        }

        LocalDateTime ngayTao = LocalDateTime.now();
        Connection connection = null;
        String mappedTrangThai = mapTrangThai(trangThai);

        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            String sqlInsert = """
                INSERT INTO LopHoc (
                    ClassCode, TenLopHoc, ID_KhoaHoc, SiSo, GhiChu,
                    TrangThai, SoTien, NgayTao, Image, SiSoToiDa, [Order]
                ) OUTPUT INSERTED.ID_LopHoc
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            int newId;
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
                if (rs.next()) {
                    newId = rs.getInt("ID_LopHoc");
                } else {
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể chèn vào bảng LopHoc!");
                }
            }

            if (newId <= 0) {
                connection.rollback();
                return new AddLopHocResult(null, "ID lớp học không hợp lệ!");
            }

            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LocalDate> ngayHocDates = ngayHocs.stream().map(LocalDate::parse).toList();
            List<LichHoc> lichHocList = lichHocDAO.addMultipleLichHoc(ngayHocDates, idSlotHocs, newId, idPhongHocs, ghiChu);
            if (lichHocList == null || lichHocList.size() != ngayHocs.size()) {
                connection.rollback();
                return new AddLopHocResult(null, "Không thể chèn vào bảng LichHoc!");
            }

            LopHocInfoDTO info = getLopHocInfoById(newId);
            if (info != null) {
                connection.commit();
                return new AddLopHocResult(info, null);
            } else {
                connection.rollback();
                return new AddLopHocResult(null, "Không thể lấy thông tin lớp học vừa tạo!");
            }
        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                // Bỏ qua để tránh treo
            }
            return new AddLopHocResult(null, "Lỗi cơ sở dữ liệu khi thêm lớp học: " + e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                // Bỏ qua để tránh treo
            }
        }
    }

    public AddLopHocResult updateLopHoc(int idLopHoc, String tenLopHoc, String classCode, int idKhoaHoc, int idKhoi, int siSo, List<Integer> idSlotHocs, List<String> ngayHocs, List<Integer> idPhongHocs, String ghiChu, String trangThai, int soTien, String image, int siSoToiDa, int order) {
        String validationError = validateLopHocInput(tenLopHoc, classCode, idKhoaHoc, idKhoi, siSoToiDa, idLopHoc, true, ngayHocs, idSlotHocs, idPhongHocs);
        if (validationError != null) {
            return new AddLopHocResult(null, validationError);
        }

        Connection connection = null;
        String mappedTrangThai = mapTrangThai(trangThai);

        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            String checkExistSql = "SELECT SiSo FROM LopHoc WHERE ID_LopHoc = ?";
            try (PreparedStatement checkStmt = connection.prepareStatement(checkExistSql)) {
                checkStmt.setInt(1, idLopHoc);
                ResultSet rs = checkStmt.executeQuery();
                if (!rs.next()) {
                    connection.rollback();
                    return new AddLopHocResult(null, "Lớp học không tồn tại!");
                }
                int currentSiSo = rs.getInt("SiSo");
                if (siSoToiDa < currentSiSo) {
                    connection.rollback();
                    return new AddLopHocResult(null, "Sĩ số tối đa (" + siSoToiDa + ") không được nhỏ hơn sĩ số hiện tại (" + currentSiSo + ")!");
                }
            }

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
                    connection.rollback();
                    return new AddLopHocResult(null, "Không thể cập nhật bảng LopHoc!");
                }
            }

            String sqlDeleteLichHoc = "DELETE FROM LichHoc WHERE ID_LopHoc = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(sqlDeleteLichHoc)) {
                deleteStmt.setInt(1, idLopHoc);
                deleteStmt.executeUpdate();
            }

            LichHocDAO lichHocDAO = new LichHocDAO();
            List<LocalDate> ngayHocDates = ngayHocs.stream().map(LocalDate::parse).toList();
            List<LichHoc> lichHocList = lichHocDAO.addMultipleLichHoc(ngayHocDates, idSlotHocs, idLopHoc, idPhongHocs, ghiChu);
            if (lichHocList == null || lichHocList.size() != ngayHocs.size()) {
                connection.rollback();
                return new AddLopHocResult(null, "Không thể chèn vào bảng LichHoc!");
            }

            LopHocInfoDTO info = getLopHocInfoById(idLopHoc);
            if (info != null) {
                connection.commit();
                return new AddLopHocResult(info, null);
            } else {
                connection.rollback();
                return new AddLopHocResult(null, "Không thể lấy thông tin lớp học vừa cập nhật!");
            }
        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                // Bỏ qua để tránh treo
            }
            return new AddLopHocResult(null, "Lỗi cơ sở dữ liệu khi cập nhật lớp học: " + e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                // Bỏ qua để tránh treo
            }
        }
    }
}
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.LopHoc;
import model.LopHocTheoNhomDTO;

public class LopHocDAO {

    // Lấy tất cả lớp học từ database, join với KhoaHoc, LichHoc và SlotHoc
    public List<LopHoc> getAllLopHoc() {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = """
            SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi, sh.SlotThoiGian
            FROM [dbo].[LopHoc] lh
            JOIN [dbo].[KhoaHoc] kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN [dbo].[LichHoc] lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số lớp học
    public static int getTotalLopHoc() {
        DBContext db = DBContext.getInstance();
        int total = 0;
        String sql = "SELECT COUNT(*) FROM LopHoc";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Đếm tổng số lớp học cho admin
    public static int adminGetTongSoLopHoc() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        String sql = "SELECT COUNT(*) FROM LopHoc";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tong;
    }

    // Lấy tổng số lớp học theo nhóm môn học
    public List<LopHocTheoNhomDTO> getTongLopHocTheoNhomMonHoc() {
        List<LopHocTheoNhomDTO> result = new ArrayList<>();
        String sql = """
            SELECT 
                khoc.ID_Khoi,
                khoc.TenKhoi,
                CASE 
                    WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%' THEN N'Toán'
                    WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%' THEN N'Văn'
                    ELSE N'Khác'
                END AS NhomMonHoc,
                COUNT(l.ID_LopHoc) AS TongSoLopHoc
            FROM 
                dbo.KhoiHoc khoc
            INNER JOIN 
                dbo.KhoaHoc khoah ON khoc.ID_Khoi = khoah.ID_Khoi
            LEFT JOIN 
                dbo.LopHoc l ON khoah.ID_KhoaHoc = l.ID_KhoaHoc
            GROUP BY 
                khoc.ID_Khoi, 
                khoc.TenKhoi,
                CASE 
                    WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%' THEN N'Toán'
                    WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%' THEN N'Văn'
                    ELSE N'Khác'
                END
            ORDER BY 
                khoc.ID_Khoi,
                NhomMonHoc
        """;
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LopHocTheoNhomDTO dto = new LopHocTheoNhomDTO(
                    rs.getInt("ID_Khoi"),
                    rs.getString("TenKhoi"),
                    rs.getString("NhomMonHoc"),
                    rs.getInt("TongSoLopHoc")
                );
                result.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Lấy lớp học theo ID khóa học
    public static List<LopHoc> getLopHocByIdKhoa(int idKhoaHoc) {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = """
            SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi, sh.SlotThoiGian
            FROM [dbo].[LopHoc] lh
            JOIN [dbo].[KhoaHoc] kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN [dbo].[LichHoc] lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE lh.ID_KhoaHoc = ?
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idKhoaHoc);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy lớp học theo ID khối
    public static List<LopHoc> getLopHocByIdKhoi(int idKhoiHoc) {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = """
            SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi, sh.SlotThoiGian
            FROM [dbo].[LopHoc] lh
            JOIN [dbo].[KhoaHoc] kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN [dbo].[LichHoc] lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN [dbo].[SlotHoc] sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE kh.ID_Khoi = ?
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idKhoiHoc);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy lớp học theo khóa học và khối
    public List<LopHoc> getLopHocByKhoaHocAndKhoi(int idKhoaHoc, int idKhoi) throws SQLException {
        List<LopHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT 
                lh.ID_LopHoc,
                lh.TenLopHoc,
                lh.ID_KhoaHoc,
                kh.TenKhoaHoc,
                kh.ID_Khoi,
                k.TenKhoi,
                lh.SiSo,
                lh.ID_Schedule,
                sh.SlotThoiGian,
                lh.GhiChu,
                lh.TrangThai,
                lh.SoTien,
                lh.NgayTao,
                lh.Image,
                lh.SiSoToiDa
            FROM 
                LopHoc lh
            JOIN 
                KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            JOIN 
                KhoiHoc k ON kh.ID_Khoi = k.ID_Khoi
            LEFT JOIN 
                LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN 
                SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE 
                lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idKhoaHoc);
            statement.setInt(2, idKhoi);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        }
        return list;
    }

    // Thêm lớp học mới và tạo lịch học
    public LopHoc addLopHoc(String tenLopHoc, int idKhoaHoc, int siSo, int idSlotHoc, String ngayHoc,
            String ghiChu, String trangThai, String soTien, String image, int siSoToiDa) {
        DBContext db = DBContext.getInstance();
        LocalDateTime ngayTao = LocalDateTime.now();
        Connection connection = null;

        try {
            connection = db.getConnection();
            connection.setAutoCommit(false);

            // Thêm bản ghi vào bảng LichHoc
            String sqlLichHoc = """
                INSERT INTO LichHoc (NgayHoc, ID_SlotHoc, GhiChu)
                VALUES (?, ?, ?)
            """;
            PreparedStatement stmtLichHoc = connection.prepareStatement(sqlLichHoc, java.sql.Statement.RETURN_GENERATED_KEYS);
            stmtLichHoc.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmtLichHoc.setInt(2, idSlotHoc);
            stmtLichHoc.setString(3, ghiChu);
            stmtLichHoc.executeUpdate();

            // Lấy ID_Schedule vừa tạo
            ResultSet rsLichHoc = stmtLichHoc.getGeneratedKeys();
            int idSchedule = -1;
            if (rsLichHoc.next()) {
                idSchedule = rsLichHoc.getInt(1);
            }
            rsLichHoc.close();
            stmtLichHoc.close();

            if (idSchedule == -1) {
                connection.rollback();
                return null;
            }

            // Thêm bản ghi vào bảng LopHoc
            String sqlInsert = """
                INSERT INTO LopHoc (
                    TenLopHoc, ID_KhoaHoc, SiSo, ID_Schedule, GhiChu,
                    TrangThai, SoTien, NgayTao, Image, SiSoToiDa
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            PreparedStatement statement = connection.prepareStatement(sqlInsert, java.sql.Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, tenLopHoc);
            statement.setInt(2, idKhoaHoc);
            statement.setInt(3, siSo);
            statement.setInt(4, idSchedule);
            statement.setString(5, ghiChu);
            statement.setString(6, trangThai);
            statement.setString(7, soTien);
            statement.setTimestamp(8, Timestamp.valueOf(ngayTao));
            statement.setString(9, image);
            statement.setInt(10, siSoToiDa);

            int rs = statement.executeUpdate();
            if (rs > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int newId = generatedKeys.getInt(1);
                    String sqlSelect = """
                        SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi, sh.SlotThoiGian
                        FROM LopHoc lh
                        JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                        LEFT JOIN LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
                        LEFT JOIN SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
                        WHERE lh.ID_LopHoc = ?
                    """;
                    PreparedStatement selectStmt = connection.prepareStatement(sqlSelect);
                    selectStmt.setInt(1, newId);
                    ResultSet rsSelect = selectStmt.executeQuery();
                    if (rsSelect.next()) {
                        LopHoc result = new LopHoc();
                        result.setID_LopHoc(rsSelect.getInt("ID_LopHoc"));
                        result.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                        result.setID_KhoaHoc(rsSelect.getInt("ID_KhoaHoc"));
                        result.setSiSo(rsSelect.getInt("SiSo"));
                        result.setID_Schedule(rsSelect.getInt("ID_Schedule"));
                        result.setGhiChu(rsSelect.getString("GhiChu"));
                        result.setTrangThai(rsSelect.getString("TrangThai"));
                        result.setSoTien(rsSelect.getString("SoTien"));
                        Timestamp ts = rsSelect.getTimestamp("NgayTao");
                        if (ts != null) {
                            result.setNgayTao(ts.toLocalDateTime());
                        }
                        result.setImage(rsSelect.getString("Image"));
                        result.setSiSoToiDa(rsSelect.getInt("SiSoToiDa"));
                        result.setTenKhoaHoc(rsSelect.getString("TenKhoaHoc"));
                        result.setID_Khoi(rsSelect.getInt("ID_Khoi"));
                        connection.commit();
                        return result;
                    }
                    selectStmt.close();
                }
                generatedKeys.close();
            }
            statement.close();
            connection.rollback();
            return null;
        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (connection != null) {
                    connection.setAutoCommit(true);
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Xóa lớp học
    public LopHoc deleteLopHoc(LopHoc lopHoc) {
        DBContext db = DBContext.getInstance();
        String sql = "DELETE FROM LopHoc WHERE ID_LopHoc = ?";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, lopHoc.getID_LopHoc());
            int rs = statement.executeUpdate();
            if (rs > 0) {
                return lopHoc;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy lớp học theo ID
    public LopHoc getLopHocById(int idLopHoc) {
        DBContext db = DBContext.getInstance();
        String sqlSelect = """
            SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi, sh.SlotThoiGian
            FROM LopHoc lh
            JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE lh.ID_LopHoc = ?
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sqlSelect)) {
            statement.setInt(1, idLopHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                LopHoc result = new LopHoc();
                result.setID_LopHoc(rs.getInt("ID_LopHoc"));
                result.setTenLopHoc(rs.getString("TenLopHoc"));
                result.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                result.setSiSo(rs.getInt("SiSo"));
                result.setID_Schedule(rs.getInt("ID_Schedule"));
                result.setGhiChu(rs.getString("GhiChu"));
                result.setTrangThai(rs.getString("TrangThai"));
                result.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    result.setNgayTao(ts.toLocalDateTime());
                }
                result.setImage(rs.getString("Image"));
                result.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                result.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                result.setID_Khoi(rs.getInt("ID_Khoi"));
                return result;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy lớp học phân trang và sắp xếp
    public List<LopHoc> getClassesSortedPaged(String sortColumn, String sortOrder, String searchName, int page, int pageSize, int idKhoaHoc, int idKhoi) {
        List<LopHoc> list = new ArrayList<>();
        List<String> allowedColumns = Arrays.asList("ID_LopHoc", "TenLopHoc", "SiSo", "ID_Schedule", "GhiChu", "TrangThai", "NgayTao", "SiSoToiDa");
        if (!allowedColumns.contains(sortColumn)) {
            sortColumn = "ID_LopHoc";
        }
        if (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc")) {
            sortOrder = "asc";
        }
        int offset = (page - 1) * pageSize;
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT 
                lh.ID_LopHoc,
                lh.TenLopHoc,
                lh.ID_KhoaHoc,
                kh.TenKhoaHoc,
                kh.ID_Khoi,
                lh.SiSo,
                lh.ID_Schedule,
                sh.SlotThoiGian,
                lh.GhiChu,
                lh.TrangThai,
                lh.SoTien,
                lh.NgayTao,
                lh.Image,
                lh.SiSoToiDa
            FROM 
                LopHoc lh
            JOIN 
                KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            LEFT JOIN 
                LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN 
                SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE 
                lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """;
        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += " AND lh.TenLopHoc LIKE ?";
            params.add("%" + searchName + "%");
        }
        sql += " ORDER BY " + sortColumn + " " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add(offset);
        params.add(pageSize);
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm số lớp học với bộ lọc
    public int countClasses(String searchName, int idKhoaHoc, int idKhoi) {
        int count = 0;
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT COUNT(*)
            FROM LopHoc lh
            JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            WHERE lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """;
        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += " AND lh.TenLopHoc LIKE ?";
            params.add("%" + searchName + "%");
        }
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // Lấy lớp học theo khóa học và khối với phân trang
    public List<LopHoc> getLopHocByKhoaHocAndKhoi(int idKhoaHoc, int idKhoi, int page, int pageSize) throws SQLException {
        List<LopHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        String sql = """
            SELECT 
                lh.ID_LopHoc,
                lh.TenLopHoc,
                lh.ID_KhoaHoc,
                kh.TenKhoaHoc,
                kh.ID_Khoi,
                k.TenKhoi,
                lh.SiSo,
                lh.ID_Schedule,
                sh.SlotThoiGian,
                lh.GhiChu,
                lh.TrangThai,
                lh.SoTien,
                lh.NgayTao,
                lh.Image,
                lh.SiSoToiDa
            FROM 
                LopHoc lh
            JOIN 
                KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            JOIN 
                KhoiHoc k ON kh.ID_Khoi = k.ID_Khoi
            LEFT JOIN 
                LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN 
                SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE 
                lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
            ORDER BY lh.TrangThai asc
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            statement.setInt(1, idKhoaHoc);
            statement.setInt(2, idKhoi);
            statement.setInt(3, offset);
            statement.setInt(4, pageSize);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        }
        return list;
    }

    // Cập nhật lớp học
    public LopHoc updateLopHoc(int idLopHoc, String tenLopHoc, int idKhoaHoc, int siSo, int idSchedule,
            String ghiChu, String trangThai, String soTien, String image, int siSoToiDa) {
        DBContext db = DBContext.getInstance();
        String sqlUpdate = """
            UPDATE LopHoc
            SET TenLopHoc = ?, ID_KhoaHoc = ?, SiSo = ?, ID_Schedule = ?, GhiChu = ?,
                TrangThai = ?, SoTien = ?, Image = ?, SiSoToiDa = ?
            WHERE ID_LopHoc = ?
        """;
        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(sqlUpdate)) {
            statement.setString(1, tenLopHoc);
            statement.setInt(2, idKhoaHoc);
            statement.setInt(3, siSo);
            statement.setInt(4, idSchedule);
            statement.setString(5, ghiChu);
            statement.setString(6, trangThai);
            statement.setString(7, soTien);
            statement.setString(8, image);
            statement.setInt(9, siSoToiDa);
            statement.setInt(10, idLopHoc);
            int rs = statement.executeUpdate();
            if (rs > 0) {
                String sqlSelect = """
                    SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi, sh.SlotThoiGian
                    FROM LopHoc lh
                    JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                    LEFT JOIN LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
                    LEFT JOIN SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
                    WHERE lh.ID_LopHoc = ?
                """;
                try (PreparedStatement selectStmt = connection.prepareStatement(sqlSelect)) {
                    selectStmt.setInt(1, idLopHoc);
                    ResultSet rsSelect = selectStmt.executeQuery();
                    if (rsSelect.next()) {
                        LopHoc result = new LopHoc();
                        result.setID_LopHoc(rsSelect.getInt("ID_LopHoc"));
                        result.setTenLopHoc(rsSelect.getString("TenLopHoc"));
                        result.setID_KhoaHoc(rsSelect.getInt("ID_KhoaHoc"));
                        result.setSiSo(rsSelect.getInt("SiSo"));
                        result.setID_Schedule(rsSelect.getInt("ID_Schedule"));
                        result.setGhiChu(rsSelect.getString("GhiChu"));
                        result.setTrangThai(rsSelect.getString("TrangThai"));
                        result.setSoTien(rsSelect.getString("SoTien"));
                        Timestamp ts = rsSelect.getTimestamp("NgayTao");
                        if (ts != null) {
                            result.setNgayTao(ts.toLocalDateTime());
                        }
                        result.setImage(rsSelect.getString("Image"));
                        result.setSiSoToiDa(rsSelect.getInt("SiSoToiDa"));
                        result.setTenKhoaHoc(rsSelect.getString("TenKhoaHoc"));
                        result.setID_Khoi(rsSelect.getInt("ID_Khoi"));
                        return result;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra trùng lặp GhiChu và ID_Schedule
    public boolean isDuplicateGhiChuAndThoiGian(String ghiChu, int idSchedule) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM LopHoc WHERE GhiChu = ? AND ID_Schedule = ?";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, ghiChu);
            ps.setInt(2, idSchedule);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tìm kiếm và lọc lớp học
    public List<LopHoc> searchAndFilterLopHoc(String name, String filterStatus, int page, int pageSize, int idKhoaHoc, int idKhoi) throws SQLException {
        List<LopHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("""
            SELECT 
                lh.ID_LopHoc,
                lh.TenLopHoc,
                lh.ID_KhoaHoc,
                kh.TenKhoaHoc,
                kh.ID_Khoi,
                k.TenKhoi,
                lh.SiSo,
                lh.ID_Schedule,
                sh.SlotThoiGian,
                lh.GhiChu,
                lh.TrangThai,
                lh.SoTien,
                lh.NgayTao,
                lh.Image,
                lh.SiSoToiDa
            FROM LopHoc lh
            JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            JOIN KhoiHoc k ON kh.ID_Khoi = k.ID_Khoi
            LEFT JOIN LichHoc lich ON lh.ID_Schedule = lich.ID_Schedule
            LEFT JOIN SlotHoc sh ON lich.ID_SlotHoc = sh.ID_SlotHoc
            WHERE lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """);
        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND lh.TenLopHoc LIKE ? ");
            params.add("%" + name.trim() + "%");
        }
        if (filterStatus != null && !filterStatus.trim().isEmpty()) {
            sql.append(" AND lh.TrangThai = ? ");
            params.add(filterStatus.trim());
        }
        sql.append(" ORDER BY lh.ID_LopHoc DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        int offset = (page - 1) * pageSize;
        params.add(offset);
        params.add(pageSize);
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setID_Schedule(rs.getInt("ID_Schedule"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                Timestamp ts = rs.getTimestamp("NgayTao");
                if (ts != null) {
                    lh.setNgayTao(ts.toLocalDateTime());
                }
                lh.setImage(rs.getString("Image"));
                lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
                lh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(lh);
            }
        }
        return list;
    }

    // Đếm số lớp học với bộ lọc tìm kiếm và trạng thái
    public int countClasses(String name, String filterStatus, int idKhoaHoc, int idKhoi) {
        int count = 0;
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*) FROM LopHoc lh
            JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
            JOIN KhoiHoc k ON kh.ID_Khoi = k.ID_Khoi
            WHERE lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """);
        List<Object> params = new ArrayList<>();
        params.add(idKhoaHoc);
        params.add(idKhoi);
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND lh.TenLopHoc LIKE ? ");
            params.add("%" + name.trim() + "%");
        }
        if (filterStatus != null && !filterStatus.trim().isEmpty()) {
            sql.append(" AND lh.TrangThai = ? ");
            params.add(filterStatus.trim());
        }
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
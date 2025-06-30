package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.LopHoc;
import model.LopHocTheoNhomDTO;

public class LopHocDAO {

    //Listing all Class from the Database
    public List<LopHoc> getAllFeaturedLopHoc() {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc]\n"
                + "                WHERE GhiChu IS NOT NULL";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
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
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());

                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //Call the Sum of Class 
    public static int getTotalLopHoc() {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = """
            SELECT COUNT(*) FROM LopHoc
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            rs.close();
            statement.close();
        } catch (Exception e) {
            return 0; // hoặc có thể trả về -1 để phân biệt có lỗi
        }
        return total;
    }

    public static int adminGetTongSoLopHoc() {
        DBContext db = DBContext.getInstance();
        int tong = 0;

        try {
            String sql = """
                          select count(*) from LopHoc
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                tong = rs.getInt(1);
                return tong;
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }
        return tong;
    }

    public List<LopHocTheoNhomDTO> getTongLopHocTheoNhomMonHoc() {
        List<LopHocTheoNhomDTO> result = new ArrayList<>();
        String sql = "	SELECT \n"
                + "    khoc.ID_Khoi,\n"
                + "    khoc.TenKhoi,\n"
                + "    CASE \n"
                + "        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%' THEN N'Toán'\n"
                + "        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%' THEN N'Văn'\n"
                + "        ELSE N'Khác'\n"
                + "    END AS NhomMonHoc,\n"
                + "    COUNT(l.ID_LopHoc) AS TongSoLopHoc\n"
                + "FROM \n"
                + "    dbo.KhoiHoc khoc\n"
                + "INNER JOIN \n"
                + "    dbo.KhoaHoc khoah ON khoc.ID_Khoi = khoah.ID_Khoi\n"
                + "LEFT JOIN \n"
                + "    dbo.LopHoc l ON khoah.ID_KhoaHoc = l.ID_KhoaHoc\n"
                + "GROUP BY \n"
                + "    khoc.ID_Khoi, \n"
                + "    khoc.TenKhoi,\n"
                + "    CASE \n"
                + "        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%' THEN N'Toán'\n"
                + "        WHEN khoah.TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%' THEN N'Văn'\n"
                + "        ELSE N'Khác'\n"
                + "    END\n"
                + "ORDER BY \n"
                + "    khoc.ID_Khoi,\n"
                + "    NhomMonHoc;";

        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int idKhoi = rs.getInt("ID_Khoi");
                String tenKhoi = rs.getString("TenKhoi");
                String nhomMonHoc = rs.getString("NhomMonHoc");
                int tongSoLopHoc = rs.getInt("TongSoLopHoc");

                LopHocTheoNhomDTO dto = new LopHocTheoNhomDTO(idKhoi, tenKhoi, nhomMonHoc, tongSoLopHoc);
                result.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public static List<LopHoc> getLopHocByIdKhoa(int idKhoaHoc) {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc] WHERE ID_KhoaHoc = ?";

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
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<LopHoc> getLopHocByIdKhoi(int idKhoiHoc) {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc] WHERE ID_Khoi = ?";

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
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy lớp học phân trang và sắp xếp
    // Lấy danh sách lớp học theo ID_KhoaHoc và ID_Khoi với phân trang
   public List<LopHoc> getClassesSortedPaged(String sortColumn, String sortOrder, String name, int pageNumber, int pageSize, int idKhoaHoc, int idKhoi) {
    List<LopHoc> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();

    String sql = """
        SELECT l.ID_LopHoc, l.ClassCode, l.TenLopHoc, l.ID_KhoaHoc, l.SiSo, l.SiSoToiDa, l.SiSoToiThieu, 
               l.ID_PhongHoc, p.TenPhongHoc, l.GhiChu, l.TrangThai, l.SoTien, l.NgayTao, l.Image, l.[Order]
        FROM [dbo].[LopHoc] l
        INNER JOIN [dbo].[KhoaHoc] k ON l.ID_KhoaHoc = k.ID_KhoaHoc
        LEFT JOIN [dbo].[PhongHoc] p ON l.ID_PhongHoc = p.ID_PhongHoc
        WHERE l.ID_KhoaHoc = ? AND k.ID_Khoi = ?
        """ + (name != null && !name.isEmpty() ? "AND l.TenLopHoc LIKE ? " : "") +
        (sortColumn != null && !sortColumn.isEmpty() ? "ORDER BY " + sortColumn : "ORDER BY l.ID_LopHoc") + " " +
        (sortOrder != null && !sortOrder.isEmpty() ? sortOrder : "ASC") +
        " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        int paramIndex = 1;
        ps.setInt(paramIndex++, idKhoaHoc);
        ps.setInt(paramIndex++, idKhoi);
        if (name != null && !name.isEmpty()) {
            ps.setString(paramIndex++, "%" + name + "%");
        }
        ps.setInt(paramIndex++, (pageNumber - 1) * pageSize);
        ps.setInt(paramIndex++, pageSize);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            LopHoc lh = new LopHoc();
            lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
            lh.setClassCode(rs.getString("ClassCode"));
            lh.setTenLopHoc(rs.getString("TenLopHoc"));
            lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
            lh.setSiSo(rs.getInt("SiSo"));
            lh.setSiSoToiDa(rs.getInt("SiSoToiDa"));
            lh.setSiSoToiThieu(rs.getInt("SiSoToiThieu"));
            lh.setID_PhongHoc(rs.getInt("ID_PhongHoc"));
            lh.setTenPhongHoc(rs.getString("TenPhongHoc"));
            lh.setGhiChu(rs.getString("GhiChu"));
            lh.setTrangThai(rs.getString("TrangThai"));
            lh.setSoTien(rs.getString("SoTien"));
            lh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
            lh.setImage(rs.getString("Image"));
            lh.setOrder(rs.getInt("Order"));
            list.add(lh);
        }
        System.out.println("getClassesSortedPaged: Retrieved " + list.size() + " classes for ID_KhoaHoc=" + idKhoaHoc + ", ID_Khoi=" + idKhoi + ", name=" + name);
    } catch (SQLException e) {
        System.out.println("SQL Error in getClassesSortedPaged: " + e.getMessage());
        e.printStackTrace();
    }
    return list;
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
                list.add(lh);
            }
        }
        return list;
    }

    // Đếm số lớp học với bộ lọc tìm kiếm và trạng thái
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
        System.out.println("SQL Error in countClasses: " + e.getMessage());
        e.printStackTrace();
    }
    return count;
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
                return result;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

            // Thêm bản ghi vào bảng LopHoc trước
            String sqlInsert = """
            INSERT INTO LopHoc (
                TenLopHoc, ID_KhoaHoc, SiSo, GhiChu,
                TrangThai, SoTien, NgayTao, Image, SiSoToiDa
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;
            PreparedStatement statement = connection.prepareStatement(sqlInsert, java.sql.Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, tenLopHoc);
            statement.setInt(2, idKhoaHoc);
            statement.setInt(3, siSo);
            statement.setString(4, ghiChu);
            statement.setString(5, trangThai);
            statement.setString(6, soTien);
            statement.setTimestamp(7, Timestamp.valueOf(ngayTao));
            statement.setString(8, image);
            statement.setInt(9, siSoToiDa);

            int rs = statement.executeUpdate();
            int newId = -1;
            if (rs > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    newId = generatedKeys.getInt(1);
                }
                generatedKeys.close();
            }
            statement.close();

            if (newId == -1) {
                System.out.println("Lỗi: Không thể tạo ID_LopHoc cho lớp học");
                connection.rollback();
                return null;
            }

            // Thêm bản ghi vào bảng LichHoc
            String sqlLichHoc = """
            INSERT INTO LichHoc (NgayHoc, ID_SlotHoc, GhiChu, ID_LopHoc)
            VALUES (?, ?, ?, ?)
        """;
            PreparedStatement stmtLichHoc = connection.prepareStatement(sqlLichHoc, java.sql.Statement.RETURN_GENERATED_KEYS);
            stmtLichHoc.setDate(1, java.sql.Date.valueOf(ngayHoc));
            stmtLichHoc.setInt(2, idSlotHoc);
            stmtLichHoc.setString(3, ghiChu);
            stmtLichHoc.setInt(4, newId);
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
                System.out.println("Lỗi: Không thể tạo ID_Schedule cho lịch học");
                connection.rollback();
                return null;
            }

            // Cập nhật ID_Schedule trong LopHoc
            String sqlUpdateLopHoc = """
            UPDATE LopHoc
            SET ID_Schedule = ?
            WHERE ID_LopHoc = ?
        """;
            PreparedStatement stmtUpdateLopHoc = connection.prepareStatement(sqlUpdateLopHoc);
            stmtUpdateLopHoc.setInt(1, idSchedule);
            stmtUpdateLopHoc.setInt(2, newId);
            stmtUpdateLopHoc.executeUpdate();
            stmtUpdateLopHoc.close();

            // Lấy thông tin lớp học vừa tạo
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
                connection.commit();
                return result;
            }
            selectStmt.close();
            connection.rollback();
            System.out.println("Lỗi: Không thể lấy thông tin lớp học vừa tạo");
            return null;
        } catch (SQLException e) {
            System.out.println("Lỗi SQL khi thêm lớp học: " + e.getMessage() + " [SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + "]");
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
        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sqlUpdate)) {
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
                        return result;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật sĩ số của lớp học
    public boolean updateSiSo(int idLopHoc, int siSo) {
        DBContext db = DBContext.getInstance();
        String sql = """
            UPDATE LopHoc
            SET SiSo = ?
            WHERE ID_LopHoc = ?
        """;
        List<Object> params = new ArrayList<>();
        params.add(siSo);
        params.add(idLopHoc);
        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    

}

package dal;

import java.beans.Statement;
import java.sql.Timestamp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.KhoaHoc;
import model.LopHoc;
import model.LopHocTheoNhomDTO;

public class LopHocDAO {

    //Listing all Class from the Database
    public List<LopHoc> getAllLopHoc() {
        DBContext db = DBContext.getInstance();
        List<LopHoc> list = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[LopHoc]";
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql);) {
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
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
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
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
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
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
                         lh.ThoiGianHoc,
                         lh.GhiChu,
                         lh.TrangThai,
                         lh.SoTien,
                         lh.NgayTao,
                         lh.Image
                     FROM 
                         LopHoc lh
                     JOIN 
                         KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                     JOIN 
                         KhoiHoc k ON kh.ID_Khoi = k.ID_Khoi
                     WHERE 
                         lh.ID_KhoaHoc = ?
                         AND kh.ID_Khoi = ?;
                     """;

        try (
                PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, idKhoaHoc);
            statement.setInt(2, idKhoi);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                // Khởi tạo đối tượng LopHoc từ rs
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }
        }
        return list;
    }

    public LopHoc addLopHoc(String tenLopHoc, int idKhoaHoc, int siSo, String thoiGianHoc,
            String ghiChu, String trangThai, String soTien, String image) {
        DBContext db = DBContext.getInstance();
        LocalDateTime ngayTao = LocalDateTime.now();

        String sqlInsert = """
        INSERT INTO LopHoc (
            TenLopHoc, ID_KhoaHoc, SiSo, ThoiGianHoc, GhiChu,
            TrangThai, SoTien, NgayTao, Image
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """;

        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sqlInsert, java.sql.Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, tenLopHoc);
            statement.setInt(2, idKhoaHoc);
            statement.setInt(3, siSo);
            statement.setString(4, thoiGianHoc);
            statement.setString(5, ghiChu);
            statement.setString(6, trangThai);
            statement.setDouble(7, Double.parseDouble(soTien));
            statement.setTimestamp(8, java.sql.Timestamp.valueOf(ngayTao));  // Chuyển LocalDateTime sang Timestamp
            statement.setString(9, image);

            int rs = statement.executeUpdate();

            if (rs > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int newId = generatedKeys.getInt(1);

                        String sqlSelect = """
                        SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi
                        FROM LopHoc lh
                        JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                        WHERE lh.ID_LopHoc = ?
                    """;

                        try (PreparedStatement selectStmt = connection.prepareStatement(sqlSelect)) {
                            selectStmt.setInt(1, newId);
                            ResultSet rsSelect = selectStmt.executeQuery();

                            if (rsSelect.next()) {
                                Timestamp ts = rsSelect.getTimestamp("NgayTao");
                                LocalDateTime ngayTaoFromDB = null;
                                if (ts != null) {
                                    ngayTaoFromDB = ts.toLocalDateTime();
                                }

                                LopHoc result = new LopHoc(
                                        rsSelect.getInt("ID_LopHoc"),
                                        rsSelect.getString("TenLopHoc"),
                                        rsSelect.getInt("ID_KhoaHoc"),
                                        rsSelect.getInt("SiSo"),
                                        rsSelect.getString("ThoiGianHoc"),
                                        rsSelect.getString("GhiChu"),
                                        rsSelect.getString("TrangThai"),
                                        String.valueOf(rsSelect.getDouble("SoTien")),
                                        ngayTaoFromDB,
                                        rsSelect.getString("Image")
                                );
                                result.setID_Khoi(rsSelect.getInt("ID_Khoi"));
                                result.setTenKhoaHoc(rsSelect.getString("TenKhoaHoc"));
                                return result;
                            }
                        }
                    }
                }
            }

            return null;
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    public LopHoc deleteLopHoc(LopHoc lopHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;

        try {
            String sql = """
        DELETE FROM LopHoc
        WHERE ID_LopHoc = ?
    """;
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, lopHoc.getID_LopHoc()); // (4)
            rs = statment.executeUpdate(); // (5)
        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return lopHoc;
        }
    }

    public LopHoc getLopHocById(int idLopHoc) {
        DBContext db = DBContext.getInstance();

        String sqlSelect = """
        SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi
        FROM LopHoc lh
        JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
        WHERE lh.ID_LopHoc = ?
    """;

        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sqlSelect)) {

            statement.setInt(1, idLopHoc);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("NgayTao");
                LocalDateTime ngayTaoFromDB = null;
                if (ts != null) {
                    ngayTaoFromDB = ts.toLocalDateTime();
                }

                // Lấy SoTien dưới dạng chuỗi và loại bỏ dấu phẩy
                String soTienStr = rs.getString("SoTien");
                String soTienFormatted = soTienStr != null ? soTienStr.replace(",", "") : "0";

                LopHoc result = new LopHoc(
                        rs.getInt("ID_LopHoc"),
                        rs.getString("TenLopHoc"),
                        rs.getInt("ID_KhoaHoc"),
                        rs.getInt("SiSo"),
                        rs.getString("ThoiGianHoc"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        soTienFormatted, // Dùng chuỗi đã xử lý
                        ngayTaoFromDB,
                        rs.getString("Image")
                );
                result.setID_Khoi(rs.getInt("ID_Khoi"));
                result.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                return result;
            }

            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<LopHoc> getClassesSortedPaged(String sortColumn, String sortOrder, String searchName, int page, int pageSize, int idKhoaHoc, int idKhoi) {
        List<LopHoc> list = new ArrayList<>();
        List<String> allowedColumns = Arrays.asList("ID_LopHoc", "TenLopHoc", "SiSo", "ThoiGianHoc", "GhiChu", "TrangThai", "NgayTao");

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
            kh.ID_Khoi,
            lh.SiSo,
            lh.ThoiGianHoc,
            lh.GhiChu,
            lh.TrangThai,
            lh.SoTien,
            lh.NgayTao,
            lh.Image
        FROM 
            LopHoc lh
        JOIN 
            KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
        WHERE 
            lh.ID_KhoaHoc = ?
            AND kh.ID_Khoi = ?
        """;

        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += " AND lh.TenLopHoc LIKE ?";
        }

        sql += " ORDER BY " + sortColumn + " " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            int idx = 1;
            stmt.setInt(idx++, idKhoaHoc);
            stmt.setInt(idx++, idKhoi);

            if (searchName != null && !searchName.trim().isEmpty()) {
                stmt.setString(idx++, "%" + searchName + "%");
            }

            stmt.setInt(idx++, offset);
            stmt.setInt(idx, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LopHoc lh = new LopHoc();
                lh.setID_LopHoc(rs.getInt("ID_LopHoc"));
                lh.setTenLopHoc(rs.getString("TenLopHoc"));
                lh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                lh.setSiSo(rs.getInt("SiSo"));
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                lh.setID_Khoi(rs.getInt("ID_Khoi"));  // nếu bạn có setter
                list.add(lh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countClasses(String searchName, int idKhoaHoc, int idKhoi) {
        int count = 0;
        DBContext db = DBContext.getInstance();

        String sql = """
        SELECT COUNT(*)
        FROM LopHoc lh
        JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
        WHERE lh.ID_KhoaHoc = ? AND kh.ID_Khoi = ?
        """;

        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += " AND lh.TenLopHoc LIKE ?";
        }

        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            int idx = 1;
            stmt.setInt(idx++, idKhoaHoc);
            stmt.setInt(idx++, idKhoi);
            if (searchName != null && !searchName.trim().isEmpty()) {
                stmt.setString(idx, "%" + searchName + "%");
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

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
                     lh.ThoiGianHoc,
                     lh.GhiChu,
                     lh.TrangThai,
                     lh.SoTien,
                     lh.NgayTao,
                     lh.Image
                 FROM 
                     LopHoc lh
                 JOIN 
                     KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                 JOIN 
                     KhoiHoc k ON kh.ID_Khoi = k.ID_Khoi
                 WHERE 
                     lh.ID_KhoaHoc = ?
                     AND kh.ID_Khoi = ?
                 ORDER BY lh.ID_LopHoc
                 OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
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
                lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
                lh.setGhiChu(rs.getString("GhiChu"));
                lh.setTrangThai(rs.getString("TrangThai"));
                lh.setSoTien(rs.getString("SoTien"));
                lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                lh.setImage(rs.getString("Image"));
                list.add(lh);
            }
        }
        return list;
    }

    public LopHoc updateLopHoc(int idLopHoc, String tenLopHoc, int idKhoaHoc, int siSo, String thoiGianHoc,
            String ghiChu, String trangThai, String soTien, String image) {
        DBContext db = DBContext.getInstance();
        LocalDateTime ngayCapNhat = LocalDateTime.now(); // Nếu bạn muốn cập nhật thời gian

        String sqlUpdate = """
        UPDATE LopHoc
        SET TenLopHoc = ?, ID_KhoaHoc = ?, SiSo = ?, ThoiGianHoc = ?, GhiChu = ?,
            TrangThai = ?, SoTien = ?, Image = ?
        WHERE ID_LopHoc = ?
    """;

        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sqlUpdate)) {

            statement.setString(1, tenLopHoc);
            statement.setInt(2, idKhoaHoc);
            statement.setInt(3, siSo);
            statement.setString(4, thoiGianHoc);
            statement.setString(5, ghiChu);
            statement.setString(6, trangThai);
            statement.setDouble(7, Double.parseDouble(soTien));
            statement.setString(8, image);
            statement.setInt(9, idLopHoc);

            int rs = statement.executeUpdate();

            if (rs > 0) {
                // Trả về đối tượng LopHoc mới sau khi cập nhật
                String sqlSelect = """
                SELECT lh.*, kh.TenKhoaHoc, kh.ID_Khoi
                FROM LopHoc lh
                JOIN KhoaHoc kh ON lh.ID_KhoaHoc = kh.ID_KhoaHoc
                WHERE lh.ID_LopHoc = ?
            """;

                try (PreparedStatement selectStmt = connection.prepareStatement(sqlSelect)) {
                    selectStmt.setInt(1, idLopHoc);
                    ResultSet rsSelect = selectStmt.executeQuery();

                    if (rsSelect.next()) {
                        Timestamp ts = rsSelect.getTimestamp("NgayTao");
                        LocalDateTime ngayTaoFromDB = (ts != null) ? ts.toLocalDateTime() : null;

                        LopHoc result = new LopHoc(
                                rsSelect.getInt("ID_LopHoc"),
                                rsSelect.getString("TenLopHoc"),
                                rsSelect.getInt("ID_KhoaHoc"),
                                rsSelect.getInt("SiSo"),
                                rsSelect.getString("ThoiGianHoc"),
                                rsSelect.getString("GhiChu"),
                                rsSelect.getString("TrangThai"),
                                String.valueOf(rsSelect.getDouble("SoTien")),
                                ngayTaoFromDB,
                                rsSelect.getString("Image")
                        );
                        result.setID_Khoi(rsSelect.getInt("ID_Khoi"));
                        result.setTenKhoaHoc(rsSelect.getString("TenKhoaHoc"));
                        return result;
                    }
                }
            }

            return null;

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean isDuplicateGhiChuAndThoiGian(String ghiChu, String thoiGianHoc) {
        boolean isDuplicate = false;
        DBContext db = DBContext.getInstance();

        String sql = "SELECT COUNT(*) FROM LopHoc WHERE GhiChu = ? AND ThoiGianHoc = ?";
        try (Connection conn = db.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, ghiChu);
            ps.setString(2, thoiGianHoc);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isDuplicate = rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDuplicate;
    }

    public List<LopHoc> searchAndFilterLopHoc(String name, String filterStatus,
        int page, int pageSize,
        int idKhoaHoc, int idKhoi) throws SQLException {

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
            lh.ThoiGianHoc,
            lh.GhiChu,
            lh.TrangThai,
            lh.SoTien,
            lh.NgayTao,
            lh.Image
        FROM LopHoc lh
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

    // Sử dụng phân trang chuẩn SQL Server
    sql.append(" ORDER BY lh.ID_LopHoc DESC ");
    sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    // OFFSET và FETCH NEXT
    int offset = (page - 1) * pageSize;
    params.add(offset);      // OFFSET
    params.add(pageSize);    // FETCH NEXT

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
            lh.setThoiGianHoc(rs.getString("ThoiGianHoc"));
            lh.setGhiChu(rs.getString("GhiChu"));
            lh.setTrangThai(rs.getString("TrangThai"));
            lh.setSoTien(rs.getString("SoTien"));
            lh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
            lh.setImage(rs.getString("Image"));
            list.add(lh);
        }
    }

    return list;
}


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
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

}

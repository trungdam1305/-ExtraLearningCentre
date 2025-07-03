package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Normalizer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;
import model.KhoaHoc;

/**
 * Data Access Object for KhoaHoc entity.
 * @author Vuh26
 */
public class KhoaHocDAO {

    /**
     * Loại bỏ dấu tiếng Việt từ chuỗi.
     * @param s Chuỗi đầu vào
     * @return Chuỗi không dấu
     */
    public static String removeAccent(String s) {
        if (s == null) {
            return "";
        }
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("").replaceAll("đ", "d").replaceAll("Đ", "D");
    }

    /**
     * Lấy tất cả khóa học.
     * @return Danh sách khóa học hoặc null nếu không có
     */
    public static ArrayList<KhoaHoc> adminGetAllKhoaHoc() {
        ArrayList<KhoaHoc> khoahocs = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM KhoaHoc";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoahoc = new KhoaHoc(
                        rs.getInt("ID_KhoaHoc"),
                        rs.getString("CourseCode"),
                        rs.getString("TenKhoaHoc"),
                        rs.getString("MoTa"),
                        rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null,
                        rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null,
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null,
                        rs.getInt("ID_Khoi"),
                        rs.getString("Image"),
                        rs.getInt("Order")
                );
                khoahocs.add(khoahoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (khoahocs.isEmpty()) {
            return null;
        } else {
            return khoahocs;
        }
    }

    /**
     * Lấy tất cả khóa học.
     * @return Danh sách khóa học
     */
    public static ArrayList<KhoaHoc> getKhoaHoc() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM KhoaHoc";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                courses.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return courses;
    }

    /**
     * Lấy khóa học theo trang.
     * @param pageIndex Số trang
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public List<KhoaHoc> getKhoaHocByPage(int pageIndex, int pageSize) {
        List<KhoaHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                SELECT * FROM (
                    SELECT ROW_NUMBER() OVER (ORDER BY ID_KhoaHoc) AS RowNum, *
                    FROM KhoaHoc
                ) AS temp
                WHERE RowNum BETWEEN ? AND ?
            """;
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            int start = (pageIndex - 1) * pageSize + 1;
            int end = pageIndex * pageSize;
            ps.setInt(1, start);
            ps.setInt(2, end);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                KhoaHoc kh = new KhoaHoc();
                kh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                kh.setCourseCode(rs.getString("CourseCode"));
                kh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                kh.setMoTa(rs.getString("MoTa"));
                kh.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                kh.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                kh.setGhiChu(rs.getString("GhiChu"));
                kh.setTrangThai(rs.getString("TrangThai"));
                kh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                kh.setID_Khoi(rs.getInt("ID_Khoi"));
                kh.setImage(rs.getString("Image"));
                kh.setOrder(rs.getInt("Order"));
                list.add(kh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy thông tin khóa học theo ID.
     * @param ID_KhoaHoc ID khóa học
     * @return Đối tượng KhoaHoc hoặc null nếu không tìm thấy
     */
    public static KhoaHoc getKhoaHocById(int ID_KhoaHoc) {
        DBContext db = DBContext.getInstance();
        KhoaHoc khoaHoc = null;
        try {
            String sql = "SELECT * FROM KhoaHoc WHERE ID_KhoaHoc = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID_KhoaHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return khoaHoc;
    }

    /**
     * Lấy danh sách khóa học theo tên.
     * @param name Tên khóa học
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getKhoaHocByName(String name) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM KhoaHoc WHERE TenKhoaHoc LIKE ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + name + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                list.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Xóa một khóa học.
     * @param khoaHoc Đối tượng KhoaHoc
     * @return Đối tượng KhoaHoc đã xóa hoặc null nếu thất bại
     */
    public static KhoaHoc deleteKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = "DELETE FROM KhoaHoc WHERE ID_KhoaHoc = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, khoaHoc.getID_KhoaHoc());
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return rs > 0 ? khoaHoc : null;
    }

    /**
     * Thêm một khóa học mới.
     * @param khoaHoc Đối tượng KhoaHoc
     * @return Đối tượng KhoaHoc đã thêm hoặc null nếu thất bại
     */
    public static KhoaHoc addKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                INSERT INTO KhoaHoc (CourseCode, TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, GhiChu, TrangThai, NgayTao, ID_Khoi, Image, [Order])
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, khoaHoc.getCourseCode());
            statement.setString(2, khoaHoc.getTenKhoaHoc());
            statement.setString(3, khoaHoc.getMoTa());
            statement.setDate(4, khoaHoc.getThoiGianBatDau() != null ? java.sql.Date.valueOf(khoaHoc.getThoiGianBatDau()) : null);
            statement.setDate(5, khoaHoc.getThoiGianKetThuc() != null ? java.sql.Date.valueOf(khoaHoc.getThoiGianKetThuc()) : null);
            statement.setString(6, khoaHoc.getGhiChu());
            statement.setString(7, khoaHoc.getTrangThai());
            statement.setTimestamp(8, khoaHoc.getNgayTao() != null ? java.sql.Timestamp.valueOf(khoaHoc.getNgayTao()) : null);
            statement.setInt(9, khoaHoc.getID_Khoi());
            statement.setString(10, khoaHoc.getImage());
            statement.setInt(11, khoaHoc.getOrder());
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return rs > 0 ? khoaHoc : null;
    }

    /**
     * Đếm tổng số khóa học.
     * @return Tổng số khóa học
     */
    public static int getTotalCourses() {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
        return total;
    }

    /**
     * Lấy danh sách khóa học với phân trang.
     * @param offset Vị trí bắt đầu
     * @param limit Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getKhoaHoc(int offset, int limit) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        try {
            String sql = """
                SELECT * FROM KhoaHoc
                ORDER BY ID_KhoaHoc
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, limit);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return khoaHocList;
    }

    /**
     * Cập nhật thông tin khóa học.
     * @param khoaHoc Đối tượng KhoaHoc
     * @return Đối tượng KhoaHoc đã cập nhật hoặc null nếu thất bại
     */
    public static KhoaHoc updateKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                UPDATE KhoaHoc
                SET CourseCode = ?, TenKhoaHoc = ?, MoTa = ?, ThoiGianBatDau = ?, ThoiGianKetThuc = ?, GhiChu = ?, TrangThai = ?, NgayTao = ?, ID_Khoi = ?, Image = ?, [Order] = ?
                WHERE ID_KhoaHoc = ?
            """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, khoaHoc.getCourseCode());
            statement.setString(2, khoaHoc.getTenKhoaHoc());
            statement.setString(3, khoaHoc.getMoTa());
            statement.setDate(4, khoaHoc.getThoiGianBatDau() != null ? java.sql.Date.valueOf(khoaHoc.getThoiGianBatDau()) : null);
            statement.setDate(5, khoaHoc.getThoiGianKetThuc() != null ? java.sql.Date.valueOf(khoaHoc.getThoiGianKetThuc()) : null);
            statement.setString(6, khoaHoc.getGhiChu());
            statement.setString(7, khoaHoc.getTrangThai());
            statement.setTimestamp(8, khoaHoc.getNgayTao() != null ? java.sql.Timestamp.valueOf(khoaHoc.getNgayTao()) : null);
            statement.setInt(9, khoaHoc.getID_Khoi());
            statement.setString(10, khoaHoc.getImage());
            statement.setInt(11, khoaHoc.getOrder());
            statement.setInt(12, khoaHoc.getID_KhoaHoc());
            rs = statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return rs > 0 ? khoaHoc : null;
    }

    /**
     * Sắp xếp khóa học theo ID.
     * @param sortId Thứ tự sắp xếp (ASC/DESC)
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getSortedById(String sortId) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortId)) {
            order = "DESC";
        }
        try {
            String sql = "SELECT * FROM KhoaHoc ORDER BY ID_KhoaHoc " + order;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return khoaHocList;
    }

    /**
     * Sắp xếp khóa học theo tên.
     * @param sortName Thứ tự sắp xếp (ASC/DESC)
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getSortedByName(String sortName) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortName)) {
            order = "DESC";
        }
        try {
            String sql = "SELECT * FROM KhoaHoc ORDER BY TenKhoaHoc " + order;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return khoaHocList;
    }

    /**
     * Sắp xếp khóa học theo trạng thái.
     * @param sortOrder Thứ tự sắp xếp (ASC/DESC)
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getSortedByTrangThai(String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortOrder)) {
            order = "DESC";
        }
        try {
            String sql = "SELECT * FROM KhoaHoc ORDER BY TrangThai " + order;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return khoaHocList;
    }

    /**
     * Lấy danh sách khóa học với phân trang và sắp xếp theo tên.
     * @param offset Vị trí bắt đầu
     * @param limit Số bản ghi mỗi trang
     * @param sortOrder Thứ tự sắp xếp (ASC/DESC)
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getSortedKhoaHoc(int offset, int limit, String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        if (!"ASC".equalsIgnoreCase(sortOrder) && !"DESC".equalsIgnoreCase(sortOrder)) {
            sortOrder = "ASC";
        }
        try {
            String sql = "SELECT * FROM KhoaHoc ORDER BY TenKhoaHoc " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, limit);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return khoaHocList;
    }

    /**
     * Kiểm tra trùng lặp tên khóa học.
     * @param tenKhoaHoc Tên khóa học
     * @return true nếu trùng, false nếu không
     */
    public static boolean isTenKhoaHocDuplicate(String tenKhoaHoc) {
        DBContext db = DBContext.getInstance();
        boolean isDuplicate = false;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE LOWER(TenKhoaHoc) = LOWER(?)";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setNString(1, tenKhoaHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                isDuplicate = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isDuplicate;
    }

    /**
     * Kiểm tra trùng lặp tên khóa học và ID khối.
     * @param tenKhoaHoc Tên khóa học
     * @param idKhoi ID khối học
     * @return true nếu trùng, false nếu không
     */
    public static boolean isDuplicateTenKhoaHocAndIDKhoi(String tenKhoaHoc, int idKhoi) {
        DBContext db = DBContext.getInstance();
        boolean isDuplicate = false;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE LOWER(TenKhoaHoc) = LOWER(?) AND ID_Khoi = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, tenKhoaHoc);
            statement.setInt(2, idKhoi);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                isDuplicate = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isDuplicate;
    }

    /**
     * Đếm tổng số khóa học theo trạng thái.
     * @param trangThai Trạng thái khóa học
     * @return Tổng số khóa học
     */
    public static int getTotalCoursesByTrangThai(String trangThai) {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE LOWER(LTRIM(RTRIM(TrangThai))) = LOWER(?)";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, trangThai.trim());
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tổng số khóa học theo trạng thái: " + e.getMessage());
        }
        return total;
    }

    /**
     * Lấy danh sách khóa học theo trạng thái với phân trang.
     * @param trangThai Trạng thái khóa học
     * @param offset Vị trí bắt đầu
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getSortedByTrangThai(String order, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        if (!"ASC".equalsIgnoreCase(order) && !"DESC".equalsIgnoreCase(order)) {
            order = "ASC";
        }
        try {
            String sql = "SELECT * FROM KhoaHoc ORDER BY TrangThai " + order + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, pageSize);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return khoaHocList;
    }

    /**
     * Đếm số khóa học theo trạng thái.
     * @param trangThai Trạng thái khóa học
     * @return Tổng số khóa học
     */
    public static int countCoursesByTrangThai(String trangThai) {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TrangThai = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, trangThai);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    /**
     * Lấy danh sách khóa học theo trạng thái với phân trang.
     * @param trangThai Trạng thái khóa học
     * @param offset Vị trí bắt đầu
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getCoursesByTrangThai(String trangThai, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM KhoaHoc WHERE TrangThai = ? ORDER BY ID_KhoaHoc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, trangThai);
            statement.setInt(2, offset);
            statement.setInt(3, pageSize);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return khoaHocList;
    }

    /**
     * Lấy danh sách khóa học theo tên với phân trang.
     * @param name Tên khóa học
     * @param offset Vị trí bắt đầu
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getKhoaHocByNamePaging(String name, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();
        String searchKey = removeAccent(name.trim().replaceAll("\\s+", " "));
        try {
            String sql = """
                SELECT * FROM KhoaHoc
                WHERE REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?
                ORDER BY TenKhoaHoc ASC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            """;
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, "%" + searchKey + "%");
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                KhoaHoc kh = new KhoaHoc();
                kh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                kh.setCourseCode(rs.getString("CourseCode"));
                kh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                kh.setMoTa(rs.getString("MoTa"));
                kh.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                kh.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                kh.setGhiChu(rs.getString("GhiChu"));
                kh.setTrangThai(rs.getString("TrangThai"));
                kh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                kh.setID_Khoi(rs.getInt("ID_Khoi"));
                kh.setImage(rs.getString("Image"));
                kh.setOrder(rs.getInt("Order"));
                list.add(kh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm tổng số khóa học theo tên.
     * @param name Tên khóa học
     * @return Tổng số khóa học
     */
    public static int getTotalCoursesByName(String name) {
        DBContext db = DBContext.getInstance();
        int total = 0;
        String searchKey = removeAccent(name.trim().replaceAll("\\s+", " "));
        try {
            String sql = """
                SELECT COUNT(*) FROM KhoaHoc
                WHERE REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?
            """;
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, "%" + searchKey + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    /**
     * Lấy danh sách khóa học theo các bộ lọc và phân trang.
     * @param searchName Tên khóa học để tìm kiếm
     * @param trangThai Trạng thái khóa học
     * @param idKhoi ID khối học
     * @param order Thứ tự ưu tiên
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @param offset Vị trí bắt đầu
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public List<KhoaHoc> getCoursesByFilters(String searchName, String trangThai, Integer idKhoi, Integer order, LocalDate startDate, LocalDate endDate, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT * FROM KhoaHoc WHERE 1=1");
            List<Object> params = new ArrayList<>();
            if (searchName != null && !searchName.trim().isEmpty()) {
                sql.append(" AND REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?");
                params.add("%" + removeAccent(searchName.trim().replaceAll("\\s+", " ")) + "%");
            }
            if (trangThai != null && !trangThai.trim().isEmpty()) {
                sql.append(" AND TrangThai = ?");
                params.add(trangThai);
            }
            if (idKhoi != null) {
                sql.append(" AND ID_Khoi = ?");
                params.add(idKhoi);
            }
            if (order != null) {
                sql.append(" AND [Order] = ?");
                params.add(order);
            }
            if (startDate != null) {
                sql.append(" AND ThoiGianBatDau >= ?");
                params.add(startDate);
            }
            if (endDate != null) {
                sql.append(" AND ThoiGianKetThuc <= ?");
                params.add(endDate);
            }
            sql.append(" ORDER BY ID_KhoaHoc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            PreparedStatement statement = db.getConnection().prepareStatement(sql.toString());
            int paramIndex = 1;
            for (Object param : params) {
                statement.setObject(paramIndex++, param);
            }
            statement.setInt(paramIndex++, offset);
            statement.setInt(paramIndex, pageSize);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return khoaHocList;
    }

    /**
     * Đếm tổng số khóa học theo các bộ lọc.
     * @param searchName Tên khóa học để tìm kiếm
     * @param trangThai Trạng thái khóa học
     * @param idKhoi ID khối học
     * @param order Thứ tự ưu tiên
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @return Tổng số khóa học
     */
    public int getTotalCoursesByFilters(String searchName, String trangThai, Integer idKhoi, Integer order, LocalDate startDate, LocalDate endDate) {
        DBContext db = DBContext.getInstance();
        try {
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM KhoaHoc WHERE 1=1");
            List<Object> params = new ArrayList<>();
            if (searchName != null && !searchName.trim().isEmpty()) {
                sql.append(" AND REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?");
                params.add("%" + removeAccent(searchName.trim().replaceAll("\\s+", " ")) + "%");
            }
            if (trangThai != null && !trangThai.trim().isEmpty()) {
                sql.append(" AND TrangThai = ?");
                params.add(trangThai);
            }
            if (idKhoi != null) {
                sql.append(" AND ID_Khoi = ?");
                params.add(idKhoi);
            }
            if (order != null) {
                sql.append(" AND [Order] = ?");
                params.add(order);
            }
            if (startDate != null) {
                sql.append(" AND ThoiGianBatDau >= ?");
                params.add(startDate);
            }
            if (endDate != null) {
                sql.append(" AND ThoiGianKetThuc <= ?");
                params.add(endDate);
            }
            PreparedStatement stmt = db.getConnection().prepareStatement(sql.toString());
            int paramIndex = 1;
            for (Object param : params) {
                stmt.setObject(paramIndex++, param);
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách khóa học với sắp xếp, tìm kiếm và lọc, hỗ trợ phân trang.
     * @param sortColumn Cột để sắp xếp
     * @param sortOrder Thứ tự sắp xếp (asc/desc)
     * @param searchName Tên khóa học để tìm kiếm
     * @param trangThai Trạng thái khóa học
     * @param idKhoi ID khối học
     * @param order Thứ tự ưu tiên
     * @param startDate Ngày bắt đầu
     * @param endDate Ngày kết thúc
     * @param page Số trang
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public List<KhoaHoc> getCoursesSortedPaged(String sortColumn, String sortOrder, String searchName, String trangThai, Integer idKhoi, Integer order, LocalDate startDate, LocalDate endDate, int page, int pageSize) {
        List<String> allowedColumns = Arrays.asList(
                "ID_KhoaHoc", "TenKhoaHoc", "MoTa", "ThoiGianBatDau", 
                "ThoiGianKetThuc", "GhiChu", "TrangThai", "NgayTao", "ID_Khoi",
                "CourseCode", "Image", "Order"
        );
        if (!allowedColumns.contains(sortColumn)) {
            sortColumn = "ID_KhoaHoc";
        }
        if (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc")) {
            sortOrder = "asc";
        }
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM KhoaHoc WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?");
            params.add("%" + removeAccent(searchName.trim().replaceAll("\\s+", " ")) + "%");
        }
        if (trangThai != null && !trangThai.trim().isEmpty()) {
            sql.append(" AND TrangThai = ?");
            params.add(trangThai);
        }
        if (idKhoi != null) {
            sql.append(" AND ID_Khoi = ?");
            params.add(idKhoi);
        }
        if (order != null) {
            sql.append(" AND [Order] = ?");
            params.add(order);
        }
        if (startDate != null) {
            sql.append(" AND ThoiGianBatDau >= ?");
            params.add(startDate);
        }
        if (endDate != null) {
            sql.append(" AND ThoiGianKetThuc <= ?");
            params.add(endDate);
        }
        sql.append(" ORDER BY ").append(sortColumn).append(" ").append(sortOrder);
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql.toString())) {
            int paramIndex = 1;
            for (Object param : params) {
                statement.setObject(paramIndex++, param);
            }
            statement.setInt(paramIndex++, (page - 1) * pageSize);
            statement.setInt(paramIndex, pageSize);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                list.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return list;
    }

    /**
     * Lấy danh sách khóa học theo tên với phân trang.
     * @param tenKhoaHoc Tên khóa học
     * @param offset Vị trí bắt đầu
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getCoursesByTen(String tenKhoaHoc, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();
        try {
            String sql = """
                SELECT * FROM KhoaHoc WHERE TenKhoaHoc LIKE ?
                ORDER BY ID_KhoaHoc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            """;
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, "%" + tenKhoaHoc + "%");
            stmt.setInt(2, offset);
            stmt.setInt(3, pageSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                list.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
        return list;
    }

    /**
     * Lấy danh sách khóa học theo tên với phân trang và sắp xếp.
     * @param ten Tên khóa học
     * @param offset Vị trí bắt đầu
     * @param pageSize Số bản ghi mỗi trang
     * @param sortOrder Thứ tự sắp xếp (ASC/DESC)
     * @return Danh sách khóa học
     */
    public static List<KhoaHoc> getCoursesByTenSorted(String ten, int offset, int pageSize, String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        String order = "ASC".equalsIgnoreCase(sortOrder) ? "ASC" : "DESC";
        try {
            String sql = """
                SELECT * FROM KhoaHoc WHERE TenKhoaHoc LIKE ?
                ORDER BY TenKhoaHoc """ + order + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + ten + "%");
            statement.setInt(2, offset);
            statement.setInt(3, pageSize);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setCourseCode(rs.getString("CourseCode"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHoc.setImage(rs.getString("Image"));
                khoaHoc.setOrder(rs.getInt("Order"));
                khoaHocList.add(khoaHoc);
            }
            rs.close();
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return khoaHocList;
    }

    /**
     * Lấy danh sách khóa học theo tên và ID khối với phân trang.
     * @param keyword Tên khóa học
     * @param idKhoi ID khối học
     * @param page Số trang
     * @param pageSize Số bản ghi mỗi trang
     * @return Danh sách khóa học
     */
    public List<KhoaHoc> getKhoaHocFiltered(String keyword, String idKhoi, int page, int pageSize) {
        List<KhoaHoc> list = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("SELECT * FROM KhoaHoc WHERE 1=1");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND TenKhoaHoc LIKE ?");
        }
        if (idKhoi != null && !idKhoi.trim().isEmpty()) {
            sql.append(" AND ID_Khoi = ?");
        }
        sql.append(" ORDER BY ID_KhoaHoc DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(idx++, "%" + keyword + "%");
            }
            if (idKhoi != null && !idKhoi.trim().isEmpty()) {
                ps.setInt(idx++, Integer.parseInt(idKhoi));
            }
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                KhoaHoc kh = new KhoaHoc();
                kh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                kh.setCourseCode(rs.getString("CourseCode"));
                kh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                kh.setMoTa(rs.getString("MoTa"));
                kh.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                kh.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                kh.setGhiChu(rs.getString("GhiChu"));
                kh.setTrangThai(rs.getString("TrangThai"));
                kh.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                kh.setID_Khoi(rs.getInt("ID_Khoi"));
                kh.setImage(rs.getString("Image"));
                kh.setOrder(rs.getInt("Order"));
                list.add(kh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm số khóa học theo tên và ID khối.
     * @param keyword Tên khóa học
     * @param idKhoi ID khối học
     * @return Tổng số khóa học
     */
    public int countKhoaHocFiltered(String keyword, String idKhoi) {
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM KhoaHoc WHERE 1=1");
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND TenKhoaHoc LIKE ?");
        }
        if (idKhoi != null && !idKhoi.trim().isEmpty()) {
            sql.append(" AND ID_Khoi = ?");
        }
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(idx++, "%" + keyword + "%");
            }
            if (idKhoi != null && !idKhoi.trim().isEmpty()) {
                ps.setInt(idx++, Integer.parseInt(idKhoi));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Đếm số khóa học theo tên.
     * @param searchName Tên khóa học
     * @return Tổng số khóa học
     */
    public int countCourses(String searchName) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM KhoaHoc";
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += " WHERE TenKhoaHoc LIKE ?";
        }
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            if (searchName != null && !searchName.trim().isEmpty()) {
                statement.setString(1, "%" + searchName + "%");
            }
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Đếm số khóa học theo tên và trạng thái.
     * @param searchName Tên khóa học
     * @param statusFilter Trạng thái khóa học
     * @return Tổng số khóa học
     */
    public int countCourses(String searchName, String statusFilter) {
        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM KhoaHoc WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND TenKhoaHoc LIKE ?");
            params.add("%" + searchName + "%");
        }
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND TrangThai = ?");
            params.add(statusFilter);
        }
        try (PreparedStatement statement = db.getConnection().prepareStatement(sql.toString())) {
            int paramIndex = 1;
            for (Object param : params) {
                statement.setObject(paramIndex++, param);
            }
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Kiểm tra trùng lặp mã khóa học.
     * @param courseCode Mã khóa học
     * @return true nếu trùng, false nếu không
     */
    public static boolean isDuplicateCourseCode(String courseCode) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE CourseCode = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, courseCode);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đếm số khóa học theo môn Văn.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocVan() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%van%'";
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

    /**
     * Đếm số khóa học theo môn Anh.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocAnh() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%anh%'";
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

    /**
     * Đếm số khóa học theo môn Sử.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocSu() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%su%'";
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

    /**
     * Đếm số khóa học theo môn Toán.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocToan() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%toan%'";
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

    /**
     * Đếm số khóa học theo môn Địa.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocDia() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%dia%'";
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

    /**
     * Đếm số khóa học theo môn Lý.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocLy() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%ly%'";
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

    /**
     * Đếm số khóa học theo môn Hóa.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocHoa() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%hoa%'";
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

    /**
     * Đếm số khóa học theo môn Sinh.
     * @return Tổng số khóa học
     */
    public static int getKhoaHocSinh() {
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc COLLATE Latin1_General_CI_AI LIKE '%sinh%'";
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

    /**
     * Đếm tổng số khóa học theo tên.
     * @param tenKhoaHoc Tên khóa học
     * @return Tổng số khóa học
     */
    public static int getTotalCoursesByTen(String tenKhoaHoc) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc WHERE TenKhoaHoc LIKE ?";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, "%" + tenKhoaHoc + "%");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Main method for testing.
     */
    public static void main(String[] args) {
        int a = KhoaHocDAO.getKhoaHocVan();
        System.out.println(a);
    }
}
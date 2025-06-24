/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.sun.jdi.connect.spi.Connection;
import dal.DBContext;
import java.util.ArrayList;
import model.KhoaHoc;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Normalizer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;
import model.KhoiHoc;

/**
 *
 * @author Vuh26
 */
public class KhoaHocDAO {
    public static ArrayList<KhoaHoc> adminGetAllKhoaHoc(){
        ArrayList<KhoaHoc> khoahocs = new ArrayList<KhoaHoc>() ; 
        DBContext db = DBContext.getInstance() ; 
        try {
            String sql = """
                         select * from KhoaHoc 
                         """ ; 
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ; 
            while(rs.next()){
                KhoaHoc khoahoc = new KhoaHoc(
                        rs.getInt("ID_KhoaHoc") , 
                        rs.getString("TenKhoaHoc") , 
                        rs.getString("MoTa") , 
                        rs.getDate("ThoiGianBatDau").toLocalDate() , 
                        rs.getDate("ThoiGianKetThuc").toLocalDate() ,  
                        rs.getString("GhiChu") , 
                        rs.getString("TrangThai") , 
                        rs.getTimestamp("NgayTao").toLocalDateTime()
                
                
                ) ; 
                khoahocs.add(khoahoc) ; 
            }
        } catch (SQLException e){
            e.printStackTrace();
            return null ; 
        }
        
        if (khoahocs.isEmpty()){
            return null ; 
        } else {
            return khoahocs ; 
        }
    }
    
  public static ArrayList<KhoaHoc> getKhoaHoc() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                        SELECT * FROM KhoaHoc
                     """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();

                khoaHoc.setID_KhoaHoc(rs.getInt(1));                        // ID_KhoaHoc
                khoaHoc.setTenKhoaHoc(rs.getString(2));                     // TenKhoaHoc
                khoaHoc.setMoTa(rs.getString(3));                           // MoTa
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());     // ThoiGianBatDau
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());    // ThoiGianKetThuc
                khoaHoc.setGhiChu(rs.getString(6));                         // GhiChu
                khoaHoc.setTrangThai(rs.getString(7));                      // TrangThai
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());  // NgayTao
                khoaHoc.setID_Khoi(rs.getInt(9));                           // ID_Khoi
                khoaHoc.setImage(rs.getString(10));// Image
                courses.add(khoaHoc);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log ra console để debug
            return null;
        }

        return courses;
    }
    
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
            kh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
            kh.setMoTa(rs.getString("MoTa"));
            kh.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
            kh.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
            kh.setGhiChu(rs.getString("GhiChu"));
            kh.setTrangThai(rs.getString("TrangThai"));
            kh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
            kh.setID_Khoi(rs.getInt("ID_Khoi"));
            kh.setImage(rs.getString("Image"));
            list.add(kh);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
  
     public static KhoaHoc getKhoaHocById(int ID_KhoaHoc) {
        DBContext db = DBContext.getInstance();
        KhoaHoc khoaHoc = null;
        try {
            String sql = """
            SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau,
                   ThoiGianKetThuc, GhiChu, TrangThai, NgayTao, ID_Khoi
            FROM KhoaHoc WHERE ID_KhoaHoc = ?
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID_KhoaHoc);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi")); // Bổ sung dòng này
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return khoaHoc;
    }

    public static List<KhoaHoc> getKhoaHocByName(String name) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();
        try {
            String sql = """
            SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau,
                   ThoiGianKetThuc, GhiChu, TrangThai, NgayTao, ID_Khoi
            FROM KhoaHoc
            WHERE TenKhoaHoc LIKE ?
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + name + "%"); // tìm gần đúng

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi")); // thêm dòng này
                list.add(khoaHoc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

     public static KhoaHoc deleteKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance(); // (1)
        int rs = 0;
        try {
            String sql = """
            delete from KhoaHoc
            where ID_KhoaHoc = ?
            """; // (2)
            PreparedStatement statment = db.getConnection().prepareStatement(sql); // (3)
            statment.setInt(1, khoaHoc.getID_KhoaHoc()); // (4)
            rs = statment.executeUpdate(); // (5)
        } catch (Exception e) {
            return null;
        }
        if (rs == 0) {
            return null;
        } else {
            return khoaHoc;
        }
    }

   public static KhoaHoc addKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;

        try {
            String sql = """
            INSERT INTO KhoaHoc (TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, GhiChu, TrangThai, ID_Khoi)
            VALUES (?, ?, ?,  ?, ?, ?,?)
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            statement.setString(1, khoaHoc.getTenKhoaHoc());
            statement.setString(2, khoaHoc.getMoTa());
            statement.setDate(3, java.sql.Date.valueOf(khoaHoc.getThoiGianBatDau()));
            statement.setDate(4, java.sql.Date.valueOf(khoaHoc.getThoiGianKetThuc()));
            statement.setString(5, khoaHoc.getGhiChu());
            statement.setString(6, khoaHoc.getTrangThai());
            statement.setInt(7, khoaHoc.getID_Khoi());

            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // bạn nên log lỗi ra để debug
            return null;
        }

        return rs > 0 ? khoaHoc : null;
    }
    
    public static int getTotalCourses() {
        DBContext db = DBContext.getInstance();
        int total = 0;
        try {
            String sql = """
            SELECT COUNT(*) FROM KhoaHoc
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

    public static List<KhoaHoc> getKhoaHoc(int offset, int limit) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        try {
            String sql = """
            SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau,
                   ThoiGianKetThuc, GhiChu, TrangThai, NgayTao, ID_Khoi
            FROM KhoaHoc
            ORDER BY ID_KhoaHoc
            OFFSET ? ROWS
            FETCH NEXT ? ROWS ONLY
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, limit);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Ghi log để debug
            return Collections.emptyList(); // tránh null pointer
        }

        return khoaHocList;
    }

    public static KhoaHoc updateKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
            UPDATE KhoaHoc
            SET TenKhoaHoc = ?, MoTa = ?, ThoiGianBatDau = ?, ThoiGianKetThuc = ?,GhiChu = ?, TrangThai = ?, ID_Khoi = ?
            WHERE ID_KhoaHoc = ?
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, khoaHoc.getTenKhoaHoc());
            statement.setString(2, khoaHoc.getMoTa());
            statement.setDate(3, java.sql.Date.valueOf(khoaHoc.getThoiGianBatDau()));
            statement.setDate(4, java.sql.Date.valueOf(khoaHoc.getThoiGianKetThuc()));
            statement.setString(5, khoaHoc.getGhiChu());
            statement.setString(6, khoaHoc.getTrangThai());
            statement.setInt(7, khoaHoc.getID_Khoi());
            statement.setInt(8, khoaHoc.getID_KhoaHoc());

            rs = statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return rs > 0 ? khoaHoc : null;
    }

    public static List<KhoaHoc> getSortedById(String sortId) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        // Chỉ chấp nhận ASC hoặc DESC, mặc định ASC
        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortId)) {
            order = "DESC";
        }

        String sql = "SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, "
                + "GhiChu, TrangThai, NgayTao, ID_Khoi FROM KhoaHoc ORDER BY ID_KhoaHoc " + order;

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }

                return khoaHocList;
    }

    public static List<KhoaHoc> getSortedByName(String sortName) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        // Xác định thứ tự sắp xếp (ASC hoặc DESC)
        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortName)) {
            order = "DESC";
        }

        String sql = "SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, "
                + "GhiChu, TrangThai, NgayTao, ID_Khoi FROM KhoaHoc ORDER BY TenKhoaHoc " + order;

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }

                return khoaHocList;
    }

    public static List<KhoaHoc> getSortedByTrangThai(String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortOrder)) {
            order = "DESC";
        }

        String sql = "SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, "
                + "GhiChu, TrangThai, NgayTao, ID_Khoi FROM KhoaHoc ORDER BY TrangThai " + order;

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql); ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

        } catch (Exception e) {
            e.printStackTrace();
                        return Collections.emptyList();
        }

        return khoaHocList;
    }

    public static List<KhoaHoc> getSortedKhoaHoc(int offset, int limit, String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        // Bảo vệ chống SQL Injection - chỉ cho phép ASC hoặc DESC
        if (!"ASC".equalsIgnoreCase(sortOrder) && !"DESC".equalsIgnoreCase(sortOrder)) {
            sortOrder = "ASC"; // mặc định
        }

        String sql = "SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, "
                + "GhiChu, TrangThai, NgayTao, ID_Khoi "
                + "FROM KhoaHoc ORDER BY TenKhoaHoc " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            statement.setInt(1, offset);
            statement.setInt(2, limit);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    KhoaHoc khoaHoc = new KhoaHoc();
                    khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                    khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                    khoaHoc.setMoTa(rs.getString("MoTa"));
                    khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                    khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                    khoaHoc.setGhiChu(rs.getString("GhiChu"));
                    khoaHoc.setTrangThai(rs.getString("TrangThai"));
                    khoaHoc.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                    khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                    khoaHocList.add(khoaHoc);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }

                    return khoaHocList;
    }

    public static boolean isTenKhoaHocDuplicate(String tenKhoaHoc) {
        DBContext db = DBContext.getInstance();
        boolean isDuplicate = false;

        try {
            String sql = """
            SELECT COUNT(*)
            FROM KhoaHoc
            WHERE LOWER(TenKhoaHoc) = LOWER(?)
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setNString(1, tenKhoaHoc);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                isDuplicate = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDuplicate;
    }

     public static boolean isDuplicateTenKhoaHocAndIDKhoi(String tenKhoaHoc, int idKhoi) {
        DBContext db = DBContext.getInstance();
        boolean isDuplicate = false;

        try {
            String sql = """
        SELECT COUNT(*)
        FROM KhoaHoc
        WHERE LOWER(TenKhoaHoc) = LOWER(?)
        AND ID_Khoi = ?
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, tenKhoaHoc);
            statement.setInt(2, idKhoi);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                isDuplicate = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDuplicate;
    }

    public static int getTotalCoursesByTrangThai(String trangThai) {
        int total = 0;
        DBContext db = DBContext.getInstance();
        String sql = "SELECT COUNT(*) FROM SWP.dbo.KhoaHoc WHERE LOWER(LTRIM(RTRIM(TrangThai))) = LOWER(?)";

        try (PreparedStatement stmt = db.getConnection().prepareStatement(sql)) {
            stmt.setString(1, trangThai.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tổng số khóa học theo trạng thái: " + e.getMessage());
        }

        return total;
    }

    public static List<KhoaHoc> getSortedByTrangThai(String order, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        try {
            // Bảo vệ chống SQL Injection - chỉ cho phép ASC hoặc DESC
            if (!"ASC".equalsIgnoreCase(order) && !"DESC".equalsIgnoreCase(order)) {
                order = "ASC"; // mặc định
            }

            String sql = "SELECT * FROM KhoaHoc ORDER BY TrangThai " + order + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, pageSize);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                khoaHocList.add(khoaHoc);
            }
            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null; // hoặc Collections.emptyList()
        }
                    return khoaHocList;
    }

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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

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
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
                    return khoaHocList;
    }

    public static List<KhoaHoc> getKhoaHocByNamePaging(String name, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();

        // Bỏ dấu và chuẩn hóa khoảng trắng trong chuỗi tìm kiếm
        String searchKey = removeAccent(name.trim().replaceAll("\\s+", " "));

        try {
            String sql = "SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau, "
                    + "ThoiGianKetThuc, GhiChu, TrangThai, NgayTao, ID_Khoi "
                    + "FROM KhoaHoc "
                    + "WHERE REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ? "
                    + "ORDER BY TenKhoaHoc ASC "
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, "%" + searchKey + "%");
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                KhoaHoc kh = new KhoaHoc();
                kh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                kh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                kh.setMoTa(rs.getString("MoTa"));
                kh.setThoiGianBatDau(rs.getDate("ThoiGianBatDau").toLocalDate());
                kh.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc").toLocalDate());
                kh.setGhiChu(rs.getString("GhiChu"));
                kh.setTrangThai(rs.getString("TrangThai"));
                kh.setNgayTao(rs.getTimestamp("NgayTao").toLocalDateTime());
                kh.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(kh);
            }
        } catch (Exception e) {
                        e.printStackTrace();
        }
        return list;
    }

    public static int getTotalCoursesByName(String name) {
        DBContext db = DBContext.getInstance();
        int total = 0;

        // Chuẩn hóa chuỗi tìm kiếm: xóa khoảng trắng dư và bỏ dấu
        String searchKey = removeAccent(name.trim().replaceAll("\\s+", " "));

        try {
            String sql = "SELECT COUNT(*) FROM KhoaHoc "
                    + "WHERE REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?";

            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(1, "%" + searchKey + "%");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public static List<KhoaHoc> getCoursesByTrangThaiVaTen(String trangThai, String tenKhoaHoc, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        try {
            // Chuẩn hóa tên khóa học: loại bỏ dấu và khoảng trắng thừa
            String normalizedTen = removeAccent(tenKhoaHoc.trim().replaceAll("\\s+", " "));

            String sql = "SELECT * FROM KhoaHoc "
                    + "WHERE TrangThai = ? "
                    + "AND REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ? "
                    + "ORDER BY ID_KhoaHoc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, trangThai);
            statement.setString(2, "%" + normalizedTen + "%"); // tìm tên đã chuẩn hóa
            statement.setInt(3, offset);
            statement.setInt(4, pageSize);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return khoaHocList;
    }

    public static String removeAccent(String s) {
        if (s == null) {
            return "";
        }
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("").replaceAll("đ", "d").replaceAll("Đ", "D");
    }

   public static int getTotalCoursesByTrangThaiVaTen(String trangThai, String tenKhoaHoc) {
    DBContext db = DBContext.getInstance();
    try {
        // Chuẩn hóa tên tìm kiếm: loại bỏ dấu, bỏ khoảng trắng thừa
        String normalizedTen = removeAccent(tenKhoaHoc.trim().replaceAll("\\s+", " "));

            String sql = "SELECT COUNT(*) FROM KhoaHoc " +
                     "WHERE TrangThai = ? " +
                     "AND REPLACE(TenKhoaHoc, 'đ', 'd') COLLATE Latin1_General_CI_AI LIKE ?";

        PreparedStatement stmt = db.getConnection().prepareStatement(sql);
        stmt.setString(1, trangThai);
        stmt.setString(2, "%" + normalizedTen + "%");
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static List<KhoaHoc> getCoursesByTen(String tenKhoaHoc, int offset, int pageSize) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM KhoaHoc WHERE TenKhoaHoc LIKE ? ORDER BY ID_KhoaHoc OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement stmt = db.getConnection().prepareStatement(sql);
            stmt.setString(1, "%" + tenKhoaHoc + "%");
            stmt.setInt(2, offset);
            stmt.setInt(3, pageSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                // map dữ liệu
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<KhoaHoc> getCoursesByTenSorted(String ten, int offset, int pageSize, String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM KhoaHoc WHERE TenKhoaHoc LIKE ? ORDER BY TenKhoaHoc "
                    + ("DESC".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC")
                    + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + ten + "%");
            statement.setInt(2, offset);
            statement.setInt(3, pageSize);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                     khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));

                khoaHocList.add(khoaHoc);
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return khoaHocList;
    }

    public static boolean isTenKhoaHocAndIDKhoiDuplicate(String tenKhoaHoc, int idKhoi) {
        DBContext db = DBContext.getInstance();
        boolean isDuplicate = false;

        try {
            String sql = "SELECT * FROM KhoaHoc WHERE TenKhoaHoc = ? AND ID_Khoi = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, tenKhoaHoc);
            statement.setInt(2, idKhoi);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) { // Nếu có ít nhất 1 bản ghi
                isDuplicate = true;
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

            return isDuplicate;
    }
    
    public static int getKhoaHocVan() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%van%'
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
    public static int getKhoaHocAnh() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%anh%'
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
    public static int getKhoaHocSu() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%su%'
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
    public static int getKhoaHocToan() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%toan%'
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
    public static int getKhoaHocDia() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%dia%'
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
    public static int getKhoaHocLy() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%ly%'
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
    public static int getKhoaHocHoa() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%hoa%'
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
    public static int getKhoaHocSinh() {
        ArrayList<KhoaHoc> courses = new ArrayList<>();
        DBContext db = DBContext.getInstance();
        int tong = 0;
        try {
            String sql = """
                        SELECT COUNT(*) FROM KhoaHoc
                        WHERE TenKhoaHoc Collate Latin1_General_CI_AI LIKE '%sinh%'
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
    
    public List<KhoaHoc> getKhoaHocFiltered(String keyword, String idKhoi, int page, int pageSize) {
    List<KhoaHoc> list = new ArrayList<>();
    DBContext db = DBContext.getInstance();

    // Start SQL query with base condition
    StringBuilder sql = new StringBuilder("SELECT * FROM KhoaHoc WHERE 1=1");

    // Apply search keyword filter if provided
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND TenKhoaHoc LIKE ?");
    }

    // Apply grade (Khoi) filter if provided
    if (idKhoi != null && !idKhoi.trim().isEmpty()) {
        sql.append(" AND ID_Khoi = ?");
    }

    // Add pagination using OFFSET-FETCH
    sql.append(" ORDER BY ID_KhoaHoc DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        int idx = 1;

        // Set parameters for keyword and ID_Khoi if they exist
        if (keyword != null && !keyword.trim().isEmpty()) {
            ps.setString(idx++, "%" + keyword + "%");
        }
        if (idKhoi != null && !idKhoi.trim().isEmpty()) {
            ps.setInt(idx++, Integer.parseInt(idKhoi));
        }

        // Set OFFSET and LIMIT for pagination
        ps.setInt(idx++, (page - 1) * pageSize);
        ps.setInt(idx, pageSize);

        // Execute query and map results to KhoaHoc objects
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            KhoaHoc kh = new KhoaHoc();
            kh.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
            kh.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
            kh.setMoTa(rs.getString("MoTa"));
            kh.setImage(rs.getString("Image"));
            kh.setID_Khoi(rs.getInt("ID_Khoi"));
            list.add(kh);
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log exception for debugging
    }

    return list;
}
    
    public int countKhoaHocFiltered(String keyword, String idKhoi) {
    DBContext db = DBContext.getInstance();

    // Start SQL query
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM KhoaHoc WHERE 1=1");

    // Add conditions for keyword and grade filter
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND TenKhoaHoc LIKE ?");
    }
    if (idKhoi != null && !idKhoi.trim().isEmpty()) {
        sql.append(" AND ID_Khoi = ?");
    }

    try (PreparedStatement ps = db.getConnection().prepareStatement(sql.toString())) {
        int idx = 1;

        // Set parameters for keyword and ID_Khoi if applicable
        if (keyword != null && !keyword.trim().isEmpty()) {
            ps.setString(idx++, "%" + keyword + "%");
        }
        if (idKhoi != null && !idKhoi.trim().isEmpty()) {
            ps.setInt(idx++, Integer.parseInt(idKhoi));
        }

        // Execute query and return count
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (Exception e) {
        e.printStackTrace(); // Log exception
    }

    return 0; // Return 0 if exception occurs or no match
}

    
    public List<KhoaHoc> getCoursesSortedPaged(String sortColumn, String sortOrder, String searchName, int page, int pageSize) {
        List<KhoaHoc> list = new ArrayList<>();
        List<String> allowedColumns = new ArrayList<>();
        allowedColumns.add("ID_KhoaHoc");
        allowedColumns.add("TenKhoaHoc");
        allowedColumns.add("MoTa");
        allowedColumns.add("ThoiGianBatDau");
        allowedColumns.add("ThoiGianKetThuc");
        allowedColumns.add("GhiChu");
        allowedColumns.add("TrangThai");
        allowedColumns.add("NgayTao");
        allowedColumns.add("ID_Khoi");

        if (!allowedColumns.contains(sortColumn)) {
            sortColumn = "ID_KhoaHoc";
        }
        if (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc")) {
            sortOrder = "asc";
        }

        int offset = (page - 1) * pageSize;
        DBContext db = DBContext.getInstance();

        String sql = "SELECT * FROM KhoaHoc ";
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql += "WHERE TenKhoaHoc LIKE ? ";
        }
        sql += "ORDER BY " + sortColumn + " " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement statement = db.getConnection().prepareStatement(sql)) {
            int paramIndex = 1;
            if (searchName != null && !searchName.trim().isEmpty()) {
                statement.setString(paramIndex++, "%" + searchName + "%");
            }
            // Đặt offset trước, pageSize sau
            statement.setInt(paramIndex++, offset);
            statement.setInt(paramIndex, pageSize);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt("ID_KhoaHoc"));
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(khoaHoc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public static void main(String[] args) {
        int a = KhoaHocDAO.getKhoaHocVan();
        System.out.println(a);
    }
    
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
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
     
     public List<KhoaHoc> getCoursesSortedPaged(String sortColumn, String sortOrder, String searchName, String statusFilter, int page, int pageSize) {
        List<KhoaHoc> list = new ArrayList<>();
        List<String> allowedColumns = Arrays.asList(
            "ID_KhoaHoc", "TenKhoaHoc", "MoTa", "ThoiGianBatDau", 
            "ThoiGianKetThuc", "GhiChu", "TrangThai", "NgayTao", "ID_Khoi"
        );

        // Validate sortColumn để chống SQL injection
        if (!allowedColumns.contains(sortColumn)) {
            sortColumn = "ID_KhoaHoc";
        }
        // Validate sortOrder
        if (!sortOrder.equalsIgnoreCase("asc") && !sortOrder.equalsIgnoreCase("desc")) {
            sortOrder = "asc";
        }

        DBContext db = DBContext.getInstance();
        StringBuilder sql = new StringBuilder("SELECT * FROM KhoaHoc WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện tìm kiếm theo tên
        if (searchName != null && !searchName.trim().isEmpty()) {
            sql.append(" AND TenKhoaHoc LIKE ?");
            params.add("%" + searchName + "%");
        }

        // Thêm điều kiện lọc trạng thái
        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append(" AND TrangThai = ?");
            params.add(statusFilter);
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
                khoaHoc.setTenKhoaHoc(rs.getString("TenKhoaHoc"));
                khoaHoc.setMoTa(rs.getString("MoTa"));
                khoaHoc.setThoiGianBatDau(rs.getDate("ThoiGianBatDau") != null ? rs.getDate("ThoiGianBatDau").toLocalDate() : null);
                khoaHoc.setThoiGianKetThuc(rs.getDate("ThoiGianKetThuc") != null ? rs.getDate("ThoiGianKetThuc").toLocalDate() : null);
                khoaHoc.setGhiChu(rs.getString("GhiChu"));
                khoaHoc.setTrangThai(rs.getString("TrangThai"));
                khoaHoc.setNgayTao(rs.getTimestamp("NgayTao") != null ? rs.getTimestamp("NgayTao").toLocalDateTime() : null);
                khoaHoc.setID_Khoi(rs.getInt("ID_Khoi"));
                list.add(khoaHoc);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }

        return list;
    }
     
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
}

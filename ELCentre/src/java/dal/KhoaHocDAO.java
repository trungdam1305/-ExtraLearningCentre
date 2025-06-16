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

                courses.add(khoaHoc);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log ra console để debug
            return null;
        }

        return courses;
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
}

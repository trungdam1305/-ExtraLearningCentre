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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author Vuh26
 */
public class KhoaHocDAO {

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
//                Course course = new Course();
//                course.setIdKhoaHoc(rs.getInt(1));
//                course.setTenKhoaHoc(rs.getString(2));
//                course.setMoTa(rs.getString(3));
//                course.setHocPhi(rs.getDouble(4));
//                course.setNgayKetThuc(rs.getDate(6).toLocalDate());
//                course.setGhiChu(rs.getString(7));
//                course.setTrangThai(rs.getString(8));
//                course.setNgayBatDau(rs.getDate(5).toLocalDate());
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());

                courses.add(khoaHoc);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log ra console để debug
            return null;
        }

        return courses;
    }

//    public static void main(String[] args) {
//        ArrayList<KhoaHoc> courses = KhoaHocDAO.getKhoaHoc();
//          DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//
//        if (courses == null || courses.isEmpty()) {
//            System.out.println("Không có khóa học nào hoặc xảy ra lỗi khi truy vấn.");
//            return;
//        }
//
//        for (KhoaHoc course : courses) {
//            System.out.println("ID: " + course.getID_KhoaHoc());
//            System.out.println("Tên khóa học: " + course.getTenKhoaHoc());
//            System.out.println("Mô tả: " + course.getMoTa());
//            System.out.println("Thời gian bắt đầu: " + course.getThoiGianBatDau());
//            System.out.println("Thời gian kết thúc: " + course.getThoiGianKetThuc());
//            System.out.println("Ghi chú: " + course.getGhiChu());
//            System.out.println("Trạng thái: " + course.getTrangThai());
//            System.out.println("Ngày tạo: " + course.getNgayTao().format(formatter));
//            System.out.println("-----------------------------------");
//        }
//    }
    public static KhoaHoc getKhoaHocById(int ID_KhoaHoc) {
        DBContext db = DBContext.getInstance();
        KhoaHoc khoaHoc = null;
        try {
            String sql = """
            SELECT ID_KhoaHoc, TenKhoaHoc, MoTa, ThoiGianBatDau,
                   ThoiGianKetThuc, GhiChu, TrangThai, NgayTao
            FROM KhoaHoc WHERE ID_KhoaHoc = ?
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, ID_KhoaHoc);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());
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
               ThoiGianKetThuc, GhiChu, TrangThai, NgayTao
        FROM KhoaHoc
        WHERE TenKhoaHoc LIKE ?
        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, "%" + name + "%"); // cho phép tìm một phần tên
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());
                list.add(khoaHoc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

//    public static void main(String[] args) {
//        // Giả sử bạn muốn kiểm tra với ID_KhoaHoc là 1
//        int idKhoaHoc = 11;
//        // Gọi hàm getKhoaHocById
//        KhoaHoc khoaHoc = getKhoaHocById(idKhoaHoc);
//        // Kiểm tra kết quả
//        if (khoaHoc != null) {
//            System.out.println("ID Khoa Hoc: " + khoaHoc.getID_KhoaHoc());
//            System.out.println("Ten Khoa Hoc: " + khoaHoc.getTenKhoaHoc());
//            System.out.println("Mo Ta: " + khoaHoc.getMoTa());
//            System.out.println("Thoi Gian Bat Dau: " + khoaHoc.getThoiGianBatDau());
//            System.out.println("Thoi Gian Ket Thuc: " + khoaHoc.getThoiGianKetThuc());
//            System.out.println("Ghi Chu: " + khoaHoc.getGhiChu());
//            System.out.println("Trang Thai: " + khoaHoc.getTrangThai());
//            System.out.println("Ngay Tao: " + khoaHoc.getNgayTao());
//        } else {
//            System.out.println("Khong tim thay Khoa Hoc voi ID: " + idKhoaHoc);
//        }
//    }
//
    public static KhoaHoc addKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;

        try {
            String sql = """
            INSERT INTO KhoaHoc (TenKhoaHoc, MoTa, ThoiGianBatDau, ThoiGianKetThuc, GhiChu, TrangThai)
            VALUES (?, ?, ?,  ?, ?, ?)
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            statement.setString(1, khoaHoc.getTenKhoaHoc());
            statement.setString(2, khoaHoc.getMoTa());
            statement.setDate(3, java.sql.Date.valueOf(khoaHoc.getThoiGianBatDau()));
            statement.setDate(4, java.sql.Date.valueOf(khoaHoc.getThoiGianKetThuc()));
            statement.setString(5, khoaHoc.getGhiChu());
            statement.setString(6, khoaHoc.getTrangThai());

            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // bạn nên log lỗi ra để debug
            return null;
        }

        return rs > 0 ? khoaHoc : null;
    }

//    public static void main(String[] args) {
//        KhoaHoc newKhoaHoc = new KhoaHoc();
//        newKhoaHoc.setTenKhoaHoc("Lập trình Java");
//        newKhoaHoc.setMoTa("Khóa học về lập trình Java cơ bản.");
//        newKhoaHoc.setThoiGianBatDau(LocalDate.of(2023, 10, 1));
//        newKhoaHoc.setThoiGianKetThuc(LocalDate.of(2023, 12, 31));
//        newKhoaHoc.setGhiChu("Khóa học này dành cho người mới bắt đầu.");
//        newKhoaHoc.setTrangThai("Đang mở");
//        KhoaHoc addedKhoaHoc = addKhoaHoc(newKhoaHoc);
//        if (addedKhoaHoc != null) {
//            System.out.println("Thêm khóa học thành công: " + addedKhoaHoc.getTenKhoaHoc());
//        } else {
//            System.out.println("Thêm khóa học thất bại.");
//        }
//    }
//
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
            SELECT * FROM KhoaHoc
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
                // Gán giá trị từ ResultSet cho đối tượng KhoaHoc
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());

                khoaHocList.add(khoaHoc);
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace(); // nên log lỗi để dễ debug
            return null; // hoặc Collections.emptyList()
        }
        return khoaHocList;
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

    public static KhoaHoc updateKhoaHoc(KhoaHoc khoaHoc) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
            UPDATE KhoaHoc
            SET TenKhoaHoc = ?, MoTa = ?, ThoiGianBatDau = ?, ThoiGianKetThuc = ?,GhiChu = ?, TrangThai = ?
            WHERE ID_KhoaHoc = ?
        """;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, khoaHoc.getTenKhoaHoc());
            statement.setString(2, khoaHoc.getMoTa());
            statement.setDate(3, java.sql.Date.valueOf(khoaHoc.getThoiGianBatDau()));
            statement.setDate(4, java.sql.Date.valueOf(khoaHoc.getThoiGianKetThuc()));
            statement.setString(5, khoaHoc.getGhiChu());
            statement.setString(6, khoaHoc.getTrangThai());
            statement.setInt(7, khoaHoc.getID_KhoaHoc());

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
        try {
            // Kiểm tra và đảm bảo sortId chỉ có giá trị "ASC" hoặc "DESC"
            String order = "ASC";
            if ("DESC".equalsIgnoreCase(sortId)) {
                order = "DESC";
            }

            String sql = "SELECT * FROM KhoaHoc ORDER BY ID_KhoaHoc " + order;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());

                khoaHocList.add(khoaHoc);
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null; // hoặc Collections.emptyList();
        }
        return khoaHocList;
    }

    public static List<KhoaHoc> getSortedByName(String sortName) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();
        try {
            // Xác định thứ tự sắp xếp, mặc định là ASC nếu không hợp lệ
            String order = "ASC";
            if ("DESC".equalsIgnoreCase(sortName)) {
                order = "DESC";
            }

            String sql = "SELECT * FROM KhoaHoc ORDER BY TenKhoaHoc " + order;

            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());

                khoaHocList.add(khoaHoc);
            }

            rs.close();
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null; // hoặc Collections.emptyList();
        }
        return khoaHocList;
    }
    
    public static List<KhoaHoc> getSortedByTrangThai(String sortOrder) {
    DBContext db = DBContext.getInstance();
    List<KhoaHoc> khoaHocList = new ArrayList<>();
    try {
        // Xác định thứ tự sắp xếp, mặc định là ASC nếu không hợp lệ
        String order = "ASC";
        if ("DESC".equalsIgnoreCase(sortOrder)) {
            order = "DESC";
        }

        String sql = "SELECT * FROM KhoaHoc ORDER BY TrangThai " + order;

        PreparedStatement statement = db.getConnection().prepareStatement(sql);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            KhoaHoc khoaHoc = new KhoaHoc();
            khoaHoc.setID_KhoaHoc(rs.getInt(1));
            khoaHoc.setTenKhoaHoc(rs.getString(2));
            khoaHoc.setMoTa(rs.getString(3));
            khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
            khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
            khoaHoc.setGhiChu(rs.getString(6));
            khoaHoc.setTrangThai(rs.getString(7));
            khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());

            khoaHocList.add(khoaHoc);
        }

        rs.close();
        statement.close();
    } catch (Exception e) {
        e.printStackTrace();
        return null; // hoặc Collections.emptyList();
    }
    return khoaHocList;
}

// public static void main(String[] args) {
////        // Thử sắp xếp tăng dần
////        System.out.println("Sắp xếp theo tên khóa học - ASC:");
////        List<KhoaHoc> listAsc = KhoaHocDAO.getSortedByName("ASC");
////        printList(listAsc);
//
//        // Thử sắp xếp giảm dần
//        System.out.println("\nSắp xếp theo tên khóa học - DESC:");
//        List<KhoaHoc> listDesc = KhoaHocDAO.getSortedByName("DESC");
//        printList(listDesc);
//    }

    private static void printList(List<KhoaHoc> list) {
        if (list == null || list.isEmpty()) {
            System.out.println("Danh sách rỗng hoặc lỗi truy vấn.");
            return;
        }
        for (KhoaHoc kh : list) {
            System.out.println("ID: " + kh.getID_KhoaHoc());
            System.out.println("Tên khóa học: " + kh.getTenKhoaHoc());
            System.out.println("Mô tả: " + kh.getMoTa());
            System.out.println("Thời gian bắt đầu: " + kh.getThoiGianBatDau());
            System.out.println("Thời gian kết thúc: " + kh.getThoiGianKetThuc());
            System.out.println("Ghi chú: " + kh.getGhiChu());
            System.out.println("Trạng thái: " + kh.getTrangThai());
            System.out.println("Ngày tạo: " + kh.getNgayTao());
            System.out.println("----------------------------");
        }
    }

//public static void main(String[] args) {
//        // Test sắp xếp tăng dần (ASC)
//        System.out.println("Danh sách khóa học (sắp xếp ASC):");
//        List<KhoaHoc> listAsc = KhoaHocDAO.getSortedByName("ASC");
//        if (listAsc != null) {
//            for (KhoaHoc khoaHoc : listAsc) {
//                        System.out.println("ID Khoa Hoc: " + khoaHoc.getID_KhoaHoc());
//           System.out.println("Ten Khoa Hoc: " + khoaHoc.getTenKhoaHoc());
//           System.out.println("Mo Ta: " + khoaHoc.getMoTa());
//           System.out.println("Thoi Gian Bat Dau: " + khoaHoc.getThoiGianBatDau());
//           System.out.println("Thoi Gian Ket Thuc: " + khoaHoc.getThoiGianKetThuc());
//           System.out.println("Ghi Chu: " + khoaHoc.getGhiChu());
//           System.out.println("Trang Thai: " + khoaHoc.getTrangThai());
//           System.out.println("Ngay Tao: " + khoaHoc.getNgayTao());
//
//            }
//        } else {
//            System.out.println("Không thể lấy danh sách khóa học.");
//        }
//
//        System.out.println("\n--------------------------------\n");
//}
    public static List<KhoaHoc> getSortedKhoaHoc(int offset, int limit, String sortOrder) {
        DBContext db = DBContext.getInstance();
        List<KhoaHoc> khoaHocList = new ArrayList<>();

        try {
            // Bảo vệ chống SQL Injection - chỉ cho phép ASC hoặc DESC
            if (!"ASC".equalsIgnoreCase(sortOrder) && !"DESC".equalsIgnoreCase(sortOrder)) {
                sortOrder = "ASC"; // mặc định
            }

            String sql = "SELECT * FROM KhoaHoc ORDER BY TenKhoaHoc " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, limit);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                KhoaHoc khoaHoc = new KhoaHoc();
                khoaHoc.setID_KhoaHoc(rs.getInt(1));
                khoaHoc.setTenKhoaHoc(rs.getString(2));
                khoaHoc.setMoTa(rs.getString(3));
                khoaHoc.setThoiGianBatDau(rs.getDate(4).toLocalDate());
                khoaHoc.setThoiGianKetThuc(rs.getDate(5).toLocalDate());
                khoaHoc.setGhiChu(rs.getString(6));
                khoaHoc.setTrangThai(rs.getString(7));
                khoaHoc.setNgayTao(rs.getTimestamp(8).toLocalDateTime());

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

   

//     public static void main(String[] args) {
//        String trangThaiCanTim = "Hoạt động"; // hoặc "Active", "Đã kết thúc" v.v.
//
//        List<KhoaHoc> danhSach = KhoaHocDAO.getKhoaHocByTrangThai(trangThaiCanTim);
//
//        if (danhSach == null || danhSach.isEmpty()) {
//            System.out.println("Không tìm thấy khóa học với trạng thái: " + trangThaiCanTim);
//        } else {
//            System.out.println("Danh sách khóa học với trạng thái: " + trangThaiCanTim);
//            for (KhoaHoc kh : danhSach) {
//                System.out.println("ID: " + kh.getID_KhoaHoc());
//                System.out.println("Tên: " + kh.getTenKhoaHoc());
//                System.out.println("Mô tả: " + kh.getMoTa());
//                System.out.println("Thời gian bắt đầu: " + kh.getThoiGianBatDau());
//                System.out.println("Thời gian kết thúc: " + kh.getThoiGianKetThuc());
//                System.out.println("Ghi chú: " + kh.getGhiChu());
//                System.out.println("Trạng thái: " + kh.getTrangThai());
//                System.out.println("Ngày tạo: " + kh.getNgayTao());
//                System.out.println("----------------------------------------");
//            }
//        }
//    }
    
    public static int getTotalCoursesByTrangThai() {
    DBContext db = DBContext.getInstance();
    int total = 0;
    try {
        String sql = "SELECT COUNT(*) FROM ELCentre.dbo.KhoaHoc WHERE TrangThai IN (N'Hoạt động', N'Kết thúc', N'Chờ mở')";
        PreparedStatement statement = db.getConnection().prepareStatement(sql);
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
    

//public static void main(String[] args) {
//        int total = KhoaHocDAO.getTotalCoursesByTrangThai();
//        System.out.println("Tổng số khóa học theo trạng thái: " + total);
//    }
    
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

}

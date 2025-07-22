package dal;

/**
 *
 * @author wrx_Chur04
 */
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import model.GiaoVien_ChiTietDay;
import model.HocPhi;
import model.TinhHocPhi;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.sql.Connection;

public class HocPhiDAO {

    public static ArrayList<GiaoVien_ChiTietDay> adminGetAllLopHocDangHocToSendHocPhi() {
        ArrayList<GiaoVien_ChiTietDay> lophocs = new ArrayList<GiaoVien_ChiTietDay>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                        select LH.ID_KhoaHoc, LH.ID_LopHoc , GVLH.ID_GiaoVien , GV.HoTen , TH.TenTruongHoc  , LH.TenLopHoc , LH.SiSo  , LH.GhiChu , LH.TrangThai , LH.NgayTao , LH.Image  , KH.TenKhoaHoc , KH.ID_Khoi , LH.SoTien from GiaoVien_LopHoc GVLH 
                        join LopHoc LH 
                        on GVLH.ID_LopHoc = LH.ID_LopHoc 

                        JOIN GiaoVien GV 
                        ON GVLH.ID_GiaoVien = GV.ID_GiaoVien
                        JOIN TruongHoc TH 
                        ON TH.ID_TruongHoc = GV.ID_TruongHoc
                         JOIN KhoaHoc KH 
                         ON KH.ID_KhoaHoc = LH.ID_KhoaHoc

                        WHERE 
                       LH.TrangThai = N'Đang học'; 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                GiaoVien_ChiTietDay giaovien = new GiaoVien_ChiTietDay(
                        rs.getInt("ID_KhoaHoc"),
                        rs.getInt("ID_LopHoc"),
                        rs.getInt("ID_GiaoVien"),
                        rs.getString("HoTen"),
                        rs.getString("TenTruongHoc"),
                        rs.getString("TenLopHoc"),
                        rs.getString("SiSo"),
                        rs.getString("GhiChu"),
                        rs.getString("TrangThai"),
                        rs.getTimestamp("NgayTao").toLocalDateTime(),
                        rs.getString("Image"),
                        rs.getInt("ID_Khoi"),
                        rs.getString("TenKhoaHoc"),
                        rs.getString("SoTien")
                );
                lophocs.add(giaovien);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (lophocs == null) {
            return null;
        } else {
            return lophocs;
        }
    }

    public static ArrayList<HocPhi> adminGetAllInforToViewHocPhi(String ID_LopHoc) {
        ArrayList<HocPhi> hocphis = new ArrayList<HocPhi>();
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                         SELECT hp.ID_HocPhi, hp.ID_HocSinh, hp.ID_LopHoc,
                        hp.Thang, hp.Nam, hp.SoBuoi, hp.HocPhiPhaiDong,
                        hp.DaDong, hp.NoConLai, hp.TinhTrangThanhToan,
                        hp.PhuongThucThanhToan, hp.NgayThanhToan,
                        hp.GhiChu, hs.MaHocSinh , hp.NgayThanhToan , 
                        hs.HoTen, hs.SDT_PhuHuynh , hs.ID_TaiKhoan 
                            FROM HocPhi hp
                            JOIN HocSinh hs ON hp.ID_HocSinh = hs.ID_HocSinh
                            where HP.ID_LopHoc = ? 
                        AND Thang = 6 
                        AND Nam = 2025 
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_LopHoc);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Timestamp ts = rs.getTimestamp("NgayThanhToan");
                LocalDate ngayThanhToan = (ts != null) ? ts.toLocalDateTime().toLocalDate() : null;
                HocPhi hocphi = new HocPhi(
                        rs.getInt("ID_HocPhi"),
                        rs.getInt("ID_HocSinh"),
                        rs.getInt("ID_LopHoc"),
                        rs.getString("PhuongThucThanhToan"),
                        rs.getString("TinhTrangThanhToan"),
                        ngayThanhToan,
                        rs.getString("GhiChu"),
                        rs.getInt("Thang"),
                        rs.getInt("Nam"),
                        rs.getInt("SoBuoi"),
                        rs.getInt("HocPhiPhaiDong"),
                        rs.getInt("DaDong"),
                        rs.getInt("NoConLai"),
                        rs.getString("MaHocSinh"),
                        rs.getInt("ID_TaiKhoan"),
                        rs.getString("HoTen"),
                        rs.getString("SDT_PhuHuynh")
                );
                hocphis.add(hocphi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (hocphis == null) {
            return null;
        } else {
            return hocphis;
        }
    }

    public static int adminTinhTienNo(String ID_HocSinh) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                    	SELECT SUM(HP.NoConLai) AS TongNo
                    FROM HocPhi HP
                    WHERE ID_HocSinh = ? 
                      AND (TinhTrangThanhToan = N'Chưa thanh toán' OR NoConLai > 0)
                      AND (Thang < 6 OR Nam < 2025)
                    """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, ID_HocSinh);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt("TongNo");
            }
            return 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public static boolean adminKetToanThangNay() {
        int rs = 0;
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                    	INSERT INTO HocPhi (
                            ID_HocSinh,
                            ID_LopHoc,
                            Thang,
                            Nam,
                            SoBuoi,
                            HocPhiPhaiDong,
                            NoConLai,
                            TinhTrangThanhToan
                        )
                        SELECT 
                            hs.ID_HocSinh,
                            lh.ID_LopHoc,
                            MONTH(lich.NgayHoc),
                            YEAR(lich.NgayHoc),
                            COUNT(*) AS SoBuoiCoMat,
                            CAST(lh.SoTien AS INT) * COUNT(*) AS HocPhiPhaiDong,
                            CAST(lh.SoTien AS INT) * COUNT(*) AS SoTienConNo,
                            N'Chưa thanh toán'
                        FROM DiemDanh dd
                        JOIN LichHoc lich ON dd.ID_Schedule = lich.ID_Schedule
                        JOIN LopHoc lh ON lich.ID_LopHoc = lh.ID_LopHoc
                        JOIN HocSinh hs ON dd.ID_HocSinh = hs.ID_HocSinh
                        WHERE (dd.TrangThai = N'Có mặt' OR dd.TrangThai = N'Đi muộn')
                          AND lh.TrangThai IN (N'Đang học', N'Đã học')
                          AND MONTH(lich.NgayHoc) = 6  
                          AND YEAR(lich.NgayHoc) = 2025 
                          AND NOT EXISTS (
                                SELECT 1 
                                FROM HocPhi hp
                                WHERE 
                                    hp.ID_HocSinh = hs.ID_HocSinh AND
                                    hp.ID_LopHoc = lh.ID_LopHoc AND
                                    hp.Thang = MONTH(lich.NgayHoc) AND
                                    hp.Nam = YEAR(lich.NgayHoc)
                            )
                        GROUP BY 
                            hs.ID_HocSinh,
                            lh.ID_LopHoc,
                            lh.SoTien,
                            MONTH(lich.NgayHoc),
                            YEAR(lich.NgayHoc);
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            rs = statement.executeUpdate();
            if (rs > 0) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static boolean adminDongCapNhatDongTien(String ID_HocSinh, String Thang, String Nam, String ID_LopHoc, String soTienDong) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                    	UPDATE HocPhi 
                        SET 
                        PhuongThucThanhToan = N'Tiền mặt',
                        TinhTrangThanhToan = N'Đã thanh toán',
                        NgayThanhToan = ?, 
                       
                        DaDong = ?, 
                        NoConLai = ?
                        WHERE 
                        ID_HocSinh = ? 
                        AND ID_LopHoc = ? 
                        AND Thang = ? 
                        AND Nam = ? ;
                    """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            statement.setString(2, soTienDong);
            statement.setString(3, "0");
            statement.setString(4, ID_HocSinh);
            statement.setString(5, ID_LopHoc);
            statement.setString(6, Thang);
            statement.setString(7, Nam);
            rs = statement.executeUpdate();
            if (rs > 0) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static boolean adminSendThongBaoHocPhi(String ID_TaiKhoanHS) {
        DBContext db = DBContext.getInstance();
        int rs = 0;
        try {
            String sql = """
                    	
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);

            rs = statement.executeUpdate();
            if (rs > 0) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public static String adminGetID_TaiKhoanPHToGuiThongBao(String sdt) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                    	select PH.ID_TaiKhoan from PhuHuynh PH 
                        where PH.SDT = ?
                         """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, sdt);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                return rs.getString("ID_TaiKhoan");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public static ArrayList<TinhHocPhi> adminGetInforToGuiThongBaoDenTatCa() {
        ArrayList<TinhHocPhi> hocphis = new ArrayList<TinhHocPhi>() ; 
        DBContext db = DBContext.getInstance();
        try {
            String sql = """
                        	 SELECT 
                                hs.ID_HocSinh,
                                hs.ID_TaiKhoan , 
                                hs.MaHocSinh,
                                hs.SDT_PhuHuynh , 
                                ph.ID_TaiKhoan AS ID_TaiKhoanPH , 
                                hs.HoTen,
                                hs.LopDangHocTrenTruong,
                                lh.ID_LopHoc,
                                lh.TenLopHoc,
                                MONTH(lich.NgayHoc) AS Thang,
                                YEAR(lich.NgayHoc) AS Nam,
                                COUNT(*) AS SoBuoiCoMat,
                                CAST(lh.SoTien AS INT) * COUNT(*) AS HocPhiPhaiDong
                            FROM DiemDanh dd
                            JOIN LichHoc lich ON dd.ID_Schedule = lich.ID_Schedule
                            JOIN LopHoc lh ON lich.ID_LopHoc = lh.ID_LopHoc
                            JOIN HocSinh hs ON dd.ID_HocSinh = hs.ID_HocSinh
                            JOIN PhuHuynh ph ON ph.SDT = hs.SDT_PhuHuynh
                            WHERE (dd.TrangThai = N'Có mặt' OR dd.TrangThai = N'Đi muộn')
                              AND (lh.TrangThai = N'Đang học' or lh.TrangThai = N'Đã học')
                              AND MONTH(lich.NgayHoc) = 6
                              AND YEAR(lich.NgayHoc) = 2025
                            GROUP BY 
                                hs.ID_HocSinh, hs.MaHocSinh, hs.HoTen, hs.LopDangHocTrenTruong,
                                lh.ID_LopHoc, lh.TenLopHoc, lh.SoTien, hs.ID_TaiKhoan , hs.SDT_PhuHuynh , ph.ID_TaiKhoan , 
                                MONTH(lich.NgayHoc), YEAR(lich.NgayHoc)
                         """;
            
            PreparedStatement statement = db.getConnection().prepareStatement(sql) ; 
            ResultSet rs = statement.executeQuery() ;
            
            while(rs.next()) {
                TinhHocPhi hocphi = new TinhHocPhi(
                        rs.getInt("ID_HocSinh") , 
                        rs.getInt("ID_TaiKhoan") , 
                        rs.getString("MaHocSinh") , 
                        rs.getString("HoTen") , 
                        rs.getString("SDT_PhuHuynh") , 
                        rs.getInt("ID_TaiKhoanPH") , 
                        rs.getString("LopDangHocTrenTruong") , 
                        
                        
                        rs.getInt("ID_LopHoc") , 
                        rs.getString("TenLopHoc") , 
                        rs.getInt("Thang") , 
                        rs.getInt("Nam") , 
                        rs.getInt("SoBuoiCoMat") , 
                        rs.getInt("HocPhiPhaiDong") 
                ) ; 
                hocphis.add(hocphi) ; 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        
        if (hocphis == null ) {
            return null ; 
        } else {
            return hocphis  ; 
        }
    }

      
    public static List<HocPhi> getHocPhiByHocSinhId(int idHocSinh) {
        List<HocPhi> list = new ArrayList<>();
        String sql = """
            SELECT hp.*, lh.ClassCode, lh.TenLopHoc, lh.SoTien
            FROM HocPhi hp
            JOIN LopHoc lh ON hp.ID_LopHoc = lh.ID_LopHoc
            WHERE hp.ID_HocSinh = ?
        """;
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HocPhi hp = new HocPhi();
                hp.setID_HocPhi(rs.getInt("ID_HocPhi"));
                hp.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hp.setID_LopHoc(rs.getInt("ID_LopHoc"));
                hp.setMonHoc(rs.getString("MonHoc"));
                hp.setPhuongThucThanhToan(rs.getString("PhuongThucThanhToan"));
                hp.setTinhTrangThanhToan(rs.getString("TinhTrangThanhToan"));

                java.sql.Date sqlDate = rs.getDate("NgayThanhToan");
                if (sqlDate != null) {
                    hp.setNgayThanhToan(sqlDate.toLocalDate());
                }

                hp.setGhiChu(rs.getString("GhiChu"));
                int tongHocPhi = rs.getInt("SoTien");  
                int daDong = rs.getInt("SoTienDaDong"); 

                hp.setTongHocPhi(tongHocPhi);
                hp.setSoTienDaDong(daDong);
                hp.setConThieu(Math.max(0, tongHocPhi - daDong));

                list.add(hp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
    public static int getTongHocPhiChuaDong(int idHocSinh) {
        String sql = "SELECT SUM(ConThieu) FROM HocPhi WHERE ID_HocSinh = ? AND TinhTrangThanhToan != 'Đã đóng'";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public static List<HocPhi> getLichSuThanhToan(int idHocSinh) {
        List<HocPhi> list = new ArrayList<>();
        String sql = "SELECT * FROM HocPhi WHERE ID_HocSinh = ? AND TinhTrangThanhToan = 'Đã đóng'";
        try (Connection conn = DBContext.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idHocSinh);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                HocPhi hp = new HocPhi();
                hp.setID_HocPhi(rs.getInt("ID_HocPhi"));
                hp.setID_HocSinh(rs.getInt("ID_HocSinh"));
                hp.setID_LopHoc(rs.getInt("ID_LopHoc"));
                hp.setMonHoc(rs.getString("MonHoc"));
                hp.setPhuongThucThanhToan(rs.getString("PhuongThucThanhToan"));
                hp.setTinhTrangThanhToan(rs.getString("TinhTrangThanhToan"));
                LocalDateTime ngay = rs.getTimestamp("NgayThanhToan").toLocalDateTime();
                hp.setNgayThanhToan(ngay != null ? ngay.toLocalDate() : null);
                hp.setGhiChu(rs.getString("GhiChu"));
                list.add(hp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //Kiểm tra dữ liệu
    public static void main(String[] args) {
        int idHocSinh = 17; // Thay ID tương ứng
        List<HocPhi> list = getHocPhiByHocSinhId(idHocSinh);
        if (list.isEmpty()) {
            System.out.println("⚠️ Không tìm thấy học phí cho học sinh ID: " + idHocSinh);
            return;
        }

        int tong = 0, daDong = 0;
        for (HocPhi hp : list) {
            System.out.println("📘 Môn: " + hp.getMonHoc());
            System.out.println(" - Tổng học phí: " + hp.getTongHocPhi());
            System.out.println(" - Đã đóng: " + hp.getSoTienDaDong());
            System.out.println(" - Còn thiếu: " + hp.getConThieu());
            System.out.println();
            tong += hp.getTongHocPhi();
            daDong += hp.getSoTienDaDong();
        }
        int conThieu = Math.max(0, tong - daDong);
        System.out.println("📊 TỔNG CỘNG:");
        System.out.println(" - Tổng học phí: " + tong);
        System.out.println(" - Đã đóng: " + daDong);
        System.out.println(" - Còn thiếu: " + conThieu);
    }

    
}
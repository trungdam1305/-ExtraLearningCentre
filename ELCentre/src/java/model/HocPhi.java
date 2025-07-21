package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Represents tuition payment information for a student in a specific class and
 * subject.
 *
 * Author: trungdam1305
 */
public class HocPhi {

    // Unique ID for the tuition record
    private Integer ID_HocPhi;

    // ID of the student who paid the tuition
    private Integer ID_HocSinh;

    // ID of the class associated with this tuition
    private Integer ID_LopHoc;

    // Payment method used (e.g., Cash, Bank Transfer, Online)
    private String PhuongThucThanhToan;

    // Payment status (e.g., Paid, Unpaid, Pending)
    private String TinhTrangThanhToan;

    // Date when the tuition was paid
    private LocalDateTime NgayThanhToan;

    // Additional notes or remarks
    private String GhiChu;

    private int Thang;
    private int Nam;
    private int SoBuoi ; 
    private int HocPhiPhaiDong;
    private int DaDong;
    private int NoConLai;
    private String MaHocSinh ; 
    private int ID_TaiKhoan  ; 
    private String HoTen ; 
    private String SDT_PhuHuynh ; 
   
    

    /**
     * Default constructor
     */
    public HocPhi() {
    }

    public HocPhi(Integer ID_HocPhi, Integer ID_HocSinh, Integer ID_LopHoc, String PhuongThucThanhToan, String TinhTrangThanhToan, LocalDateTime NgayThanhToan, String GhiChu, int Thang, int Nam, int SoBuoi, int HocPhiPhaiDong, int DaDong, int NoConLai, String MaHocSinh, int ID_TaiKhoan, String HoTen, String SDT_PhuHuynh) {
        this.ID_HocPhi = ID_HocPhi;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_LopHoc = ID_LopHoc;
        this.PhuongThucThanhToan = PhuongThucThanhToan;
        this.TinhTrangThanhToan = TinhTrangThanhToan;
        this.NgayThanhToan = NgayThanhToan;
        this.GhiChu = GhiChu;
        this.Thang = Thang;
        this.Nam = Nam;
        this.SoBuoi = SoBuoi;
        this.HocPhiPhaiDong = HocPhiPhaiDong;
        this.DaDong = DaDong;
        this.NoConLai = NoConLai;
        this.MaHocSinh = MaHocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
    }

    public int getSoBuoi() {
        return SoBuoi;
    }

    public String getMaHocSinh() {
        return MaHocSinh;
    }

    public int getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getSDT_PhuHuynh() {
        return SDT_PhuHuynh;
    }

    

    

    public Integer getID_HocPhi() {
        return ID_HocPhi;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public String getPhuongThucThanhToan() {
        return PhuongThucThanhToan;
    }

    public String getTinhTrangThanhToan() {
        return TinhTrangThanhToan;
    }

    public LocalDateTime getNgayThanhToan() {
        return NgayThanhToan;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public int getThang() {
        return Thang;
    }

    public int getNam() {
        return Nam;
    }

    public int getHocPhiPhaiDong() {
        return HocPhiPhaiDong;
    }

    public int getDaDong() {
        return DaDong;
    }

    public int getNoConLai() {
        return NoConLai;
    }

}

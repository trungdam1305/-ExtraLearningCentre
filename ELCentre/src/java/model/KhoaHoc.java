package model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Represents a course offered by the tutoring center.
 * Stores information such as course name, duration, description, notes, status, 
 * creation date, educational level, and associated image.
 * 
 * @author trungdam1305
 */
public class KhoaHoc {
    private Integer ID_KhoaHoc;          // Unique identifier for the course
    private String CourseCode ; 
    private String TenKhoaHoc;           // Course name
    private String MoTa;                 // Description of the course
    private LocalDate ThoiGianBatDau;    // Start date of the course
    private LocalDate ThoiGianKetThuc;   // End date of the course
    private String GhiChu;               // Additional notes
    private String TrangThai;            // Status of the course (e.g., active, closed)
    private LocalDateTime NgayTao;       // Date the course was created
    private int ID_Khoi;                 // Educational level ID (e.g., primary, secondary)
    private String Image;                // URL or path to course image
    private int  Order ; 

    // Constructors
    public KhoaHoc() {}
    
     public KhoaHoc(Integer ID_KhoaHoc, String TenKhoaHoc, String MoTa, LocalDate ThoiGianBatDau, LocalDate ThoiGianKetThuc, String GhiChu, String TrangThai, LocalDateTime NgayTao, int ID_Khoi) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.TenKhoaHoc = TenKhoaHoc;
        this.MoTa = MoTa;
        this.ThoiGianBatDau = ThoiGianBatDau;
        this.ThoiGianKetThuc = ThoiGianKetThuc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.ID_Khoi = ID_Khoi;
    }

    public KhoaHoc(Integer ID_KhoaHoc, String CourseCode, String TenKhoaHoc, String MoTa, LocalDate ThoiGianBatDau, LocalDate ThoiGianKetThuc, String GhiChu, String TrangThai, LocalDateTime NgayTao, int ID_Khoi, String Image, int Order) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.CourseCode = CourseCode;
        this.TenKhoaHoc = TenKhoaHoc;
        this.MoTa = MoTa;
        this.ThoiGianBatDau = ThoiGianBatDau;
        this.ThoiGianKetThuc = ThoiGianKetThuc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.ID_Khoi = ID_Khoi;
        this.Image = Image;
        this.Order = Order;
    }

    

   

    // Getter and Setter methods

    public Integer getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public void setID_KhoaHoc(Integer ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public String getTenKhoaHoc() {
        return TenKhoaHoc;
    }

    public void setTenKhoaHoc(String TenKhoaHoc) {
        this.TenKhoaHoc = TenKhoaHoc;
    }

    public String getMoTa() {
        return MoTa;
    }

    public void setMoTa(String MoTa) {
        this.MoTa = MoTa;
    }

    public LocalDate getThoiGianBatDau() {
        return ThoiGianBatDau;
    }

    public void setThoiGianBatDau(LocalDate ThoiGianBatDau) {
        this.ThoiGianBatDau = ThoiGianBatDau;
    }

    public LocalDate getThoiGianKetThuc() {
        return ThoiGianKetThuc;
    }

    public void setThoiGianKetThuc(LocalDate ThoiGianKetThuc) {
        this.ThoiGianKetThuc = ThoiGianKetThuc;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public int getID_Khoi() {
        return ID_Khoi;
    }

    public void setID_Khoi(int ID_Khoi) {
        this.ID_Khoi = ID_Khoi;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    /**
     * Returns the formatted start date in the pattern "dd/MM/yyyy".
     * @return Formatted start date or empty string if null.
     */
    public String getThoiGianBatDauFormatted() {
        return (ThoiGianBatDau != null) ? ThoiGianBatDau.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    /**
     * Returns the formatted end date in the pattern "dd/MM/yyyy".
     * @return Formatted end date or empty string if null.
     */
    public String getThoiGianKetThucFormatted() {
        return (ThoiGianKetThuc != null) ? ThoiGianKetThuc.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }
    
     

public String getNgayTaoFormatted() {
    if (NgayTao != null) {
        return NgayTao.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    return "";
}

public String getLopTheoKhoi() {
    if (ID_Khoi >= 1 && ID_Khoi <= 7) {
        return "Lớp " + (ID_Khoi + 5); // Vì 1 => lớp 6, nên cộng 5
    } else {
        return "Tổng ôn";
    }
}
}

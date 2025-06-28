package model;

import java.time.LocalDateTime;

/**
 * The LopHoc class represents a class (group of students) in the tutoring center.
 * It includes metadata about the course, number of students, schedule, tuition fee,
 * status, creation time, and an image for display purposes.
 * 
 * Fields:
 * - ID_LopHoc: Unique identifier for the class.
 * - TenLopHoc: The name of the class.
 * - ID_KhoaHoc: The ID of the associated course.
 * - SiSo: Number of students in the class.
 * - ID_Schedule: Identifier for the associated schedule or timetable.
 * - GhiChu: Notes about the class.
 * - TrangThai: Status of the class (e.g., Active, Inactive).
 * - SoTien: Tuition fee amount.
 * - NgayTao: Creation timestamp.
 * - Image: Image representing the class.
 * 
 * Author: Quang Trung Đàm
 */
public class LopHoc {
    
    private Integer ID_LopHoc;          // Unique class ID
    private String ClassCode ; 
    private String TenLopHoc;           // Name of the class
    private Integer ID_KhoaHoc;         // Linked course ID
    private Integer SiSo;               // Number of students (class size)
    private Integer SiSoToiDa ; 
    private Integer SiSoToiThieu ;  
    private int ID_Schedule;            // Associated schedule ID
    private int ID_PhongHoc ; 
    private String GhiChu;              // Class notes
    private String TrangThai;           // Status of the class
    private String SoTien;              // Tuition fee (as string for formatting reasons)
    private LocalDateTime NgayTao;      // Date and time of class creation
    private String Image;               // URL or filename of the class image
    private String Order ; 

    public LopHoc(Integer ID_LopHoc, String ClassCode, String TenLopHoc, Integer ID_KhoaHoc, Integer SiSo, Integer SiSoToiDa, Integer SiSoToiThieu, int ID_Schedule, int ID_PhongHoc, String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image, int Order) {
        this.ID_LopHoc = ID_LopHoc;
        this.ClassCode = ClassCode;
        this.TenLopHoc = TenLopHoc;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.SiSo = SiSo;
        this.SiSoToiDa = SiSoToiDa;
        this.SiSoToiThieu = SiSoToiThieu;
        this.ID_Schedule = ID_Schedule;
        this.ID_PhongHoc = ID_PhongHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
        this.Order = Order;
    }

    

    public Integer getSiSoToiDa() {
        return SiSoToiDa;
    }

    public void setSiSoToiDa(Integer SiSoToiDa) {
        this.SiSoToiDa = SiSoToiDa;
    }
    /**
     * Default constructor.
     */
    public LopHoc() {
    }

    /**
     * Full constructor with all fields.
     */
    public LopHoc(Integer ID_LopHoc, String TenLopHoc, Integer ID_KhoaHoc, Integer SiSo, int ID_Schedule,
                  String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image) {
        this.ID_LopHoc = ID_LopHoc;
        this.TenLopHoc = TenLopHoc;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.SiSo = SiSo;
        this.ID_Schedule = ID_Schedule;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
    }

    // --- Getters and Setters ---

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public void setTenLopHoc(String TenLopHoc) {
        this.TenLopHoc = TenLopHoc;
    }

    public Integer getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public void setID_KhoaHoc(Integer ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public Integer getSiSo() {
        return SiSo;
    }

    public void setSiSo(Integer SiSo) {
        this.SiSo = SiSo;
    }

    public int getID_Schedule() {
        return ID_Schedule;
    }

    public void setID_Schedule(int ID_Schedule) {
        this.ID_Schedule = ID_Schedule;
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

    public String getSoTien() {
        return SoTien;
    }

    public void setSoTien(String SoTien) {
        this.SoTien = SoTien;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getClassCode() {
        return ClassCode;
    }

    public Integer getSiSoToiThieu() {
        return SiSoToiThieu;
    }

    public int getID_PhongHoc() {
        return ID_PhongHoc;
    }

    public int getOrder() {
        return Order;
    }

    public void setClassCode(String ClassCode) {
        this.ClassCode = ClassCode;
    }

    public void setSiSoToiThieu(Integer SiSoToiThieu) {
        this.SiSoToiThieu = SiSoToiThieu;
    }

    public void setID_PhongHoc(int ID_PhongHoc) {
        this.ID_PhongHoc = ID_PhongHoc;
    }

    public void setOrder(int Order) {
        this.Order = Order;
    }
    
    
}

package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Represents a student with personal, contact, and school information.
 * 
 * Author: trungdam1305
 */
public class HocSinh {

    // Unique ID for the student
    private Integer ID_HocSinh;

    // ID of the associated user account
    private Integer ID_TaiKhoan;

    // Full name of the student
    private String HoTen;

    // Date of birth
    private LocalDate NgaySinh;

    // Gender of the student
    private String GioiTinh;

    // Address of the student
    private String DiaChi;

    // Parent's phone number
    private String SDT_PhuHuynh;

    // School ID the student is enrolled in
    private int ID_TruongHoc;

    // Additional notes
    private String GhiChu;

    // Current status (e.g., Active, Inactive)
    private String TrangThai;

    // Timestamp of student record creation
    private LocalDateTime NgayTao;

    // Name of the school (denormalized for display)
    private String TenTruongHoc;

    /**
     * Default constructor
     */
    public HocSinh() {
    }

    /**
     * Constructor with school name included
     */
    public HocSinh(Integer ID_HocSinh, Integer ID_TaiKhoan, String HoTen, LocalDate NgaySinh, String GioiTinh,
                   String DiaChi, String SDT_PhuHuynh, int ID_TruongHoc, String GhiChu,
                   String TrangThai, LocalDateTime NgayTao, String TenTruongHoc) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.NgaySinh = NgaySinh;
        this.GioiTinh = GioiTinh;
        this.DiaChi = DiaChi;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
        this.ID_TruongHoc = ID_TruongHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.TenTruongHoc = TenTruongHoc;
    }

    /**
     * Constructor without school name
     */
    public HocSinh(Integer ID_HocSinh, Integer ID_TaiKhoan, String HoTen, LocalDate NgaySinh, String GioiTinh,
                   String DiaChi, String SDT_PhuHuynh, int ID_TruongHoc, String GhiChu,
                   String TrangThai, LocalDateTime NgayTao) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.NgaySinh = NgaySinh;
        this.GioiTinh = GioiTinh;
        this.DiaChi = DiaChi;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
        this.ID_TruongHoc = ID_TruongHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    // Getters and setters

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public LocalDate getNgaySinh() {
        return NgaySinh;
    }

    public void setNgaySinh(LocalDate NgaySinh) {
        this.NgaySinh = NgaySinh;
    }

    public String getGioiTinh() {
        return GioiTinh;
    }

    public void setGioiTinh(String GioiTinh) {
        this.GioiTinh = GioiTinh;
    }

    public String getDiaChi() {
        return DiaChi;
    }

    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
    }

    public String getSDT_PhuHuynh() {
        return SDT_PhuHuynh;
    }

    public void setSDT_PhuHuynh(String SDT_PhuHuynh) {
        this.SDT_PhuHuynh = SDT_PhuHuynh;
    }

    public int getID_TruongHoc() {
        return ID_TruongHoc;
    }

    public void setID_TruongHoc(int ID_TruongHoc) {
        this.ID_TruongHoc = ID_TruongHoc;
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

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
    }
}

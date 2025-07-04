package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Represents a teacher's profile including personal and professional
 * information. Contains fields for salary, account, specialization, school,
 * status, and avatar.
 *
 * Author: trungdam1305
 */
public class GiaoVien {

    // Unique ID of the teacher
    private Integer ID_GiaoVien;

    // Linked account ID
    private Integer ID_TaiKhoan;

    // Full name of the teacher
    private String HoTen;

    // Specialization or subject taught
    private String ChuyenMon;

    // Phone number
    private String SDT;

    // ID of the school where the teacher works
    private int ID_TruongHoc;

    // Salary of the teacher
    private BigDecimal Luong;

    // Hot flag (e.g., featured teacher: 1 = yes, 0 = no)
    private int IsHot;

    // Status of the teacher (e.g., Active, Inactive)
    private String TrangThai;

    // Date and time when the teacher profile was created
    private LocalDateTime NgayTao;

    // URL or path to teacher's avatar image
    private String Avatar;

    // Name of the school (used in display, not for DB insertion)
    private String TenTruongHoc;

    // Constructors
    public GiaoVien() {
    }
    
     public GiaoVien(Integer ID_GiaoVien, Integer ID_TaiKhoan, String HoTen, String ChuyenMon, String SDT, int ID_TruongHoc, BigDecimal Luong, int IsHot, String TrangThai, LocalDateTime NgayTao, String Avatar) {
        this.ID_GiaoVien = ID_GiaoVien;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.ChuyenMon = ChuyenMon;
        this.SDT = SDT;
        this.ID_TruongHoc = ID_TruongHoc;
        this.Luong = Luong;
        this.IsHot = IsHot;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.Avatar = Avatar;
    }

   public GiaoVien(Integer ID_GiaoVien, Integer ID_TaiKhoan, String HoTen, String ChuyenMon, String SDT, int ID_TruongHoc, BigDecimal Luong, int IsHot, String TrangThai, LocalDateTime NgayTao, String Avatar, String TenTruongHoc) {
        this.ID_GiaoVien = ID_GiaoVien;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.ChuyenMon = ChuyenMon;
        this.SDT = SDT;
        this.ID_TruongHoc = ID_TruongHoc;
        this.Luong = Luong;
        this.IsHot = IsHot;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.Avatar = Avatar;
        this.TenTruongHoc = TenTruongHoc;
    }

   

    public GiaoVien(int ID_GiaoVien, Integer ID_TaiKhoan, String HoTen, String ChuyenMon, String SDT,
            int ID_TruongHoc, BigDecimal Luong, int IsHot, String TrangThai,
            LocalDateTime NgayTao) {
        this(ID_GiaoVien, ID_TaiKhoan, HoTen, ChuyenMon, SDT, ID_TruongHoc, Luong, IsHot, TrangThai, NgayTao, null);
    }

    // Getters and Setters
    public Integer getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public void setID_GiaoVien(Integer ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
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

    public String getChuyenMon() {
        return ChuyenMon;
    }

    public void setChuyenMon(String ChuyenMon) {
        this.ChuyenMon = ChuyenMon;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public int getID_TruongHoc() {
        return ID_TruongHoc;
    }

    public void setID_TruongHoc(int ID_TruongHoc) {
        this.ID_TruongHoc = ID_TruongHoc;
    }

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
    }

    public BigDecimal getLuong() {
        return Luong;
    }

    public void setLuong(BigDecimal Luong) {
        this.Luong = Luong;
    }

    public int getIsHot() {
        return IsHot;
    }

    public void setIsHot(int IsHot) {
        this.IsHot = IsHot;
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

    public String getAvatar() {
        return Avatar;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }
}

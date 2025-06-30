package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Represents a teacher along with the school they belong to.
 * Combines teacher information with related school data such as school name and address.
 *
 * Author: wrx_Chur04
 * 
 * Updated day 23/06/2025: trungdam 
 * Description: update comment 
 */
public class GiaoVien_TruongHoc {

    // Unique ID of the teacher
    private Integer ID_GiaoVien;

    // Linked account ID of the teacher
    private Integer ID_TaiKhoan;

    // Full name of the teacher
    private String HoTen;

    // Teacher's specialization or subject
    private String ChuyenMon;

 
    // Phone number
    private String SDT;

    // ID of the associated school
    private int ID_TruongHoc;

    // Salary of the teacher
    private BigDecimal Luong;

    // Indicates if the teacher is highlighted or featured (1 = yes, 0 = no)
    private int IsHot;

    // Current status (e.g., Active, Inactive)
    private String TrangThai;

    // Timestamp when the teacher profile was created
    private LocalDateTime NgayTao;

    // Avatar image path or URL
    private String Avatar;

    // Name of the school
    private String TenTruongHoc;

    private String BangCap ; 
    private String LopDangDayTrenTruong ; 
    private String TrangThaiDay ; 

    /**
     * Default constructor
     */
    public GiaoVien_TruongHoc() {
    }

    public GiaoVien_TruongHoc(Integer ID_GiaoVien, Integer ID_TaiKhoan, String HoTen, String ChuyenMon, String SDT, int ID_TruongHoc, BigDecimal Luong, int IsHot, String TrangThai, LocalDateTime NgayTao, String Avatar, String TenTruongHoc, String BangCap, String LopDangDayTrenTruong, String TrangThaiDay) {
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
        this.BangCap = BangCap;
        this.LopDangDayTrenTruong = LopDangDayTrenTruong;
        this.TrangThaiDay = TrangThaiDay;
    }

    // Getters
    public Integer getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getChuyenMon() {
        return ChuyenMon;
    }

    public String getSDT() {
        return SDT;
    }

    public int getID_TruongHoc() {
        return ID_TruongHoc;
    }

    public BigDecimal getLuong() {
        return Luong;
    }

    public int getIsHot() {
        return IsHot;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public String getAvatar() {
        return Avatar;
    }

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public String getBangCap() {
        return BangCap;
    }

    public String getLopDangDayTrenTruong() {
        return LopDangDayTrenTruong;
    }

    public String getTrangThaiDay() {
        return TrangThaiDay;
    }

    

   

    public void setID_GiaoVien(Integer ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setChuyenMon(String ChuyenMon) {
        this.ChuyenMon = ChuyenMon;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public void setID_TruongHoc(int ID_TruongHoc) {
        this.ID_TruongHoc = ID_TruongHoc;
    }

    public void setLuong(BigDecimal Luong) {
        this.Luong = Luong;
    }

    public void setIsHot(int IsHot) {
        this.IsHot = IsHot;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
    }

   
}

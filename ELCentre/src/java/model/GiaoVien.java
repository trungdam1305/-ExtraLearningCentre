package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

// 8. GiaoVien.java
public class GiaoVien {

    private Integer ID_GiaoVien;
    private Integer ID_TaiKhoan;
    private String HoTen;
    private String ChuyenMon;
    private String SDT;
    private int ID_TruongHoc;
    private BigDecimal Luong;
    private int IsHot;
    private String TrangThai;
    private LocalDateTime NgayTao;
    private String Avatar;
    private String TenTruongHoc;

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
    
    public GiaoVien() {
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

    public int getID_TruongHoc() {
        return ID_TruongHoc;
    }

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public void setID_TruongHoc(int ID_TruongHoc) {
        this.ID_TruongHoc = ID_TruongHoc;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
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

    
    
    public GiaoVien(int ID_GiaoVien, Integer ID_TaiKhoan, String HoTen, String ChuyenMon, String SDT, int ID_TruongHoc, BigDecimal Luong, int IsHot, String TrangThai, LocalDateTime NgayTao) {
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
    
    }

    public String getAvatar() {
        return Avatar;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }
    
    

    
    public Integer getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(Integer ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; 
    
    
    }

}
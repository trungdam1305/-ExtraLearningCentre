/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author wrx_Chur04
 */
public class HocSinh_SDT {
    // Unique ID for the student
    private Integer ID_HocSinh;
    
    
    private String MaHocSinh ; 

    // ID of the associated user account
    private Integer ID_TaiKhoan;

    // Full name of the student
    private String HoTen;

    // Date of birth
    private LocalDate NgaySinh;

    // Gender of the student
    private String GioiTinh;
    
    
    private String SoDienThoai ; 

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
    
    private String LopDangHocTrenTruong ; 
    
    private String TrangThaiHoc ; 
    
    private String Avatar ; 

    public HocSinh_SDT() {
    }

    public HocSinh_SDT(Integer ID_HocSinh, String MaHocSinh, Integer ID_TaiKhoan, String HoTen, LocalDate NgaySinh, String GioiTinh, String SoDienThoai, String DiaChi, String SDT_PhuHuynh, int ID_TruongHoc, String GhiChu, String TrangThai, LocalDateTime NgayTao, String TenTruongHoc, String LopDangHocTrenTruong, String TrangThaiHoc, String Avatar) {
        this.ID_HocSinh = ID_HocSinh;
        this.MaHocSinh = MaHocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.NgaySinh = NgaySinh;
        this.GioiTinh = GioiTinh;
        this.SoDienThoai = SoDienThoai;
        this.DiaChi = DiaChi;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
        this.ID_TruongHoc = ID_TruongHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.TenTruongHoc = TenTruongHoc;
        this.LopDangHocTrenTruong = LopDangHocTrenTruong;
        this.TrangThaiHoc = TrangThaiHoc;
        this.Avatar = Avatar;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public String getMaHocSinh() {
        return MaHocSinh;
    }

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public LocalDate getNgaySinh() {
        return NgaySinh;
    }

    public String getGioiTinh() {
        return GioiTinh;
    }

    public String getSoDienThoai() {
        return SoDienThoai;
    }

    public String getDiaChi() {
        return DiaChi;
    }

    public String getSDT_PhuHuynh() {
        return SDT_PhuHuynh;
    }

    public int getID_TruongHoc() {
        return ID_TruongHoc;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public String getLopDangHocTrenTruong() {
        return LopDangHocTrenTruong;
    }

    public String getTrangThaiHoc() {
        return TrangThaiHoc;
    }

    public String getAvatar() {
        return Avatar;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public void setMaHocSinh(String MaHocSinh) {
        this.MaHocSinh = MaHocSinh;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setNgaySinh(LocalDate NgaySinh) {
        this.NgaySinh = NgaySinh;
    }

    public void setGioiTinh(String GioiTinh) {
        this.GioiTinh = GioiTinh;
    }

    public void setSoDienThoai(String SoDienThoai) {
        this.SoDienThoai = SoDienThoai;
    }

    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
    }

    public void setSDT_PhuHuynh(String SDT_PhuHuynh) {
        this.SDT_PhuHuynh = SDT_PhuHuynh;
    }

    public void setID_TruongHoc(int ID_TruongHoc) {
        this.ID_TruongHoc = ID_TruongHoc;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
    }

    public void setLopDangHocTrenTruong(String LopDangHocTrenTruong) {
        this.LopDangHocTrenTruong = LopDangHocTrenTruong;
    }

    public void setTrangThaiHoc(String TrangThaiHoc) {
        this.TrangThaiHoc = TrangThaiHoc;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }
    
   
    
}

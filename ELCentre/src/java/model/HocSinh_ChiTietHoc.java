/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author wrx_Chur04
 */
public class HocSinh_ChiTietHoc {
    private Integer ID_KhoaHoc ; 
    private Integer ID_LopHoc ; 
    private Integer ID_HocSinh ; 
    private Integer ID_GiaoVien ; 
    private String TenLopHoc ; 
    private String SlotThoiGian ; 
    private String HoTen ; 
    private String GhiChu ; 
    private String TrangThai ; 
    private String SoTien ; 
    private LocalDateTime NgayTao ; 
    private String Image ; 

    public HocSinh_ChiTietHoc() {
    }

    public HocSinh_ChiTietHoc(Integer ID_KhoaHoc, Integer ID_LopHoc, Integer ID_HocSinh, Integer ID_GiaoVien, String TenLopHoc, String SlotThoiGian, String HoTen, String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.ID_LopHoc = ID_LopHoc;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenLopHoc = TenLopHoc;
        this.SlotThoiGian = SlotThoiGian;
        this.HoTen = HoTen;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
    }

    public HocSinh_ChiTietHoc(Integer ID_KhoaHoc, Integer ID_LopHoc, Integer ID_HocSinh, Integer ID_GiaoVien, String TenLopHoc, String HoTen, String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.ID_LopHoc = ID_LopHoc;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenLopHoc = TenLopHoc;
        
        this.HoTen = HoTen;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
    }

    public Integer getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public Integer getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public String getSlotThoiGian() {
        return SlotThoiGian;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public String getSoTien() {
        return SoTien;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public String getImage() {
        return Image;
    }

    public void setID_KhoaHoc(Integer ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public void setID_GiaoVien(Integer ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public void setTenLopHoc(String TenLopHoc) {
        this.TenLopHoc = TenLopHoc;
    }

    public void setSlotThoiGian(String SlotThoiGian) {
        this.SlotThoiGian = SlotThoiGian;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public void setSoTien(String SoTien) {
        this.SoTien = SoTien;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }
    
    
}

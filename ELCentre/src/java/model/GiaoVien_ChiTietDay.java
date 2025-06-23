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
public class GiaoVien_ChiTietDay {
    private Integer ID_KhoaHoc ; 
    private Integer ID_LopHoc ; 
    private Integer ID_GiaoVien ; 
    private String HoTen ; 
    private String TenTruongHoc ;
    private String TenLopHoc ; 
    private String SiSo ; 
    private String SlotThoiGian ; 
    private String GhiChu ; 
    private String TrangThai ; 
    private LocalDateTime NgayTao ; 
    private String Image ; 

    public GiaoVien_ChiTietDay() {
    }

    public GiaoVien_ChiTietDay(Integer ID_KhoaHoc, Integer ID_LopHoc, Integer ID_GiaoVien, String HoTen, String TenTruongHoc, String TenLopHoc, String SiSo, String SlotThoiGian, String GhiChu, String TrangThai, LocalDateTime NgayTao, String Image) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.ID_LopHoc = ID_LopHoc;
        this.ID_GiaoVien = ID_GiaoVien;
        this.HoTen = HoTen;
        this.TenTruongHoc = TenTruongHoc;
        this.TenLopHoc = TenLopHoc;
        this.SiSo = SiSo;
        this.SlotThoiGian = SlotThoiGian;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.Image = Image;
    }

    public Integer getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public Integer getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public String getSiSo() {
        return SiSo;
    }

    public String getSlotThoiGian() {
        return SlotThoiGian;
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

    public String getImage() {
        return Image;
    }

    public void setID_KhoaHoc(Integer ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public void setID_GiaoVien(Integer ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
    }

    public void setTenLopHoc(String TenLopHoc) {
        this.TenLopHoc = TenLopHoc;
    }

    public void setSiSo(String SiSo) {
        this.SiSo = SiSo;
    }

    public void setSlotThoiGian(String SlotThoiGian) {
        this.SlotThoiGian = SlotThoiGian;
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

    public void setImage(String Image) {
        this.Image = Image;
    }
    
    
}

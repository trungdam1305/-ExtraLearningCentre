/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
import java.math.BigDecimal;
import java.util.Date;

public class GiaoVien {
    private int ID_GiaoVien;
    private int ID_TaiKhoan;
    private String HoTen;
    private String ChuyenMon;
    private String SDT;
    private int ID_LopHoc;
    private String TruongGiangDay;
    private BigDecimal Luong;
    private String GhiChu;
    private String TrangThai = "Active";
    private Date NgayTao;

    // Constructor không tham số
    public GiaoVien() {
    }

    // Constructor có tham số đầy đủ
    public GiaoVien(int ID_GiaoVien, int ID_TaiKhoan, String HoTen, String ChuyenMon, String SDT,
                    int ID_LopHoc, String TruongGiangDay, BigDecimal Luong, String GhiChu,
                    String TrangThai, Date NgayTao) {
        this.ID_GiaoVien = ID_GiaoVien;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.ChuyenMon = ChuyenMon;
        this.SDT = SDT;
        this.ID_LopHoc = ID_LopHoc;
        this.TruongGiangDay = TruongGiangDay;
        this.Luong = Luong;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public void setID_GiaoVien(int ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public int getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_TaiKhoan(int ID_TaiKhoan) {
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

    public int getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(int ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public String getTruongGiangDay() {
        return TruongGiangDay;
    }

    public void setTruongGiangDay(String TruongGiangDay) {
        this.TruongGiangDay = TruongGiangDay;
    }

    public BigDecimal getLuong() {
        return Luong;
    }

    public void setLuong(BigDecimal Luong) {
        this.Luong = Luong;
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

    public Date getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(Date NgayTao) {
        this.NgayTao = NgayTao;
    }
}


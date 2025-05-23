/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author admin
 */
public class PhuHuynh {
    private int ID_PhuHuynh;
    private int ID_TaiKhoan;
    private String HoTen;
    private String SDT;
    private String Email;
    private String DiaChi;
    private String GhiChu;
    private String TrangThai;
    private Date NgayTao;

    public PhuHuynh() {
    }

    public PhuHuynh(int ID_PhuHuynh, int ID_TaiKhoan, String HoTen, String SDT, String Email, String DiaChi, String GhiChu, String TrangThai, Date NgayTao) {
        this.ID_PhuHuynh = ID_PhuHuynh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.SDT = SDT;
        this.Email = Email;
        this.DiaChi = DiaChi;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_PhuHuynh() {
        return ID_PhuHuynh;
    }

    public void setID_PhuHuynh(int ID_PhuHuynh) {
        this.ID_PhuHuynh = ID_PhuHuynh;
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

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getDiaChi() {
        return DiaChi;
    }

    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
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

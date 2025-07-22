/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vuh26
 */
public class TeacherSalary {
     private int idGiaoVien;
    private int idLopHoc;
    private String chuKyBatDau;
    private String chuKyKetThuc;
    private int soBuoiDay;
    private double luongDuTinh;
    private String trangThai;
    private double thuongPhat;

    public TeacherSalary(int idGiaoVien, int idLopHoc, String chuKyBatDau, String chuKyKetThuc, int soBuoiDay, 
                         double luongDuTinh, String trangThai, double thuongPhat) {
        this.idGiaoVien = idGiaoVien;
        this.idLopHoc = idLopHoc;
        this.chuKyBatDau = chuKyBatDau;
        this.chuKyKetThuc = chuKyKetThuc;
        this.soBuoiDay = soBuoiDay;
        this.luongDuTinh = luongDuTinh;
        this.trangThai = trangThai;
        this.thuongPhat = thuongPhat;
    }

    // Getters and setters
    public int getIdGiaoVien() {
        return idGiaoVien;
    }

    public void setIdGiaoVien(int idGiaoVien) {
        this.idGiaoVien = idGiaoVien;
    }

    public int getIdLopHoc() {
        return idLopHoc;
    }

    public void setIdLopHoc(int idLopHoc) {
        this.idLopHoc = idLopHoc;
    }

    public String getChuKyBatDau() {
        return chuKyBatDau;
    }

    public void setChuKyBatDau(String chuKyBatDau) {
        this.chuKyBatDau = chuKyBatDau;
    }

    public String getChuKyKetThuc() {
        return chuKyKetThuc;
    }

    public void setChuKyKetThuc(String chuKyKetThuc) {
        this.chuKyKetThuc = chuKyKetThuc;
    }

    public int getSoBuoiDay() {
        return soBuoiDay;
    }

    public void setSoBuoiDay(int soBuoiDay) {
        this.soBuoiDay = soBuoiDay;
    }

    public double getLuongDuTinh() {
        return luongDuTinh;
    }

    public void setLuongDuTinh(double luongDuTinh) {
        this.luongDuTinh = luongDuTinh;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public double getThuongPhat() {
        return thuongPhat;
    }

    public void setThuongPhat(double thuongPhat) {
        this.thuongPhat = thuongPhat;
    }
}

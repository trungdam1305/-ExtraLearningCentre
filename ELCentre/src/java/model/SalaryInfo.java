/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vuh26
 */
public class SalaryInfo {

    private int idGiaoVien;
    private int idLopHoc;
    private String tenLopHoc;
    private int soBuoiDay;
    private int siSo;
    private double hocPhi;
    private double luongDuTinh;
    private int idLuong;          // ID của bản ghi lương từ LuongGiaoVien
    private String chuKyBatDau;   // Chu kỳ bắt đầu
    private String chuKyKetThuc;  // Chu kỳ kết thúc
    private double thuongPhat;    // Thưởng/Phạt

    public SalaryInfo(int idGiaoVien, int idLopHoc, String tenLopHoc, int soBuoiDay, int siSo, double hocPhi, double luongDuTinh) {
        this.idGiaoVien = idGiaoVien;
        this.idLopHoc = idLopHoc;
        this.tenLopHoc = tenLopHoc;
        this.soBuoiDay = soBuoiDay;
        this.siSo = siSo;
        this.hocPhi = hocPhi;
        this.luongDuTinh = luongDuTinh;
        this.idLuong = -1;           // Giá trị mặc định nếu chưa có
        this.chuKyBatDau = null;
        this.chuKyKetThuc = null;
        this.thuongPhat = 0.0;       // Giá trị mặc định
    }

    // Getters và Setters hiện tại
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

    public String getTenLopHoc() {
        return tenLopHoc;
    }

    public void setTenLopHoc(String tenLopHoc) {
        this.tenLopHoc = tenLopHoc;
    }

    public int getSoBuoiDay() {
        return soBuoiDay;
    }

    public void setSoBuoiDay(int soBuoiDay) {
        this.soBuoiDay = soBuoiDay;
    }

    public int getSiSo() {
        return siSo;
    }

    public void setSiSo(int siSo) {
        this.siSo = siSo;
    }

    public double getHocPhi() {
        return hocPhi;
    }

    public void setHocPhi(double hocPhi) {
        this.hocPhi = hocPhi;
    }

    public double getLuongDuTinh() {
        return luongDuTinh;
    }

    public void setLuongDuTinh(double luongDuTinh) {
        this.luongDuTinh = luongDuTinh;
    }

    // Getters và Setters mới
    public int getIdLuong() {
        return idLuong;
    }

    public SalaryInfo setIdLuong(int idLuong) {
        this.idLuong = idLuong;
        return this;
    }

    public String getChuKyBatDau() {
        return chuKyBatDau;
    }

    public SalaryInfo setChuKyBatDau(String chuKyBatDau) {
        this.chuKyBatDau = chuKyBatDau;
        return this;
    }

    public String getChuKyKetThuc() {
        return chuKyKetThuc;
    }

    public SalaryInfo setChuKyKetThuc(String chuKyKetThuc) {
        this.chuKyKetThuc = chuKyKetThuc;
        return this;
    }

    public double getThuongPhat() {
        return thuongPhat;
    }

    public SalaryInfo setThuongPhat(double thuongPhat) {
        this.thuongPhat = thuongPhat;
        return this;
    }
}
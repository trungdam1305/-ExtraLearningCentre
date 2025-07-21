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

    public int idGiaoVien;
    public int idLopHoc;
    public String tenLopHoc;
    public int soBuoiDay;
    public int siSo;
    public double hocPhi;
    public double luongDuTinh;

    public SalaryInfo(int idGiaoVien, int idLopHoc, String tenLopHoc, int soBuoiDay, int siSo, double hocPhi, double luongDuTinh) {
        this.idGiaoVien = idGiaoVien;
        this.idLopHoc = idLopHoc;
        this.tenLopHoc = tenLopHoc;
        this.soBuoiDay = soBuoiDay;
        this.siSo = siSo;
        this.hocPhi = hocPhi;
        this.luongDuTinh = luongDuTinh;
    }

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
    
    
}

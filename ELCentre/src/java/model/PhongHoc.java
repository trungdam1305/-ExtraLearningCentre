/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vuh26
 */
public class PhongHoc {
    private int ID_PhongHoc;
    private String TenPhongHoc;
    private int SucChua;
    private String TrangThai;

    public PhongHoc() {
    }

    public PhongHoc(int ID_PhongHoc, String TenPhongHoc, int SucChua, String TrangThai) {
        this.ID_PhongHoc = ID_PhongHoc;
        this.TenPhongHoc = TenPhongHoc;
        this.SucChua = SucChua;
        this.TrangThai = TrangThai;
    }

    public int getID_PhongHoc() {
        return ID_PhongHoc;
    }

    public void setID_PhongHoc(int ID_PhongHoc) {
        this.ID_PhongHoc = ID_PhongHoc;
    }

    public String getTenPhongHoc() {
        return TenPhongHoc;
    }

    public void setTenPhongHoc(String TenPhongHoc) {
        this.TenPhongHoc = TenPhongHoc;
    }

    public int getSucChua() {
        return SucChua;
    }

    public void setSucChua(int SucChua) {
        this.SucChua = SucChua;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }
    
    
}

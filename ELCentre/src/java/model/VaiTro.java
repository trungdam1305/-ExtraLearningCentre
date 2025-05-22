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
public class VaiTro {
    private int ID_VaiTro;
    private String TenVaiTro;
    private String MieuTa;
    private String TrangThai;
    private Date NgayTao;

    public VaiTro() {
    }

    public VaiTro(int ID_VaiTro, String TenVaiTro, String MieuTa, String TrangThai, Date NgayTao) {
        this.ID_VaiTro = ID_VaiTro;
        this.TenVaiTro = TenVaiTro;
        this.MieuTa = MieuTa;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_VaiTro() {
        return ID_VaiTro;
    }

    public void setID_VaiTro(int ID_VaiTro) {
        this.ID_VaiTro = ID_VaiTro;
    }

    public String getTenVaiTro() {
        return TenVaiTro;
    }

    public void setTenVaiTro(String TenVaiTro) {
        this.TenVaiTro = TenVaiTro;
    }

    public String getMieuTa() {
        return MieuTa;
    }

    public void setMieuTa(String MieuTa) {
        this.MieuTa = MieuTa;
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

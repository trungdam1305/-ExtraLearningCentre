/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author wrx_Chur04
 */
public class TruongHoc {
    private Integer ID_TruongHoc ; 
    private String TenTruongHoc ; 
    private String DiaChi ; 

    public TruongHoc() {
    }

    public TruongHoc(Integer ID_TruongHoc, String TenTruongHoc, String DiaChi) {
        this.ID_TruongHoc = ID_TruongHoc;
        this.TenTruongHoc = TenTruongHoc;
        this.DiaChi = DiaChi;
    }

    public Integer getID_TruongHoc() {
        return ID_TruongHoc;
    }

    public String getTenTruongHoc() {
        return TenTruongHoc;
    }

    public String getDiaChi() {
        return DiaChi;
    }
    public void setID_TruongHoc(Integer ID_TruongHoc) {
        this.ID_TruongHoc = ID_TruongHoc;
    }

    public void setTenTruongHoc(String TenTruongHoc) {
        this.TenTruongHoc = TenTruongHoc;
    }

    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
    }
}

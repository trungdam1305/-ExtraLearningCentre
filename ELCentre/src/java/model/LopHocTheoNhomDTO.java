/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class LopHocTheoNhomDTO {
    private int idKhoi;
    private String tenKhoi;
    private String nhomMonHoc; // Toán, Văn, Khác
            private int tongSoLopHoc;

    // Constructor
    public LopHocTheoNhomDTO(int idKhoi, String tenKhoi, String nhomMonHoc, int tongSoLopHoc) {
        this.idKhoi = idKhoi;
        this.tenKhoi = tenKhoi;
        this.nhomMonHoc = nhomMonHoc;
        this.tongSoLopHoc = tongSoLopHoc;
    }

    // Getters và setters
        public int getIdKhoi() { return idKhoi; }
    public void setIdKhoi(int idKhoi) { this.idKhoi = idKhoi; }

    public String getTenKhoi() { return tenKhoi; }
    public void setTenKhoi(String tenKhoi) { this.tenKhoi = tenKhoi; }

    public String getNhomMonHoc() { return nhomMonHoc; }
    public void setNhomMonHoc(String nhomMonHoc) { this.nhomMonHoc = nhomMonHoc; }

    public int getTongSoLopHoc() { return tongSoLopHoc; }
    public void setTongSoLopHoc(int tongSoLopHoc) { this.tongSoLopHoc = tongSoLopHoc; }
}

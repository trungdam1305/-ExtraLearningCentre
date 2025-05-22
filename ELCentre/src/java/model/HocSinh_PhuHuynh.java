/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author wrx_Chur04
 */
public class HocSinh_PhuHuynh {
    private int idHocSinh;
    private int idPhuHuynh;

    public HocSinh_PhuHuynh() {
    }

    public HocSinh_PhuHuynh(int idHocSinh, int idPhuHuynh) {
        this.idHocSinh = idHocSinh;
        this.idPhuHuynh = idPhuHuynh;
    }

    public int getIdHocSinh() {
        return idHocSinh;
    }

    public void setIdHocSinh(int idHocSinh) {
        this.idHocSinh = idHocSinh;
    }

    public int getIdPhuHuynh() {
        return idPhuHuynh;
    }

    public void setIdPhuHuynh(int idPhuHuynh) {
        this.idPhuHuynh = idPhuHuynh;
    }

    @Override
    public String toString() {
        return "HocSinh_PhuHuynh{" +
                "idHocSinh=" + idHocSinh +
                ", idPhuHuynh=" + idPhuHuynh +
                '}';
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author wrx_Chur04
 */
public class UserLogView {
         private int ID_TaiKhoan;
    private String HoTen;
    private String HanhDong;
    private LocalDateTime ThoiGian;

    public UserLogView() {
    }

    public UserLogView(int ID_TaiKhoan, String HoTen, String HanhDong, LocalDateTime ThoiGian) {
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.HanhDong = HanhDong;
        this.ThoiGian = ThoiGian;
    }

    public int getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getHanhDong() {
        return HanhDong;
    }

    public LocalDateTime getThoiGian() {
        return ThoiGian;
    }

    public void setID_TaiKhoan(int ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setHanhDong(String HanhDong) {
        this.HanhDong = HanhDong;
    }

    public void setThoiGian(LocalDateTime ThoiGian) {
        this.ThoiGian = ThoiGian;
    }

    
    
    
    

}

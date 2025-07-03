/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author wrx_Chur04
 */
public class Admin {
    private Integer ID_Admin ; 
    private Integer ID_TaiKhoan ;
    private String HoTen ; 
    private String Avatar ; 

    public Admin() {
    }

    public Admin(Integer ID_Admin, Integer ID_TaiKhoan, String HoTen, String Avatar) {
        this.ID_Admin = ID_Admin;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.Avatar = Avatar;
    }

    public Integer getID_Admin() {
        return ID_Admin;
    }

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getAvatar() {
        return Avatar;
    }

    public void setID_Admin(Integer ID_Admin) {
        this.ID_Admin = ID_Admin;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }
    
    
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author wrx_Chur04
 */
public class Staff {
    private Integer  ID_Staff ; 
    private Integer ID_TaiKhoan ; 
    private String HoTen ; 
    private String Avatar ; 

    public Staff() {
    }

    public Staff(Integer ID_Staff, Integer ID_TaiKhoan, String HoTen, String Avatar) {
        this.ID_Staff = ID_Staff;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.Avatar = Avatar;
    }

    public Integer getID_Staff() {
        return ID_Staff;
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

    public void setID_Staff(Integer ID_Staff) {
        this.ID_Staff = ID_Staff;
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

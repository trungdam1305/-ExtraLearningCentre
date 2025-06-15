/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vuh26
 */
public class MonHoc {
    private int id;
    private String tenMonHoc;

    public MonHoc() {
    }

    public MonHoc(int id, String tenMonHoc) {
        this.id = id;
        this.tenMonHoc = tenMonHoc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTenMonHoc() {
        return tenMonHoc;
    }

    public void setTenMonHoc(String tenMonHoc) {
        this.tenMonHoc = tenMonHoc;
    }
    
    
}

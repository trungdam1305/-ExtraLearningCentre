/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class SlotHoc {
    private int ID_SlotHoc;
    private String SlotThoiGian;

    public SlotHoc(int ID_SlotHoc, String SlotThoiGian) {
        this.ID_SlotHoc = ID_SlotHoc;
        this.SlotThoiGian = SlotThoiGian;
    }

    public SlotHoc() {
    }

    public int getID_SlotHoc() {
        return ID_SlotHoc;
    }

    public void setID_SlotHoc(int ID_SlotHoc) {
        this.ID_SlotHoc = ID_SlotHoc;
    }

    public String getSlotThoiGian() {
        return SlotThoiGian;
    }

    public void setSlotThoiGian(String SlotThoiGian) {
        this.SlotThoiGian = SlotThoiGian;
    }
    
    
}

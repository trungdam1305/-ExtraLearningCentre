package model;

/**
 * Represents the relationship between a student and a parent.
 * Used to associate a student with their guardian or parent in the system.
 * 
 * Author: trungdam1305
 */
public class HocSinh_PhuHuynh {

    /** The ID of the student */
    private Integer ID_HocSinh;

    /** The ID of the parent or guardian */
    private Integer ID_PhuHuynh;

    // Getter and Setter methods

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public Integer getID_PhuHuynh() {
        return ID_PhuHuynh;
    }

    public void setID_PhuHuynh(Integer ID_PhuHuynh) {
        this.ID_PhuHuynh = ID_PhuHuynh;
    }
}

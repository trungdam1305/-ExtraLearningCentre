package model;

/**
 * Represents the association between a teacher and a class.
 * This model links a teacher (GiaoVien) to the class (LopHoc) they are assigned to.
 * 
 * Author: trungdam1305
 */
public class GiaoVien_LopHoc {

    // ID of the teacher assigned to the class
    private Integer ID_GiaoVien;

    // ID of the class assigned to the teacher
    private Integer ID_LopHoc;

    // Getter and setter methods

    public GiaoVien_LopHoc() {
    }

    public GiaoVien_LopHoc(Integer ID_GiaoVien, Integer ID_LopHoc) {
        this.ID_GiaoVien = ID_GiaoVien;
        this.ID_LopHoc = ID_LopHoc;
    }
    
    

    public Integer getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public void setID_GiaoVien(Integer ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }
}

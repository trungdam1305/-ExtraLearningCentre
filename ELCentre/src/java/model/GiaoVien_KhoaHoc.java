package model;

/**
 * Represents the association between a teacher and a course.
 * This is a join model that links teachers to the courses they teach.
 * 
 * Author: trungdam1305
 */
public class GiaoVien_KhoaHoc {

    // ID of the teacher
    private int ID_GiaoVien;

    // ID of the course the teacher is assigned to
    private int ID_KhoaHoc;

    /**
     * Default constructor
     */
    public GiaoVien_KhoaHoc() {}

    /**
     * Constructor to initialize both teacher ID and course ID
     */
    public GiaoVien_KhoaHoc(int ID_GiaoVien, int ID_KhoaHoc) {
        this.ID_GiaoVien = ID_GiaoVien;
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    // Getter and setter methods

    public int getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public void setID_GiaoVien(int ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public int getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public void setID_KhoaHoc(int ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }
}

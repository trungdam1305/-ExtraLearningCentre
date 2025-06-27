package model;

import java.time.LocalDate;

/**
 * Represents a course registration made by a student.
 * It includes the student's ID, course ID, date of registration, 
 * and the tuition payment status.
 * 
 * Author: trungdam1305
 */
public class DangKyKhoaHoc {

    // ID of the student who registered
    private int ID_HocSinh;

    // ID of the registered course
    private int ID_KhoaHoc;

    // Date when the registration was made
    private LocalDate NgayDangKy;

    // Tuition fee status (e.g. Paid, Unpaid, Pending)
    private String TinhTrangHocPhi;

    /**
     * Default constructor
     */
    public DangKyKhoaHoc() {}

    /**
     * Constructor to initialize all fields
     */
    public DangKyKhoaHoc(int ID_HocSinh, int ID_KhoaHoc, LocalDate NgayDangKy, String TinhTrangHocPhi) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.NgayDangKy = NgayDangKy;
        this.TinhTrangHocPhi = TinhTrangHocPhi;
    }

    // Getter and setter methods

    public int getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(int ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public int getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public void setID_KhoaHoc(int ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public LocalDate getNgayDangKy() {
        return NgayDangKy;
    }

    public void setNgayDangKy(LocalDate NgayDangKy) {
        this.NgayDangKy = NgayDangKy;
    }

    public String getTinhTrangHocPhi() {
        return TinhTrangHocPhi;
    }

    public void setTinhTrangHocPhi(String TinhTrangHocPhi) {
        this.TinhTrangHocPhi = TinhTrangHocPhi;
    }
}

package model;

import java.time.LocalDate;

/**
 * Represents a student's registration for a class.
 * Includes the student's ID, class ID, registration date,
 * and tuition payment status.
 * 
 * Author: trungdam1305
 */
public class DangKyLopHoc {

    // ID of the student who registered
    private Integer ID_HocSinh;

    // ID of the class the student registered for
    private Integer ID_LopHoc;

    // Date the student registered for the class
    private LocalDate NgayDangKy;

    // Status of tuition payment (e.g. Paid, Unpaid, Pending)
    private String TinhTrangHocPhi;

    // Getter and setter methods

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
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

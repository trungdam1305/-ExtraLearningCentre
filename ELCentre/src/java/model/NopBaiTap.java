package model;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * NopBaiTap represents a student's assignment submission.
 * It includes information about the student, the assignment,
 * the submission file, date, grade, and teacher's feedback.
 * 
 * Fields:
 * - ID_HocSinh: ID of the student who submitted the assignment
 * - ID_BaiTap: ID of the assignment
 * - TepNop: File path or name of the submitted file
 * - NgayNop: Submission date
 * - Diem: Grade (score) received for the submission
 * - NhanXet: Teacher's feedback or comment
 */
public class NopBaiTap {

    private Integer ID_HocSinh;    // Student ID
    private Integer ID_BaiTap;     // Assignment ID
    private String TepNop;         // Submitted file name or path
    private LocalDate NgayNop;     // Submission date
    private BigDecimal Diem;       // Grade/score
    private String NhanXet;        // Feedback/comment from teacher
    private int ID_LopHoc;
    // Getter and Setter for ID_HocSinh
    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    // Getter and Setter for ID_BaiTap
    public Integer getID_BaiTap() {
        return ID_BaiTap;
    }

    public void setID_BaiTap(Integer ID_BaiTap) {
        this.ID_BaiTap = ID_BaiTap;
    }

    // Getter and Setter for TepNop
    public String getTepNop() {
        return TepNop;
    }

    public void setTepNop(String TepNop) {
        this.TepNop = TepNop;
    }

    // Getter and Setter for NgayNop
    public LocalDate getNgayNop() {
        return NgayNop;
    }

    public void setNgayNop(LocalDate NgayNop) {
        this.NgayNop = NgayNop;
    }

    // Getter and Setter for Diem
    public BigDecimal getDiem() {
        return Diem;
    }

    public void setDiem(BigDecimal Diem) {
        this.Diem = Diem;
    }

    // Getter and Setter for NhanXet
    public String getNhanXet() {
        return NhanXet;
    }

    public void setNhanXet(String NhanXet) {
        this.NhanXet = NhanXet;
    }

    public int getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(int ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public NopBaiTap(Integer ID_HocSinh, Integer ID_BaiTap, String TepNop, LocalDate NgayNop, BigDecimal Diem, String NhanXet, int ID_LopHoc) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_BaiTap = ID_BaiTap;
        this.TepNop = TepNop;
        this.NgayNop = NgayNop;
        this.Diem = Diem;
        this.NhanXet = NhanXet;
        this.ID_LopHoc = ID_LopHoc;
    }

    public NopBaiTap() {
    }
    
    
}

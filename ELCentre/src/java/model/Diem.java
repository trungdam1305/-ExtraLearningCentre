package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Represents a student's score record for a specific class.
 * It includes scores for different assessment components such as tests,
 * assignments, midterms, and finals, along with the last updated time.
 * 
 * Author: trungdam1305
 */
public class Diem {

    // Unique identifier for the score record
    private Integer ID_Diem;

    // ID of the student this score belongs to
    private Integer ID_HocSinh;

    // ID of the class this score is associated with
    private Integer ID_LopHoc;

    // Score for tests or quizzes
    private BigDecimal DiemKiemTra;

    // Score for homework or assignments
    private BigDecimal DiemBaiTap;

    // Score for the midterm exam
    private BigDecimal DiemGiuaKy;

    // Score for the final exam
    private BigDecimal DiemCuoiKy;

    // Timestamp of the last score update
    private LocalDateTime ThoiGianCapNhat;

    // Getter and setter methods

    public Integer getID_Diem() {
        return ID_Diem;
    }

    public void setID_Diem(Integer ID_Diem) {
        this.ID_Diem = ID_Diem;
    }

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

    public BigDecimal getDiemKiemTra() {
        return DiemKiemTra;
    }

    public void setDiemKiemTra(BigDecimal DiemKiemTra) {
        this.DiemKiemTra = DiemKiemTra;
    }

    public BigDecimal getDiemBaiTap() {
        return DiemBaiTap;
    }

    public void setDiemBaiTap(BigDecimal DiemBaiTap) {
        this.DiemBaiTap = DiemBaiTap;
    }

    public BigDecimal getDiemGiuaKy() {
        return DiemGiuaKy;
    }

    public void setDiemGiuaKy(BigDecimal DiemGiuaKy) {
        this.DiemGiuaKy = DiemGiuaKy;
    }

    public BigDecimal getDiemCuoiKy() {
        return DiemCuoiKy;
    }

    public void setDiemCuoiKy(BigDecimal DiemCuoiKy) {
        this.DiemCuoiKy = DiemCuoiKy;
    }

    public LocalDateTime getThoiGianCapNhat() {
        return ThoiGianCapNhat;
    }

    public void setThoiGianCapNhat(LocalDateTime ThoiGianCapNhat) {
        this.ThoiGianCapNhat = ThoiGianCapNhat;
    }
}

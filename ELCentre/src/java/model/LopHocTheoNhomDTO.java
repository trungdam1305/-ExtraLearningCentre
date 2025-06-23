package model;

/**
 * LopHocTheoNhomDTO is a Data Transfer Object (DTO) used to group class information
 * by grade level (Khoi) and subject group (e.g., Math, Literature, Others).
 * It is typically used for statistics, reporting, or dashboard summaries.
 *
 * Fields:
 * - idKhoi: ID of the grade level.
 * - tenKhoi: Name of the grade level.
 * - nhomMonHoc: Subject group (e.g., "Toán", "Văn", or "Khác").
 * - tongSoLopHoc: Total number of classes in the group.
 * 
 * Author: admin
 */
public class LopHocTheoNhomDTO {
    
    private int idKhoi;                // Grade level ID
    private String tenKhoi;           // Grade level name
    private String nhomMonHoc;        // Subject group name (Math, Literature, Others)
    private int tongSoLopHoc;         // Total number of classes in this group

    /**
     * Constructor to initialize all fields.
     * 
     * @param idKhoi ID of the grade level
     * @param tenKhoi Name of the grade level
     * @param nhomMonHoc Subject group name (e.g., Math)
     * @param tongSoLopHoc Total number of classes
     */
    public LopHocTheoNhomDTO(int idKhoi, String tenKhoi, String nhomMonHoc, int tongSoLopHoc) {
        this.idKhoi = idKhoi;
        this.tenKhoi = tenKhoi;
        this.nhomMonHoc = nhomMonHoc;
        this.tongSoLopHoc = tongSoLopHoc;
    }

    // --- Getters and Setters ---

    public int getIdKhoi() {
        return idKhoi;
    }

    public void setIdKhoi(int idKhoi) {
        this.idKhoi = idKhoi;
    }

    public String getTenKhoi() {
        return tenKhoi;
    }

    public void setTenKhoi(String tenKhoi) {
        this.tenKhoi = tenKhoi;
    }

    public String getNhomMonHoc() {
        return nhomMonHoc;
    }

    public void setNhomMonHoc(String nhomMonHoc) {
        this.nhomMonHoc = nhomMonHoc;
    }

    public int getTongSoLopHoc() {
        return tongSoLopHoc;
    }

    public void setTongSoLopHoc(int tongSoLopHoc) {
        this.tongSoLopHoc = tongSoLopHoc;
    }
}

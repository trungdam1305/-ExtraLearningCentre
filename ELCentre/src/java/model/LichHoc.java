package model;

import java.time.LocalDate;

public class LichHoc {
    private Integer idSchedule;
    private LocalDate ngayHoc;
    private Integer idSlotHoc;
    private Integer idLopHoc;
    private String ghiChu;
    private String slotThoiGian; // Lấy từ bảng SlotHoc

    // Constructor mặc định
    public LichHoc() {
    }

    // Constructor đầy đủ
    public LichHoc(Integer idSchedule, LocalDate ngayHoc, Integer idSlotHoc, Integer idLopHoc, String ghiChu) {
        this.idSchedule = idSchedule;
        this.ngayHoc = ngayHoc;
        this.idSlotHoc = idSlotHoc;
        this.idLopHoc = idLopHoc;
        this.ghiChu = ghiChu;
    }

    // Getters và Setters
    public Integer getIdSchedule() {
        return idSchedule;
    }

    public void setIdSchedule(Integer idSchedule) {
        this.idSchedule = idSchedule;
    }

    public LocalDate getNgayHoc() {
        return ngayHoc;
    }

    public void setNgayHoc(LocalDate ngayHoc) {
        this.ngayHoc = ngayHoc;
    }

    public Integer getIdSlotHoc() {
        return idSlotHoc;
    }

    public void setIdSlotHoc(Integer idSlotHoc) {
        this.idSlotHoc = idSlotHoc;
    }

    public Integer getIdLopHoc() {
        return idLopHoc;
    }

    public void setIdLopHoc(Integer idLopHoc) {
        this.idLopHoc = idLopHoc;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public String getSlotThoiGian() {
        return slotThoiGian;
    }

    public void setSlotThoiGian(String slotThoiGian) {
        this.slotThoiGian = slotThoiGian;
    }

    @Override
    public String toString() {
        return "LichHoc{" +
                "idSchedule=" + idSchedule +
                ", ngayHoc=" + ngayHoc +
                ", idSlotHoc=" + idSlotHoc +
                ", idLopHoc=" + idLopHoc +
                ", ghiChu='" + ghiChu + '\'' +
                ", slotThoiGian='" + slotThoiGian + '\'' +
                '}';
    }
}
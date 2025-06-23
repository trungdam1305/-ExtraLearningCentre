package model;

import java.time.LocalDate;

/**
 * The LichHoc class represents a schedule entry for a class session.
 * It stores information about the class date, time slot, associated class,
 * additional notes, and display-related values such as time range and class name.
 * 
 * Fields:
 * - ID_Schedule: Unique identifier of the schedule.
 * - NgayHoc: The date when the lesson occurs.
 * - ID_SlotHoc: The ID of the associated time slot (e.g., 1st period, 2nd period).
 * - ID_LopHoc: The ID of the class (group of students).
 * - GhiChu: Notes or remarks related to this session.
 * - SlotThoiGian: The human-readable time range (e.g., "07:00 - 08:30").
 * - TenLopHoc: Name of the class.
 * 
 * Author: Quang Trung Đàm
 */
public class LichHoc {

    // Unique ID for the schedule
    private int ID_Schedule;

    // Date of the lesson
    private LocalDate NgayHoc;

    // Slot ID indicating the time slot of the lesson
    private int ID_SlotHoc;

    // ID of the class this schedule belongs to
    private int ID_LopHoc;

    // Additional notes for the lesson
    private String GhiChu;

    // Text representing the time slot (e.g., "07:00 - 08:30")
    private String SlotThoiGian;

    // Class name associated with the lesson
    private String TenLopHoc;

    /**
     * Default constructor.
     */
    public LichHoc() {
    }

    /**
     * Constructor with full parameters including time slot text and class name.
     */
    public LichHoc(int ID_Schedule, LocalDate NgayHoc, int ID_SlotHoc, int ID_LopHoc, String GhiChu, String SlotThoiGian, String TenLopHoc) {
        this.ID_Schedule = ID_Schedule;
        this.NgayHoc = NgayHoc;
        this.ID_SlotHoc = ID_SlotHoc;
        this.ID_LopHoc = ID_LopHoc;
        this.GhiChu = GhiChu;
        this.SlotThoiGian = SlotThoiGian;
        this.TenLopHoc = TenLopHoc;
    }

    /**
     * Constructor with parameters excluding class name.
     */
    public LichHoc(int ID_Schedule, LocalDate NgayHoc, int ID_SlotHoc, int ID_LopHoc, String GhiChu, String SlotThoiGian) {
        this.ID_Schedule = ID_Schedule;
        this.NgayHoc = NgayHoc;
        this.ID_SlotHoc = ID_SlotHoc;
        this.ID_LopHoc = ID_LopHoc;
        this.GhiChu = GhiChu;
        this.SlotThoiGian = SlotThoiGian;
    }

    /**
     * Constructor with only essential scheduling fields.
     */
    public LichHoc(int ID_Schedule, LocalDate NgayHoc, int ID_SlotHoc, int ID_LopHoc, String GhiChu) {
        this.ID_Schedule = ID_Schedule;
        this.NgayHoc = NgayHoc;
        this.ID_SlotHoc = ID_SlotHoc;
        this.ID_LopHoc = ID_LopHoc;
        this.GhiChu = GhiChu;
    }

    // --- Getters and Setters ---

    public int getID_Schedule() {
        return ID_Schedule;
    }

    public void setID_Schedule(int ID_Schedule) {
        this.ID_Schedule = ID_Schedule;
    }

    public LocalDate getNgayHoc() {
        return NgayHoc;
    }

    public void setNgayHoc(LocalDate NgayHoc) {
        this.NgayHoc = NgayHoc;
    }

    public int getID_SlotHoc() {
        return ID_SlotHoc;
    }

    public void setID_SlotHoc(int ID_SlotHoc) {
        this.ID_SlotHoc = ID_SlotHoc;
    }

    public int getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(int ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public String getSlotThoiGian() {
        return SlotThoiGian;
    }

    public void setSlotThoiGian(String SlotThoiGian) {
        this.SlotThoiGian = SlotThoiGian;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public void setTenLopHoc(String TenLopHoc) {
        this.TenLopHoc = TenLopHoc;
    }
}

package model;

/**
 * Represents an attendance record for a student.
 * Includes student ID, schedule ID, attendance status,
 * and an optional reason for absence.
 * 
 * Author: trungdam1305
 */
public class DiemDanh {

    // Unique identifier for the attendance record
    private Integer ID_DiemDanh;

    // ID of the student being marked
    private Integer ID_HocSinh;

    // ID of the schedule (class session) this record belongs to
    private Integer ID_Schedule;

    // Attendance status (e.g., Present, Absent, Late)
    private String TrangThai;

    // Reason for absence (if applicable)
    private String LyDoVang;

    private String HoTen;
    
    private String Avatar;

    public DiemDanh() {
    }

    public DiemDanh(Integer ID_DiemDanh, Integer ID_HocSinh, Integer ID_Schedule, String TrangThai, String LyDoVang) {
        this.ID_DiemDanh = ID_DiemDanh;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_Schedule = ID_Schedule;
        this.TrangThai = TrangThai;
        this.LyDoVang = LyDoVang;
    }
    
    

    // Getter and setter methods

    public Integer getID_DiemDanh() {
        return ID_DiemDanh;
    }

    public void setID_DiemDanh(Integer ID_DiemDanh) {
        this.ID_DiemDanh = ID_DiemDanh;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public Integer getID_Schedule() {
        return ID_Schedule;
    }

    public void setID_Schedule(Integer ID_Schedule) {
        this.ID_Schedule = ID_Schedule;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public String getLyDoVang() {
        return LyDoVang;
    }

    public void setLyDoVang(String LyDoVang) {
        this.LyDoVang = LyDoVang;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public String getHoTen() {
        return HoTen;
    }

    public DiemDanh(Integer ID_DiemDanh, Integer ID_HocSinh, Integer ID_Schedule, String TrangThai, String LyDoVang, String HoTen, String Avatar) {
        this.ID_DiemDanh = ID_DiemDanh;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_Schedule = ID_Schedule;
        this.TrangThai = TrangThai;
        this.LyDoVang = LyDoVang;
        this.HoTen = HoTen;
        this.Avatar = Avatar;
    }

    public String getAvatar() {
        return Avatar;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }

}

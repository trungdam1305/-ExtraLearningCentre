package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

// 19. LichHoc.java
public class LichHoc {
    private int ID_Schedule;
    private int ID_KhoaHoc;
    private LocalDate NgayHoc;
    private String GioHoc;
    private String GhiChu;

    public LichHoc() {}

    public LichHoc(int ID_Schedule, int ID_KhoaHoc, LocalDate NgayHoc, String GioHoc, String GhiChu) {
        this.ID_Schedule = ID_Schedule;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.NgayHoc = NgayHoc;
        this.GioHoc = GioHoc;
        this.GhiChu = GhiChu;
    }

    public int getID_Schedule() { return ID_Schedule; }
    public void setID_Schedule(int ID_Schedule) { this.ID_Schedule = ID_Schedule; }
    public int getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(int ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }
    public LocalDate getNgayHoc() { return NgayHoc; }
    public void setNgayHoc(LocalDate NgayHoc) { this.NgayHoc = NgayHoc; }
    public String getGioHoc() { return GioHoc; }
    public void setGioHoc(String GioHoc) { this.GioHoc = GioHoc; }
    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }
}

package model;

import java.time.LocalDate;

public class LichHoc {
    private Integer ID_Schedule;
    private LocalDate NgayHoc;
    private String GioHoc;
    private Integer ID_LopHoc;
    private String GhiChu;

    public Integer getID_Schedule() { return ID_Schedule; }
    public void setID_Schedule(Integer ID_Schedule) { this.ID_Schedule = ID_Schedule; }

    public LocalDate getNgayHoc() { return NgayHoc; }
    public void setNgayHoc(LocalDate NgayHoc) { this.NgayHoc = NgayHoc; }

    public String getGioHoc() { return GioHoc; }
    public void setGioHoc(String GioHoc) { this.GioHoc = GioHoc; }

    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }
}

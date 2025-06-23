package model;

public class DiemDanh {
     private Integer ID_DiemDanh;
    private Integer ID_HocSinh;
    private Integer ID_Schedule;
    private String TrangThai;   
    private String LyDoVang;

    public Integer getID_DiemDanh() { return ID_DiemDanh; }
    public void setID_DiemDanh(Integer ID_DiemDanh) { this.ID_DiemDanh = ID_DiemDanh; }

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_Schedule() { return ID_Schedule; }
    public void setID_Schedule(Integer ID_Schedule) { this.ID_Schedule = ID_Schedule; }

    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }

    public String getLyDoVang() { return LyDoVang; }
    public void setLyDoVang(String LyDoVang) { this.LyDoVang = LyDoVang; }
}

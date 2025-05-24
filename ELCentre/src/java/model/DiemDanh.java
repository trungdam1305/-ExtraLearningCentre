package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

// 16. DiemDanh.java
public class DiemDanh {
    private int ID_DiemDanh;
    private int ID_HocSinh;
    private int ID_LopHoc;
    private LocalDate NgayHoc;
    private String TrangThai;
    private String LyDoVang;

    public DiemDanh() {}

    public DiemDanh(int ID_DiemDanh, int ID_HocSinh, int ID_LopHoc, LocalDate NgayHoc, String TrangThai, String LyDoVang) {
        this.ID_DiemDanh = ID_DiemDanh;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_LopHoc = ID_LopHoc;
        this.NgayHoc = NgayHoc;
        this.TrangThai = TrangThai;
        this.LyDoVang = LyDoVang;
    }

    public int getID_DiemDanh() { return ID_DiemDanh; }
    public void setID_DiemDanh(int ID_DiemDanh) { this.ID_DiemDanh = ID_DiemDanh; }
    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public int getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(int ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }
    public LocalDate getNgayHoc() { return NgayHoc; }
    public void setNgayHoc(LocalDate NgayHoc) { this.NgayHoc = NgayHoc; }
    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }
    public String getLyDoVang() { return LyDoVang; }
    public void setLyDoVang(String LyDoVang) { this.LyDoVang = LyDoVang; }
}

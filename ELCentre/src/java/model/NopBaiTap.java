package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

// 15. NopBaiTap.java
public class NopBaiTap {
    private int ID_HocSinh;
    private int ID_BaiTap;
    private String TepNop;
    private LocalDate NgayNop;
    private BigDecimal Diem;
    private String NhanXet;

    public NopBaiTap() {}

    public NopBaiTap(int ID_HocSinh, int ID_BaiTap, String TepNop, LocalDate NgayNop, BigDecimal Diem, String NhanXet) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_BaiTap = ID_BaiTap;
        this.TepNop = TepNop;
        this.NgayNop = NgayNop;
        this.Diem = Diem;
        this.NhanXet = NhanXet;
    }

    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public int getID_BaiTap() { return ID_BaiTap; }
    public void setID_BaiTap(int ID_BaiTap) { this.ID_BaiTap = ID_BaiTap; }
    public String getTepNop() { return TepNop; }
    public void setTepNop(String TepNop) { this.TepNop = TepNop; }
    public LocalDate getNgayNop() { return NgayNop; }
    public void setNgayNop(LocalDate NgayNop) { this.NgayNop = NgayNop; }
    public BigDecimal getDiem() { return Diem; }
    public void setDiem(BigDecimal Diem) { this.Diem = Diem; }
    public String getNhanXet() { return NhanXet; }
    public void setNhanXet(String NhanXet) { this.NhanXet = NhanXet; }
}

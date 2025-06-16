package model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class NopBaiTap {
            private Integer ID_HocSinh;
    private Integer ID_BaiTap;
    private String TepNop;
    private LocalDate NgayNop;
    private BigDecimal Diem;
    private String NhanXet;

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_BaiTap() { return ID_BaiTap; }
    public void setID_BaiTap(Integer ID_BaiTap) { this.ID_BaiTap = ID_BaiTap; }

    public String getTepNop() { return TepNop; }
    public void setTepNop(String TepNop) { this.TepNop = TepNop; }

    public LocalDate getNgayNop() { return NgayNop; }
    public void setNgayNop(LocalDate NgayNop) { this.NgayNop = NgayNop; }

    public BigDecimal getDiem() { return Diem; }
    public void setDiem(BigDecimal Diem) { this.Diem = Diem; }

    public String getNhanXet() { return NhanXet; }
    public void setNhanXet(String NhanXet) { this.NhanXet = NhanXet; }
}

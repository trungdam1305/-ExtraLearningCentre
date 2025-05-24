package model;

import java.math.BigDecimal;
import java.time.LocalDate;

// 12. HocPhi.java
public class HocPhi {
    private int ID_HocPhi;
    private int ID_HocSinh;
    private String Lop;
    private String MonHoc;
    private BigDecimal SoTien;
    private String PhuongThucThanhToan;
    private String TinhTrangThanhToan;
    private LocalDate NgayThanhToan;
    private String GhiChu;

    public HocPhi() {}

    public HocPhi(int ID_HocPhi, int ID_HocSinh, String Lop, String MonHoc, BigDecimal SoTien, String PhuongThucThanhToan,
                  String TinhTrangThanhToan, LocalDate NgayThanhToan, String GhiChu) {
        this.ID_HocPhi = ID_HocPhi;
        this.ID_HocSinh = ID_HocSinh;
        this.Lop = Lop;
        this.MonHoc = MonHoc;
        this.SoTien = SoTien;
        this.PhuongThucThanhToan = PhuongThucThanhToan;
        this.TinhTrangThanhToan = TinhTrangThanhToan;
        this.NgayThanhToan = NgayThanhToan;
        this.GhiChu = GhiChu;
    }

    public int getID_HocPhi() { return ID_HocPhi; }
    public void setID_HocPhi(int ID_HocPhi) { this.ID_HocPhi = ID_HocPhi; }
    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public String getLop() { return Lop; }
    public void setLop(String Lop) { this.Lop = Lop; }
    public String getMonHoc() { return MonHoc; }
    public void setMonHoc(String MonHoc) { this.MonHoc = MonHoc; }
    public BigDecimal getSoTien() { return SoTien; }
    public void setSoTien(BigDecimal SoTien) { this.SoTien = SoTien; }
    public String getPhuongThucThanhToan() { return PhuongThucThanhToan; }
    public void setPhuongThucThanhToan(String PhuongThucThanhToan) { this.PhuongThucThanhToan = PhuongThucThanhToan; }
    public String getTinhTrangThanhToan() { return TinhTrangThanhToan; }
    public void setTinhTrangThanhToan(String TinhTrangThanhToan) { this.TinhTrangThanhToan = TinhTrangThanhToan; }
    public LocalDate getNgayThanhToan() { return NgayThanhToan; }
    public void setNgayThanhToan(LocalDate NgayThanhToan) { this.NgayThanhToan = NgayThanhToan; }
    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }
}

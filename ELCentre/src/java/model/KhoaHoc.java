package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

// 3. KhoaHoc.java
public class KhoaHoc {
    private int ID_KhoaHoc;
    private String TenKhoaHoc;
    private String MoTa;
    private BigDecimal HocPhi;
    private LocalDate ThoiGianBatDau;
    private LocalDate ThoiGianKetThuc;
    private String GhiChu;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public KhoaHoc() {}

    public KhoaHoc(int ID_KhoaHoc, String TenKhoaHoc, String MoTa, BigDecimal HocPhi, LocalDate ThoiGianBatDau, LocalDate ThoiGianKetThuc, String GhiChu, String TrangThai, LocalDateTime NgayTao) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.TenKhoaHoc = TenKhoaHoc;
        this.MoTa = MoTa;
        this.HocPhi = HocPhi;
        this.ThoiGianBatDau = ThoiGianBatDau;
        this.ThoiGianKetThuc = ThoiGianKetThuc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(int ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }
    public String getTenKhoaHoc() { return TenKhoaHoc; }
    public void setTenKhoaHoc(String TenKhoaHoc) { this.TenKhoaHoc = TenKhoaHoc; }
    public String getMoTa() { return MoTa; }
    public void setMoTa(String MoTa) { this.MoTa = MoTa; }
    public BigDecimal getHocPhi() { return HocPhi; }
    public void setHocPhi(BigDecimal HocPhi) { this.HocPhi = HocPhi; }
    public LocalDate getThoiGianBatDau() { return ThoiGianBatDau; }
    public void setThoiGianBatDau(LocalDate ThoiGianBatDau) { this.ThoiGianBatDau = ThoiGianBatDau; }
    public LocalDate getThoiGianKetThuc() { return ThoiGianKetThuc; }
    public void setThoiGianKetThuc(LocalDate ThoiGianKetThuc) { this.ThoiGianKetThuc = ThoiGianKetThuc; }
    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }
    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }
    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

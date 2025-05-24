package model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

// 1. VaiTro.java
public class VaiTro {
    private int ID_VaiTro;
    private String TenVaiTro;
    private String MieuTa;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public VaiTro() {}

    public VaiTro(int ID_VaiTro, String TenVaiTro, String MieuTa, String TrangThai, LocalDateTime NgayTao) {
        this.ID_VaiTro = ID_VaiTro;
        this.TenVaiTro = TenVaiTro;
        this.MieuTa = MieuTa;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_VaiTro() { return ID_VaiTro; }
    public void setID_VaiTro(int ID_VaiTro) { this.ID_VaiTro = ID_VaiTro; }
    public String getTenVaiTro() { return TenVaiTro; }
    public void setTenVaiTro(String TenVaiTro) { this.TenVaiTro = TenVaiTro; }
    public String getMieuTa() { return MieuTa; }
    public void setMieuTa(String MieuTa) { this.MieuTa = MieuTa; }
    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }
    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

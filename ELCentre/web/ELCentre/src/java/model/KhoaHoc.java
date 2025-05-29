package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class KhoaHoc {
    private Integer ID_KhoaHoc;//1
    private String TenKhoaHoc;//2
    private String MoTa;//3
    private LocalDate ThoiGianBatDau;//4
    private LocalDate ThoiGianKetThuc;//5
    private String GhiChu;//6
    private String TrangThai;//7
    private LocalDateTime NgayTao;//8

    public KhoaHoc() {
    }

    public KhoaHoc(Integer ID_KhoaHoc, String TenKhoaHoc, String MoTa, LocalDate ThoiGianBatDau, LocalDate ThoiGianKetThuc, String GhiChu, String TrangThai, LocalDateTime NgayTao) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.TenKhoaHoc = TenKhoaHoc;
        this.MoTa = MoTa;
        this.ThoiGianBatDau = ThoiGianBatDau;
        this.ThoiGianKetThuc = ThoiGianKetThuc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }
    
    

    public Integer getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(Integer ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }

    public String getTenKhoaHoc() { return TenKhoaHoc; }
    public void setTenKhoaHoc(String TenKhoaHoc) { this.TenKhoaHoc = TenKhoaHoc; }

    public String getMoTa() { return MoTa; }
    public void setMoTa(String MoTa) { this.MoTa = MoTa; }

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

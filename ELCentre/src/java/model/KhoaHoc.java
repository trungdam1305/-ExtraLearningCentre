package model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class KhoaHoc {
    private Integer ID_KhoaHoc;
    private String TenKhoaHoc;
    private String MoTa;
    private LocalDate ThoiGianBatDau;
    private LocalDate ThoiGianKetThuc;
    private String GhiChu;
    private String TrangThai;
    private LocalDateTime NgayTao;
    private int ID_Khoi;

    public int getID_Khoi() {
        return ID_Khoi;
    }

    
    
    public void setID_Khoi(int ID_Khoi) {
        this.ID_Khoi = ID_Khoi;
    }

    public KhoaHoc(Integer ID_KhoaHoc, String TenKhoaHoc, String MoTa, LocalDate ThoiGianBatDau, LocalDate ThoiGianKetThuc, String GhiChu, String TrangThai, LocalDateTime NgayTao, int ID_Khoi) {
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.TenKhoaHoc = TenKhoaHoc;
        this.MoTa = MoTa;
        this.ThoiGianBatDau = ThoiGianBatDau;
        this.ThoiGianKetThuc = ThoiGianKetThuc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
        this.ID_Khoi = ID_Khoi;
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

    

    public KhoaHoc() {
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
    
    
    public String getThoiGianBatDauFormatted() {
    if (ThoiGianBatDau != null) {
        return ThoiGianBatDau.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    return "";
}

public String getThoiGianKetThucFormatted() {
    if (ThoiGianKetThuc != null) {
        return ThoiGianKetThuc.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }
    return "";
}
}



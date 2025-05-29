package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class GiaoVien {
    private Integer ID_GiaoVien;
    private Integer ID_TaiKhoan;
    private String HoTen;
    private String ChuyenMon;
    private String SDT;
    private String TruongGiangDay;
    private BigDecimal Luong;
    private String GhiChu;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public Integer getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(Integer ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; }

    public Integer getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(Integer ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }

    public String getHoTen() { return HoTen; }
    public void setHoTen(String HoTen) { this.HoTen = HoTen; }

    public String getChuyenMon() { return ChuyenMon; }
    public void setChuyenMon(String ChuyenMon) { this.ChuyenMon = ChuyenMon; }

    public String getSDT() { return SDT; }
    public void setSDT(String SDT) { this.SDT = SDT; }

    public String getTruongGiangDay() { return TruongGiangDay; }
    public void setTruongGiangDay(String TruongGiangDay) { this.TruongGiangDay = TruongGiangDay; }

    public BigDecimal getLuong() { return Luong; }
    public void setLuong(BigDecimal Luong) { this.Luong = Luong; }

    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }

    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }

    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

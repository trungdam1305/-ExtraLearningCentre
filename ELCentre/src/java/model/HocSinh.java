package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class HocSinh {
    private Integer ID_HocSinh;
    private Integer ID_TaiKhoan;
    private String HoTen;
    private LocalDate NgaySinh;
    private String GioiTinh;
    private String DiaChi;
    private String SDT_PhuHuynh;
    private String TruongHoc;
    private String GhiChu;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(Integer ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }

    

    public String getHoTen() { return HoTen; }
    public void setHoTen(String HoTen) { this.HoTen = HoTen; }

    public LocalDate getNgaySinh() { return NgaySinh; }
    public void setNgaySinh(LocalDate NgaySinh) { this.NgaySinh = NgaySinh; }

    public String getGioiTinh() { return GioiTinh; }
    public void setGioiTinh(String GioiTinh) { this.GioiTinh = GioiTinh; }

    public String getDiaChi() { return DiaChi; }
    public void setDiaChi(String DiaChi) { this.DiaChi = DiaChi; }

    public String getSDT_PhuHuynh() { return SDT_PhuHuynh; }
    public void setSDT_PhuHuynh(String SDT_PhuHuynh) { this.SDT_PhuHuynh = SDT_PhuHuynh; }

    public String getTruongHoc() { return TruongHoc; }
    public void setTruongHoc(String TruongHoc) { this.TruongHoc = TruongHoc; }

    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }

    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }

    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

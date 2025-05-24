package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

// 5. HocSinh.java
public class HocSinh {
    private int ID_HocSinh;
    private Integer ID_TaiKhoan;
    private int ID_LopHoc;
    private String HoTen;
    private LocalDate NgaySinh;
    private String GioiTinh;
    private String DiaChi;
    private String SDT_PhuHuynh;
    private String TruongHoc;
    private String GhiChu;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public HocSinh() {}

    public HocSinh(int ID_HocSinh, Integer ID_TaiKhoan, int ID_LopHoc, String HoTen, LocalDate NgaySinh, String GioiTinh, String DiaChi, String SDT_PhuHuynh, String TruongHoc, String GhiChu, String TrangThai, LocalDateTime NgayTao) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.ID_LopHoc = ID_LopHoc;
        this.HoTen = HoTen;
        this.NgaySinh = NgaySinh;
        this.GioiTinh = GioiTinh;
        this.DiaChi = DiaChi;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
        this.TruongHoc = TruongHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public Integer getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(Integer ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }
    public int getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(int ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }
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

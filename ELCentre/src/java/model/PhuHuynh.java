package model;

import java.time.LocalDateTime;

/**
 * The PhuHuynh class represents a parent or guardian in the system.
 * This class includes details such as account ID, name, phone number, email,
 * address, notes, related student, status, and creation time.
 */
public class PhuHuynh {
    // Unique ID of the parent
    private Integer ID_PhuHuynh;

    // Linked account ID in the system
    private Integer ID_TaiKhoan;

    // Full name of the parent
    private String HoTen;

    // Phone number
    private String SDT;

    // Email address
    private String Email;

    // Home address
    private String DiaChi;

    // Optional notes
    private String GhiChu;

    // ID of the associated student
    private Integer ID_HocSinh;

    // Status (e.g., Active, Inactive)
    private String TrangThai;

    // Date and time the parent record was created
    private LocalDateTime NgayTao;

    // Default constructor
    public PhuHuynh() {
    }

    // Full constructor
    public PhuHuynh(Integer ID_PhuHuynh, Integer ID_TaiKhoan, String HoTen, String SDT, String Email, String DiaChi, String GhiChu, Integer ID_HocSinh, String TrangThai, LocalDateTime NgayTao) {
        this.ID_PhuHuynh = ID_PhuHuynh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.SDT = SDT;
        this.Email = Email;
        this.DiaChi = DiaChi;
        this.GhiChu = GhiChu;
        this.ID_HocSinh = ID_HocSinh;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    // Getters and setters

    public Integer getID_PhuHuynh() {
        return ID_PhuHuynh;
    }

    public void setID_PhuHuynh(Integer ID_PhuHuynh) {
        this.ID_PhuHuynh = ID_PhuHuynh;
    }

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public String getSDT() {
        return SDT;
    }

    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getDiaChi() {
        return DiaChi;
    }

    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }
}

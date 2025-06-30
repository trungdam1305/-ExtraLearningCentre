package model;

import java.time.LocalDateTime;

/**
 * The TaiKhoanChiTiet class represents a detailed view of a user account,
 * combining both account credentials and user profile information.
 * It is typically used for displaying full account information in admin or user management views.
 * 
 * Author: wrx_Chur04
 */
public class TaiKhoanChiTiet {
    
    // Unique account ID
    private Integer ID_TaiKhoan;
    
    // User's email address (login credential)
    private String Email;

    // User's full name
    private String HoTen;

    // Type of user (e.g., "Student", "Teacher", "Parent")
    private String UserType;

    // Account password (should be encrypted/hashed in actual use)
    private String MatKhau;

    // Role ID for authorization
    private Integer ID_VaiTro;

    // User's phone number
    private String SoDienThoai;

    // Account status (e.g., "Active", "Inactive", "Suspended")
    private String TrangThai;

    // Date and time the account was created
    private LocalDateTime NgayTao;

    /**
     * Default constructor.
     */
    public TaiKhoanChiTiet() {
    }

    /**
     * Full-argument constructor to initialize all fields.
     */
    public TaiKhoanChiTiet(Integer ID_TaiKhoan, String Email, String HoTen, String UserType, String MatKhau, Integer ID_VaiTro, String SoDienThoai, String TrangThai, LocalDateTime NgayTao) {
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.Email = Email;
        this.HoTen = HoTen;
        this.UserType = UserType;
        this.MatKhau = MatKhau;
        this.ID_VaiTro = ID_VaiTro;
        this.SoDienThoai = SoDienThoai;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    // Getters

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getEmail() {
        return Email;
    }

    public String getMatKhau() {
        return MatKhau;
    }

    public Integer getID_VaiTro() {
        return ID_VaiTro;
    }

    public String getUserType() {
        return UserType;
    }

    public String getSoDienThoai() {
        return SoDienThoai;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    // Setters

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public void setMatKhau(String MatKhau) {
        this.MatKhau = MatKhau;
    }

    public void setID_VaiTro(Integer ID_VaiTro) {
        this.ID_VaiTro = ID_VaiTro;
    }

    public void setUserType(String UserType) {
        this.UserType = UserType;
    }

    public void setSoDienThoai(String SoDienThoai) {
        this.SoDienThoai = SoDienThoai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }
}

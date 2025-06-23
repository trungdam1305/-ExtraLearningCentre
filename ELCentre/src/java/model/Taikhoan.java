package model;

import java.time.LocalDateTime;

/**
 * The TaiKhoan class represents a user account in the system.
 * It contains account credentials, role, status, and metadata like creation time.
 * This class is typically used for authentication and user role management.
 * 
 * Author: admin
 */
public class TaiKhoan {

    // Unique identifier for the account
    private Integer ID_TaiKhoan;

    // User's email address (used as username)
    private String Email;

    // Encrypted or hashed password
    private String MatKhau;

    // Role ID (e.g., Admin = 1, Student = 2, etc.)
    private Integer ID_VaiTro;

    // Descriptive user type (e.g., "Student", "Parent", "Teacher")
    private String UserType;

    // User's phone number
    private String SoDienThoai;

    // Account status (e.g., "Active", "Inactive", "Suspended")
    private String TrangThai;

    // Account creation timestamp
    private LocalDateTime NgayTao;

    /**
     * Default constructor.
     */
    public TaiKhoan() {
    }

    /**
     * Full-argument constructor for initializing all fields.
     */
    public TaiKhoan(Integer ID_TaiKhoan, String Email, String MatKhau, Integer ID_VaiTro, String UserType, String SoDienThoai, String TrangThai, LocalDateTime NgayTao) {
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.Email = Email;
        this.MatKhau = MatKhau;
        this.ID_VaiTro = ID_VaiTro;
        this.UserType = UserType;
        this.SoDienThoai = SoDienThoai;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    // Getters and Setters

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getMatKhau() {
        return MatKhau;
    }

    public void setMatKhau(String MatKhau) {
        this.MatKhau = MatKhau;
    }

    public Integer getID_VaiTro() {
        return ID_VaiTro;
    }

    public void setID_VaiTro(Integer ID_VaiTro) {
        this.ID_VaiTro = ID_VaiTro;
    }

    public String getUserType() {
        return UserType;
    }

    public void setUserType(String UserType) {
        this.UserType = UserType;
    }

    public String getSoDienThoai() {
        return SoDienThoai;
    }

    public void setSoDienThoai(String SoDienThoai) {
        this.SoDienThoai = SoDienThoai;
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

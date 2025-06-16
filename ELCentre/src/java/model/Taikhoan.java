package model;

import java.time.LocalDateTime;

public class TaiKhoan {
            private Integer ID_TaiKhoan;
    private String Email;
    private String MatKhau;
    private Integer ID_VaiTro;
    private String UserType;
    private String SoDienThoai;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public TaiKhoan() {
    }

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

    
    public Integer getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(Integer ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }

    public String getEmail() { return Email; }
    public void setEmail(String Email) { this.Email = Email; }

    public String getMatKhau() { return MatKhau; }
    public void setMatKhau(String MatKhau) { this.MatKhau = MatKhau; }

    public Integer getID_VaiTro() { return ID_VaiTro; }
    public void setID_VaiTro(Integer ID_VaiTro) { this.ID_VaiTro = ID_VaiTro; }

    public String getUserType() { return UserType; }
    public void setUserType(String UserType) { this.UserType = UserType; }

    public String getSoDienThoai() { return SoDienThoai; }
    public void setSoDienThoai(String SoDienThoai) { this.SoDienThoai = SoDienThoai; }

    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }

    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

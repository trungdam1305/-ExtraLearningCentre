
package model;

import java.time.LocalDateTime;

/**
 *
 * @author wrx_Chur04
 */
public class TaiKhoanChiTiet {
    private Integer ID_TaiKhoan;
    private String Email;
    private String HoTen ; 
    private String UserType;
    private String MatKhau;
    private Integer ID_VaiTro;
    
    private String SoDienThoai;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public TaiKhoanChiTiet() {
    }

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

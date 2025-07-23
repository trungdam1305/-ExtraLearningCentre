
package model;

import java.time.LocalDateTime;

/**
 *
 * @author wrx_Chur04
 */
public class StaffUpdate {
    private int ID_Staff ; 
    private int ID_TaiKhoan ; 
    private String HoTen ; 
    private String Email ;
    private String MatKhau ; 
    private int ID_VaiTro ; 
    private String UserType ; 
    private String SoDienThoai ; 
    private String TrangThai ; 
    private LocalDateTime NgayTao ;

    public StaffUpdate() {
    }

    public StaffUpdate(int ID_Staff, int ID_TaiKhoan, String HoTen, String Email, String MatKhau, int ID_VaiTro, String UserType, String SoDienThoai, String TrangThai, LocalDateTime NgayTao) {
        this.ID_Staff = ID_Staff;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.Email = Email;
        this.MatKhau = MatKhau;
        this.ID_VaiTro = ID_VaiTro;
        this.UserType = UserType;
        this.SoDienThoai = SoDienThoai;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_Staff() {
        return ID_Staff;
    }

    public int getID_TaiKhoan() {
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

    public int getID_VaiTro() {
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
    
    
}

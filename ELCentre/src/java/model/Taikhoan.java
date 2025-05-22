/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package model;
import java.time.LocalDateTime;
/**
 *
 * @author wrx_Chur04
 */
public class Taikhoan {
    private int idTaiKhoan;
    private String email;
    private String matKhau;
    private int idVaiTro;
    private String userType;
    private String trangThai;
    private String soDienThoai;
    private LocalDateTime ngayTao;

    public Taikhoan() {
    }

    public Taikhoan(int idTaiKhoan, String email, String matKhau, int idVaiTro, String userType, String trangThai, String soDienThoai, LocalDateTime ngayTao) {
        this.idTaiKhoan = idTaiKhoan;
        this.email = email;
        this.matKhau = matKhau;
        this.idVaiTro = idVaiTro;
        this.userType = userType;
        this.trangThai = trangThai;
        this.soDienThoai = soDienThoai;
        this.ngayTao = ngayTao;
    }

    public int getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public String getEmail() {
        return email;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public int getIdVaiTro() {
        return idVaiTro;
    }

    public String getUserType() {
        return userType;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    public void setIdTaiKhoan(int idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public void setIdVaiTro(int idVaiTro) {
        this.idVaiTro = idVaiTro;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    
}

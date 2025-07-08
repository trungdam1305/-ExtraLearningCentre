package model;

import java.time.LocalDateTime;

public class ThongBao {
    private Integer ID_ThongBao;
    private Integer ID_TaiKhoan;
    private String noiDung;
    private Integer ID_HocPhi;
    private LocalDateTime thoiGian;


    public ThongBao() {
    }

    public ThongBao(Integer ID_ThongBao, Integer ID_TaiKhoan, String noiDung, Integer ID_HocPhi, LocalDateTime thoiGian) {
        this.ID_ThongBao = ID_ThongBao;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.noiDung = noiDung;
        this.ID_HocPhi = ID_HocPhi;
        this.thoiGian = thoiGian;
    }

    public Integer getID_ThongBao() {
        return ID_ThongBao;
    }

    public void setID_ThongBao(Integer ID_ThongBao) {
        this.ID_ThongBao = ID_ThongBao;
    }

    public Integer getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_TaiKhoan(Integer ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public Integer getID_HocPhi() {
        return ID_HocPhi;
    }

    public void setID_HocPhi(Integer ID_HocPhi) {
        this.ID_HocPhi = ID_HocPhi;
    }

    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }
    
    
    
}

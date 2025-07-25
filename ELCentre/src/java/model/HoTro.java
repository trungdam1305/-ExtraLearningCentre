
package model;

import java.time.LocalDateTime;

/**
 *
 * @author wrx_Chur04
 */
public class HoTro {
    private int ID_HoTro;
    private String HoTen;
    private String TenHoTro;
    private LocalDateTime ThoiGian;
    private String MoTa;
    private int ID_TaiKhoan;
    private String DaDuyet ; 
    private String PhanHoi ; 
    private String VaiTro ; 
    private String SoDienThoai ; 
    public HoTro() {
    }

    public HoTro(int ID_HoTro, String HoTen, String TenHoTro, LocalDateTime ThoiGian, String MoTa, int ID_TaiKhoan, String DaDuyet, String PhanHoi, String VaiTro, String SoDienThoai) {
        this.ID_HoTro = ID_HoTro;
        this.HoTen = HoTen;
        this.TenHoTro = TenHoTro;
        this.ThoiGian = ThoiGian;
        this.MoTa = MoTa;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.DaDuyet = DaDuyet;
        this.PhanHoi = PhanHoi;
        this.VaiTro = VaiTro;
        this.SoDienThoai = SoDienThoai;
    }

    

    public String getSoDienThoai() {
        return SoDienThoai;
    }

    
    
    
    public String getVaiTro() {
        return VaiTro;
    }

    

    public String getPhanHoi() {
        return PhanHoi;
    }

    

    public String getDaDuyet() {
        return DaDuyet;
    }

    public void setDaDuyet(String DaDuyet) {
        this.DaDuyet = DaDuyet;
    }

    public int getID_HoTro() {
        return ID_HoTro;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getTenHoTro() {
        return TenHoTro;
    }

    public LocalDateTime getThoiGian() {
        return ThoiGian;
    }

    public String getMoTa() {
        return MoTa;
    }

    public int getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_HoTro(int ID_HoTro) {
        this.ID_HoTro = ID_HoTro;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public void setTenHoTro(String TenHoTro) {
        this.TenHoTro = TenHoTro;
    }

    public void setThoiGian(LocalDateTime ThoiGian) {
        this.ThoiGian = ThoiGian;
    }

    public void setMoTa(String MoTa) {
        this.MoTa = MoTa;
    }

    public void setID_TaiKhoan(int ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public void setPhanHoi(String PhanHoi) {
        this.PhanHoi = PhanHoi;
    }

    public void setVaiTro(String VaiTro) {
        this.VaiTro = VaiTro;
    }

    public void setSoDienThoai(String SoDienThoai) {
        this.SoDienThoai = SoDienThoai;
    }
    
    
    
}
package model;

import java.time.LocalDateTime;

public class ThongBao {
     private Integer ID_ThongBao;
    private Integer ID_TaiKhoan;
    private String NoiDung;
    private Integer ID_HocPhi;
    private LocalDateTime ThoiGian;
    private String Status ; 

    public ThongBao() {
    }

    public ThongBao(Integer ID_ThongBao, Integer ID_TaiKhoan, String NoiDung, Integer ID_HocPhi, LocalDateTime ThoiGian, String Status) {
        this.ID_ThongBao = ID_ThongBao;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.NoiDung = NoiDung;
        this.ID_HocPhi = ID_HocPhi;
        this.ThoiGian = ThoiGian;
        this.Status = Status;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }
    public Integer getID_ThongBao() { return ID_ThongBao; }
    public void setID_ThongBao(Integer ID_ThongBao) { this.ID_ThongBao = ID_ThongBao; }

    public Integer getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(Integer ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }

    public String getNoiDung() { return NoiDung; }
    public void setNoiDung(String NoiDung) { this.NoiDung = NoiDung; }

    public Integer getID_HocPhi() { return ID_HocPhi; }
    public void setID_HocPhi(Integer ID_HocPhi) { this.ID_HocPhi = ID_HocPhi; }

    public LocalDateTime getThoiGian() { return ThoiGian; }
    public void setThoiGian(LocalDateTime ThoiGian) { this.ThoiGian = ThoiGian; }
}
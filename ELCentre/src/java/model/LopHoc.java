package model;

import java.time.LocalDateTime;

public class LopHoc {
    private Integer ID_LopHoc;
    private String TenLopHoc;
    private Integer ID_KhoaHoc;
    private Integer SiSo;
    private String ThoiGianHoc;
    private String GhiChu;
    private String TrangThai;
    private String SoTien;
    private LocalDateTime NgayTao;
    private String Image;

    public LopHoc(Integer ID_LopHoc, String TenLopHoc, Integer ID_KhoaHoc, Integer SiSo, String ThoiGianHoc, String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image) {
        this.ID_LopHoc = ID_LopHoc;
        this.TenLopHoc = TenLopHoc;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.SiSo = SiSo;
        this.ThoiGianHoc = ThoiGianHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
    }

    public LopHoc() {
    }

    @Override
    public String toString() {
        return "LopHoc{" + "ID_LopHoc=" + ID_LopHoc + ", TenLopHoc=" + TenLopHoc + ", ID_KhoaHoc=" + ID_KhoaHoc + ", SiSo=" + SiSo + ", ThoiGianHoc=" + ThoiGianHoc + ", GhiChu=" + GhiChu + ", TrangThai=" + TrangThai + ", SoTien=" + SoTien + ", NgayTao=" + NgayTao + ", Image=" + Image + '}';
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    
    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public String getTenLopHoc() { return TenLopHoc; }
    public void setTenLopHoc(String TenLopHoc) { this.TenLopHoc = TenLopHoc; }

    public Integer getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(Integer ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }

    public Integer getSiSo() { return SiSo; }
    public void setSiSo(Integer SiSo) { this.SiSo = SiSo; }

    public String getThoiGianHoc() { return ThoiGianHoc; }
    public void setThoiGianHoc(String ThoiGianHoc) { this.ThoiGianHoc = ThoiGianHoc; }

    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }

    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }

    public String getSoTien() { return SoTien; }
    public void setSoTien(String SoTien) { this.SoTien = SoTien; }

    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

package model;

import java.time.LocalDateTime;

// 4. LopHoc.java
public class LopHoc {
    private int ID_LopHoc;
    private String TenLopHoc;
    private Integer ID_KhoaHoc;
    private Integer SiSo;
    private String ThoiGianHoc;
    private String GhiChu;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public LopHoc() {}

    public LopHoc(int ID_LopHoc, String TenLopHoc, Integer ID_KhoaHoc, Integer SiSo, String ThoiGianHoc, String GhiChu, String TrangThai, LocalDateTime NgayTao) {
        this.ID_LopHoc = ID_LopHoc;
        this.TenLopHoc = TenLopHoc;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.SiSo = SiSo;
        this.ThoiGianHoc = ThoiGianHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.NgayTao = NgayTao;
    }

    public int getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(int ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }
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
    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

package model;

import java.time.LocalDateTime;

public class VaiTro {
    private Integer ID_VaiTro;
    private String TenVaiTro;
    private String MieuTa;
    private String TrangThai;
    private LocalDateTime NgayTao;

    public Integer getID_VaiTro() { return ID_VaiTro; }
    public void setID_VaiTro(Integer ID_VaiTro) { this.ID_VaiTro = ID_VaiTro; }

    public String getTenVaiTro() { return TenVaiTro; }
    public void setTenVaiTro(String TenVaiTro) { this.TenVaiTro = TenVaiTro; }

    public String getMieuTa() { return MieuTa; }
    public void setMieuTa(String MieuTa) { this.MieuTa = MieuTa; }

    public String getTrangThai() { return TrangThai; }
    public void setTrangThai(String TrangThai) { this.TrangThai = TrangThai; }

    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

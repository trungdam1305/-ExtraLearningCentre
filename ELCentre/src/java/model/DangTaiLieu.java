package model;



import java.time.LocalDate;

public class DangTaiLieu {
    private Integer ID_Material;
    private Integer ID_GiaoVien;
    private String TenTaiLieu;
    private String LoaiTaiLieu;
    private String DuongDan;
    private LocalDate NgayTao;

    public DangTaiLieu() {
    }

    public DangTaiLieu(Integer ID_Material, Integer ID_GiaoVien, String TenTaiLieu, String LoaiTaiLieu, String DuongDan, LocalDate NgayTao) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.LoaiTaiLieu = LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
    }

    
    public Integer getID_Material() { return ID_Material; }
    public void setID_Material(Integer ID_Material) { this.ID_Material = ID_Material; }

    public Integer getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(Integer ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; }

    public String getTenTaiLieu() { return TenTaiLieu; }
    public void setTenTaiLieu(String TenTaiLieu) { this.TenTaiLieu = TenTaiLieu; }

    public String getLoaiTaiLieu() { return LoaiTaiLieu; }
    public void setLoaiTaiLieu(String LoaiTaiLieu) { this.LoaiTaiLieu = LoaiTaiLieu; }

    public String getDuongDan() { return DuongDan; }
    public void setDuongDan(String DuongDan) { this.DuongDan = DuongDan; }

    public LocalDate getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDate NgayTao) { this.NgayTao = NgayTao; }

}

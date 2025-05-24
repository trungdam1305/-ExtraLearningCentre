package model;

import java.time.LocalDateTime;

// 13. UploadMaterials.java
public class DangTaiLieu {
    private int ID_Material;
    private int ID_GiaoVien;
    private String TenTaiLieu;
    private String LoaiTaiLieu;
    private String DuongDan;
    private LocalDateTime NgayTao;

    public DangTaiLieu() {}

    public DangTaiLieu(int ID_Material, int ID_GiaoVien, String TenTaiLieu, String LoaiTaiLieu, String DuongDan, LocalDateTime NgayTao) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.LoaiTaiLieu = LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
    }

    public int getID_Material() { return ID_Material; }
    public void setID_Material(int ID_Material) { this.ID_Material = ID_Material; }
    public int getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(int ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; }
    public String getTenTaiLieu() { return TenTaiLieu; }
    public void setTenTaiLieu(String TenTaiLieu) { this.TenTaiLieu = TenTaiLieu; }
    public String getLoaiTaiLieu() { return LoaiTaiLieu; }
    public void setLoaiTaiLieu(String LoaiTaiLieu) { this.LoaiTaiLieu = LoaiTaiLieu; }
    public String getDuongDan() { return DuongDan; }
    public void setDuongDan(String DuongDan) { this.DuongDan = DuongDan; }
    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
}

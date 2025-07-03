package model;

import java.time.LocalDateTime;

/**
 * Represents an uploaded teaching material by a teacher.
 * Each material has an ID, teacher ID, title, type, upload path,
 * creation date, category, price, and an associated image.
 * 
 * Author: trungdam1305
 */
public class DangTaiLieu {

    // Unique identifier for the material
    private Integer ID_Material;

    // ID of the teacher who uploaded the material
    private Integer ID_GiaoVien;

    // Title or name of the material
    private String TenTaiLieu;

    // Type or format of the material (e.g., PDF, DOCX, Video)
    private String LoaiTaiLieu;

    // File path or URL to access the material
    private String DuongDan;

    // Date and time when the material was created/uploaded
    private LocalDateTime NgayTao;

    // Category or subject area of the material
    private String DanhMuc;

    // Price of the material (could be "Free" or a number as String)
    private String GiaTien;

    // Image representing the material (e.g., thumbnail)
    private String Image;

    /**
     * Default constructor
     */
    public DangTaiLieu() {}

    /**
     * Full constructor to initialize all fields
     */
    public DangTaiLieu(Integer ID_Material, Integer ID_GiaoVien, String TenTaiLieu, String LoaiTaiLieu,
                       String DuongDan, LocalDateTime NgayTao, String DanhMuc, String GiaTien, String Image) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.LoaiTaiLieu = LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
        this.DanhMuc = DanhMuc;
        this.GiaTien = GiaTien;
        this.Image = Image;
    }

    /**
     * Constructor with essential fields only
     */
    public DangTaiLieu(Integer ID_Material, Integer ID_GiaoVien, String TenTaiLieu, String LoaiTaiLieu,
                       String DuongDan, LocalDateTime NgayTao) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.LoaiTaiLieu = LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
    }

    // Getter and setter methods

    public Integer getID_Material() {
        return ID_Material;
    }

    public void setID_Material(Integer ID_Material) {
        this.ID_Material = ID_Material;
    }

    public Integer getID_GiaoVien() {
        return ID_GiaoVien;
    }

    public void setID_GiaoVien(Integer ID_GiaoVien) {
        this.ID_GiaoVien = ID_GiaoVien;
    }

    public String getTenTaiLieu() {
        return TenTaiLieu;
    }

    public void setTenTaiLieu(String TenTaiLieu) {
        this.TenTaiLieu = TenTaiLieu;
    }

    public String getLoaiTaiLieu() {
        return LoaiTaiLieu;
    }

    public void setLoaiTaiLieu(String LoaiTaiLieu) {
        this.LoaiTaiLieu = LoaiTaiLieu;
    }

    public String getDuongDan() {
        return DuongDan;
    }

    public void setDuongDan(String DuongDan) {
        this.DuongDan = DuongDan;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public String getDanhMuc() {
        return DanhMuc;
    }

    public void setDanhMuc(String DanhMuc) {
        this.DanhMuc = DanhMuc;
    }

    public String getGiaTien() {
        return GiaTien;
    }

    public void setGiaTien(String GiaTien) {
        this.GiaTien = GiaTien;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }
}

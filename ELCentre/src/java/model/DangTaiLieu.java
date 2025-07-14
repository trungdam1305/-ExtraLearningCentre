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
    private int ID_LoaiTaiLieu;

    // File path or URL to access the material
    private String DuongDan;

    // Date and time when the material was created/uploaded
    private LocalDateTime NgayTao;

    // Category or subject area of the material
    private int ID_MonHoc;

    // Price of the material (could be "Free" or a number as String)
    private String GiaTien;

    // Image representing the material (e.g., thumbnail)
    private String Image;
    
    private String LoaiTaiLieu;
    
    private String MonHoc;
    
    
    /**
     * Default constructor
     */
    public DangTaiLieu() {}

    /**
     * Full constructor to initialize all fields
     */

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

    public int getID_LoaiTaiLieu() {
        return ID_LoaiTaiLieu;
    }

    public int getID_MonHoc() {
        return ID_MonHoc;
    }

    public void setID_LoaiTaiLieu(int ID_LoaiTaiLieu) {
        this.ID_LoaiTaiLieu = ID_LoaiTaiLieu;
    }

    public void setID_MonHoc(int ID_MonHoc) {
        this.ID_MonHoc = ID_MonHoc;
    }

    public String getLoaiTaiLieu() {
        return LoaiTaiLieu;
    }

    public String getMonHoc() {
        return MonHoc;
    }

    public void setLoaiTaiLieu(String LoaiTaiLieu) {
        this.LoaiTaiLieu = LoaiTaiLieu;
    }

    public void setMonHoc(String MonHoc) {
        this.MonHoc = MonHoc;
    }
    
    

    public DangTaiLieu(Integer ID_Material, Integer ID_GiaoVien, String TenTaiLieu, int ID_LoaiTaiLieu, String DuongDan, LocalDateTime NgayTao, int ID_MonHoc, String GiaTien, String Image) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.ID_LoaiTaiLieu = ID_LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
        this.ID_MonHoc = ID_MonHoc;
        this.GiaTien = GiaTien;
        this.Image = Image;
    }

    public DangTaiLieu(Integer ID_Material, Integer ID_GiaoVien, String TenTaiLieu, int ID_LoaiTaiLieu, String DuongDan, LocalDateTime NgayTao, int ID_MonHoc, String GiaTien, String Image, String LoaiTaiLieu, String MonHoc) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.ID_LoaiTaiLieu = ID_LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
        this.ID_MonHoc = ID_MonHoc;
        this.GiaTien = GiaTien;
        this.Image = Image;
        this.LoaiTaiLieu = LoaiTaiLieu;
        this.MonHoc = MonHoc;
    }
    
    
}

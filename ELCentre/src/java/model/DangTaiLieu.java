package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter; // Added for formatted date

public class DangTaiLieu {
    private int ID_Material;
    private Integer ID_GiaoVien; // Changed to Integer for nullability
    private String TenTaiLieu;
    private Integer ID_LoaiTaiLieu; // Changed to Integer for nullability
    private String DuongDan; // Will store the file path/name
    private LocalDateTime NgayTao;
    private Integer ID_MonHoc; // Changed to Integer for nullability
    private String GiaTien; // Assuming string based on your DAO for now
    private String Image; // For thumbnail
    private String NoiDung; // NEW: For CKEditor content

    // Fields from JOINs (not directly in DangTaiLieu table, populated by DAO)
    private String MonHoc;
    private String LoaiTaiLieu;

    public DangTaiLieu() {}

    // Constructor (update existing ones or add new if necessary)
    public DangTaiLieu(int ID_Material, Integer ID_GiaoVien, String TenTaiLieu, Integer ID_LoaiTaiLieu,
                       String DuongDan, LocalDateTime NgayTao, Integer ID_MonHoc, String GiaTien,
                       String Image, String NoiDung, String MonHoc, String LoaiTaiLieu) {
        this.ID_Material = ID_Material;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenTaiLieu = TenTaiLieu;
        this.ID_LoaiTaiLieu = ID_LoaiTaiLieu;
        this.DuongDan = DuongDan;
        this.NgayTao = NgayTao;
        this.ID_MonHoc = ID_MonHoc;
        this.GiaTien = GiaTien;
        this.Image = Image;
        this.NoiDung = NoiDung; // NEW
        this.MonHoc = MonHoc;
        this.LoaiTaiLieu = LoaiTaiLieu;
    }

    // --- Getters and Setters (add for NoiDung, update types for others) ---
    public int getID_Material() { return ID_Material; }
    public void setID_Material(int ID_Material) { this.ID_Material = ID_Material; }

    public Integer getID_GiaoVien() { return ID_GiaoVien; } // Changed to Integer
    public void setID_GiaoVien(Integer ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; } // Changed to Integer

    public String getTenTaiLieu() { return TenTaiLieu; }
    public void setTenTaiLieu(String TenTaiLieu) { this.TenTaiLieu = TenTaiLieu; }

    public Integer getID_LoaiTaiLieu() { return ID_LoaiTaiLieu; } // Changed to Integer
    public void setID_LoaiTaiLieu(Integer ID_LoaiTaiLieu) { this.ID_LoaiTaiLieu = ID_LoaiTaiLieu; } // Changed to Integer

    public String getDuongDan() { return DuongDan; }
    public void setDuongDan(String DuongDan) { this.DuongDan = DuongDan; }

    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
    
    public String getFormattedNgayTao() { // Re-added this for table display
        if (NgayTao == null) {
            return "";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
        return NgayTao.format(formatter);
    }

    public Integer getID_MonHoc() { return ID_MonHoc; } // Changed to Integer
    public void setID_MonHoc(Integer ID_MonHoc) { this.ID_MonHoc = ID_MonHoc; } // Changed to Integer

    public String getGiaTien() { return GiaTien; }
    public void setGiaTien(String GiaTien) { this.GiaTien = GiaTien; }

    public String getImage() { return Image; }
    public void setImage(String Image) { this.Image = Image; }

    // --- NEW GETTER/SETTER for NoiDung ---
    public String getNoiDung() { return NoiDung; }
    public void setNoiDung(String NoiDung) { this.NoiDung = NoiDung; }

    public String getMonHoc() { return MonHoc; }
    public void setMonHoc(String MonHoc) { this.MonHoc = MonHoc; }

    public String getLoaiTaiLieu() { return LoaiTaiLieu; }
    public void setLoaiTaiLieu(String LoaiTaiLieu) { this.LoaiTaiLieu = LoaiTaiLieu; }
}
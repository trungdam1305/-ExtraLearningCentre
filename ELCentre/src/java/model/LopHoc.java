package model;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class LopHoc {

    private Integer ID_LopHoc;
    private String TenLopHoc;
    private Integer ID_KhoaHoc;
    private Integer SiSo;
    private int ID_Schedule;
    private String GhiChu;
    private String TrangThai;
    private String SoTien;
    private LocalDateTime NgayTao;
    private String Image;
    private int ID_Khoi;         
    private String TenKhoaHoc;    
     private Integer SiSoToiDa;

    public LopHoc() {
    }

    public Integer getSiSoToiDa() {
        return SiSoToiDa;
    }

    public void setSiSoToiDa(Integer SiSoToiDa) {
        this.SiSoToiDa = SiSoToiDa;
    }

    

    public LopHoc(Integer ID_LopHoc, String TenLopHoc, Integer ID_KhoaHoc, Integer SiSo, int ID_Schedule, String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image, int ID_Khoi, String TenKhoaHoc, Integer SiSoToiDa) {
        this.ID_LopHoc = ID_LopHoc;
        this.TenLopHoc = TenLopHoc;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.SiSo = SiSo;
        this.ID_Schedule = ID_Schedule;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
        this.ID_Khoi = ID_Khoi;
        this.TenKhoaHoc = TenKhoaHoc;
        this.SiSoToiDa = SiSoToiDa;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public void setTenLopHoc(String TenLopHoc) {
        this.TenLopHoc = TenLopHoc;
    }

    public Integer getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public void setID_KhoaHoc(Integer ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public Integer getSiSo() {
        return SiSo;
    }

    public void setSiSo(Integer SiSo) {
        this.SiSo = SiSo;
    }

    public int getID_Schedule() {
        return ID_Schedule;
    }

    public void setID_Schedule(int ID_Schedule) {
        this.ID_Schedule = ID_Schedule;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public String getSoTien() {
        return SoTien;
    }

    public void setSoTien(String SoTien) {
        this.SoTien = SoTien;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getID_Khoi() {
        return ID_Khoi;
    }

    public void setID_Khoi(int ID_Khoi) {
        this.ID_Khoi = ID_Khoi;
    }

    public String getTenKhoaHoc() {
        return TenKhoaHoc;
    }

    public void setTenKhoaHoc(String TenKhoaHoc) {
        this.TenKhoaHoc = TenKhoaHoc;
    }
    
    

}

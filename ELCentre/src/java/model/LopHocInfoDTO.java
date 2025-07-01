    package model;

import java.time.LocalDateTime;

public class LopHocInfoDTO {

    public int getSoTien() {
        return SoTien;
    }

    public void setSoTien(int SoTien) {
        this.SoTien = SoTien;
    }
    private int idLopHoc;
    private String ClassCode;
    private String tenLopHoc;
    private int siSo;
    private int siSoToiDa;
    private String thoiGianHoc;
    private String tenGiaoVien;
    private String ghiChu;
    private String trangThai;
    private LocalDateTime ngayTao;
    private int SoTien;
    private String avatarGiaoVien;
    private int order;
    private int idKhoaHoc;
    private int idKhoi;

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public int getIdKhoaHoc() {
        return idKhoaHoc;
    }

    public void setIdKhoaHoc(int idKhoaHoc) {
        this.idKhoaHoc = idKhoaHoc;
    }

    public int getIdKhoi() {
        return idKhoi;
    }

    public void setIdKhoi(int idKhoi) {
        this.idKhoi = idKhoi;
    }
    
    // Constructor
    public LopHocInfoDTO() {
    }
    

    // Getters and Setters
    public int getIdLopHoc() {
        return idLopHoc;
    }

    public void setIdLopHoc(int idLopHoc) {
        this.idLopHoc = idLopHoc;
    }

    public String getTenLopHoc() {
        return tenLopHoc;
    }

    public void setTenLopHoc(String tenLopHoc) {
        this.tenLopHoc = tenLopHoc;
    }

    public int getSiSo() {
        return siSo;
    }

    public void setSiSo(int siSo) {
        this.siSo = siSo;
    }

    public int getSiSoToiDa() {
        return siSoToiDa;
    }

    public void setSiSoToiDa(int siSoToiDa) {
        this.siSoToiDa = siSoToiDa;
    }

    public String getThoiGianHoc() {
        return thoiGianHoc;
    }

    public void setThoiGianHoc(String thoiGianHoc) {
        this.thoiGianHoc = thoiGianHoc;
    }

    public String getTenGiaoVien() {
        return tenGiaoVien;
    }

    public void setTenGiaoVien(String tenGiaoVien) {
        this.tenGiaoVien = tenGiaoVien;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }

    public String getAvatarGiaoVien() {
        return avatarGiaoVien;
    }

    public String getClassCode() {
        return ClassCode;
    }

    public void setClassCode(String ClassCode) {
        this.ClassCode = ClassCode;
    }

    public void setAvatarGiaoVien(String avatarGiaoVien) {
        this.avatarGiaoVien = avatarGiaoVien;
    }
}
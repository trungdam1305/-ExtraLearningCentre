package model;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * DTO này kết hợp thông tin bài nộp (NopBaiTap) và thông tin học sinh (HocSinh).
 */
public class NopBaiTapInfo {
    // Thông tin từ HocSinh
    private String hoTen;
    private String maHocSinh;

    // Thông tin từ NopBaiTap
    private Integer ID_HocSinh;
    private Integer ID_BaiTap;
    private String tepNop;
    private LocalDate ngayNop;
    private BigDecimal diem;
    private String nhanXet;
    
    // Getters and Setters cho tất cả các thuộc tính...
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getMaHocSinh() { return maHocSinh; }
    public void setMaHocSinh(String maHocSinh) { this.maHocSinh = maHocSinh; }
    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer iD_HocSinh) { ID_HocSinh = iD_HocSinh; }
    public Integer getID_BaiTap() { return ID_BaiTap; }
    public void setID_BaiTap(Integer iD_BaiTap) { ID_BaiTap = iD_BaiTap; }
    public String getTepNop() { return tepNop; }
    public void setTepNop(String tepNop) { this.tepNop = tepNop; }
    public LocalDate getNgayNop() { return ngayNop; }
    public void setNgayNop(LocalDate ngayNop) { this.ngayNop = ngayNop; }
    public BigDecimal getDiem() { return diem; }
    public void setDiem(BigDecimal diem) { this.diem = diem; }
    public String getNhanXet() { return nhanXet; }
    public void setNhanXet(String nhanXet) { this.nhanXet = nhanXet; }
}
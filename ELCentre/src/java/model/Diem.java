package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

// 11. Diem.java
public class Diem {
    private int ID_Diem;
    private int ID_HocSinh;
    private int ID_KhoaHoc;
    private BigDecimal DiemKiemTra;
    private BigDecimal DiemBaiTap;
    private BigDecimal DiemGiuaKy;
    private BigDecimal DiemCuoiKy;
    private BigDecimal DiemTongKet;
    private LocalDateTime ThoiGianCapNhat;

    public Diem() {}

    public Diem(int ID_Diem, int ID_HocSinh, int ID_KhoaHoc, BigDecimal DiemKiemTra, BigDecimal DiemBaiTap,
                BigDecimal DiemGiuaKy, BigDecimal DiemCuoiKy, BigDecimal DiemTongKet, LocalDateTime ThoiGianCapNhat) {
        this.ID_Diem = ID_Diem;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.DiemKiemTra = DiemKiemTra;
        this.DiemBaiTap = DiemBaiTap;
        this.DiemGiuaKy = DiemGiuaKy;
        this.DiemCuoiKy = DiemCuoiKy;
        this.DiemTongKet = DiemTongKet;
        this.ThoiGianCapNhat = ThoiGianCapNhat;
    }

    public int getID_Diem() { return ID_Diem; }
    public void setID_Diem(int ID_Diem) { this.ID_Diem = ID_Diem; }
    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public int getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(int ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }
    public BigDecimal getDiemKiemTra() { return DiemKiemTra; }
    public void setDiemKiemTra(BigDecimal DiemKiemTra) { this.DiemKiemTra = DiemKiemTra; }
    public BigDecimal getDiemBaiTap() { return DiemBaiTap; }
    public void setDiemBaiTap(BigDecimal DiemBaiTap) { this.DiemBaiTap = DiemBaiTap; }
    public BigDecimal getDiemGiuaKy() { return DiemGiuaKy; }
    public void setDiemGiuaKy(BigDecimal DiemGiuaKy) { this.DiemGiuaKy = DiemGiuaKy; }
    public BigDecimal getDiemCuoiKy() { return DiemCuoiKy; }
    public void setDiemCuoiKy(BigDecimal DiemCuoiKy) { this.DiemCuoiKy = DiemCuoiKy; }
    public BigDecimal getDiemTongKet() { return DiemTongKet; }
    public void setDiemTongKet(BigDecimal DiemTongKet) { this.DiemTongKet = DiemTongKet; }
    public LocalDateTime getThoiGianCapNhat() { return ThoiGianCapNhat; }
    public void setThoiGianCapNhat(LocalDateTime ThoiGianCapNhat) { this.ThoiGianCapNhat = ThoiGianCapNhat; }
}

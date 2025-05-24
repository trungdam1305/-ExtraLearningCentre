package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

// 14. CreateHomework.java
public class TaoBaiTap {
    private int ID_BaiTap;
    private int ID_GiaoVien;
    private String TenBaiTap;
    private String MoTa;
    private LocalDateTime NgayTao;
    private LocalDate Deadline;

    public TaoBaiTap() {}

    public TaoBaiTap(int ID_BaiTap, int ID_GiaoVien, String TenBaiTap, String MoTa, LocalDateTime NgayTao, LocalDate Deadline) {
        this.ID_BaiTap = ID_BaiTap;
        this.ID_GiaoVien = ID_GiaoVien;
        this.TenBaiTap = TenBaiTap;
        this.MoTa = MoTa;
        this.NgayTao = NgayTao;
        this.Deadline = Deadline;
    }

    public int getID_BaiTap() { return ID_BaiTap; }
    public void setID_BaiTap(int ID_BaiTap) { this.ID_BaiTap = ID_BaiTap; }
    public int getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(int ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; }
    public String getTenBaiTap() { return TenBaiTap; }
    public void setTenBaiTap(String TenBaiTap) { this.TenBaiTap = TenBaiTap; }
    public String getMoTa() { return MoTa; }
    public void setMoTa(String MoTa) { this.MoTa = MoTa; }
    public LocalDateTime getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDateTime NgayTao) { this.NgayTao = NgayTao; }
    public LocalDate getDeadline() { return Deadline; }
    public void setDeadline(LocalDate Deadline) { this.Deadline = Deadline; }
}

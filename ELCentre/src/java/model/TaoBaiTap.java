package model;

import java.time.LocalDate;

public class TaoBaiTap {
       private Integer ID_BaiTap;
    private Integer ID_GiaoVien;
    private String TenBaiTap;
    private String MoTa;
    private LocalDate NgayTao;
    private Integer ID_LopHoc;
    private LocalDate Deadline;

    public Integer getID_BaiTap() { return ID_BaiTap; }
    public void setID_BaiTap(Integer ID_BaiTap) { this.ID_BaiTap = ID_BaiTap; }

    public Integer getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(Integer ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; }

    public String getTenBaiTap() { return TenBaiTap; }
    public void setTenBaiTap(String TenBaiTap) { this.TenBaiTap = TenBaiTap; }

    public String getMoTa() { return MoTa; }
    public void setMoTa(String MoTa) { this.MoTa = MoTa; }

    public LocalDate getNgayTao() { return NgayTao; }
    public void setNgayTao(LocalDate NgayTao) { this.NgayTao = NgayTao; }

    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public LocalDate getDeadline() { return Deadline; }
    public void setDeadline(LocalDate Deadline) { this.Deadline = Deadline; }
}

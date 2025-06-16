package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;


public class Diem {
            private Integer ID_Diem;
    private Integer ID_HocSinh;
    private Integer ID_LopHoc;

    private BigDecimal DiemKiemTra;
    private BigDecimal DiemBaiTap;
    private BigDecimal DiemGiuaKy;
    private BigDecimal DiemCuoiKy;
    private LocalDateTime ThoiGianCapNhat;

    public Integer getID_Diem() { return ID_Diem; }
    public void setID_Diem(Integer ID_Diem) { this.ID_Diem = ID_Diem; }

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public BigDecimal getDiemKiemTra() { return DiemKiemTra; }
    public void setDiemKiemTra(BigDecimal DiemKiemTra) { this.DiemKiemTra = DiemKiemTra; }

    public BigDecimal getDiemBaiTap() { return DiemBaiTap; }
    public void setDiemBaiTap(BigDecimal DiemBaiTap) { this.DiemBaiTap = DiemBaiTap; }

    public BigDecimal getDiemGiuaKy() { return DiemGiuaKy; }
    public void setDiemGiuaKy(BigDecimal DiemGiuaKy) { this.DiemGiuaKy = DiemGiuaKy; }

    public BigDecimal getDiemCuoiKy() { return DiemCuoiKy; }
    public void setDiemCuoiKy(BigDecimal DiemCuoiKy) { this.DiemCuoiKy = DiemCuoiKy; }

    public LocalDateTime getThoiGianCapNhat() { return ThoiGianCapNhat; }
    public void setThoiGianCapNhat(LocalDateTime ThoiGianCapNhat) { this.ThoiGianCapNhat = ThoiGianCapNhat; }
}

package model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.math.BigDecimal;

public class DangKyLopHoc {
            private Integer ID_HocSinh;
    private Integer ID_LopHoc;
    private LocalDate NgayDangKy;
    private String TinhTrangHocPhi;

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public LocalDate getNgayDangKy() { return NgayDangKy; }
    public void setNgayDangKy(LocalDate NgayDangKy) { this.NgayDangKy = NgayDangKy; }

    public String getTinhTrangHocPhi() { return TinhTrangHocPhi; }
    public void setTinhTrangHocPhi(String TinhTrangHocPhi) { this.TinhTrangHocPhi = TinhTrangHocPhi; }
}

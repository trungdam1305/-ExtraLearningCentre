package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

// 10. DangKyKhoaHoc.java
public class DangKyKhoaHoc {
    private int ID_HocSinh;
    private int ID_KhoaHoc;
    private LocalDate NgayDangKy;
    private String TinhTrangHocPhi;

                public DangKyKhoaHoc() {}

    public DangKyKhoaHoc(int ID_HocSinh, int ID_KhoaHoc, LocalDate NgayDangKy, String TinhTrangHocPhi) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.NgayDangKy = NgayDangKy;
        this.TinhTrangHocPhi = TinhTrangHocPhi;
    }

    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public int getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(int ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }
    public LocalDate getNgayDangKy() { return NgayDangKy; }
    public void setNgayDangKy(LocalDate NgayDangKy) { this.NgayDangKy = NgayDangKy; }
    public String getTinhTrangHocPhi() { return TinhTrangHocPhi; }
    public void setTinhTrangHocPhi(String TinhTrangHocPhi) { this.TinhTrangHocPhi = TinhTrangHocPhi; }
}

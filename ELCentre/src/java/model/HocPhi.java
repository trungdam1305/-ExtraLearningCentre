package model;

import java.time.LocalDate;

public class HocPhi {
             private Integer ID_HocPhi;
    private Integer ID_HocSinh;
    private Integer ID_LopHoc;
    private String MonHoc;
    private String PhuongThucThanhToan;
    private String TinhTrangThanhToan;
    private LocalDate NgayThanhToan;
    private String GhiChu;

    public HocPhi() {
    }

    public HocPhi(Integer ID_HocPhi, Integer ID_HocSinh, Integer ID_LopHoc, String MonHoc, String PhuongThucThanhToan, String TinhTrangThanhToan, LocalDate NgayThanhToan, String GhiChu) {
        this.ID_HocPhi = ID_HocPhi;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_LopHoc = ID_LopHoc;
        this.MonHoc = MonHoc;
        this.PhuongThucThanhToan = PhuongThucThanhToan;
        this.TinhTrangThanhToan = TinhTrangThanhToan;
        this.NgayThanhToan = NgayThanhToan;
        this.GhiChu = GhiChu;
    }

    
    public Integer getID_HocPhi() { return ID_HocPhi; }
    public void setID_HocPhi(Integer ID_HocPhi) { this.ID_HocPhi = ID_HocPhi; }

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public String getMonHoc() { return MonHoc; }
    public void setMonHoc(String MonHoc) { this.MonHoc = MonHoc; }

    public String getPhuongThucThanhToan() { return PhuongThucThanhToan; }
    public void setPhuongThucThanhToan(String PhuongThucThanhToan) { this.PhuongThucThanhToan = PhuongThucThanhToan; }

    public String getTinhTrangThanhToan() { return TinhTrangThanhToan; }
    public void setTinhTrangThanhToan(String TinhTrangThanhToan) { this.TinhTrangThanhToan = TinhTrangThanhToan; }

    public LocalDate getNgayThanhToan() { return NgayThanhToan; }
    public void setNgayThanhToan(LocalDate NgayThanhToan) { this.NgayThanhToan = NgayThanhToan; }

    public String getGhiChu() { return GhiChu; }
    public void setGhiChu(String GhiChu) { this.GhiChu = GhiChu; }
}

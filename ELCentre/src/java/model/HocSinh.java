package model ; 
import java.time.LocalDate;
import java.time.LocalDateTime;

public class HocSinh {
    private int idHocSinh;
    private int idTaiKhoan;
    private String hoTen;
    private LocalDate ngaySinh;
    private String gioiTinh;
    private String diaChi;
    private String sdtPhuHuynh;
    private int idLopHoc;
    private String truongHoc;
    private String ghiChu;
    private String trangThai;
    private LocalDateTime ngayTao;

    // Constructors
    public HocSinh() {
        this.trangThai = "Active";
        this.ngayTao = LocalDateTime.now();
    }

    public HocSinh(int idTaiKhoan, String hoTen, LocalDate ngaySinh, String gioiTinh, String diaChi,
                   String sdtPhuHuynh, int idLopHoc, String truongHoc, String ghiChu) {
        this.idTaiKhoan = idTaiKhoan;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.diaChi = diaChi;
        this.sdtPhuHuynh = sdtPhuHuynh;
        this.idLopHoc = idLopHoc;
        this.truongHoc = truongHoc;
        this.ghiChu = ghiChu;
        this.trangThai = "Active";
        this.ngayTao = LocalDateTime.now();
    }

    // Getters and Setters
    public int getIdHocSinh() {
        return idHocSinh;
    }

    public void setIdHocSinh(int idHocSinh) {
        this.idHocSinh = idHocSinh;
    }

    public int getIdTaiKhoan() {
        return idTaiKhoan;
    }

    public void setIdTaiKhoan(int idTaiKhoan) {
        this.idTaiKhoan = idTaiKhoan;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public LocalDate getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(LocalDate ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getSdtPhuHuynh() {
        return sdtPhuHuynh;
    }

    public void setSdtPhuHuynh(String sdtPhuHuynh) {
        this.sdtPhuHuynh = sdtPhuHuynh;
    }

    public int getIdLopHoc() {
        return idLopHoc;
    }

    public void setIdLopHoc(int idLopHoc) {
        this.idLopHoc = idLopHoc;
    }

    public String getTruongHoc() {
        return truongHoc;
    }

    public void setTruongHoc(String truongHoc) {
        this.truongHoc = truongHoc;
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
}

package model;
import java.time.LocalDate;
import java.time.LocalDateTime;
public class HocPhi {
    private Integer ID_HocPhi;
    private Integer ID_HocSinh;
    private Integer ID_LopHoc;
    private String MonHoc;
    private String PhuongThucThanhToan;
    private String TinhTrangThanhToan;
    private LocalDate NgayThanhToan;
    private String GhiChu;
    private Integer tongHocPhi;
    private Integer soTienDaDong;
    private Integer conThieu;
    
    private int Thang;
    private int Nam;
    private int SoBuoi ; 
    private int HocPhiPhaiDong;
    private int DaDong;
    private int NoConLai;
    private String MaHocSinh ; 
    private int ID_TaiKhoan  ; 
    private String HoTen ; 
    private String SDT_PhuHuynh ; 

    

    public HocPhi() {
    }

    public HocPhi(Integer ID_HocPhi, Integer ID_HocSinh, Integer ID_LopHoc, String PhuongThucThanhToan, String TinhTrangThanhToan, LocalDate NgayThanhToan, String GhiChu, int Thang, int Nam, int SoBuoi, int HocPhiPhaiDong, int DaDong, int NoConLai, String MaHocSinh, int ID_TaiKhoan, String HoTen, String SDT_PhuHuynh) {
        this.ID_HocPhi = ID_HocPhi;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_LopHoc = ID_LopHoc;
        this.PhuongThucThanhToan = PhuongThucThanhToan;
        this.TinhTrangThanhToan = TinhTrangThanhToan;
        this.NgayThanhToan = NgayThanhToan;
        this.GhiChu = GhiChu;
        this.Thang = Thang;
        this.Nam = Nam;
        this.SoBuoi = SoBuoi;
        this.HocPhiPhaiDong = HocPhiPhaiDong;
        this.DaDong = DaDong;
        this.NoConLai = NoConLai;
        this.MaHocSinh = MaHocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
    }

    public HocPhi(Integer ID_HocPhi, Integer ID_HocSinh, Integer ID_LopHoc, String MonHoc, String PhuongThucThanhToan, String TinhTrangThanhToan, LocalDate NgayThanhToan, String GhiChu, Integer tongHocPhi, Integer soTienDaDong, Integer conThieu) {
        this.ID_HocPhi = ID_HocPhi;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_LopHoc = ID_LopHoc;
        this.MonHoc = MonHoc;
        this.PhuongThucThanhToan = PhuongThucThanhToan;
        this.TinhTrangThanhToan = TinhTrangThanhToan;
        this.NgayThanhToan = NgayThanhToan;
        this.GhiChu = GhiChu;
        this.tongHocPhi = tongHocPhi;
        this.soTienDaDong = soTienDaDong;
        this.conThieu = conThieu;
    }

    public HocPhi(Integer ID_HocPhi, Integer ID_HocSinh, Integer ID_LopHoc, String MonHoc, String PhuongThucThanhToan, String TinhTrangThanhToan, LocalDate NgayThanhToan, String GhiChu, Integer tongHocPhi, Integer soTienDaDong, Integer conThieu, int Thang, int Nam, int SoBuoi, int HocPhiPhaiDong, int DaDong, int NoConLai, String MaHocSinh, int ID_TaiKhoan, String HoTen, String SDT_PhuHuynh) {
        this.ID_HocPhi = ID_HocPhi;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_LopHoc = ID_LopHoc;
        this.MonHoc = MonHoc;
        this.PhuongThucThanhToan = PhuongThucThanhToan;
        this.TinhTrangThanhToan = TinhTrangThanhToan;
        this.NgayThanhToan = NgayThanhToan;
        this.GhiChu = GhiChu;
        this.tongHocPhi = tongHocPhi;
        this.soTienDaDong = soTienDaDong;
        this.conThieu = conThieu;
        this.Thang = Thang;
        this.Nam = Nam;
        this.SoBuoi = SoBuoi;
        this.HocPhiPhaiDong = HocPhiPhaiDong;
        this.DaDong = DaDong;
        this.NoConLai = NoConLai;
        this.MaHocSinh = MaHocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HoTen = HoTen;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
    }

    public Integer getID_HocPhi() {
        return ID_HocPhi;
    }

    public void setID_HocPhi(Integer ID_HocPhi) {
        this.ID_HocPhi = ID_HocPhi;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public String getMonHoc() {
        return MonHoc;
    }

    public void setMonHoc(String MonHoc) {
        this.MonHoc = MonHoc;
    }

    public String getPhuongThucThanhToan() {
        return PhuongThucThanhToan;
    }

    public void setPhuongThucThanhToan(String PhuongThucThanhToan) {
        this.PhuongThucThanhToan = PhuongThucThanhToan;
    }

    public String getTinhTrangThanhToan() {
        return TinhTrangThanhToan;
    }

    public void setTinhTrangThanhToan(String TinhTrangThanhToan) {
        this.TinhTrangThanhToan = TinhTrangThanhToan;
    }

    public LocalDate getNgayThanhToan() {
        return NgayThanhToan;
    }

    public void setNgayThanhToan(LocalDate NgayThanhToan) {
        this.NgayThanhToan = NgayThanhToan;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public Integer getTongHocPhi() {
        return tongHocPhi;
    }

    public void setTongHocPhi(Integer tongHocPhi) {
        this.tongHocPhi = tongHocPhi;
    }

    public Integer getSoTienDaDong() {
        return soTienDaDong;
    }

    public void setSoTienDaDong(Integer soTienDaDong) {
        this.soTienDaDong = soTienDaDong;
    }

    public Integer getConThieu() {
        return conThieu;
    }

    public void setConThieu(Integer conThieu) {
        this.conThieu = conThieu;
    }

    public int getThang() {
        return Thang;
    }

    public void setThang(int Thang) {
        this.Thang = Thang;
    }

    public int getNam() {
        return Nam;
    }

    public void setNam(int Nam) {
        this.Nam = Nam;
    }

    public int getSoBuoi() {
        return SoBuoi;
    }

    public void setSoBuoi(int SoBuoi) {
        this.SoBuoi = SoBuoi;
    }

    public int getHocPhiPhaiDong() {
        return HocPhiPhaiDong;
    }

    public void setHocPhiPhaiDong(int HocPhiPhaiDong) {
        this.HocPhiPhaiDong = HocPhiPhaiDong;
    }

    public int getDaDong() {
        return DaDong;
    }

    public void setDaDong(int DaDong) {
        this.DaDong = DaDong;
    }

    public int getNoConLai() {
        return NoConLai;
    }

    public void setNoConLai(int NoConLai) {
        this.NoConLai = NoConLai;
    }

    public String getMaHocSinh() {
        return MaHocSinh;
    }

    public void setMaHocSinh(String MaHocSinh) {
        this.MaHocSinh = MaHocSinh;
    }

    public int getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public void setID_TaiKhoan(int ID_TaiKhoan) {
        this.ID_TaiKhoan = ID_TaiKhoan;
    }

    public String getHoTen() {
        return HoTen;
    }

    public void setHoTen(String HoTen) {
        this.HoTen = HoTen;
    }

    public String getSDT_PhuHuynh() {
        return SDT_PhuHuynh;
    }

    public void setSDT_PhuHuynh(String SDT_PhuHuynh) {
        this.SDT_PhuHuynh = SDT_PhuHuynh;
    }




    

    
}
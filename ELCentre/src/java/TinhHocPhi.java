
package model;

/**
 *
 * @author wrx_Chur04
 */
public class TinhHocPhi {
    private int ID_HocSinh ; 
    private int ID_TaiKhoan ; 
    private String MaHocSinh ; 
    private String HoTen ; 
    private String SDT_PhuHuynh ; 
    private int  ID_TaiKhoanPH ; 
    private String LopDangHocTrenTruong ; 
    private int ID_LopHoc ; 
    private String TenLopHoc ; 
    private int Thang ; 
    private int Nam ; 
    private int SoBuoiCoMat ; 
    private int  HocPhiPhaiDong ; 

    public TinhHocPhi() {
    }

    public TinhHocPhi(int ID_HocSinh, int ID_TaiKhoan, String MaHocSinh, String HoTen, String SDT_PhuHuynh, int ID_TaiKhoanPH, String LopDangHocTrenTruong, int ID_LopHoc, String TenLopHoc, int Thang, int Nam, int SoBuoiCoMat, int HocPhiPhaiDong) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.MaHocSinh = MaHocSinh;
        this.HoTen = HoTen;
        this.SDT_PhuHuynh = SDT_PhuHuynh;
        this.ID_TaiKhoanPH = ID_TaiKhoanPH;
        this.LopDangHocTrenTruong = LopDangHocTrenTruong;
        this.ID_LopHoc = ID_LopHoc;
        this.TenLopHoc = TenLopHoc;
        this.Thang = Thang;
        this.Nam = Nam;
        this.SoBuoiCoMat = SoBuoiCoMat;
        this.HocPhiPhaiDong = HocPhiPhaiDong;
    }

    

    

    

    public int getID_HocSinh() {
        return ID_HocSinh;
    }

    public int getID_TaiKhoan() {
        return ID_TaiKhoan;
    }

    public String getMaHocSinh() {
        return MaHocSinh;
    }

    public String getHoTen() {
        return HoTen;
    }

    public String getSDT_PhuHuynh() {
        return SDT_PhuHuynh;
    }

    public int getID_TaiKhoanPH() {
        return ID_TaiKhoanPH;
    }

    
    
    

    public String getLopDangHocTrenTruong() {
        return LopDangHocTrenTruong;
    }

    public int getID_LopHoc() {
        return ID_LopHoc;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public int getThang() {
        return Thang;
    }

    public int getNam() {
        return Nam;
    }

    public int getSoBuoiCoMat() {
        return SoBuoiCoMat;
    }

    public int getHocPhiPhaiDong() {
        return HocPhiPhaiDong;
    }

    

    
    
    
    
}
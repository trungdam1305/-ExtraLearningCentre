package model;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class LopHoc {

    private Integer ID_LopHoc;
    private String TenLopHoc;
    private Integer ID_KhoaHoc;
    private Integer SiSo;
    private String ThoiGianHoc;
    private String GhiChu;
    private String TrangThai;
    private String SoTien;
    private LocalDateTime NgayTao;
    private String Image;
    private int ID_Khoi;         // Đã có, nhưng cần getter/setter
    private String TenKhoaHoc;   // Thêm trường này

    public LopHoc() {
    }

    public LopHoc(Integer ID_LopHoc, String TenLopHoc, Integer ID_KhoaHoc, Integer SiSo, String ThoiGianHoc,
            String GhiChu, String TrangThai, String SoTien, LocalDateTime NgayTao, String Image) {
        this.ID_LopHoc = ID_LopHoc;
        this.TenLopHoc = TenLopHoc;
        this.ID_KhoaHoc = ID_KhoaHoc;
        this.SiSo = SiSo;
        this.ThoiGianHoc = ThoiGianHoc;
        this.GhiChu = GhiChu;
        this.TrangThai = TrangThai;
        this.SoTien = SoTien;
        this.NgayTao = NgayTao;
        this.Image = Image;
    }

    @Override
    public String toString() {
        return "LopHoc{" + "ID_LopHoc=" + ID_LopHoc + ", TenLopHoc=" + TenLopHoc + ", ID_KhoaHoc=" + ID_KhoaHoc
                + ", SiSo=" + SiSo + ", ThoiGianHoc=" + ThoiGianHoc + ", GhiChu=" + GhiChu + ", TrangThai=" + TrangThai
                + ", SoTien=" + SoTien + ", NgayTao=" + NgayTao + ", Image=" + Image + ", ID_Khoi=" + ID_Khoi
                + ", TenKhoaHoc=" + TenKhoaHoc + '}';
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public String getTenLopHoc() {
        return TenLopHoc;
    }

    public void setTenLopHoc(String TenLopHoc) {
        this.TenLopHoc = TenLopHoc;
    }

    public Integer getID_KhoaHoc() {
        return ID_KhoaHoc;
    }

    public void setID_KhoaHoc(Integer ID_KhoaHoc) {
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public Integer getSiSo() {
        return SiSo;
    }

    public void setSiSo(Integer SiSo) {
        this.SiSo = SiSo;
    }

    public String getThoiGianHoc() {
        return ThoiGianHoc;
    }

    public void setThoiGianHoc(String ThoiGianHoc) {
        this.ThoiGianHoc = ThoiGianHoc;
    }

    public String getGhiChu() {
        return GhiChu;
    }

    public void setGhiChu(String GhiChu) {
        this.GhiChu = GhiChu;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String TrangThai) {
        this.TrangThai = TrangThai;
    }

    public String getSoTien() {
        return SoTien;
    }

    public void setSoTien(String SoTien) {
        this.SoTien = SoTien;
    }

    public LocalDateTime getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(LocalDateTime NgayTao) {
        this.NgayTao = NgayTao;
    }

    public String getNgayTaoFormatted() {
        if (NgayTao != null) {
            return NgayTao.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
        return "";
    }

    // Thêm getter và setter cho ID_Khoi
    public int getID_Khoi() {
        return ID_Khoi;
    }

    public void setID_Khoi(int ID_Khoi) {
        this.ID_Khoi = ID_Khoi;
    }

    // Thêm getter và setter cho TenKhoaHoc
    public String getTenKhoaHoc() {
        return TenKhoaHoc;
    }

    public void setTenKhoaHoc(String TenKhoaHoc) {
        this.TenKhoaHoc = TenKhoaHoc;
    }

    
    public List<String> getThoiGianHocFormatted() {
    List<String> result = new ArrayList<>();

    if (this.ThoiGianHoc != null && !this.ThoiGianHoc.trim().isEmpty()) {
        String[] entries = this.ThoiGianHoc.split(";");
        for (String entry : entries) {
            String[] parts = entry.trim().split(" ");
            if (parts.length == 2) {
                String thu = parts[0];
                String gioPhut = parts[1];

                try {
                    // Parse định dạng 24h từ DB
                    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("HH:mm");
                    LocalTime time = LocalTime.parse(gioPhut, inputFormatter);

                    // Hiển thị ra định dạng 12h có AM/PM
                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("hh:mm a", Locale.US);
                    String formattedTime = time.format(outputFormatter);

                    // Kết hợp
                    result.add(formattedTime + " - " + thu);
                } catch (DateTimeParseException e) {
                    result.add(entry); // fallback nếu parse lỗi
                }
            } else {
                result.add(entry); // fallback nếu format không đúng
            }
        }
    }

    return result;
}

   

}

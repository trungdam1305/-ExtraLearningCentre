package model;

import java.time.LocalDateTime;

// 18. ThongBao.java
public class ThongBao {
    private int ID_ThongBao;
    private int ID_TaiKhoan;
    private String NoiDung;
    private LocalDateTime ThoiGian;

    public ThongBao() {}

    public ThongBao(int ID_ThongBao, int ID_TaiKhoan, String NoiDung, LocalDateTime ThoiGian) {
        this.ID_ThongBao = ID_ThongBao;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.NoiDung = NoiDung;
        this.ThoiGian = ThoiGian;
    }

    public int getID_ThongBao() { return ID_ThongBao; }
    public void setID_ThongBao(int ID_ThongBao) { this.ID_ThongBao = ID_ThongBao; }
    public int getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(int ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }
    public String getNoiDung() { return NoiDung; }
    public void setNoiDung(String NoiDung) { this.NoiDung = NoiDung; }
    public LocalDateTime getThoiGian() { return ThoiGian; }
    public void setThoiGian(LocalDateTime ThoiGian) { this.ThoiGian = ThoiGian; }
}

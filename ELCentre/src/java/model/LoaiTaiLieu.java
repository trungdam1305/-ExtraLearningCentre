package model;

public class LoaiTaiLieu {
    private int ID_LoaiTaiLieu;
    private String TenLoaiTaiLieu;

    // Constructors, Getters, Setters
    public LoaiTaiLieu() {}

    public LoaiTaiLieu(int ID_LoaiTaiLieu, String TenLoaiTaiLieu) {
        this.ID_LoaiTaiLieu = ID_LoaiTaiLieu;
        this.TenLoaiTaiLieu = TenLoaiTaiLieu;
    }

    public int getID_LoaiTaiLieu() { return ID_LoaiTaiLieu; }
    public void setID_LoaiTaiLieu(int ID_LoaiTaiLieu) { this.ID_LoaiTaiLieu = ID_LoaiTaiLieu; }
    public String getTenLoaiTaiLieu() { return TenLoaiTaiLieu; }
    public void setTenLoaiTaiLieu(String TenLoaiTaiLieu) { this.TenLoaiTaiLieu = TenLoaiTaiLieu; }
}
package model;

// 9. GiaoVien_KhoaHoc.java
public class GiaoVien_KhoaHoc {
    private int ID_GiaoVien;
    private int ID_KhoaHoc;

    public GiaoVien_KhoaHoc() {}

    public GiaoVien_KhoaHoc(int ID_GiaoVien, int ID_KhoaHoc) {
        this.ID_GiaoVien = ID_GiaoVien;
        this.ID_KhoaHoc = ID_KhoaHoc;
    }

    public int getID_GiaoVien() { return ID_GiaoVien; }
    public void setID_GiaoVien(int ID_GiaoVien) { this.ID_GiaoVien = ID_GiaoVien; }
    public int getID_KhoaHoc() { return ID_KhoaHoc; }
    public void setID_KhoaHoc(int ID_KhoaHoc) { this.ID_KhoaHoc = ID_KhoaHoc; }
}

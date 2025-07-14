package model;

public class MonHoc {
    private int ID_MonHoc;
    private String TenMonHoc;

    // Constructors, Getters, Setters
    public MonHoc() {}

    public MonHoc(int ID_MonHoc, String TenMonHoc) {
        this.ID_MonHoc = ID_MonHoc;
        this.TenMonHoc = TenMonHoc;
    }

    public int getID_MonHoc() { return ID_MonHoc; }
    public void setID_MonHoc(int ID_MonHoc) { this.ID_MonHoc = ID_MonHoc; }
    public String getTenMonHoc() { return TenMonHoc; }
    public void setTenMonHoc(String TenMonHoc) { this.TenMonHoc = TenMonHoc; }
}
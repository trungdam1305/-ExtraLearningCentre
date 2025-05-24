package model;

// 7. HocSinh_PhuHuynh.java
public class HocSinh_PhuHuynh {
    private int ID_HocSinh;
    private int ID_PhuHuynh;

    public HocSinh_PhuHuynh() {}

    public HocSinh_PhuHuynh(int ID_HocSinh, int ID_PhuHuynh) {
        this.ID_HocSinh = ID_HocSinh;
        this.ID_PhuHuynh = ID_PhuHuynh;
    }

    public int getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(int ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }
    public int getID_PhuHuynh() { return ID_PhuHuynh; }
    public void setID_PhuHuynh(int ID_PhuHuynh) { this.ID_PhuHuynh = ID_PhuHuynh; }
}

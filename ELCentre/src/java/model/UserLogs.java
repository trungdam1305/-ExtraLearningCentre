package model;

import java.time.LocalDateTime;

// 17. UserLogs.java
public class UserLogs {
    private int ID_Log;
    private int ID_TaiKhoan;
    private String HanhDong;
    private LocalDateTime ThoiGian;

    public UserLogs() {}

    public UserLogs(int ID_Log, int ID_TaiKhoan, String HanhDong, LocalDateTime ThoiGian) {
        this.ID_Log = ID_Log;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HanhDong = HanhDong;
        this.ThoiGian = ThoiGian;
    }

    public int getID_Log() { return ID_Log; }
    public void setID_Log(int ID_Log) { this.ID_Log = ID_Log; }
    public int getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(int ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }
    public String getHanhDong() { return HanhDong; }
    public void setHanhDong(String HanhDong) { this.HanhDong = HanhDong; }
    public LocalDateTime getThoiGian() { return ThoiGian; }
    public void setThoiGian(LocalDateTime ThoiGian) { this.ThoiGian = ThoiGian; }
}

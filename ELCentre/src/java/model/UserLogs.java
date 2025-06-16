package model;

import java.time.LocalDateTime;

public class UserLogs {
            private Integer ID_Log;
    private Integer ID_TaiKhoan;
    private String HanhDong;
    private LocalDateTime ThoiGian;


    public UserLogs() {
    }

    public UserLogs(Integer ID_Log, Integer ID_TaiKhoan, String HanhDong, LocalDateTime ThoiGian) {
        this.ID_Log = ID_Log;
        this.ID_TaiKhoan = ID_TaiKhoan;
        this.HanhDong = HanhDong;
        this.ThoiGian = ThoiGian;
    }

    public Integer getID_Log() { return ID_Log; }
    public void setID_Log(Integer ID_Log) { this.ID_Log = ID_Log; }

    public Integer getID_TaiKhoan() { return ID_TaiKhoan; }
    public void setID_TaiKhoan(Integer ID_TaiKhoan) { this.ID_TaiKhoan = ID_TaiKhoan; }

    public String getHanhDong() { return HanhDong; }
    public void setHanhDong(String HanhDong) { this.HanhDong = HanhDong; }

    public LocalDateTime getThoiGian() { return ThoiGian; }
    public void setThoiGian(LocalDateTime ThoiGian) { this.ThoiGian = ThoiGian; }
}

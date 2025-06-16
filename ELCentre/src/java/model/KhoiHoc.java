
package model;

public class KhoiHoc {
            private int ID_Khoi;
    private String TenKhoi;
    private int Status_Khoi;

    // Constructor không tham số
    public KhoiHoc() {
    }

    // Constructor đầy đủ tham số
    public KhoiHoc(int ID_Khoi, String TenKhoi, int Status_Khoi) {
        this.ID_Khoi = ID_Khoi;
        this.TenKhoi = TenKhoi;
        this.Status_Khoi = Status_Khoi;
    }

    // Getter và Setter
    public int getID_Khoi() {
        return ID_Khoi;
    }

    public void setID_Khoi(int ID_Khoi) {
        this.ID_Khoi = ID_Khoi;
    }

    public String getTenKhoi() {
        return TenKhoi;
    }

    public void setTenKhoi(String TenKhoi) {
        this.TenKhoi = TenKhoi;
    }

    public int getStatus_Khoi() {
        return Status_Khoi;
    }

    public void setStatus_Khoi(int Status_Khoi) {
        this.Status_Khoi = Status_Khoi;
    }
}

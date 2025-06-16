package model;

public class HocSinh_LopHoc {
            private Integer ID_LopHoc;
    private Integer ID_HocSinh;
    private Integer ID_HSLopHoc;
    private String FeedBack;
    private boolean status_FeedBack;

    public String getFeedBack() {
        return FeedBack;
    }

    public void setFeedBack(String FeedBack) {
        this.FeedBack = FeedBack;
    }

    public boolean isStatus_FeedBack() {
        return status_FeedBack;
    }

    public void setStatus_FeedBack(boolean status_FeedBack) {
        this.status_FeedBack = status_FeedBack;
    }
    
    public Integer getID_LopHoc() { return ID_LopHoc; }
    public void setID_LopHoc(Integer ID_LopHoc) { this.ID_LopHoc = ID_LopHoc; }

    public Integer getID_HocSinh() { return ID_HocSinh; }
    public void setID_HocSinh(Integer ID_HocSinh) { this.ID_HocSinh = ID_HocSinh; }

    public Integer getID_HSLopHoc() { return ID_HSLopHoc; }
    public void setID_HSLopHoc(Integer ID_HSLopHoc) { this.ID_HSLopHoc = ID_HSLopHoc; }
}

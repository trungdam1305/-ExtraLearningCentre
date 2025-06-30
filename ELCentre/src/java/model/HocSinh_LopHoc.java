package model;

/**
 * Represents the relationship between a student and a class, 
 * including feedback and feedback status tracking.
 * 
 * Author: trungdam1305
 */
public class HocSinh_LopHoc {

    /** ID of the class */
    private Integer ID_LopHoc;

    /** ID of the student */
    private Integer ID_HocSinh;

    /** Unique ID for this specific student-class relationship */
    private Integer ID_HSLopHoc;

    /** Feedback provided by the student for the class */
    private String FeedBack;

    /** Whether feedback has been submitted (true if submitted) */
    private boolean Status_FeedBack;

    // Getter and Setter methods

    public Integer getID_LopHoc() {
        return ID_LopHoc;
    }

    public void setID_LopHoc(Integer ID_LopHoc) {
        this.ID_LopHoc = ID_LopHoc;
    }

    public Integer getID_HocSinh() {
        return ID_HocSinh;
    }

    public void setID_HocSinh(Integer ID_HocSinh) {
        this.ID_HocSinh = ID_HocSinh;
    }

    public Integer getID_HSLopHoc() {
        return ID_HSLopHoc;
    }

    public void setID_HSLopHoc(Integer ID_HSLopHoc) {
        this.ID_HSLopHoc = ID_HSLopHoc;
    }

    public String getFeedBack() {
        return FeedBack;
    }

    public void setFeedBack(String FeedBack) {
        this.FeedBack = FeedBack;
    }

    public HocSinh_LopHoc(Integer ID_LopHoc, Integer ID_HocSinh, Integer ID_HSLopHoc, String FeedBack, boolean Status_FeedBack) {
        this.ID_LopHoc = ID_LopHoc;
        this.ID_HocSinh = ID_HocSinh;
        this.ID_HSLopHoc = ID_HSLopHoc;
        this.FeedBack = FeedBack;
        this.Status_FeedBack = Status_FeedBack;
    }

    public HocSinh_LopHoc() {
    }

    public boolean isStatus_FeedBack() {
        return Status_FeedBack;
    }

    public void setStatus_FeedBack(boolean Status_FeedBack) {
        this.Status_FeedBack = Status_FeedBack;
    }

        
}

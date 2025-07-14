package model;

/**
 * Represents an educational level (e.g., Primary, Secondary, High School)
 * in the tutoring center system.
 * 
 * This class holds basic information about the level such as its ID,
 * name, and status (e.g., active/inactive).
 * 
 * @author trungdam1305
 */
public class KhoiHoc {

    private int ID_Khoi;         // Unique ID of the level
    private String TenKhoi;      // Name of the level (e.g., "Primary", "Grade 10")
    private int Status_Khoi;     // Status (1 = active, 0 = inactive)
    private String Image;
    /**
     * Default constructor.
     */
    public KhoiHoc() {
    }

    /**
     * Full-argument constructor.
     * 
     * @param ID_Khoi      Unique identifier of the educational level
     * @param TenKhoi      Name of the educational level
     * @param Status_Khoi  Status (1: active, 0: inactive)
     */
    public KhoiHoc(int ID_Khoi, String TenKhoi, int Status_Khoi) {
        this.ID_Khoi = ID_Khoi;
        this.TenKhoi = TenKhoi;
        this.Status_Khoi = Status_Khoi;
    }

    // Getter and Setter methods

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

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public KhoiHoc(int ID_Khoi, String TenKhoi, int Status_Khoi, String Image) {
        this.ID_Khoi = ID_Khoi;
        this.TenKhoi = TenKhoi;
        this.Status_Khoi = Status_Khoi;
        this.Image = Image;
    }
    
    
}

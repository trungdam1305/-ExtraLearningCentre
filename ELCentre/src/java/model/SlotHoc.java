package model;

/**
 * The SlotHoc class represents a specific time slot for a class session.
 * It includes an ID and a string representing the time (e.g. "08:00 - 09:30").
 * This class is typically used for scheduling classes in a timetable.
 * 
 * Author: admin
 */
public class SlotHoc {

    // Unique identifier for the time slot
    private int ID_SlotHoc;

    // Time slot description (e.g., "08:00 - 09:30")
    private String SlotThoiGian;

    /**
     * Constructor with parameters to initialize all attributes.
     * 
     * @param ID_SlotHoc      the ID of the time slot
     * @param SlotThoiGian    the time range string
     */
    public SlotHoc(int ID_SlotHoc, String SlotThoiGian) {
        this.ID_SlotHoc = ID_SlotHoc;
        this.SlotThoiGian = SlotThoiGian;
    }

    /**
     * Default constructor.
     */
    public SlotHoc() {
    }

    // Getter for ID_SlotHoc
    public int getID_SlotHoc() {
        return ID_SlotHoc;
    }

    // Setter for ID_SlotHoc
    public void setID_SlotHoc(int ID_SlotHoc) {
        this.ID_SlotHoc = ID_SlotHoc;
    }

    // Getter for SlotThoiGian
    public String getSlotThoiGian() {
        return SlotThoiGian;
    }

    // Setter for SlotThoiGian
    public void setSlotThoiGian(String SlotThoiGian) {
        this.SlotThoiGian = SlotThoiGian;
    }
}

package model;

public class SlotHoc {
    private Integer idSlotHoc;
    private String slotThoiGian;

    // Constructor mặc định
    public SlotHoc() {
    }

    // Constructor đầy đủ
    public SlotHoc(Integer idSlotHoc, String slotThoiGian) {
        this.idSlotHoc = idSlotHoc;
        this.slotThoiGian = slotThoiGian;
    }

    // Getters và Setters
    public Integer getIdSlotHoc() {
        return idSlotHoc;
    }

    public void setIdSlotHoc(Integer idSlotHoc) {
        this.idSlotHoc = idSlotHoc;
    }

    public String getSlotThoiGian() {
        return slotThoiGian;
    }

    public void setSlotThoiGian(String slotThoiGian) {
        this.slotThoiGian = slotThoiGian;
    }

    @Override
    public String toString() {
        return "SlotHoc{" +
                "idSlotHoc=" + idSlotHoc +
                ", slotThoiGian='" + slotThoiGian + '\'' +
                '}';
    }
}
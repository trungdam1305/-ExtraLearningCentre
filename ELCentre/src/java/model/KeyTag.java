package model;

public class KeyTag {
    private int ID_KeyTag;
    private String KeyTag; // The actual tag name

    public KeyTag() {}

    public KeyTag(int ID_KeyTag, String KeyTag) {
        this.ID_KeyTag = ID_KeyTag;
        this.KeyTag = KeyTag;
    }

    public int getID_KeyTag() {
        return ID_KeyTag;
    }

    public void setID_KeyTag(int ID_KeyTag) {
        this.ID_KeyTag = ID_KeyTag;
    }

    public String getKeyTag() {
        return KeyTag;
    }

    public void setKeyTag(String KeyTag) {
        this.KeyTag = KeyTag;
    }
}
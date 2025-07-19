// In model/Keyword.java
package model;

public class Keyword {
    private int ID_Keyword;
    private String Keyword; // The actual keyword name

    public Keyword() {}

    public Keyword(int ID_Keyword, String Keyword) {
        this.ID_Keyword = ID_Keyword;
        this.Keyword = Keyword;
    }

    // Getters and Setters
    public int getID_Keyword() {
        return ID_Keyword;
    }

    public void setID_Keyword(int ID_Keyword) {
        this.ID_Keyword = ID_Keyword;
    }

    public String getKeyword() {
        return Keyword;
    }

    public void setKeyword(String Keyword) {
        this.Keyword = Keyword;
    }
}
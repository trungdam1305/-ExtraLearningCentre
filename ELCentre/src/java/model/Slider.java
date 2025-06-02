/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Slider {
    private int ID_Slider;
    private String Title;
    private String Image;
    private String BackLink;

    public Slider() {
    }

    public Slider(int ID_Slider, String Title, String Image, String BackLink) {
        this.ID_Slider = ID_Slider;
        this.Title = Title;
        this.Image = Image;
        this.BackLink = BackLink;
    }

    public int getID_Slider() {
        return ID_Slider;
    }

    public void setID_Slider(int ID_Slider) {
        this.ID_Slider = ID_Slider;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getBackLink() {
        return BackLink;
    }

    public void setBackLink(String BackLink) {
        this.BackLink = BackLink;
    }
    
    
}

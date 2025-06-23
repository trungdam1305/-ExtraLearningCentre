package model;

/**
 * The Slider class represents a banner or carousel item on the homepage or UI.
 * It contains information such as ID, title, image path, and a backlink URL.
 * This class can be used to dynamically render image sliders in the frontend.
 * 
 * Author: admin
 */
public class Slider {
    // Unique ID of the slider
    private int ID_Slider;

    // Title or description shown with the slider
    private String Title;

    // Path or URL to the image file
    private String Image;

    // Optional backlink URL when the slider is clicked
    private String BackLink;

    /**
     * Default constructor.
     */
    public Slider() {
    }

    /**
     * Full constructor with all attributes.
     * 
     * @param ID_Slider  ID of the slider
     * @param Title      Title or caption of the slider
     * @param Image      Image path or URL
     * @param BackLink   Hyperlink associated with the slider
     */
    public Slider(int ID_Slider, String Title, String Image, String BackLink) {
        this.ID_Slider = ID_Slider;
        this.Title = Title;
        this.Image = Image;
        this.BackLink = BackLink;
    }

    // Getter and Setter methods

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

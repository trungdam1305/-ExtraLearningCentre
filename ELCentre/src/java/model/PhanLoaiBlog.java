/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 * Represents a blog category used to classify blog entries.
 * Each category has a unique ID and a name.
 * 
 * Author: trungdam1305
 */
public class PhanLoaiBlog {
    // Unique identifier for the blog category
    private int ID_PhanLoai;

    // Name of the blog category
    private String PhanLoai;

    /**
     * Default constructor
     */
    public PhanLoaiBlog() {
    }

    /**
     * Constructor that initializes both fields
     */
    public PhanLoaiBlog(int ID_PhanLoai, String PhanLoai) {
        this.ID_PhanLoai = ID_PhanLoai;
        this.PhanLoai = PhanLoai;
    }

    /**
     * Returns the ID of the blog category
     */
    public int getID_PhanLoai() {
        return ID_PhanLoai;
    }

    /**
     * Returns the name of the blog category
     */
    public String getPhanLoai() {
        return PhanLoai;
    }

    /**
     * Sets the ID of the blog category
     */
    public void setID_PhanLoai(int ID_PhanLoai) {
        this.ID_PhanLoai = ID_PhanLoai;
    }

    /**
     * Sets the name of the blog category
     */
    public void setPhanLoai(String PhanLoai) {
        this.PhanLoai = PhanLoai;
    }
}

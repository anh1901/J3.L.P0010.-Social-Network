/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.dtos;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 *
 * @author DELL
 */
public class EmotionDTO implements Serializable{
    private int emotionID;
    private int postID;
    private String email;
    private String date;
    private String status;

    public EmotionDTO() {
    }

    public EmotionDTO(int postID, String email, String date) {
        this.postID = postID;
        this.email = email;
        this.date = date;
    }
    
    public EmotionDTO(int postID, String email, String date, String status) {
        this.postID = postID;
        this.email = email;
        this.date = date;
        this.status = status;
    }

    public int getEmotionID() {
        return emotionID;
    }

    public void setEmotionID(int emotionID) {
        this.emotionID = emotionID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}

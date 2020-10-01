/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.dtos;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
public class PostDTO implements Serializable{
    private int postID;
    private String email;
    private String content;
    private String image;
    private String dateTimeOfArticle;
    private String status;
    private int numberOfLike;
    private int numberOfDislike;
    private ArrayList<CommentDTO> comments;
    public PostDTO() {
    }

    public PostDTO(String email, String content, String image, String dateTimeOfArticle) {
        this.email = email;
        this.content = content;
        this.image = image;
        this.dateTimeOfArticle = dateTimeOfArticle;
    }

    public PostDTO(int postID, String email, String content, String image, String dateTimeOfArticle, int numberOfLike, int numberOfDislike) {
        this.postID = postID;
        this.email = email;
        this.content = content;
        this.image = image;
        this.dateTimeOfArticle = dateTimeOfArticle;
        this.numberOfLike = numberOfLike;
        this.numberOfDislike = numberOfDislike;
    }
    
    
    public PostDTO(int postID, String email, String content, String image, String dateTimeOfArticle, String status, int numberOfLike, int numberOfDislike, ArrayList<CommentDTO> comments) {
        this.postID = postID;
        this.email = email;
        this.content = content;
        this.image = image;
        this.dateTimeOfArticle = dateTimeOfArticle;
        this.status = status;
        this.numberOfLike = numberOfLike;
        this.numberOfDislike = numberOfDislike;
        this.comments = comments;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDateTimeOfArticle() {
        return dateTimeOfArticle;
    }

    public void setDateTimeOfArticle(String dateTimeOfArticle) {
        this.dateTimeOfArticle = dateTimeOfArticle;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getNumberOfLike() {
        return numberOfLike;
    }

    public void setNumberOfLike(int numberOfLike) {
        this.numberOfLike = numberOfLike;
    }

    public int getNumberOfDislike() {
        return numberOfDislike;
    }

    public void setNumberOfDislike(int numberOfDislike) {
        this.numberOfDislike = numberOfDislike;
    }

    public ArrayList<CommentDTO> getComments() {
        return comments;
    }

    public void setComments(ArrayList<CommentDTO> comments) {
        this.comments = comments;
    }
    
    
}



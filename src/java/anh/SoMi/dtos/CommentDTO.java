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
public class CommentDTO implements Serializable{
    private int commentID;
    private int postID;
    private String email;
    private String content;
    private String dateTimeOfComment;
    private String status;
    public CommentDTO() {
    }

    public CommentDTO(int commentID, String email, String content, String dateTimeOfComment) {
        this.commentID = commentID;
        this.email = email;
        this.content = content;
        this.dateTimeOfComment = dateTimeOfComment;
    }
    public CommentDTO(int commentID, int postID, String email, String content, String dateTimeOfComment, String status) {
        this.commentID = commentID;
        this.postID = postID;
        this.email = email;
        this.content = content;
        this.dateTimeOfComment = dateTimeOfComment;
        this.status = status;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
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

    public String getDateTimeOfComment() {
        return dateTimeOfComment;
    }

    public void setDateTimeOfComment(String dateTimeOfComment) {
        this.dateTimeOfComment = dateTimeOfComment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}

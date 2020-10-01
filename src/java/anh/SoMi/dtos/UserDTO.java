/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.dtos;

import java.io.Serializable;
/**
 *
 * @author DELL
 */
public class UserDTO implements Serializable{
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private int status;
    private int unreadNotification;
    public UserDTO() {
    }

    public UserDTO(String firstName, String lastName, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
    }

    public UserDTO(String firstName, String lastName, String email, String password, int status, int unreadNotification) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.status = status;
        this.unreadNotification = unreadNotification;
    }
    
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getUnreadNotification() {
        return unreadNotification;
    }

    public void setUnreadNotification(int unreadNotification) {
        this.unreadNotification = unreadNotification;
    }
    
    

}

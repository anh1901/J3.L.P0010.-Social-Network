/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.daos;

import anh.SoMi.utils.DBUtils;
import anh.SoMi.dtos.UserDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class UserDAO implements Serializable {

    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    final static Logger logger = Logger.getLogger(UserDAO.class.getName());
    public boolean checkUserExist(String email) throws SQLException, NamingException {
        logger.info("Checking user existance...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select status from [user] where email=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                rs = ps.executeQuery();
                if (rs.next()) {
                    logger.info("Existed.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Not exist.");
        return false;
    }
    public boolean checkLogin(String email, String password) throws SQLException, NamingException {
        logger.info("Checking login infomation...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select status from [user] where email=? and password=? ";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);
                rs=ps.executeQuery();
                if (rs.next()) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return false;
    }
    
    public boolean insertNewUser(String firstName, String lastName, String email, String password) throws SQLException, NamingException {
        logger.info("Creating new user...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into [user] (firstName, lastName, email, password, status,unreadNotification) "
                        + "values(?,?,?,?,?,?)";
                ps = c.prepareStatement(sql);
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, email);
                ps.setString(4, password);
                ps.setString(5, "1");
                ps.setInt(6,0);
                if (ps.executeUpdate() > 0) {
                    logger.info("Created");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to create.");
        return false;
    }

    public boolean insertNewUserActivationCode(String email, int activationCode) throws NamingException, SQLException {
        logger.info("Creating activation code...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into [otp] (email, otp) "
                        + "values(?,?)";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                ps.setInt(2, activationCode);
                if (ps.executeUpdate() > 0) {
                    logger.info("Created.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to create.");
        return false;
    }

    public UserDTO getUserInfo(String email, String password) throws NamingException, SQLException {
        logger.info("Getting user infomation...");
        UserDTO dto = null;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select firstName, lastName, email, password, status, unreadNotification from [user] where email=? and password=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);
                rs=ps.executeQuery();
                if (rs.next()) {
                    dto=new UserDTO(rs.getString(1), rs.getString(2), rs.getString(3),rs.getString(4),rs.getInt(5),rs.getInt(6));
                    logger.info("Got user infomation.");
                    return dto;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to get user infomation.");
        return dto;
    }
    
    public boolean checkOTP(String email, int otp) throws NamingException, SQLException {
        logger.info("Checking OTP");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "SELECT id from [otp] where email=? and otp=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                ps.setInt(2, otp);
                rs = ps.executeQuery();
                if (rs.next()) {
                    logger.info("Right OTP.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Wrong OTP.");
        return false;
    }

    public boolean updateStatus(String email) throws NamingException, SQLException {
        logger.info("Updating status...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update [user] set status=2 where email=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, email);
                int result = ps.executeUpdate();
                if (result > 0) {
                    logger.info("Updated.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to update.");
        return false;
    }
    public UserDTO updateUnreadNotification(UserDTO userDTO, int number) throws NamingException, SQLException{
        logger.info("Updating unread notification...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update [user] set unreadNotification=? where email=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, number);
                ps.setString(2, userDTO.getEmail());
                int result = ps.executeUpdate();
                if (result > 0) {
                    userDTO.setUnreadNotification(number);
                    logger.info("Updated.");
                    return userDTO;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to update.");
        return userDTO;
    }
    public boolean updateOTP(int otp, String email) throws Exception {
        logger.info("Updating OTP...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update [otp] set otp=? where email=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, otp);
                ps.setString(2, email);
                int result = ps.executeUpdate();
                if (result > 0) {
                    logger.info("Updated.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to update.");
        return false;
    }

    public void closeConnection(Connection con, PreparedStatement ps, ResultSet rs) throws SQLException {
        if (rs != null && !rs.isClosed()) {
            rs.close();
        }
        if (ps != null && !ps.isClosed()) {
            ps.close();
        }
        if (con != null && !con.isClosed()) {
            con.close();
        }
    }
}

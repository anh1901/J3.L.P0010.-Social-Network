/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.daos;

import anh.SoMi.utils.DBUtils;
import anh.SoMi.dtos.EmotionDTO;
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
public class EmotionDAO {

    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    final static Logger logger = Logger.getLogger(EmotionDAO.class.getName());
    public EmotionDTO getEmotionInfo(int postID) throws SQLException, NamingException {
        logger.info("Getting emotion of post...");
        EmotionDTO emotionDTO = null;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select email,date from emotion where and postID=? ";
                ps = c.prepareStatement(sql);
                ps.setInt(1, postID);
                rs = ps.executeQuery();
                if (rs.next()) {
                    emotionDTO = new EmotionDTO(postID, rs.getString(1), rs.getString(2));
                    logger.info("Got post's emotion.");
                    return emotionDTO;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to got post's emotion.");
        return emotionDTO;
    }

    public String checkEmotionStatus(String email, int postID) throws SQLException, NamingException {
        logger.info("Getting user emotion on post...");
        String status = "";
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select Name from status where statusID=(SELECT status FROM emotion WHERE postID=? AND email=?)";
                ps = c.prepareStatement(sql);
                ps.setInt(1, postID);
                ps.setString(2, email);
                rs = ps.executeQuery();
                if (rs.next()) {
                    status = rs.getString(1);
                    logger.info("Got user emotion on post.");
                    return status;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("No emotion of user on this post.");
        return status;
    }
    public boolean updateEmotionStatusOfUser(String status,String email, int postID) throws NamingException, SQLException{
        logger.info("Updating emotion status of user...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update emotion set status = (Select statusID from status where name=? ) where postID=? and email=?";
                ps = c.prepareStatement(sql);
                ps.setString(1, status);
                ps.setInt(2, postID);
                ps.setString(3, email);
                if (ps.executeUpdate() > 0) {
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
    public boolean insertEmotionOfUserOnPost(EmotionDTO emotionDTO) throws SQLException, NamingException {
        logger.info("Creating user emotion on post...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into emotion (postID, email, status, date) values(?,?,?,?)";
                ps = c.prepareStatement(sql);
                ps.setInt(1, emotionDTO.getPostID());
                ps.setString(2, emotionDTO.getEmail());
                ps.setString(3, emotionDTO.getStatus());
                ps.setString(4, emotionDTO.getDate());
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.daos;

import anh.SoMi.dtos.NotificationDTO;
import anh.SoMi.utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class NotificationDAO {
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    final static Logger logger = Logger.getLogger(NotificationDAO.class.getName());
    public boolean insertNotification(NotificationDTO notificationDTO) throws SQLException, NamingException{
        logger.info("Creating user notification...");
        try{
            c=DBUtils.makeConnection();
            if(c != null){
                String sql="insert into notification (postID,email,date,type)"
                        + " values(?,?,?,?)";
                ps=c.prepareStatement(sql);
                ps.setInt(1, notificationDTO.getPostID());
                ps.setString(2, notificationDTO.getEmail());
                ps.setString(3, notificationDTO.getDate());
                ps.setString(4, notificationDTO.getType());
                if(ps.executeUpdate()>0){
                    logger.info("Created.");
                    return true;
                }       
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to updated.");
        return false;
    }
    public ArrayList<NotificationDTO> getNotificationOfUser(String email) throws SQLException, NamingException{
        logger.info("Getting notifications of user...");
        ArrayList<NotificationDTO> notifications = null;
        NotificationDTO notification;
        try{
            c=DBUtils.makeConnection();
            if(c!= null){
                String sql="SELECT postID, email,date, type FROM dbo.notification WHERE postID IN (SELECT postID FROM dbo.post WHERE email=?) order by date DESC";
                ps=c.prepareStatement(sql);
                ps.setString(1, email);
                rs=ps.executeQuery();
                notifications=new ArrayList<>();
                while(rs.next()){
                    notification=new NotificationDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                    notifications.add(notification);
                }
                logger.info("Got notifications.");
                return notifications;
            }
        }finally{
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to get notification.");
        return notifications;
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

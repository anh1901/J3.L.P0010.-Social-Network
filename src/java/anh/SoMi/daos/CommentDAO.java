/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.daos;

import anh.SoMi.utils.DBUtils;
import anh.SoMi.dtos.CommentDTO;
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
public class CommentDAO {
    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    final static Logger logger = Logger.getLogger(CommentDAO.class.getName());

    public boolean insertComment(CommentDTO commentDTO) throws SQLException, NamingException{
        logger.info("Insert comment to database");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into [comment] (postID, email, content, date, status) "
                        + "values(?,?,?,?,?)";
                ps = c.prepareStatement(sql);
                ps.setInt(1, commentDTO.getPostID());
                ps.setString(2, commentDTO.getEmail());
                ps.setString(3, commentDTO.getContent());
                ps.setString(4, commentDTO.getDateTimeOfComment());
                ps.setInt(5, 3);
                if (ps.executeUpdate() > 0) {
                    logger.info("Insert Successful.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to insert.");
        return false;
    }
   
    public ArrayList<CommentDTO> getCommentsOfPost(int postID) throws NamingException, SQLException{
        ArrayList<CommentDTO> comments = new ArrayList<CommentDTO>();
        CommentDTO comment=null;
        logger.info("Getting comments of post...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select commentID, email, content, date from comment where postID=? and status=3 order by date DESC";
                ps = c.prepareStatement(sql);
                ps.setInt(1, postID);
                rs=ps.executeQuery();
                while(rs.next()) {
                    comment=new CommentDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                    comments.add(comment);
                }
                logger.info("Got all comments of post.");
                return comments;
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to get all comments of post.");
        return comments;
    }
    public boolean deleteCommentsOfArticle(int commentID) throws NamingException, SQLException{
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update comment set status=4 where commentID=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, commentID);
                if (ps.executeUpdate() > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
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

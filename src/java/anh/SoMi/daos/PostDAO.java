/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.daos;

import anh.SoMi.utils.DBUtils;
import anh.SoMi.dtos.PostDTO;
import java.io.Serializable;
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
public class PostDAO implements Serializable {

    Connection c = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    final static Logger logger = Logger.getLogger(PostDAO.class.getName());
    public boolean insertPost(PostDTO postDTO) throws SQLException, NamingException {
        logger.info("Creating post...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "insert into [post] (email, description, image, date, status, numberOfLike, numberOfDislike) "
                        + "values(?,?,?,?,?,?,?)";
                ps = c.prepareStatement(sql);
                ps.setString(1, postDTO.getEmail());
                ps.setString(2, postDTO.getContent());
                ps.setString(3, postDTO.getImage());
                ps.setString(4, postDTO.getDateTimeOfArticle());
                ps.setInt(5, 3);
                ps.setInt(6, 0);
                ps.setInt(7, 0);
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
    
    public boolean deletePost(int postID) throws SQLException, NamingException {
        logger.info("Deleting post...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update post set status=4 where postID=?";
                ps = c.prepareStatement(sql);
                ps.setInt(1, postID);
                if (ps.executeUpdate() > 0) {
                    logger.info("Deleted.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to delete.");
        return false;
    }

    public ArrayList<PostDTO> getAllPosts(int offset, int postsPerPage) throws SQLException, NamingException {
        logger.info("Getting list of post...");
        ArrayList<PostDTO> postDTOs = new ArrayList<PostDTO>();
        PostDTO postDTO;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "Select postID, email, description, image, date, numberOfLike, numberOfDisLike from post where status=3"
                        + " order by date DESC offset ? rows fetch next ? rows only";
                ps = c.prepareStatement(sql);
                ps.setInt(1, offset);
                ps.setInt(2, postsPerPage);
                rs = ps.executeQuery();
                while (rs.next()) {
                    postDTO = new PostDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7));
                    postDTOs.add(postDTO);
                }
                logger.info("Got list of post.");
                return postDTOs;
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to get the list.");
        return postDTOs;
    }

    public int countAllPosts() throws NamingException, SQLException {
        logger.info("Counting posts...");
        int count = 0;
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "select count(postID) from post where status=3";
                ps = c.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    logger.info("Number of post:"+rs.getInt(1));
                    return count = rs.getInt(1);
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to count.");
        return count;
    }

    public ArrayList<PostDTO> searchPostByContent(String searchValue) throws NamingException, SQLException {
        logger.info("Searching post by content...");
        ArrayList<PostDTO> postDTOs = new ArrayList<PostDTO>();
        PostDTO postDTO;
        try {
            c=DBUtils.makeConnection();
            if(c!=null){
                String sql="SELECT  postID, email, description, image, date, numberOfLike, numberOfDisLike FROM post WHERE description LIKE '%"+searchValue+"%' order by date DESC";
                ps=c.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    postDTO = new PostDTO(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7));
                    postDTOs.add(postDTO);
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        return postDTOs;
    }

    public boolean updateLikeCount(int numberOfLike, String postID) throws NamingException, SQLException {
        logger.info("Updating number of like...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update post set numberOfLike=? where postID=? ";
                ps = c.prepareStatement(sql);
                ps.setInt(1, numberOfLike);
                ps.setString(2, postID);
                if (ps.executeUpdate() > 0) {
                    logger.info("Updated.");
                    return true;
                }
            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to updated.");
        return false;
    }

    public boolean updateDislikeCount(int numberOfLike, String postID) throws NamingException, SQLException {
        logger.info("Updating dislike count...");
        try {
            c = DBUtils.makeConnection();
            if (c != null) {
                String sql = "update post set numberOfDislike=? where postID=? ";
                ps = c.prepareStatement(sql);
                ps.setInt(1, numberOfLike);
                ps.setString(2, postID);
                if (ps.executeUpdate() > 0) {
                    logger.info("updated.");
                    return true;
                }

            }
        } finally {
            closeConnection(c, ps, rs);
        }
        logger.info("Fail to updated.");
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

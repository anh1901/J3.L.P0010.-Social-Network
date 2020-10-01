/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.servlets;

import anh.SoMi.daos.PostDAO;
import anh.SoMi.daos.CommentDAO;
import anh.SoMi.daos.NotificationDAO;
import anh.SoMi.dtos.PostDTO;
import anh.SoMi.dtos.CommentDTO;
import anh.SoMi.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class HomePageServlet extends HttpServlet {

    ArrayList<PostDTO> posts = new ArrayList<PostDTO>();
    ArrayList<CommentDTO> comments = new ArrayList<CommentDTO>();
    final static Logger logger = Logger.getLogger(HomePageServlet.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PostDAO postDAO = new PostDAO();
        int postsPerPage = 20;
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        try {
            int numberOfPosts = postDAO.countAllPosts();
            int numberOfPage = 1;
            if (numberOfPosts % postsPerPage == 0) {
                numberOfPage = numberOfPosts / postsPerPage;
            } else {
                numberOfPage = numberOfPosts / postsPerPage + 1;
            }
            request.setAttribute("numberOfPage", numberOfPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("posts", getAllCommentsOfArticle((page - 1) * postsPerPage, postsPerPage));
            //load notification
            HttpSession session = request.getSession();
            if (session.getAttribute("User") != null) {
                UserDTO userDTO = (UserDTO) session.getAttribute("User");
                NotificationDAO notificationDAO = new NotificationDAO();
                session.setAttribute("notifications", notificationDAO.getNotificationOfUser(userDTO.getEmail()));
            }
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } finally {
            logger.info("Redirect to HomePage.jsp.");
            request.getRequestDispatcher("HomePage.jsp").forward(request, response);
        }
    }

    public ArrayList<PostDTO> getAllCommentsOfArticle(int offset, int postsPerPage) {
        try {
            ArrayList<PostDTO> posts;
            PostDAO postDAO = new PostDAO();
            CommentDAO commentDAO = new CommentDAO();
            posts = postDAO.getAllPosts(offset, postsPerPage);
            for (PostDTO post : posts) {
                post.setComments(commentDAO.getCommentsOfPost(post.getPostID()));
            }
            return posts;
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        }
        return posts;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

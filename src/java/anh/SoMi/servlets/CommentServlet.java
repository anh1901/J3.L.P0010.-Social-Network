/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.servlets;

import anh.SoMi.daos.CommentDAO;
import anh.SoMi.daos.NotificationDAO;
import anh.SoMi.daos.UserDAO;
import anh.SoMi.dtos.CommentDTO;
import anh.SoMi.dtos.NotificationDTO;
import anh.SoMi.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
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
public class CommentServlet extends HttpServlet {
    private static final String ERROR="HomePage.jsp";
    private static final String SUCCESS="HomePageServlet";
    final static Logger logger = Logger.getLogger(CommentServlet.class.getName());
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url=ERROR;
        UserDTO userDTO=null;
        try{
            String content=request.getParameter("comment");
            String postID=request.getParameter("postID");
            HttpSession session=request.getSession(false);
            userDTO=(UserDTO)session.getAttribute("User");
            logger.debug("Comment: "+content);
            CommentDTO commentDTO=new CommentDTO(Integer.parseInt(postID),userDTO.getEmail(), content, ""+new Timestamp(System.currentTimeMillis()));
            CommentDAO commentDAO=new CommentDAO();
            if(commentDAO.insertComment(commentDTO)){
                url=SUCCESS;
            }
            //notification
            NotificationDTO notificationDTO=new NotificationDTO(Integer.parseInt(postID), userDTO.getEmail(), ""+new Timestamp(System.currentTimeMillis()), "commented");
            NotificationDAO notificationDAO=new NotificationDAO();
            notificationDAO.insertNotification(notificationDTO);
            userDTO=(UserDTO)session.getAttribute("User");
            session.setAttribute("notifications", notificationDAO.getNotificationOfUser(userDTO.getEmail()));
            UserDAO userDAO=new UserDAO();
            userDTO=userDAO.updateUnreadNotification(userDTO, userDTO.getUnreadNotification()+1);
            session.setAttribute("User", userDTO);
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        }finally{
            logger.info("Redirect to "+url);
            request.getRequestDispatcher(url).forward(request, response);
        }
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

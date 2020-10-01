/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.servlets;

import anh.SoMi.daos.EmotionDAO;
import anh.SoMi.daos.NotificationDAO;
import anh.SoMi.daos.PostDAO;
import anh.SoMi.daos.UserDAO;
import anh.SoMi.dtos.EmotionDTO;
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
public class EmotionServlet extends HttpServlet {
    final static Logger logger = Logger.getLogger(EmotionServlet.class.getName());
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String button = request.getParameter("button");
            String postID = request.getParameter("postID");
            String numberOfLike = request.getParameter("numberOfLike");
            String numberOfDislike = request.getParameter("numberOfDislike");
            EmotionDAO emotionDAO = new EmotionDAO();
            PostDAO postDAO = new PostDAO();
            HttpSession session = request.getSession(false);
            UserDTO userDTO = (UserDTO) session.getAttribute("User");
            logger.info("Checking status emotion...");
            if (emotionDAO.checkEmotionStatus(userDTO.getEmail(), Integer.parseInt(postID)).equals("Liked")) {
                logger.info("Status liked.Checking button...");
                if (button.equals("Like")) {
                    postDAO.updateLikeCount(Integer.parseInt(numberOfLike) - 1, postID);
                    emotionDAO.updateEmotionStatusOfUser("Nothing", userDTO.getEmail(), Integer.parseInt(postID));
                } else {
                    postDAO.updateLikeCount(Integer.parseInt(numberOfLike) - 1, postID);
                    postDAO.updateDislikeCount(Integer.parseInt(numberOfDislike) + 1, postID);
                    emotionDAO.updateEmotionStatusOfUser("Disliked", userDTO.getEmail(), Integer.parseInt(postID));
                }
            } else if (emotionDAO.checkEmotionStatus(userDTO.getEmail(), Integer.parseInt(postID)).equals("Disliked")) {
                logger.info("Status disliked.Checking button...");
                if (button.equals("Like")) {
                    postDAO.updateDislikeCount(Integer.parseInt(numberOfDislike) - 1, postID);
                    postDAO.updateLikeCount(Integer.parseInt(numberOfLike) + 1, postID);
                    emotionDAO.updateEmotionStatusOfUser("Liked", userDTO.getEmail(), Integer.parseInt(postID));
                } else {
                    postDAO.updateDislikeCount(Integer.parseInt(numberOfDislike) - 1, postID);
                    emotionDAO.updateEmotionStatusOfUser("Nothing", userDTO.getEmail(), Integer.parseInt(postID));
                }
            } else if (emotionDAO.checkEmotionStatus(userDTO.getEmail(), Integer.parseInt(postID)).equals("Nothing")) {
                logger.info("No emotion yet. Checking button...");
                if (button.equals("Like")) {
                    postDAO.updateLikeCount(Integer.parseInt(numberOfLike) + 1, postID);
                    emotionDAO.updateEmotionStatusOfUser("Liked", userDTO.getEmail(), Integer.parseInt(postID));
                } else {
                    postDAO.updateDislikeCount(Integer.parseInt(numberOfDislike) + 1, postID);
                    emotionDAO.updateEmotionStatusOfUser("Disliked", userDTO.getEmail(), Integer.parseInt(postID));
                }
            } else {
                logger.info("First time interact with post. Checking button...");
                EmotionDTO emotionDTO = null;
                if (button.equals("Like")) {
                    emotionDTO = new EmotionDTO(Integer.parseInt(postID), userDTO.getEmail(), "" + new Timestamp(System.currentTimeMillis()), "" + 5);
                    emotionDAO.insertEmotionOfUserOnPost(emotionDTO);
                    postDAO.updateLikeCount(Integer.parseInt(numberOfLike) + 1, postID);
                } else {
                    emotionDTO = new EmotionDTO(Integer.parseInt(postID), userDTO.getEmail(), "" + new Timestamp(System.currentTimeMillis()), "" + 6);
                    emotionDAO.insertEmotionOfUserOnPost(emotionDTO);
                    postDAO.updateDislikeCount(Integer.parseInt(numberOfDislike) + 1, postID);
                }
            }
            NotificationDTO notificationDTO = new NotificationDTO(Integer.parseInt(postID), userDTO.getEmail(), "" + new Timestamp(System.currentTimeMillis()), button);
            NotificationDAO notificationDAO = new NotificationDAO();
            notificationDAO.insertNotification(notificationDTO);
            userDTO=(UserDTO)session.getAttribute("User");
            session.setAttribute("notifications", notificationDAO.getNotificationOfUser(userDTO.getEmail()));
            UserDAO userDAO=new UserDAO();
            userDTO=userDAO.updateUnreadNotification(userDTO, userDTO.getUnreadNotification()+1);
            session.setAttribute("User", userDTO);
        } catch (NamingException ex) {
            logger.error(ex.getMessage());
        } catch (SQLException ex) {
            logger.error(ex.getMessage());
        } finally {
            logger.info("Redirect to HomePageServlet.");
            request.getRequestDispatcher("HomePageServlet").forward(request, response);
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

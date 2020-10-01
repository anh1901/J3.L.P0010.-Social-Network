/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.servlets;

import anh.SoMi.daos.UserDAO;
import anh.SoMi.utils.EncryptSHA256;
import anh.SoMi.utils.SendEmail;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;
import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class LoginServlet extends HttpServlet {
    final static Logger logger = Logger.getLogger(LoginServlet.class.getName());
    private static final String ERROR = "index.jsp";
    private static final String OTP = "OTP.jsp";
    private String host;
    private String port;
    private String email;
    private String pass;

    public void init() {
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        email = context.getInitParameter("email");
        pass = context.getInitParameter("pass");
    }

    public LoginServlet() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        int minOtp = 10000000;
        int maxOtp = 99999999;
        int otp = 0;
        Random random = new Random();
        UserDAO dao = new UserDAO();
        otp = random.nextInt(maxOtp - minOtp) + minOtp;
        String recipentEmail = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        String subject = "";
        String content = "";
        String url = ERROR;
        String encryptedPassword = "";
        try {
            Thread.sleep(1000);
            boolean checkInput = true;
            if (recipentEmail.length() == 0 || !recipentEmail.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
                request.setAttribute("emailError", "Invalid email format");
                checkInput = false;
                logger.warn("Wrong email format.");
            }
            if (password.length() < 8 || password.length() > 50) {
                request.setAttribute("passwordError", "Password is between 8 and 50");
                checkInput = false;
                logger.warn("Wrong password format.");
            }
            encryptedPassword = EncryptSHA256.sha256(password);
            if (checkInput) {
                try {
                    logger.info("Checking user existence...");
                    if (dao.checkUserExist(recipentEmail)) {
                        try {
                            logger.info("Checking login...");
                            if (dao.checkLogin(recipentEmail, encryptedPassword)) {
                                switch (dao.getUserInfo(recipentEmail, encryptedPassword).getStatus()) {
                                    case 2:
                                        try {
                                            if (dao.updateOTP(otp, recipentEmail)) {
                                                subject = otp + " is your SoMi OTP code";
                                                content = "Hi\nYou are trying to login your email. Your OTP is " + otp + ".\nSoMi.\n\nThis is an automated"
                                                        + " mail. Please do not reply to this email.";
                                                url = OTP;
                                                SendEmail.sendEmail(host, port, email, pass, recipentEmail, subject, content);
                                            } else {
                                                request.setAttribute("ERROR", "Server can not update OTP.\n"
                                                        + "Try again.");
                                            }
                                        } catch (MessagingException ex) {
                                            logger.error(ex.getMessage());
                                        } catch (Exception ex) {
                                            logger.error(ex.getMessage());
                                        }
                                        break;
                                    case 1:
                                        try {
                                            if (dao.updateOTP(otp, recipentEmail)) {
                                                subject = otp + " is your SoMi activation code";
                                                content = "Hi\nYou are trying to register with your email. Your activation code is " + otp + ".\nSoMi.\n\nThis is an automated"
                                                        + " mail. Please do not reply to this email.";
                                                url = OTP;
                                                SendEmail.sendEmail(host, port, email, pass, recipentEmail, subject, content);
                                            } else {
                                                request.setAttribute("ERROR", "Something went wrong.\n"
                                                        + "Try again.");
                                            }
                                        } catch (MessagingException ex) {
                                            logger.error(ex.getMessage());
                                        } catch (Exception ex) {
                                            logger.error(ex.getMessage());
                                        }
                                        break;
                                    default:
                                        request.setAttribute("ERROR", "Invalid status found..\n"
                                                + "Try again.");
                                        break;
                                }
                            } else {
                                request.setAttribute("ERROR", "Wrong password. Try again.");
                            }
                        }catch(Exception ex){
                            logger.error(ex.getMessage());
                        }
                    }else{
                        request.setAttribute("ERROR", "User is not exist in the network.\nTry register a new one.");
                    }
                } catch (SQLException ex) {
                    logger.error(ex.getMessage());
                } catch (NamingException ex) {
                    logger.error(ex.getMessage());
                } 
            } else {
                request.setAttribute("ERROR", "Check your input.");
            }
        } catch (InterruptedException ex) {
            logger.error(ex.getMessage());
        } finally {
            try {
                logger.info("Redirect to "+url);
                request.getRequestDispatcher(url).forward(request, response);
            } catch (ServletException ex) {
                logger.error(ex.getMessage());
            } catch (IOException ex) {
                logger.error(ex.getMessage());
            }
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

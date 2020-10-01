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
import java.util.Random;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
@WebServlet(name = "RegisterController", urlPatterns = "/RegisterController")
public class RegisterServlet extends HttpServlet {
    final static Logger logger = Logger.getLogger(RegisterServlet.class.getName());

    private static final String ERROR = "login.jsp";
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

    public RegisterServlet() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String recipentEmail = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        logger.debug("Register with:firstName="+firstName+"; lastName="+lastName+";email="+recipentEmail+"; password="+password);
        int minCode = 10000000;
        int maxCode = 99999999;
        int otp = 0;
        Random random = new Random();
        UserDAO dao = new UserDAO();

        otp = random.nextInt(maxCode - minCode) + minCode;
        String subject = otp + " is your SoMi activation code";
        String content = "Hi\nYou are trying to register with your email. Your activation code is " + otp + ".\nSoMi.\n\nThis is an automated"
                + " mail. Please do not reply to this email.";
        String url = ERROR;
        try {
            Thread.sleep(1000);
            boolean checkInput = true;
            logger.info("Checking input...");
            if (recipentEmail.length()==0 || !recipentEmail.matches("^[a-z][a-z0-9_\\.]{5,32}@[a-z0-9]{2,}(\\.[a-z0-9]{2,4}){1,2}$")) {
                request.setAttribute("registerEmailError", "Invalid email format");
                checkInput = false;
                logger.warn("Wrong email format.");
            }
            if (password.length() < 8 || password.length() > 50) {
                request.setAttribute("registerPasswordError", "Password is between 8 and 50");
                checkInput = false;
                logger.warn("Wrong password format.");
            }
            password=EncryptSHA256.sha256(password);
            if (checkInput) {
                try {
                    if (dao.checkUserExist(recipentEmail)) {
                        url = ERROR;
                        request.setAttribute("ERROR", "User existed in the network.\nTry login or register using different email.");
                    } else {
                        if (dao.insertNewUser(firstName, lastName, recipentEmail, password)) {
                            if (dao.insertNewUserActivationCode(recipentEmail, otp)) {
                                url = OTP;
                                SendEmail.sendEmail(host, port, email, pass, recipentEmail, subject, content);
                                logger.info("Registered.");
                            }
                        } else {
                            url = ERROR;
                            request.setAttribute("ERROR", "Fail to create new user..\nTry again.");
                            logger.info("Fail to create user.");
                        }
                    }

                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
            }
        } catch (InterruptedException ex) {
            logger.error(ex.getMessage());
        } finally {
            logger.info("Redirecting to "+url);
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

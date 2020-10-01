package anh.SoMi.servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import anh.SoMi.daos.UserDAO;
import anh.SoMi.dtos.UserDTO;
import anh.SoMi.utils.EncryptSHA256;
import java.io.IOException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginServlet", urlPatterns = "/LoginServlet")
public class OTPServlet extends HttpServlet {

    private static final String ERROR = "OTP.jsp";
    private static final String HOME = "HomePageServlet";
    final static Logger logger = Logger.getLogger(OTPServlet.class.getName());
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserDAO dAO = new UserDAO();
        String otpCode = request.getParameter("otpCode");
        String email = request.getParameter("userEmail");
        String password = request.getParameter("userPassword");
        String encryptedPassword = "";
        logger.debug("User detail:"+email +";"+ password +";"+ otpCode);
        boolean checkInput = true;
        try {
            Thread.sleep(1000);
            if (otpCode.length() == 0 || !otpCode.matches("[0-9]{8}")) {
                request.setAttribute("otpError", "Invalid code format. Check your code again.");
                checkInput = false;
                logger.warn("Wrong OTP format.");
            }
            encryptedPassword = EncryptSHA256.sha256(password);
            if (checkInput) {
                try {
                    switch (dAO.getUserInfo(email, encryptedPassword).getStatus()) {
                        case 2:
                            try {
                                boolean checkOTP = dAO.checkOTP(email, Integer.parseInt(otpCode));
                                if (checkOTP) {
                                    url = HOME;
                                    HttpSession session = request.getSession();
                                    session.setAttribute("FullName", dAO.getUserInfo(email, encryptedPassword).getFirstName() + " "
                                            + dAO.getUserInfo(email, encryptedPassword).getLastName());
                                    UserDTO userDTO=dAO.getUserInfo(email, encryptedPassword);
                                    session.setAttribute("User", userDTO);
                                } else {
                                    request.setAttribute("userEmail", email);
                                    request.setAttribute("userPassword", encryptedPassword);
                                    request.setAttribute("OTPERROR", "Wrong OTP code");
                                }
                            } catch (NamingException ex) {
                                logger.error(ex.getMessage());
                            } catch (SQLException ex) {
                                logger.error(ex.getMessage());
                            }
                            break;
                        case 1:
                            try {
                                boolean checkOTP = dAO.checkOTP(email, Integer.parseInt(otpCode));
                                logger.info("Checking OTP.");
                                if (checkOTP) {
                                    url = HOME;
                                    dAO.updateStatus(email);
                                    HttpSession session = request.getSession();
                                    session.setAttribute("FullName", dAO.getUserInfo(email, encryptedPassword).getFirstName() + " "
                                            + dAO.getUserInfo(email, encryptedPassword).getLastName());
                                    UserDTO userDTO=dAO.getUserInfo(email, encryptedPassword);
                                    session.setAttribute("User", userDTO);
                                } else {
                                    request.setAttribute("userEmail", email);
                                    request.setAttribute("userPassword", encryptedPassword);
                                    request.setAttribute("OTPERROR", "Wrong activation code");
                                }
                            } catch (NamingException ex) {
                                logger.error(ex.getMessage());
                            } catch (SQLException ex) {
                                logger.error(ex.getMessage());
                            }
                            break;

                        default:
                            request.setAttribute("OTPERROR", "Sorry!.Something went wrong.");
                            break;
                    }
                } catch (Exception ex) {
                    logger.error(ex.getMessage());
                }
            }
        } catch (InterruptedException ex) {
        } finally {
            logger.debug("Redirect to "+url);
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

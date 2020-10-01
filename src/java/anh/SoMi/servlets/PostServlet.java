/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package anh.SoMi.servlets;

import anh.SoMi.daos.PostDAO;
import anh.SoMi.dtos.PostDTO;
import anh.SoMi.dtos.UserDTO;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author DELL
 */
public class PostServlet extends HttpServlet {

    private static final String SUCCESS = "HomePageServlet";
    private static final String ERROR = "HomePage.jsp";
    private ServletFileUpload uploader = null;
    final static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(PostServlet.class.getName());
    @Override
    public void init() throws ServletException {
        DiskFileItemFactory fileFactory = new DiskFileItemFactory();
        File filesDir = (File) getServletContext().getAttribute("FILES_DIR_FILE");
        fileFactory.setRepository(filesDir);
        this.uploader = new ServletFileUpload(fileFactory);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserDTO userDTO = null;
        HttpSession session = request.getSession(false);
        userDTO = (UserDTO) session.getAttribute("User");
        //upload
        if (!ServletFileUpload.isMultipartContent(request)) {
            throw new ServletException("Content type is not multipart/form-data");
        }
        response.setContentType("text/html");
        try {
            String imageName = "", content = "";
            List<FileItem> fileItemsList = uploader.parseRequest(request);
            for (FileItem fileItem : fileItemsList) {
                if (!fileItem.isFormField()) {
                    imageName = new File(fileItem.getName()).getName();
                    File storeImage = new File("D:\\LAB\\J3.L.P0010.-Social-Network\\web\\images\\" + imageName);
                    storeImage.delete();
                    fileItem.write(storeImage);
                    logger.debug("Image name:"+imageName);
                } else {
                    content = fileItem.getString();
                    logger.debug("Content:"+content);
                }
            }
            PostDTO postDTO = new PostDTO(userDTO.getEmail(), content, imageName, "" + new Timestamp(System.currentTimeMillis()));
            PostDAO postDAO = new PostDAO();
            if (postDAO.insertPost(postDTO)) {
                url = SUCCESS;
                logger.info("Added Post");
            }
        } catch (FileUploadException ex) {
            logger.error(ex.getMessage());
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        } finally {
            try {
                Thread.sleep(3000);
                request.getRequestDispatcher(url).forward(request, response);
            } catch (InterruptedException ex) {
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

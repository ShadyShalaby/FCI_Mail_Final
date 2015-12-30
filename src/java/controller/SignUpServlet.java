/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.DBAccess;
import model.Email;
import model.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author sabry_ragab
 */
@WebServlet(name = "SignUpServlet", urlPatterns = {"/SignUpServlet"})
@MultipartConfig // First annotate your servlet with @MultipartConfig in order to let it
//recognize and support multipart/form-data requests and thus get getPart() to work:
public class SignUpServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, FileUploadException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String userEmail = "";
            String name = "";
            String password = "";
            String country = "";
            InputStream profilePic = null;

            List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

            for (FileItem item : items) {
                if (item.isFormField()) {
                    // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString();

                    if (fieldName.equals("userEmail")) {
                        userEmail = fieldValue;
                    } else if (fieldName.equals("name")) {
                        name = fieldValue;
                    } else if (fieldName.equals("password")) {
                        password = fieldValue;
                    } else if (fieldName.equals("country")) {
                        country = fieldValue;
                    }

                } else {
                    // Process form file field (input type="file").
                    String fieldName = item.getFieldName();
                    String fileName = FilenameUtils.getName(item.getName());
                    if (fileName.equals("")) {
                        profilePic = null;
                    } else {
                        profilePic = item.getInputStream();
                    }
                }
            }

            DBAccess dbAccess = new DBAccess();
            HttpSession session = request.getSession(true);

            if (dbAccess.isExistEmail(userEmail) == false) {
                User user = new User(userEmail, name, password, country, profilePic, new ArrayList<Email>(), new ArrayList<Email>());
                session.setAttribute("userEmail", userEmail);
                session.setMaxInactiveInterval(60 * 60);// one hour
                dbAccess.addNewUser(user);
                dbAccess.closeConnection();
                session.setAttribute("user", user);
                String url = "/InboxServlet";
                response.sendRedirect(request.getContextPath() + url);

            } else {

                dbAccess.closeConnection();
                session.setAttribute("signupResult", "Sorry, this e-mail is exist.");
                session.setAttribute("userEmail", userEmail);
                session.setAttribute("name", name);
                session.setAttribute("country", country);
                String url = "/view/pages/signup.jsp";
                response.sendRedirect(request.getContextPath() + url);

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
        try {
            try {
                processRequest(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

        try {
            try {
                processRequest(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(SignUpServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

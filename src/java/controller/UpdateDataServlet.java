/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DBAccess;
import model.User;

/**
 *
 * @author sabry_ragab
 */
@WebServlet(name = "UpdateDataServlet", urlPatterns = {"/UpdateDataServlet"})
public class UpdateDataServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession(false);
            User user = null;
            if (session == null) {
                // Not created yet. Now do so yourself.
                String url = "/view/pages/signin.jsp";
                response.sendRedirect(request.getContextPath() + url);
            } else {
                // Already created.
                user = (User) session.getAttribute("user");

            }

            String userEmail = request.getParameter("userEmail");
            String country = request.getParameter("country");
            String newPassword = request.getParameter("newPassword");
            String name = request.getParameter("name");
            String oldPassword = request.getParameter("oldPassword");

            if (oldPassword.equals(user.getPassword())) {
                //update session of user
                user.setCountry(country);
                user.setName(name);
                user.setPassword(newPassword);
                session.setAttribute("user", user);
                session.setAttribute("updateResult", "Data is updated Successfully");
                out.print(user.getName());

                //update DB
                DBAccess dbAccess = new DBAccess();
                dbAccess.updateUserData(user);
                dbAccess.closeConnection();
            } else {
                 session.setAttribute("updateResult", "Incorrect Old password");
            }

            String url = "/view/pages/editProfile.jsp";
            response.sendRedirect(request.getContextPath() + url);

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
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateDataServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateDataServlet.class.getName()).log(Level.SEVERE, null, ex);
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

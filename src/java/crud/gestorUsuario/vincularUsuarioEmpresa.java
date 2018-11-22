/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.gestorUsuario;

import bd.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lechuga
 */
@WebServlet(name = "vincularUsuarioEmpresa", urlPatterns = {"/vincularUsuarioEmpresa"})
public class vincularUsuarioEmpresa extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String tipoCuenta = request.getParameter("rolUsuario");
            String idUsuario = request.getParameter("idUsuario");
            String idEmpresa = request.getParameter("idEmpresa");

            String sql = null;
            try {
                Connection conn = ConexionBD.getConexion();
                sql = "INSERT INTO aelita.trabaja (idEmpresa, idUsuario, activo, tipoCuenta) VALUES (?, ?, ?, ?);";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idEmpresa);
                pst.setString(2, idUsuario);
                pst.setString(3, "N");
                pst.setString(4, tipoCuenta);
                pst.execute();
                response.sendRedirect("/aeLita/gestores/gestorUsuarios.jsp");
            } catch (IOException | SQLException e) {
                out.println("Excepción de SQL (RegistroUsuario.jsp): " + e + sql);
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

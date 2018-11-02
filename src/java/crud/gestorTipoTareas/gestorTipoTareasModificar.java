/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.gestorTipoTareas;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import bd.*;
/**
 *
 * @author Lechuga
 */
@WebServlet(name = "gestorTipoTareasModificar", urlPatterns = {"/gestorTipoTareasModificar"})
public class gestorTipoTareasModificar extends HttpServlet {

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
            String idTipoTarea = request.getParameter("idTipoTarea");
            String nombreTipoTarea = request.getParameter("nombre_tipo_tarea");
            String detalleTipoTarea = request.getParameter("detalle_tipo_tarea");
            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "update tipo_tarea set nombreTipoTarea=?,detalleTipoTarea=? where idTipoTarea=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, nombreTipoTarea);
                pst.setString(2, detalleTipoTarea);
                pst.setString(3, idTipoTarea);
                pst.execute();
                response.sendRedirect("/aeLita/gestores/gestorTipoTareas.jsp");
            } catch (SQLException e) {
                out.println("Excepción de SQL:" + e);
                return;
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

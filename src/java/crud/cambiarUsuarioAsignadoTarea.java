/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud;

import bd.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lechuga
 */
@WebServlet(name = "cambiarUsuarioAsignadoTarea", urlPatterns = {"/cambiarUsuarioAsignadoTarea"})
public class cambiarUsuarioAsignadoTarea extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession hs = request.getSession(true);

            String idOrdenTrabajo = request.getParameter("idOT");
            String idEmpresa = "" + hs.getAttribute("idEmpresa");
            String idTarea = request.getParameter("idTarea");
            String idNuevoUsuarioEjecutor = request.getParameter("idNuevoUsuarioEjecutor");

            ResultSet rsNombreTarea = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "select tipo_tarea.nombreTipoTarea from tarea,tipo_tarea where tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idTarea =" + idTarea;
                PreparedStatement pst = conn.prepareStatement(sql);
                rsNombreTarea = pst.executeQuery();
                rsNombreTarea.next();
            } catch (SQLException e) {
                out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
                return;
            }
            ResultSet rsNombreEjecutor = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "select usuario.nombreUsuario from tarea,usuario where tarea.usuario = usuario.idUsuario and tarea.idTarea = " + idTarea;
                PreparedStatement pst = conn.prepareStatement(sql);
                rsNombreEjecutor = pst.executeQuery();
                rsNombreEjecutor.next();
            } catch (SQLException e) {
                out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
                return;
            }
            String nombreEjecutor = rsNombreEjecutor.getString("nombreUsuario"); 
            String nombreTarea = rsNombreTarea.getString("nombreTipoTarea");
            String motivo = "" + hs.getAttribute("nombreUsuario") + " cambió el usuario de la tarea " + nombreTarea + " asignando al Ejecutor " + nombreEjecutor + "";

            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "UPDATE aelita.tarea SET usuario=? WHERE  idTarea=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idNuevoUsuarioEjecutor);
                pst.setString(2, idTarea);
                pst.execute();

                String sqlAuditoria = "INSERT INTO cambio_estado (idOrdenTrabajo,idTarea,idEmpresa,motivo) VALUES (?,?,?,?)";
                PreparedStatement pstAuditoria = conn.prepareStatement(sqlAuditoria);
                pstAuditoria.setString(1, idOrdenTrabajo);
                pstAuditoria.setString(2, idTarea);
                pstAuditoria.setString(3, idEmpresa);
                pstAuditoria.setString(4, motivo);
                pstAuditoria.execute();

                response.sendRedirect("/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=" + idTarea);
                return;
            } catch (Exception e) {
                out.println("Excepción de SQL:" + e);
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
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(cambiarUsuarioAsignadoTarea.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(cambiarUsuarioAsignadoTarea.class.getName()).log(Level.SEVERE, null, ex);
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

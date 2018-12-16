/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.gestorOT;

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
@WebServlet(name = "cambiarUsuarioSupervisorOT", urlPatterns = {"/cambiarUsuarioSupervisorOT"})
public class cambiarUsuarioSupervisorOT extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession hs = request.getSession(true);

            String idOrdenTrabajo = request.getParameter("idOT");
            String idEmpresa = ""+hs.getAttribute("idEmpresa");
            String idNuevoUsuarioSupervisor = request.getParameter("idNuevoUsuarioSupervisor");

            ResultSet rsNombreOrdenTrabajo = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "select orden_trabajo.nombreOrdenTrabajo from orden_trabajo where orden_trabajo.idOrdenTrabajo = "+idOrdenTrabajo;
                PreparedStatement pst = conn.prepareStatement(sql);
                rsNombreOrdenTrabajo = pst.executeQuery();
                rsNombreOrdenTrabajo.next();
            } catch (SQLException e) {
                out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
                return;
            }
            ResultSet rsNombreSupervisor = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "select usuario.nombreUsuario as supervisor from orden_trabajo,usuario where orden_trabajo.supervisor = usuario.idUsuario and orden_trabajo.idOrdenTrabajo ="+idOrdenTrabajo;
                PreparedStatement pst = conn.prepareStatement(sql);
                rsNombreSupervisor = pst.executeQuery();
                rsNombreSupervisor.next();
            } catch (SQLException e) {
                out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
                return;
            }
            String nombreSupervisor = rsNombreSupervisor.getString("supervisor");
            String nombreTarea = rsNombreOrdenTrabajo.getString("nombreOrdenTrabajo");
            String motivo = hs.getAttribute("nombreUsuario") + " cambió el usuario de la Orden de trabajo " + nombreTarea + " asignando al Supervisor "+nombreSupervisor;

            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "UPDATE aelita.orden_trabajo SET supervisor=? WHERE  idOrdenTrabajo=?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idNuevoUsuarioSupervisor);
                pst.setString(2, idOrdenTrabajo);
                pst.execute();

                String sqlAuditoria = "INSERT INTO cambio_estado (idOrdenTrabajo,idEmpresa,motivo) VALUES (?,?,?)";
                PreparedStatement pstAuditoria = conn.prepareStatement(sqlAuditoria);
                pstAuditoria.setString(1, idOrdenTrabajo);
                pstAuditoria.setString(2, idEmpresa);
                pstAuditoria.setString(3, motivo);
                pstAuditoria.execute();

                response.sendRedirect("/aeLita/supervisor/gestorOTDetalle.jsp?idOT=" + idOrdenTrabajo);
            } catch (IOException | SQLException e) {
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
            Logger.getLogger(cambiarUsuarioSupervisorOT.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(cambiarUsuarioSupervisorOT.class.getName()).log(Level.SEVERE, null, ex);
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

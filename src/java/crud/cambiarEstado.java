/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import bd.*;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lechuga
 */
@WebServlet(name = "cambiarEstado", urlPatterns = {"/cambiarEstado"})
public class cambiarEstado extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */

            HttpSession hs = request.getSession(false);

            String idEstado = request.getParameter("idEstado");
            String idTarea = request.getParameter("idTarea");
            String idEmpresa = ""+hs.getAttribute("idEmpresa");
            
            ResultSet rsEstadoSeleccionado = null; //Permite conocer el nombre del estado que el usuario seleccionó.
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlEstadoSeleccionado = "select estado.nombreEstado from estado where estado.idEstado = "+ idEstado;
                PreparedStatement pstEstadoSeleccionado = conn.prepareStatement(sqlEstadoSeleccionado);
                rsEstadoSeleccionado = pstEstadoSeleccionado.executeQuery();
                rsEstadoSeleccionado.next();
                String nombreEstado = rsEstadoSeleccionado.getString("nombreEstado");
                String motivo = ""+hs.getAttribute("nombreUsuario")+" cambió la tarea al estado "+nombreEstado;
                String sql = "INSERT INTO cambio_estado (`motivo`, `idTarea`, `idEmpresa`) VALUES (?,?,?)";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, motivo);
                pst.setString(2, idTarea);
                pst.setString(3, idEmpresa);
                pst.execute();
                
                String sqlUpdateTarea = "UPDATE aelita.tarea SET estadoTarea=? WHERE idTarea=?";
                PreparedStatement pstUpdateTarea = conn.prepareStatement(sqlUpdateTarea);
                pstUpdateTarea.setString(1, idEstado);
                pstUpdateTarea.setString(2, idTarea);
                pstUpdateTarea.execute();
                response.sendRedirect("/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea="+idTarea);
            } catch (SQLException e) {
                out.print(e);
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

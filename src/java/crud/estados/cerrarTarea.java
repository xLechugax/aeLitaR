/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.estados;

import bd.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Games
 */
@WebServlet(name = "cerrarTarea", urlPatterns = {"/cerrarTarea"})
public class cerrarTarea extends HttpServlet {

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

            HttpSession hs = request.getSession(false); 
            String idTareaSeleccionada = request.getParameter("idTareaSeleccionada");
            String idOrdenTrabajo = request.getParameter("idOrdenTrabajo");
            String idEmpresa = request.getParameter("idEmpresa");
            out.print(idTareaSeleccionada);
            try {
                Connection conn = ConexionBD.getConexion();
                //Se cambia el estado de la tarea a suspendida
                String sqlCerrarTarea = "UPDATE `aelita`.`tarea` SET `estadoTarea`='5', `fecha_fin`=(select NOW()) WHERE  `idTarea`=?";
                PreparedStatement pstCerrarTarea = conn.prepareStatement(sqlCerrarTarea);
                pstCerrarTarea.setString(1, idTareaSeleccionada);
                pstCerrarTarea.execute();
                
                String sqlEventoDocumentarReactivar = "INSERT INTO `aelita`.`cambio_estado` (`idOrdenTrabajo`, `idTarea`, `idEmpresa`, `motivo`,  `suspension`) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstEventoDocumentarReactivar = conn.prepareStatement(sqlEventoDocumentarReactivar);
                pstEventoDocumentarReactivar.setString(1, idOrdenTrabajo);
                pstEventoDocumentarReactivar.setString(2, idTareaSeleccionada);
                pstEventoDocumentarReactivar.setString(3, idEmpresa);
                pstEventoDocumentarReactivar.setString(4, ""+hs.getAttribute("nombreUsuario")+" cerró la tarea.");
                pstEventoDocumentarReactivar.setString(5, "N");
                pstEventoDocumentarReactivar.execute();
                
            response.sendRedirect("/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=" + idTareaSeleccionada);    
            } catch (Exception e) {
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

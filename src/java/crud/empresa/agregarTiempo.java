/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.empresa;

import bd.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lechuga
 */
@WebServlet(name = "agregarTiempo", urlPatterns = {"/agregarTiempo"})
public class agregarTiempo extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String tiempo = request.getParameter("tiempo");
            String idSuscripcion = request.getParameter("idSuscripcion");
            
            try {
                Connection conn = ConexionBD.getConexion();
                //Se cambia el estado de la tarea a suspendida1
                String sqlCerrarTarea = "UPDATE suscripcion SET suscripcion.fecha_fin = ADDDATE(suscripcion.fecha_fin, INTERVAL ? MONTH) WHERE suscripcion.idSuscripcion = ?";
                PreparedStatement pstCerrarTarea = conn.prepareStatement(sqlCerrarTarea);
                pstCerrarTarea.setString(1, tiempo);
                pstCerrarTarea.setString(2, idSuscripcion);
                pstCerrarTarea.execute();

                response.sendRedirect("/aeLita/administrador/empresas.jsp");
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

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
 * @author Games
 */
@WebServlet(name = "crearEmpresa", urlPatterns = {"/crearEmpresa"})
public class crearEmpresa extends HttpServlet {

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

            String rutEmpresa = request.getParameter("rut");
            String nombreEmpresa = request.getParameter("nombre");
            String direccionEmpresa = request.getParameter("direccion");
            String correoEmpresa = request.getParameter("correo");
            String correoEmpresaConfirmar = request.getParameter("confirmar_correo");
            String telefonoEmpresa = request.getParameter("telefono");

            if (!(correoEmpresa.trim().equals(correoEmpresaConfirmar.trim()))) {
                out.print("<head>");
                out.print("<meta http-equiv='Refresh' content='5;url=/aeLita/gestores/gestorUsuarios.jsp'>");
                out.print("<link rel='stylesheet' type='text/css' href='/aeLita/css/materialize.min.css'><link>");
                out.print("<meta name='viewport' content='width=device-width, initial-scale=1.0' charset='iso-8859-1'/>");
                out.print("</head>");
                out.print("<body class='blue-grey lighten-5'>");
                out.print("<br /><br /><br /><br /><br /><br /><br /><br />");
                out.print("<center>");
                out.print("<div class='row'>");
                out.print("<div class='col s12 m12'>");
                out.print("<div class='card blue-grey darken-1'>");
                out.print("<div class='card-content white-text'>");
                out.print("<span class='card-title'>¡Oh no!</span>");
                out.print("<p>Los correos que ingresaste no coinciden...</p>");
                out.print("</div>");
                out.print("</div>");
                out.print("</div>");
                out.print("</div>");
                out.print("</center>");
                out.print("</body>");
                out.print("</html>");
                return;
            }

            try {
                Connection conn = ConexionBD.getConexion();
                //Se cambia el estado de la tarea a suspendida
                String sqlCerrarTarea = "INSERT INTO empresa (rut, nombre, direccion, correo, telefono) VALUES (?,?,?,?,?);";
                PreparedStatement pstCerrarTarea = conn.prepareStatement(sqlCerrarTarea);
                pstCerrarTarea.setString(1, rutEmpresa);
                pstCerrarTarea.setString(2, nombreEmpresa);
                pstCerrarTarea.setString(3, direccionEmpresa);
                pstCerrarTarea.setString(4, correoEmpresa);
                pstCerrarTarea.setString(5, telefonoEmpresa);
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

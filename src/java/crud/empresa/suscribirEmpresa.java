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
import java.sql.ResultSet;
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
@WebServlet(name = "suscribirEmpresa", urlPatterns = {"/suscribirEmpresa"})
public class suscribirEmpresa extends HttpServlet {

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

            String idEmpresa = request.getParameter("idEmpresa");
            String nombreSuscripcion = request.getParameter("nombreSuscripcion");
            String detalle = request.getParameter("detalle");
            String cantidadUsuarios = request.getParameter("cantidadUsuarios");
            String fecha_fin = request.getParameter("fecha_fin");

            try {

                Connection conn = ConexionBD.getConexion();

                String sqlVerificarAhora = "SELECT IF('" + fecha_fin + "'<now(), 'Y', 'N') as verificador, now() as ahora";
                PreparedStatement pstVerificarAhora = conn.prepareStatement(sqlVerificarAhora);
                ResultSet rsVerificarAhora = pstVerificarAhora.executeQuery();
                rsVerificarAhora.next();

                if (rsVerificarAhora.getString("verificador").equals("Y")) {
                    out.print("<head>");
                    out.print("<meta http-equiv='Refresh' content='5;url=/aeLita/administrador/empresas.jsp'/>");
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
                    out.print("<p>La fecha que ingresaste es menor a la fecha actual...</p>");
                    out.print("</div>");
                    out.print("<div class='card-action'>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</center>");
                    out.print("</body>");
                    out.print("</html>");
                    return;
                } else {

                    String sql = "INSERT INTO `aelita`.`suscripcion` (`idEmpresa`, `nomreSuscripcion`, `detalleSuscripcion`, `cantidadUsuarios`,  `fecha_fin`, `activo`) VALUES (?, ?, ?, ?, ?,?);";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setString(1, idEmpresa);
                    pst.setString(2, nombreSuscripcion);
                    pst.setString(3, detalle);
                    pst.setString(4, cantidadUsuarios);
                    pst.setString(5, fecha_fin);
                    pst.setString(6, "S");
                    pst.execute();

                    ResultSet rsIdSuscripcionCreada = null;
                    String sqlIdSuscripcionCreada = "select last_insert_id() as idSuscripcion";
                    PreparedStatement pstIdSuscripcionCreada = conn.prepareStatement(sqlIdSuscripcionCreada);
                    rsIdSuscripcionCreada = pstIdSuscripcionCreada.executeQuery();
                    rsIdSuscripcionCreada.next();

                    String sqlAsignarIdEmpresaSuscripcion = "UPDATE aelita.empresa SET idSuscripcion=? WHERE  idEmpresa=?";
                    PreparedStatement pstAsignarIdEmpresaSuscripcion = conn.prepareStatement(sqlAsignarIdEmpresaSuscripcion);
                    pstAsignarIdEmpresaSuscripcion.setString(1, rsIdSuscripcionCreada.getString("idSuscripcion"));
                    pstAsignarIdEmpresaSuscripcion.setString(2, idEmpresa);
                    pstAsignarIdEmpresaSuscripcion.execute();

                    String sqlAsignarAdminAEmpresa = "INSERT INTO `aelita`.`trabaja` (`idEmpresa`, `idUsuario`, `activo`, `tipoCuenta`) VALUES (?, ?, ?, ?);";
                    PreparedStatement pstAsignarAdminAEmpresa = conn.prepareStatement(sqlAsignarAdminAEmpresa);
                    pstAsignarAdminAEmpresa.setString(1, idEmpresa);
                    pstAsignarAdminAEmpresa.setString(2, "" + hs.getAttribute("idUsuarioSesion"));
                    pstAsignarAdminAEmpresa.setString(3, "S");
                    pstAsignarAdminAEmpresa.setString(4, "Administrador");
                    pstAsignarAdminAEmpresa.execute();

                    response.sendRedirect("/aeLita/administrador/empresas.jsp");
                }
            } catch (Exception e) {
                out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
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

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
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "crearUsuario", urlPatterns = {"/crearUsuario"})
public class crearUsuario extends HttpServlet {

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

            String idEmpresa = "" + hs.getAttribute("idEmpresa");
            String rut = request.getParameter("rut");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String confirmar_correo = request.getParameter("confirmar_correo");
            String telefono_m = request.getParameter("telefono_m");
            String telefono_f = request.getParameter("telefono_f");
            String area_departamento = request.getParameter("area_departamento");
            String clave = request.getParameter("clave");
            String confirmar_clave = request.getParameter("confirmar_clave");
            String direccion = request.getParameter("direccion");
            String rol = request.getParameter("rol");

            String nombreUsuario = nombre.trim().replaceAll("\\s", "").toUpperCase() + "." + apellido.trim().replaceAll("\\s", "").toUpperCase();

            try {
                //Verificar que no exista un usuario registrado con el mismo rut.
                Connection conn = ConexionBD.getConexion();
                String sqlVerificarExistenciaUnoIgual = "select * from usuario where usuario.rut ='" + rut + "'";
                PreparedStatement pstVerificarExistenciaUnoIgual = conn.prepareStatement(sqlVerificarExistenciaUnoIgual);
                ResultSet rsVerificarExistenciaUnoIgual = pstVerificarExistenciaUnoIgual.executeQuery();

                if (rsVerificarExistenciaUnoIgual.next()) {
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
                    out.print("<p>El rut ingresado ya esta registrado en el sistema...</p>");
                    out.print("</div>");
                    out.print("<div class='card-action'>");
                    out.print("<a href='/aeLita/gestores/gestorUsuarios.jsp'>¡AQUÍ!</a>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</center>");
                    out.print("</body>");
                    out.print("</html>");
                    return;
                }
            } catch (SQLException e) {
                out.print(e);
            }

            try {
                Connection conn = ConexionBD.getConexion();
                if (!(clave.trim().equals(confirmar_clave.trim()))) {
                    out.print("<meta http-equiv='Refresh' content='2;url=/aeLita/registro/registrarNuevoUsuario.jsp'>");
                } else if (!(correo.trim().equals(confirmar_correo.trim()))) {
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
                } else {
                    String sql = "INSERT INTO USUARIO (nombre, apellido, nombreUsuario, email, telefono_m, telefono_f, area_departamento, direccion, clave, rut) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setString(1, nombre);
                    pst.setString(2, apellido);
                    pst.setString(3, nombreUsuario);
                    pst.setString(4, correo);
                    pst.setString(5, telefono_m);
                    pst.setString(6, telefono_f);
                    pst.setString(7, area_departamento);
                    pst.setString(8, direccion);
                    pst.setString(9, clave);
                    pst.setString(10, rut);
                    pst.execute();
                }
            } catch (SQLException e) {
                out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
            }

            try {
                Connection conn = ConexionBD.getConexion();
                String sqlUsuario = "select usuario.idUsuario from usuario where usuario.rut ='" + rut + "'";
                PreparedStatement pstVerificarExistenciaUnoIgual = conn.prepareStatement(sqlUsuario);
                ResultSet rsUsuario = pstVerificarExistenciaUnoIgual.executeQuery();

                rsUsuario.next();

                String idUsuario = rsUsuario.getString("idUsuario");

                String sql = "INSERT INTO trabaja (idEmpresa, idUsuario, activo, tipoCuenta) VALUES (?, ?, ?, ?)";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idEmpresa);
                pst.setString(2, idUsuario);
                pst.setString(3, "N");
                pst.setString(4, rol);
                pst.execute();

            } catch (SQLException e) {
                out.print(e);
            }
            response.sendRedirect("/aeLita/gestores/gestorUsuarios.jsp");
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

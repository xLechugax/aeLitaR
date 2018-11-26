/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.estados;

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
@WebServlet(name = "suspenderOrdenTrabajo", urlPatterns = {"/suspenderOrdenTrabajo"})
public class suspenderOrdenTrabajo extends HttpServlet {

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
            //out.println(idEmpresa);
            String idOrdenTrabajo = request.getParameter("idOrdenTrabajo");
            //out.println(idOrdenTrabajo);
            String identidad = request.getParameter("identidad");
            //out.println(identidad);
            String motivo = request.getParameter("motivo");
            //out.println(motivo);
            String fecha_fin = request.getParameter("fecha_fin");
            //out.println(fecha_fin);

            try {
                Connection conn = ConexionBD.getConexion();

                String sqlVerificarAhora = "SELECT IF('"+fecha_fin+"'<now(), 'Y', 'N') as verificador, now() as ahora";
                PreparedStatement pstVerificarAhora = conn.prepareStatement(sqlVerificarAhora);
                ResultSet rsVerificarAhora = pstVerificarAhora.executeQuery();
                rsVerificarAhora.next(); 
                
                if(rsVerificarAhora.getString("verificador").equals("Y")){
                    out.print("<head>");
                        out.print("<meta http-equiv='Refresh' content='5;url=/aeLita/supervisor/gestorOTDetalle.jsp?idOT="+idOrdenTrabajo+"'/>");
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
                
                int idEmpresaInt = Integer.parseInt(idEmpresa);
                
                //Activa de manera global los Eventos
                String sqlActivarEventosEnMySQL = "SET GLOBAL event_scheduler = ON";
                PreparedStatement pstActivarEventosEnMySQL = conn.prepareStatement(sqlActivarEventosEnMySQL);
                pstActivarEventosEnMySQL.execute();
                
                //Crea el cambio de estado como suspensión
                String sql = "INSERT INTO `aelita`.`cambio_estado` (`idOrdenTrabajo`, `idEmpresa`, `motivo`, `fecha_realizacion`, `fecha_fin`, `suspension`, `identidad`) VALUES (?, ?, ?, ?, ?, ?, ?);";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idOrdenTrabajo);
                pst.setString(2, idEmpresa);
                pst.setString(3, "Suspendida: "+motivo);
                pst.setString(4, "" + rsVerificarAhora.getString("ahora"));
                pst.setString(5, fecha_fin);
                pst.setString(6, "S");
                pst.setString(7, identidad);
                pst.execute();
                
                //Se cambia el estado de la tarea a suspendida
                String sqlSuspenderTarea = "UPDATE `aelita`.`orden_trabajo` SET `estado`='3' WHERE  `idOrdenTrabajo`=?";
                PreparedStatement pstSuspenderTarea = conn.prepareStatement(sqlSuspenderTarea);
                pstSuspenderTarea.setString(1, idOrdenTrabajo);
                pstSuspenderTarea.execute();
                
                //Crea un evento para reactivar la orden de trabajo
                String sqlEventoReactivar = "CREATE EVENT A"+identidad+" ON SCHEDULE AT '"+fecha_fin+"' DO UPDATE orden_trabajo SET orden_trabajo.estado=2 WHERE orden_trabajo.idOrdenTrabajo = "+idOrdenTrabajo;
                PreparedStatement pstsqlEventoReactivar = conn.prepareStatement(sqlEventoReactivar);
                pstsqlEventoReactivar.execute();
                
                
                String sqlEventoDocumentarReactivar = "CREATE EVENT B"+identidad+" ON SCHEDULE AT '"+fecha_fin+"' DO INSERT INTO cambio_estado (idOrdenTrabajo, idEmpresa, motivo,  suspension) VALUES (?, ?, ?, ?)";
                PreparedStatement pstEventoDocumentarReactivar = conn.prepareStatement(sqlEventoDocumentarReactivar);
                pstEventoDocumentarReactivar.setString(1, idOrdenTrabajo);
                pstEventoDocumentarReactivar.setString(2, idEmpresa);
                pstEventoDocumentarReactivar.setString(3, "Cambio de estado automatico luego de  periodo en suspención");
                pstEventoDocumentarReactivar.setString(4, "N");
                pstEventoDocumentarReactivar.execute();
                response.sendRedirect("/aeLita/supervisor/gestorOTDetalle.jsp?idOT="+idOrdenTrabajo);
                }
            } catch (Exception e) {
                out.println("Excepción de SQL:" + e);
            }
            out.println("</html>");
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

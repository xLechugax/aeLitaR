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

@WebServlet(name = "suspenderTarea", urlPatterns = {"/suspenderTarea"})
public class suspenderTarea extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession hs = request.getSession(false); 
            String idEmpresa = request.getParameter("idEmpresa");
            //out.print(idEmpresa);
            //out.println("<br/>");
            String idOrdenTrabajo = request.getParameter("idOrdenTrabajo");
            //out.print(idOrdenTrabajo);
            //out.println("<br/>");
            String idTareaSeleccionada = request.getParameter("idTareaSeleccionada");
            //out.print(idTareaSeleccionada);
            //out.println("<br/>");
            String identidad = request.getParameter("identidad");
            //out.print(identidad);
            //out.println("<br/>");
            String motivo = request.getParameter("motivo");
            //out.print(motivo);
            //out.println("<br/>");
            String fecha_fin = request.getParameter("fecha_fin");
            //out.print(fecha_fin);

            try {
                Connection conn = ConexionBD.getConexion();

                String sqlVerificarAhora = "SELECT IF('"+fecha_fin+"'<now(), 'Y', 'N') as verificador, now() as ahora";
                PreparedStatement pstVerificarAhora = conn.prepareStatement(sqlVerificarAhora);
                ResultSet rsVerificarAhora = pstVerificarAhora.executeQuery();
                rsVerificarAhora.next();
                
                if(rsVerificarAhora.getString("verificador").equals("Y")){
                    out.print("<head>");
                        out.print("<meta http-equiv='Refresh' content='5;url=/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea="+idTareaSeleccionada+"&idEmpresa="+idEmpresa+"'/>");
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
                String sql = "INSERT INTO `aelita`.`cambio_estado` (`idOrdenTrabajo`, `idTarea`, `idEmpresa`, `motivo`, `fecha_realizacion`, `fecha_fin`, `suspension`, `identidad`) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idOrdenTrabajo);
                pst.setString(2, idTareaSeleccionada);
                pst.setString(3, idEmpresa);
                pst.setString(4, "Suspendida: "+motivo);
                pst.setString(5, "" + rsVerificarAhora.getString("ahora"));
                pst.setString(6, fecha_fin);
                pst.setString(7, "S");
                pst.setString(8, identidad);
                pst.execute();
                
                //Se cambia el estado de la tarea a suspendida
                String sqlSuspenderTarea = "UPDATE `aelita`.`tarea` SET `estadoTarea`='3' WHERE  `idTarea`=?";
                PreparedStatement pstSuspenderTarea = conn.prepareStatement(sqlSuspenderTarea);
                pstSuspenderTarea.setString(1, idTareaSeleccionada);
                pstSuspenderTarea.execute();
                
                //Crea un evento para reactivar la tarea
                String sqlEventoReactivar = "CREATE EVENT A"+identidad+" ON SCHEDULE AT '"+fecha_fin+"' DO UPDATE tarea SET tarea.estadoTarea=2 WHERE tarea.idTarea="+idTareaSeleccionada;
                PreparedStatement pstsqlEventoReactivar = conn.prepareStatement(sqlEventoReactivar);
                pstsqlEventoReactivar.execute();
                
                
                String sqlEventoDocumentarReactivar = "CREATE EVENT B"+identidad+" ON SCHEDULE AT '"+fecha_fin+"' DO INSERT INTO `aelita`.`cambio_estado` (`idOrdenTrabajo`, `idTarea`, `idEmpresa`, `motivo`,  `suspension`) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement pstEventoDocumentarReactivar = conn.prepareStatement(sqlEventoDocumentarReactivar);
                pstEventoDocumentarReactivar.setString(1, idOrdenTrabajo);
                pstEventoDocumentarReactivar.setString(2, idTareaSeleccionada);
                pstEventoDocumentarReactivar.setString(3, idEmpresa);
                pstEventoDocumentarReactivar.setString(4, "Cambio de estado automatico luego de Suspención");
                pstEventoDocumentarReactivar.setString(5, "N");
                pstEventoDocumentarReactivar.execute();
                
                response.sendRedirect("/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=" + idTareaSeleccionada);
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

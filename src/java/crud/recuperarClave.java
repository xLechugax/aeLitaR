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
import bd.Email;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Games
 */
@WebServlet(name = "recuperarClave", urlPatterns = {"/recuperarClave"})
public class recuperarClave extends HttpServlet {

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
           String para = request.getParameter("correo");
           Email email = new Email();
           boolean resultado =  email.enviarCorreo(para);
           if(resultado){
               out.print("<head>");
                    out.print("<meta http-equiv='Refresh' content='5;url=/aeLita/index.jsp'>");
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
                    out.print("<span class='card-title'>¡Que bien!</span>");
                    out.print("<p>Se ha enviado el correo electrónico correcatamente...</p>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</center>");
                    out.print("</body>");
                    out.print("</html>");
            }else{
                out.print("<head>");
                    out.print("<meta http-equiv='Refresh' content='5;url=/aeLita/index.jsp'>");
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
                    out.print("<p>El correo electrónico que ingresaste no esta registrado en nuestra base de datos...</p>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</center>");
                    out.print("</body>");
                    out.print("</html>");
            }
        }
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(recuperarClave.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(recuperarClave.class.getName()).log(Level.SEVERE, null, ex);
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

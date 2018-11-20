package crud.gestorOT;

import bd.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "gestorOTGenerar", urlPatterns = {"/gestorOTGenerar"})
public class gestorOTGenerar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
             HttpSession hs = request.getSession(false);
             
            String idEmpresa = "" + hs.getAttribute("idEmpresa");
            String importancia = request.getParameter("importancia");
            String idSupervisor = request.getParameter("idSupervisor");
            String nombreOT = request.getParameter("nombreOT");
            String detalleOT = request.getParameter("detalleOT");
            
            String idProcedimiento = request.getParameter("idProcedimiento");
            
            if (idProcedimiento == null){
                idProcedimiento = "00000000000";
            }
            String estado = "1";

            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "insert into orden_trabajo (importancia,supervisor,nombreOrdenTrabajo,detalleOrdenTrabajo,estado,idEmpresa,idProcedimiento) values (?,?,?,?,?,?,?)";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, importancia);
                pst.setString(2, idSupervisor);
                pst.setString(3, nombreOT);
                pst.setString(4, detalleOT);
                pst.setString(5, estado);
                pst.setString(6, idEmpresa); 
                pst.setString(7, idProcedimiento);
                pst.execute();
                if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
                    response.sendRedirect("/aeLita/administrador/gestorOT.jsp");
                }
                if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {
                    response.sendRedirect("/aeLita/supervisor/gestorOT.jsp");
                }
            } catch (IOException | SQLException e) {
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

package crud.gestorProcedimientos;

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
import javax.servlet.http.HttpSession;

@WebServlet(name = "gestorProcedimientosAgregar", urlPatterns = {"/gestorProcedimientosAgregar"})
public class gestorProcedimientosAgregar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession hs = request.getSession(false);
            
            String idEmpresa = ""+hs.getAttribute("idEmpresa");
            String nombreProcedimiento = request.getParameter("nombreProcedimiento");
            String detalleProcedimiento = request.getParameter("detalleProcedimiento");

            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "insert into procedimiento (idEmpresa,nombreProcedimiento,detalleProcedimiento) VALUES (?,?,?)";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, idEmpresa);
                pst.setString(2, nombreProcedimiento);
                pst.setString(3, detalleProcedimiento);
                pst.execute();
                response.sendRedirect("/aeLita/gestores/gestorProcedimientos.jsp");
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

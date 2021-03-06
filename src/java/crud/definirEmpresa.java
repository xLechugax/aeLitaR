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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Lechuga
 */
@WebServlet(name = "definirEmpresa", urlPatterns = {"/definirEmpresa"})
public class definirEmpresa extends HttpServlet {

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
            String idUsuario = request.getParameter("idUsuario");

            hs.setAttribute("idEmpresa", idEmpresa);
            out.print(hs.getAttribute("idEmpresa"));
            out.print(idUsuario);

            if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
                response.sendRedirect("/aeLita/administrador/inicioAdmin.jsp?idEmpresa="+hs.getAttribute("idEmpresa"));
            }
            if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {
                response.sendRedirect("/aeLita/supervisor/inicioSupervisor.jsp?idEmpresa="+hs.getAttribute("idEmpresa"));
            }
            if (hs.getAttribute("tipoCuenta").equals("Ejecutor")) {
                response.sendRedirect("/aeLita/ejecutor/inicioEjecutor.jsp?idEmpresa="+hs.getAttribute("idEmpresa"));
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

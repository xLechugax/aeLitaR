/* puedo borrarlo?
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package crud.gestorFiles;
//Este archivo ya no s necesario .. si luego te lo espepcique en workana creo

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import bd.*;
import java.io.InputStream;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author Lechuga
 * MultipartConfig(maxFileSize = 16177215)
 */
@WebServlet(name = "gestorArchivoAgregar", urlPatterns = {"/gestorArchivoAgregar"})
@MultipartConfig
public class gestorArchivoAgregar extends HttpServlet {

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
            String idEmpresa = ""+hs.getAttribute("idEmpresa");
            
            Part file = request.getPart("file");
            // Para almacenar en una carpeta.
            //String detalleAreaDepartamento = request.getParameter("detalles");
            //InputStream is = file.getInputScream();
            // File f = new File("Ruta de la carpeta + el nombre de la variable");
            // FileOutputScream ous = new FileOutputStream(f);

            int fileSize = (int) file.getSize();
            byte[] photo = null;

            if (file.getSize() > 0) {
                // System.out.println(file.getName());
                // System.out.println(file.getSize());
                // System.out.println(file.getContentType());
                out.println(file.getName());
                out.println(file.getSize());
                out.println(file.getContentType());
                
            }
//             if(fileSize > 0) {
//                 photo = new byte[fileSize];
// //                try(DataInputStream dis = new DataInputStream(file.getInputStream() )) {
// //                    dis.readFully(photo);
// //                }
//             }


            try {
                // Connection conn = ConexionBD.getConexion();
                // String sql = "insert into archivo (archivo,idEmpresa) values (?,?)";
                // PreparedStatement pst = conn.prepareStatement(sql);
                // pst.setBlob(1, (InputStream) file);                
                // pst.setString(2, idEmpresa);
                // pst.execute();
                // response.sendRedirect("/aeLita/gestores/gestorArchivos.jsp");
            } catch (Exception e) {
                // out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
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

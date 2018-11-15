package bd;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "reporteEjecutorTareaCerrada", urlPatterns = {"/reporteEjecutorTareaCerrada"})
public class reporteEjecutorTareaCerrada extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");
        OutputStream out = response.getOutputStream();

        HttpSession hs = request.getSession(false);

        try {
            Document documento = new Document();
            PdfWriter.getInstance(documento, out);

            documento.open();

            String idTareaSeleccionada = request.getParameter("idTarea");
            String comentarioOT = request.getParameter("comentarioOT");
            String idEmpresa = "" + hs.getAttribute("idEmpresa");

            ResultSet rsAux = null; // Contiene el ID de la Orden de trabajo seleccionada.
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select tarea.idOrdenTrabajo from tarea where tarea.idTarea = " + idTareaSeleccionada + " and tarea.idEmpresa = " + idEmpresa;
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsAux = pstOrdenTrabajo.executeQuery();
                rsAux.next();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            String idOrdenTrabajo = "" + rsAux.getString("idOrdenTrabajo");
            ResultSet rsOrdenTrabajo = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select orden_trabajo.detalleOrdenTrabajo, orden_trabajo.estado, orden_trabajo.nombreOrdenTrabajo, orden_trabajo.idOrdenTrabajo, orden_trabajo.importancia, usuario.nombreUsuario, DATE_FORMAT(orden_trabajo.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio, orden_trabajo.fecha_fin, estado.nombreEstado, orden_trabajo.detalleOrdenTrabajo from orden_trabajo,usuario,estado where orden_trabajo.idOrdenTrabajo = " + idOrdenTrabajo + " and orden_trabajo.supervisor = usuario.idUsuario and orden_trabajo.estado = estado.idEstado and orden_trabajo.idEmpresa = " + idEmpresa;
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsOrdenTrabajo = pstOrdenTrabajo.executeQuery();
                rsOrdenTrabajo.next();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }

            ResultSet rsTareaSeleccionada = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select usuario.nombreUsuario, tarea.idProcedimiento, tarea.idTarea, tarea.estadoTarea, estado.nombreEstado, tipo_tarea.nombreTipoTarea, DATE_FORMAT(tarea.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio, tarea.fecha_fin from tarea,usuario,estado,tipo_tarea where tarea.usuario = usuario.idUsuario and tarea.estadoTarea = estado.idEstado and tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idTarea =" + idTareaSeleccionada + " and tarea.idEmpresa = " + idEmpresa;
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsTareaSeleccionada = pstOrdenTrabajo.executeQuery();
                rsTareaSeleccionada.next();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            ResultSet rsComentariosOTContador = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select usuario.nombreUsuario, usuario.tipoCuenta, avance.comentario, DATE_FORMAT(avance.fecha_publicacion, '%d/%m/%Y %T') as fecha_publicacion from avance,usuario where usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk=" + idOrdenTrabajo + " and avance.idEmpresa = " + idEmpresa;
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsComentariosOTContador = pstOrdenTrabajo.executeQuery();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            ResultSet rsComentariosOT = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select usuario.nombreUsuario, usuario.tipoCuenta, avance.comentario, DATE_FORMAT(avance.fecha_publicacion, '%d/%m/%Y %T') as fecha_publicacion, avance.fecha_publicacion as fecha_publicacionOrdenarPorFecha from avance,usuario where usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk=" + idOrdenTrabajo + " and avance.idEmpresa = " + idEmpresa + " order by fecha_publicacionOrdenarPorFecha asc";
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsComentariosOT = pstOrdenTrabajo.executeQuery();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            if (comentarioOT != null) {
                try {
                    int idEmpresaInt = Integer.parseInt(idEmpresa);
                    Connection conn = ConexionBD.getConexion();
                    String sql = "insert into avance (idTarea_fk,idOrdenTrabajo_fk,comentario,usuario,idEmpresa) values (?,?,?,?,?)";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    pst.setString(1, idTareaSeleccionada);
                    pst.setString(2, rsAux.getString("idOrdenTrabajo"));
                    pst.setString(3, comentarioOT);
                    pst.setString(4, ("" + hs.getAttribute("idUsuarioSesion")));
                    pst.setInt(5, idEmpresaInt);
                    pst.execute();
                    response.sendRedirect("/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=" + idTareaSeleccionada);
                    return;
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
            // Para el DropdownList para cambiar el estado de las tareas
            ResultSet rsEstados = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlEstados = "select * from estado where estado.idEmpresa = 0 or estado.idEmpresa =" + idEmpresa;
                PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
                rsEstados = pstEstados.executeQuery();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            ResultSet rsUsuarioEjecutor = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlUsuariosEjecutores = "select usuario.idUsuario, usuario.nombreUsuario from usuario,trabaja where trabaja.idUsuario = usuario.idUsuario and  usuario.tipoCuenta= 'Ejecutor' and  trabaja.idEmpresa =" + idEmpresa;
                PreparedStatement pstUsuariosEjecutores = conn.prepareStatement(sqlUsuariosEjecutores);
                rsUsuarioEjecutor = pstUsuariosEjecutores.executeQuery();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }

            Paragraph par1 = new Paragraph();
            Font fontTitulo = new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.DARK_GRAY); //Da formato al texto
            par1.add(new Phrase("Reporte Tarea - " + rsTareaSeleccionada.getString("nombreTipoTarea"), fontTitulo)); //Da titulo al reporte
            par1.setAlignment(Element.ALIGN_CENTER); //Alinea el Texto
            par1.add(new Phrase(Chunk.NEWLINE));
            par1.add(new Phrase(Chunk.NEWLINE));
            documento.add(par1);

            Paragraph par2 = new Paragraph();
            Font fontOrdenTrabajo = new Font(Font.FontFamily.COURIER, 12, Font.NORMAL, BaseColor.BLACK); //Da formato al texto
            par2.add(new Phrase("Orden de Trabajo - " + rsOrdenTrabajo.getString("nombreOrdenTrabajo"), fontOrdenTrabajo)); //Da titulo al reporte
            par2.setAlignment(Element.ALIGN_LEFT); //Alinea el Texto
            par2.add(new Phrase(Chunk.NEWLINE));
            par2.add(new Phrase(Chunk.NEWLINE));
            documento.add(par2);

            PdfPTable tabla2 = new PdfPTable(3);

            tabla2.setWidthPercentage(100); // Hace que la tabla ocupe todo el espacio a la izquierda y la derecha

            PdfPCell celda1Dos = new PdfPCell(new Paragraph("ID Orden de Trabajo", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda2Dos = new PdfPCell(new Paragraph("Importancia", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda3Dos = new PdfPCell(new Paragraph("Supervisor", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tabla2.addCell(celda1Dos);
            tabla2.addCell(celda2Dos);
            tabla2.addCell(celda3Dos);
            tabla2.addCell(rsOrdenTrabajo.getString("idOrdenTrabajo"));
            tabla2.addCell(rsOrdenTrabajo.getString("importancia"));
            tabla2.addCell(rsOrdenTrabajo.getString("nombreUsuario"));

            PdfPCell celda4Dos = new PdfPCell(new Paragraph("Fecha Inicio", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda5Dos = new PdfPCell(new Paragraph("Fecha Fin", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda6Dos = new PdfPCell(new Paragraph("", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tabla2.addCell(celda4Dos);
            tabla2.addCell(celda5Dos);
            tabla2.addCell(celda6Dos);
            tabla2.addCell(rsOrdenTrabajo.getString("fecha_inicio"));
            tabla2.addCell(rsOrdenTrabajo.getString("fecha_fin"));
            tabla2.addCell("");

            documento.add(tabla2);

            Paragraph par3 = new Paragraph();
            Font fontTarea = new Font(Font.FontFamily.COURIER, 12, Font.NORMAL, BaseColor.BLACK); //Da formato al texto
            par3.add(new Phrase("Tarea - " + rsTareaSeleccionada.getString("nombreTipoTarea"), fontTarea)); //Da titulo al reporte
            par3.setAlignment(Element.ALIGN_LEFT); //Alinea el Texto
            par3.add(new Phrase(Chunk.NEWLINE));
            par3.add(new Phrase(Chunk.NEWLINE));
            documento.add(par3);

            PdfPTable tabla = new PdfPTable(3);

            tabla.setWidthPercentage(100); // Hace que la tabla ocupe todo el espacio a la izquierda y la derecha

            PdfPCell celda1 = new PdfPCell(new Paragraph("ID Tarea", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda2 = new PdfPCell(new Paragraph("Asignado", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda3 = new PdfPCell(new Paragraph("Estado", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tabla.addCell(celda1);
            tabla.addCell(celda2);
            tabla.addCell(celda3);
            tabla.addCell(rsTareaSeleccionada.getString("idTarea"));
            tabla.addCell(rsTareaSeleccionada.getString("nombreUsuario"));
            tabla.addCell(rsTareaSeleccionada.getString("nombreEstado"));

            PdfPCell celda4 = new PdfPCell(new Paragraph("Tipo Tarea", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda5 = new PdfPCell(new Paragraph("Fecha Inicio", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda6 = new PdfPCell(new Paragraph("Fecha Fin", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tabla.addCell(celda4);
            tabla.addCell(celda5);
            tabla.addCell(celda6);
            tabla.addCell(rsTareaSeleccionada.getString("nombreTipoTarea"));
            tabla.addCell(rsTareaSeleccionada.getString("fecha_inicio"));
            tabla.addCell(rsTareaSeleccionada.getString("fecha_fin"));

            documento.add(tabla);

            Paragraph par5 = new Paragraph();
            Font FontAvances = new Font(Font.FontFamily.COURIER, 12, Font.BOLD, BaseColor.DARK_GRAY); //Da formato al texto
            par5.add(new Phrase("\nAvances", FontAvances)); //Da titulo al reporte
            par5.setAlignment(Element.ALIGN_JUSTIFIED); //Alinea el Texto
            par5.add(new Phrase(Chunk.NEWLINE));
            par5.add(new Phrase(Chunk.NEWLINE));
            documento.add(par5);

            PdfPTable tablaAvances = new PdfPTable(3);
            tablaAvances.setWidthPercentage(100); // Hace que la tabla ocupe todo el espacio a la izquierda y la derecha
            
            PdfPCell celda1Avance = new PdfPCell(new Paragraph("Usuario", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda2Avance = new PdfPCell(new Paragraph("Avance", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda3Avance = new PdfPCell(new Paragraph("Fecha Publicación", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tablaAvances.addCell(celda1Avance);
            tablaAvances.addCell(celda2Avance);
            tablaAvances.addCell(celda3Avance);
            while (rsComentariosOT.next()) {                
                tablaAvances.addCell(rsComentariosOT.getString("nombreUsuario"));
                tablaAvances.addCell(rsComentariosOT.getString("comentario"));
                tablaAvances.addCell(rsComentariosOT.getString("fecha_publicacion"));
            }
            documento.add(tablaAvances);
            
            Paragraph par100 = new Paragraph();
            Font fontDetalle = new Font(Font.FontFamily.COURIER, 12, Font.NORMAL, BaseColor.DARK_GRAY); //Da formato al texto
            par100.add(new Phrase("Documento generado por motor de aeLita. El contenido de este informe es completa responsabilidad de quienes lo emiten. aeLita no es responsable de usos indebidos.", fontDetalle)); //Da titulo al reporte
            par100.setAlignment(Element.ALIGN_JUSTIFIED); //Alinea el Texto
            par100.add(new Phrase(Chunk.NEWLINE));
            par100.add(new Phrase(Chunk.NEWLINE));
            documento.add(par100);

            documento.close();

        } catch (Exception ex) {
            ex.getMessage();
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

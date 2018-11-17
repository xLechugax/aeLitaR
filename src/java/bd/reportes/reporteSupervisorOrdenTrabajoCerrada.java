/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bd.reportes;

import bd.ConexionBD;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.OutputStream;
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
 * @author Lechuga
 */
@WebServlet(name = "reporteSupervisorOrdenTrabajoCerrada", urlPatterns = {"/reporteSupervisorOrdenTrabajoCerrada"})
public class reporteSupervisorOrdenTrabajoCerrada extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");
        OutputStream out = response.getOutputStream();

        HttpSession hs = request.getSession(false);

        try {
            Document documento = new Document();
            PdfWriter.getInstance(documento, out);

            documento.open();

            String idOrdenTrabajoSeleccionada = request.getParameter("idOT");
            String idEmpresa = "" + hs.getAttribute("idEmpresa");

            ResultSet rsOrdenTrabajo = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select * from orden_trabajo,usuario,estado where orden_trabajo.idOrdenTrabajo = " + idOrdenTrabajoSeleccionada + " and orden_trabajo.supervisor = usuario.idUsuario and orden_trabajo.estado = estado.idEstado";
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsOrdenTrabajo = pstOrdenTrabajo.executeQuery();
                rsOrdenTrabajo.next();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            ResultSet rsTareasBajoLaOT = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select tarea.idTarea, tipo_tarea.nombreTipoTarea, estado.nombreEstado,  usuario.nombreUsuario, tarea.fecha_inicio, tarea.fecha_fin from tarea,usuario,tipo_tarea,estado where tarea.estadoTarea = estado.idEstado and tarea.usuario = usuario.idUsuario and tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idOrdenTrabajo =" + idOrdenTrabajoSeleccionada;
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsTareasBajoLaOT = pstOrdenTrabajo.executeQuery();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }
            ResultSet rsComentariosOT = null;
            try {
                Connection conn = ConexionBD.getConexion();
                String sqlOrdenTrabajo = "select * from avance,usuario,tarea,tipo_tarea where usuario.idUsuario = avance.usuario and avance.idTarea_fk = tarea.idTarea and tarea.idTipoTarea = tipo_tarea.idTipoTarea and avance.idOrdenTrabajo_fk= " + idOrdenTrabajoSeleccionada + " order by fecha_publicacion desc";
                PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
                rsComentariosOT = pstOrdenTrabajo.executeQuery();
            } catch (SQLException e) {
                System.out.println(e);
                return;
            }

            Paragraph par1 = new Paragraph();
            Font fontTitulo = new Font(Font.FontFamily.COURIER, 16, Font.BOLD, BaseColor.DARK_GRAY); //Da formato al texto
            par1.add(new Phrase("Reporte OT - " + rsOrdenTrabajo.getString("nombreOrdenTrabajo"), fontTitulo)); //Da titulo al reporte
            par1.setAlignment(Element.ALIGN_CENTER); //Alinea el Texto
            par1.add(new Phrase(Chunk.NEWLINE));
            par1.add(new Phrase(Chunk.NEWLINE));
            documento.add(par1);

            Paragraph par2 = new Paragraph();
            Font fontOrdenTrabajo = new Font(Font.FontFamily.COURIER, 12, Font.NORMAL, BaseColor.BLACK); //Da formato al texto
            par2.add(new Phrase("Detalle de OT", fontOrdenTrabajo)); //Da titulo al reporte
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
            Font fontTareasBajoOT = new Font(Font.FontFamily.COURIER, 12, Font.NORMAL, BaseColor.BLACK); //Da formato al texto
            par3.add(new Phrase("Tareas bajo la OT - " + rsOrdenTrabajo.getString("nombreOrdenTrabajo"), fontTareasBajoOT)); //Da titulo al reporte
            par3.setAlignment(Element.ALIGN_LEFT); //Alinea el Texto
            par3.add(new Phrase(Chunk.NEWLINE));
            par3.add(new Phrase(Chunk.NEWLINE));
            documento.add(par3);

            PdfPTable tablaTareas = new PdfPTable(6);

            tablaTareas.setWidthPercentage(100); // Hace que la tabla ocupe todo el espacio a la izquierda y la derecha

            PdfPCell celdaUno = new PdfPCell(new Paragraph("ID Tarea", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celdaDos = new PdfPCell(new Paragraph("Tipo Tarea", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celdaTres = new PdfPCell(new Paragraph("Estado", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celdaCuatro = new PdfPCell(new Paragraph("Ejecutor", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celdaCinco = new PdfPCell(new Paragraph("Fecha Inicio", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celdaSeis = new PdfPCell(new Paragraph("Fecha Fin", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tablaTareas.addCell(celdaUno);
            tablaTareas.addCell(celdaDos);
            tablaTareas.addCell(celdaTres);
            tablaTareas.addCell(celdaCuatro);
            tablaTareas.addCell(celdaCinco);
            tablaTareas.addCell(celdaSeis);
            while (rsTareasBajoLaOT.next()) {
                tablaTareas.addCell(rsTareasBajoLaOT.getString("idTarea"));
                tablaTareas.addCell(rsTareasBajoLaOT.getString("nombreTipoTarea"));
                tablaTareas.addCell(rsTareasBajoLaOT.getString("nombreEstado"));
                tablaTareas.addCell(rsTareasBajoLaOT.getString("nombreUsuario"));
                tablaTareas.addCell(rsTareasBajoLaOT.getString("fecha_inicio"));
                tablaTareas.addCell(rsTareasBajoLaOT.getString("fecha_fin"));
            }
            documento.add(tablaTareas);

            Paragraph par4 = new Paragraph();
            Font fontAvances = new Font(Font.FontFamily.COURIER, 12, Font.NORMAL, BaseColor.BLACK); //Da formato al texto
            par4.add(new Phrase("Tareas bajo la OT - " + rsOrdenTrabajo.getString("nombreOrdenTrabajo"), fontAvances)); //Da titulo al reporte
            par4.setAlignment(Element.ALIGN_LEFT); //Alinea el Texto
            par4.add(new Phrase(Chunk.NEWLINE));
            par4.add(new Phrase(Chunk.NEWLINE));
            documento.add(par4);
            
            PdfPTable tablaAvances = new PdfPTable(3);
            tablaAvances.setWidthPercentage(100); // Hace que la tabla ocupe todo el espacio a la izquierda y la derecha

            PdfPCell celda0Avance = new PdfPCell(new Paragraph("Tarea", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda1Avance = new PdfPCell(new Paragraph("Usuario", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda2Avance = new PdfPCell(new Paragraph("Avance", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            PdfPCell celda3Avance = new PdfPCell(new Paragraph("Fecha Publicación", FontFactory.getFont("Courier", 12, Font.NORMAL, BaseColor.BLACK)));
            tablaAvances.addCell(celda0Avance); 
            tablaAvances.addCell(celda1Avance);
            tablaAvances.addCell(celda2Avance);
            tablaAvances.addCell(celda3Avance);
            while (rsComentariosOT.next()) {
                tablaAvances.addCell(rsComentariosOT.getString("nombreTipoTarea"));
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

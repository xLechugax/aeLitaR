package SERVLET_CONTROLLERS;

import crud.gestorFiles.gestorDataFile;
import crud.getData.ImagenVO;
import java.io.IOException;
import java.io.InputStream;
import java.io.ByteArrayInputStream;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.sql.*;
import bd.*;
import java.io.File;
import javax.servlet.ServletOutputStream;

@WebServlet(name = "ControllerImagen", urlPatterns = {"/ControllerImagen"})
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB

public class ControllerImagen extends HttpServlet {

    String estado, idArchivo;
    gestorDataFile fileCtrl;

    public ControllerImagen() {
        fileCtrl = new gestorDataFile();
        estado = null;
        idArchivo = "";
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession hs = request.getSession(false);
        estado = request.getParameter("action");
        hs.setAttribute("estado", estado); // Esta varaible session es opcional lo determie para poder mostrar el tipo de ación que realice en la vista gestorArchivo.
        
        idArchivo = request.getParameter("id");

        ImagenVO dataVO = new ImagenVO();
        InputStream inputStream = null;

        if(estado.equalsIgnoreCase("donwload")) {

            dataVO.setIdArchivo(idArchivo);
            fileCtrl.descargar_Archivo(dataVO);
            try {
                String fileName = dataVO.getNombreFile();
                response.setContentType(dataVO.getContentType());
                response.setHeader("Content-Disposition","attachment;filename=" + fileName);
                
                inputStream = new ByteArrayInputStream(dataVO.getArchiveByte());
                ServletOutputStream outData = response.getOutputStream();

                int i;
                while ( (i = inputStream.read()) != -1 ) {
                    outData.write(i);
                }
                outData.flush();
                inputStream.close();
                outData.close();
            } catch(Exception ex) {
                ex.printStackTrace();
                System.out.println("fichero: "+ex.getMessage());
            }
        }

        response.sendRedirect("/aeLita/gestores/gestorArchivos.jsp");

    }

     public String getFileName(Part part) {
       for (String content : part.getHeader("content-disposition").split(";")) {
          if (content.trim().startsWith("filename")) {
              return content.substring(content.indexOf('=') + 1).trim().replace("\"","");
            }
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession hs = request.getSession(false);
        String action = request.getParameter("option");
        if( action != null && action !=  "") {
            estado = action;
            idArchivo = request.getParameter("idArchivo");
        } else { estado = "insert"; }

        hs.setAttribute("estado", estado);
        ImagenVO dataVO = new ImagenVO();
        int idEmpresa = Integer.parseInt(""+hs.getAttribute("idEmpresa"));
        InputStream inputStream = null;
        String type = "", nombre = "";
        try {
            Part filePart = request.getPart("file");
            if (filePart.getSize() > 0 && !estado.equalsIgnoreCase("delete")) {
                type = filePart.getContentType();// or  filePart.getHeader("content-type");
                //getName() => obtiene el nombre del archivo.
                nombre = getFileName(filePart);
                inputStream = filePart.getInputStream();
            }
        } catch (Exception ex) {
            System.out.println("fichero: "+ex.getMessage());
        }

        try {

            if(estado.equalsIgnoreCase("delete")) {
                fileCtrl.eliminar_Imagen(idArchivo);
            } else {
                if (inputStream != null) {
                    dataVO.setArchivo(inputStream);
                    dataVO.setTypeFile(type);
                    dataVO.setNombreFile(nombre);
                }
                dataVO.setIdEmpresa(idEmpresa);
                if (estado.equalsIgnoreCase("insert")) {

                    fileCtrl.agregar_Imagen(dataVO);

                } else if (estado.equalsIgnoreCase("update")) {

                    dataVO.setIdArchivo(idArchivo);
                    dataVO.setDetalle("Sin detalle");
                    fileCtrl.modificar_Imagen(dataVO);

                } else if(estado.equalsIgnoreCase("donwload")) {
                    // Aquí lo tengo igual con method Post, pero falta recuperar el nombre del archivo de la variable fileName como lo muestra en método GET, 
                    // 
                    dataVO.setIdArchivo(idArchivo);
                    fileCtrl.descargar_Archivo(dataVO);
                    response.setContentType(dataVO.getContentType());
                    // response.setHeader("Content-Disposition","attachment;filename=" + fileName );

                    try{
                        //File fileToDownload = new File( dataVO.getArchivoimg() );
                        inputStream = dataVO.getArchivo();
                        ServletOutputStream outData = response.getOutputStream();

                        int i;
                        while ( (i = inputStream.read()) != -1 ) {
                            outData.write(i);
                        }
                        inputStream.close();
                        outData.close();
                    } catch(Exception ex) {
                        ex.printStackTrace();
                        System.out.println("fichero: "+ex.getMessage());
                    }
                }
            }


        } catch (Exception ex) {
            System.out.println("textos: "+ex.getMessage());
        }

        // RequestDispatcher view = request.getRequestDispatcher("/gestores/gestorArchivos.jsp");
        // view.forward(request, response);
        response.sendRedirect("/aeLita/gestores/gestorArchivos.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

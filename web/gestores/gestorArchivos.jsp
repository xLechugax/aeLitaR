<%@page import="java.io.FileInputStream"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page import="crud.getData.ImagenVO"%>
<%@page import="crud.gestorFiles.gestorDataFile"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>

<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    HttpSession hs1 = request.getSession(false);

    // ALTER TABLE `archivo` add type char(20) not null DEFAULT "" AFTER archivo;
    // ALTER TABLE `archivo` add nombre varchar(250) not null DEFAULT "" AFTER type;    
    String detalle = "";
    gestorDataFile gdf = new gestorDataFile();
    ImagenVO dataVO = new ImagenVO();

    String nomFile = "";
    String ID = "";
    try {
        dataVO.setIdArchivo("00000000006");
        gdf.descargar_Archivo(dataVO);
        ID = dataVO.getContentType();
        // ESte fue una prueba que realizar para descargar desde la miam página...  pero lo manipule del controlador paa evitar recargar- tambien hay que borrarlo? si 
        // si desea m pero analiza este condigo, es un poco diferente al que tengo en el controlador... este lo puedes usar colocando en un archivo aparte con extension .jsp
        //ok ya veo..
        /*dataVO.setIdArchivo("00000000006");
        gdf.descargar_Archivo(dataVO);

        //String nomFile = "Bas.txt";
        //FileInputStream archivo = new FileInputStream("C:\\Users\\David Perez89\\Downloads\\"+nomFile);

        nomFile = dataVO.getNombreFile();
        ID = dataVO.getContentType();
        InputStream archivo = new ByteArrayInputStream(dataVO.getArchiveByte());
        int longitud = archivo.available();
        byte[] datos = new byte[longitud];
        archivo.read(datos);
        archivo.close();
        // response.setContentType("application/octet-stream");
        response.setContentType(dataVO.getContentType());
        response.setHeader("Content-Disposition","attachment;filename="+nomFile);
        ServletOutputStream ouputStream = response.getOutputStream();
        ouputStream.write(datos);
        ouputStream.flush();
        ouputStream.close();*/
    } catch (Exception e) {
        e.printStackTrace();

    }

    ArrayList<ImagenVO> listar = gdf.Listar_DataFile();
%>
<!DOCTYPE html>
<html>
    <head>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="/aeLita/css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
        <style>
            .show {display: block !important; }
        </style>
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <!--- 
                        <!-- <h1><%= "Nombre " + nomFile%></h1>
                         <h1><%= "ID " + ID%></h1>
                        <h1><%= hs1.getAttribute("estado")%></h1> --->

            <div class="row">
                <div class="col m3">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Filtro de Busqueda</a>
                                <br/>
                                <form action="#">
                                    <p>
                                    <div class="input-field col m12">
                                        <input id="nombreArchivo" type="text" class="validate">
                                        <label for="last_name">Nombre de Archivo</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="OrdendeTrabajo">
                                        <label for="OrdendeTrabajo">Orden de Trabajo</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Tarea">
                                        <label for="Tarea">Tarea</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Avance">
                                        <label for="Avance">Avance</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Procedimiento">
                                        <label for="Procedimiento">Procedimiento</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Actividad">
                                        <label for="Actividad">Actividad</label>
                                    </div>
                                    </p>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align" type="submit" value="buscar" />
                                    </center>
                                </form>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12" style="padding: 15px 30px !important;">
                            <!-- <form action="/aeLita/gestorArchivoAgregar" enctype="MULTIPART/FORM-DATA" method="post"> -->
                            <form action="/aeLita/ControllerImagen" enctype="MULTIPART/FORM-DATA" method="post" id="formfile">

                                <input type="hidden" id="option" />
                                <input type="hidden" name="idArchivo"  id="idArchivo"/>
                                <input type="file" name="file" /><br/> <br/>
                                <input  class="waves-effect waves-light btn right-align" type="submit" value="Cargar" />
                                <a href="#" class="waves-effect waves-light btn right-align hide" id="cancel">Cancelar</a>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col m9">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Archivos</a>
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th>idArchivo</th>
                                            <th>Avance</th>
                                            <th>Tarea</th>
                                            <th>OT</th>
                                            <th>Procedimiento</th>
                                            <th>Nombre</th>
                                            <th>Detalle</th>
                                            <th>Archivo</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%if (listar.size() > 0) {
                                                for (ImagenVO listar2 : listar) {
                                                    dataVO = listar2;
                                                    detalle = dataVO.getDetalle();
                                                    //if( detalle == "null" || detalle == null )
                                                    //  detalle = "nada";

                                        %>
                                        <tr>
                                            <td><%=dataVO.getIdArchivo()%></td>
                                            <td><%=dataVO.getidAvance()%></td>
                                            <td><%=dataVO.getidTarea()%></td>
                                            <td><%=dataVO.getidTrabajo()%></td>
                                            <td><%=dataVO.getidProcedimiento()%></td>

                                            <td><%=dataVO.getNombreFile()%></td>

                                            <td><%=detalle%></td>


                                            <td><%=dataVO.getTypeFile()%></td>
                                            <td>
                                                <a id="descargar" href="http://localhost:8080/aeLita/ControllerImagen?action=donwload&id=<%=dataVO.getIdArchivo()%>"> <img src="img/download.gif" title="Descargar"/></a>
                                                <a  id="update" class="option" href="#" data-id="<%=dataVO.getIdArchivo()%>"> <img src="img/modificar.jpg" title="Modificar"/></a>
                                                <a id="delete" class="option" href="#" data-id="<%=dataVO.getIdArchivo()%>"> <img src="img/eliminar.png" title="Eliminar"/></a>
                                            </td>
                                        </tr>
                                        <%
                                                    detalle = "";
                                                }
                                            }
                                        %>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();

            $(document).on('click', "a.option", function (e) {
                e.preventDefault();
                let self = e.target.parentNode;
                let id = $(self).data("id") || self.getAttribute("data-id");

                $("#formfile").find('input#idArchivo').val(id);
                $("#formfile").find('input#option').val(self.id);
                $("#formfile").find('input#option').attr("name", "option");
                if (self.id === "delete") {
                    if (confirm("Desea eliminar el archivo"))
                        $("form#formfile").submit();
                } else if (self.id === "update") {
                    $("#formfile").find('input[type=submit]').val("ACTUALIZAR");
                    $("#cancel").removeClass('hide');
                }
            });

            $("#cancel").on('click', function (e) {
                e.preventDefault();
                $("#formfile").find('input[type=submit]').val("CARGAR");
                $("#formfile").find('input#idArchivo').val("");
                $("#formfile").find('input#option').val("");
                $(e.target).addClass('hide');
            });
        });
    </script>
</body>
</html>
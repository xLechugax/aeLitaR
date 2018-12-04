<%@page import="java.io.FileInputStream"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page import="crud.getData.ImagenVO"%>
<%@page import="crud.gestorFiles.gestorDataFile"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    
    HttpSession hs1 = request.getSession(false);
    String detalle = "";
    gestorDataFile gdf = new gestorDataFile();
    ImagenVO dataVO = new ImagenVO();
    String nomFile = "";
    String ID = "";

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
            <div class="row">

            </div>
            <!-- <h1><%= "Nombre " + nomFile%></h1> 
             <h1><%= "ID " + ID%></h1>
            <h1><%= hs1.getAttribute("estado")%></h1>-->
            <div class="row">
                <div class="col m12">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Archivos</a>
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th>idArchivo</th>
                                            <th>Nombre</th>
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

                                            <td><%=dataVO.getNombreFile()%></td>


                                            <td><%=dataVO.getTypeFile()%></td>
                                            <td>
                                                <a id="descargar" href="http://localhost:8080/aeLita/ControllerImagen?action=donwload&id=<%=dataVO.getIdArchivo()%>"><i class="material-icons green-text">file_download</i></a>
                                                <a  id="update" class="option" href="#" data-id="<%=dataVO.getIdArchivo()%>"><i class="material-icons orange-text">edit</i></a>
                                                <a id="delete" class="option" href="#" data-id="<%=dataVO.getIdArchivo()%>"><i class="material-icons red-text">delete</i></a>
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
            <div class="col-12" style="padding: 15px 30px !important;">
                <!-- <form action="/aeLita/gestorArchivoAgregar" enctype="MULTIPART/FORM-DATA" method="post"> -->
                <form action="/aeLita/ControllerImagen" enctype="MULTIPART/FORM-DATA" method="post" id="formfile">

                    <input type="hidden" id="option" />
                    <input type="hidden" name="idArchivo"  id="idArchivo"/>
                    <input type="hidden" name="idArchivo"  id="idArchivo"/>
                    <input type="hidden" name="idProcedimiento" value="0" id="idProcedimiento"/>
                    <input type="hidden" name="idTarea" value="0" id="idTarea">
                    <input type="hidden" name="idOT" value="0" id="idOT"/>
                    <div class="file-field input-field">
                        <div class="btn">
                            <span>File</span>
                            <input type="file" name="file">
                        </div>
                        <div class="file-path-wrapper">
                            <input class="file-path validate" type="text">
                        </div>
                    </div>
                    <input  class="waves-effect waves-light btn right-align" type="submit" value="Cargar" />
                    <a href="#" class="waves-effect waves-light btn right-align hide" id="cancel">Cancelar</a>
                </form>
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
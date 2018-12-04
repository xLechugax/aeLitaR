<%@page import="java.util.ArrayList"%>
<%@page import="crud.gestorFiles.gestorDataFile"%>
<%@page import="crud.getData.ImagenVO"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession,java.util.Random,java.security.SecureRandom"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %>
<%    String idProcedimiento = request.getParameter("idProcedimiento");

    ResultSet rsProcedimientoSeleccionado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from procedimiento where idProcedimiento=" + idProcedimiento;
        PreparedStatement pst = conn.prepareStatement(sql);
        rsProcedimientoSeleccionado = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsActividades = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from actividad where idProcedimiento=" + idProcedimiento + " and actividad.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsActividades = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsActividadesContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select count(*) from actividad where idProcedimiento=" + idProcedimiento + " and actividad.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsActividadesContador = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    String detalle = "";
    ImagenVO dataVO = new ImagenVO();
    gestorDataFile gdf = new gestorDataFile();
    int idEmpresa = Integer.parseInt(("" + hs.getAttribute("idEmpresa")));
    ArrayList<ImagenVO> listar = gdf.Listar_DataFile_idProcedimiento(Integer.parseInt(idProcedimiento) , idEmpresa);
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
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <div class="row">
                <div class="col m4">
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Detalle del Procedimiento</div>
                            <div class="collapsible-body white">
                                <% rsProcedimientoSeleccionado.next();%>
                                Nombre:  <%= rsProcedimientoSeleccionado.getString("nombreProcedimiento")%><br/>
                                Detalle: <%= rsProcedimientoSeleccionado.getString("detalleProcedimiento")%>
                                Detalle: <%= hs.getAttribute("tipoCuenta")%>
                            </div> 
                        </li>
                        <% if (hs.getAttribute("tipoCuenta").equals("Supervisor") || hs.getAttribute("tipoCuenta").equals("Administrador")) {%>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">place</i>Agregar Actividad</div>
                            <div class="collapsible-body white">
                                <form action="/aeLita/gestorProcedimientosAgregarActividad" method="post">
                                    <input type="hidden" name="idProcedimiento" value="<%= idProcedimiento%>">
                                    <div class="input-field col s12">
                                        <input id="nombreActividad" name="nombreActividad" type="text" class="validate" required="">
                                        <label for="nombreActividad">Nombre de Actividad</label>
                                    </div>
                                    <div class="input-field col s12">
                                        <textarea id="detalleActividad" name="detalleActividad" class="materialize-textarea" style="height: 150px;" required=""></textarea>
                                        <label for="detalleActividad">Detalle Actividad</label>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align blue-grey darken-3" type="submit" value="Agregar Actividad" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <%}%>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">archive</i>Archivos</div>
                            <div class="collapsible-body white">
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Tipo</th>
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
                                <form action="/aeLita/ControllerImagen" enctype="MULTIPART/FORM-DATA" method="post" id="formfile">
                                    <input type="hidden" id="option" />
                                    <input type="hidden" name="idArchivo"  id="idArchivo"/>
                                    <input type="hidden" name="idProcedimiento" value="<%= idProcedimiento %>" id="idProcedimiento"/>
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
                        </li>
                    </ul>
                </div>
                <div class="col m8">
                    <ul class="collapsible" data-collapsible="accordion">
                        <% rsActividadesContador.next();
                            int CantidadActividades = rsActividadesContador.getInt(1);
                            if (CantidadActividades >= 1) {%>
                        <% while (rsActividades.next()) {%>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_drama</i><%= rsActividades.getString("nombreActividad")%></div>
                            <div class="collapsible-body white"><span><%= rsActividades.getString("detalleActividad")%></span></div>
                        </li>
                        <%}%>
                        <%} else {%>
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i><text class="orange-text">Sin actividades...</text></div>
                            <div class="collapsible-body white"><span class="red-text">Aún no son asociadas actividades...</span></div>
                        </li>
                        <%}%>
                    </ul>
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
        });
    </script>
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
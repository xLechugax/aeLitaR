<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    ResultSet rsTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tipo_tarea where tipo_tarea.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareas = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tipo_tarea where tipo_tarea.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasContador = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
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
                <div class="col m5">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Crear Tipo de Tarea</a> 
                                <form action="/aeLita/gestorTipoTareasAgregar" method="post">
                                    <table>
                                        <tbody>
                                            <tr> 
                                                <td>Nombre Tipo Tarea:</td>
                                                <td><input placeholder="Nombre..." name="nombre_tipo_tarea" class="validate" required=""></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_tipo_tarea" class="materialize-textarea" data-length="120" required=""></textarea>
                                        <label for="textarea1">Detalle de tipo tarea</label>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align blue-grey darken-4" type="submit" value="Crear Tipo de Tarea " />
                                    </center>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col m7">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-content">
                                <table class="highlight">
                                    <% if (rsTareasContador.next()) {%>
                                    <thead>
                                        <tr>
                                            <td>ID</td>
                                            <td>Tipo de Tarea</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <% while (rsTareas.next()) {%>
                                    <tbody>
                                        <tr>
                                            <td><%= rsTareas.getString("idTipoTarea")%></td>
                                            <td><%= rsTareas.getString("nombreTipoTarea")%></td>
                                            <td>
                                                <!-- Modal Trigger -->
                                                <!--<a class=" modal-trigger" href="#modal<%=rsTareas.getString("idTipoTarea")%>"><img src="img/eliminar.png" title="Modificar"/></a>-->

                                                <!-- Modal Structure -->
                                                <div id="modal<%=rsTareas.getString("idTipoTarea")%>" class="modal bottom-sheet">
                                                    <div class="modal-content">
                                                        <h4>¿Cofirmar eliminación de "<%= rsTareas.getString("nombreTipoTarea")%>"?</h4>    
                                                    </div>
                                                    <div class="modal-footer">
                                                        <a href="/aeLita/gestorTipoTareasEliminar?idTipoTarea=<%=rsTareas.getLong("idTipoTarea")%>" class="modal-close waves-effect waves-green btn-flat green white-text left">Si</a>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat red white-text">No</a>
                                                    </div>
                                                </div>
                                                    <a class="orange-text" href="gestorTipoTareasModificar.jsp?idTipoTarea=<%=rsTareas.getLong("idTipoTarea")%>">
                                                    <i class="material-icons tiny orange-text" title="Editar">edit</i>&nbsp;Editar
                                                </a>
                                            </td>
                                        </tr>
                                    </tbody>
                                    <%}%>
                                    <%} else {%>
                                    <p class="red-text">Aún no se han agregado tipos de tareas...</p>
                                    <%}%>
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
            $('.modal').modal();
        });
    </script>
</body>
</html>
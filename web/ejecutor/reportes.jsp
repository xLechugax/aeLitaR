<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<%    ResultSet rsTareasCerradas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea =5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasCerradas = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareasCerradasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea =5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasCerradasContador = pst.executeQuery();
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
                <div class="col s4 m4">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_list</i>Filtro por Fecha</div>
                            <div class="collapsible-body white">
                                <form>
                                    Desde
                                    <input id="fechaDesde" type="datetime-local" value="2017-06-01" required="">
                                    Hasta
                                    <input id="fechaHasta" type="datetime-local" value="2017-06-01">
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_list</i>Filtro por ID de Tarea</div>
                            <div class="collapsible-body white">
                                <form>
                                    ID de Tarea
                                    <input id="idTarea" type="text" required="">
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </center>
                                </form>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="col s8 m8">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">history</i>Tareas cerradas</div>
                            <div class="collapsible-body white">
                                <% if (rsTareasCerradasContador.next()) {%>
                                <table border="1" class="highlight">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Estado</th>
                                            <th>Criticidad</th>
                                            <th><center>Tarea</center></th>
                                    <th>Orden de Trabajo</th>
                                    <th>Fecha Inicio</th>
                                    <th>Operaciones</th>
                                    </tr>
                                    </thead>
                                    <%while (rsTareasCerradas.next()) {%>  
                                    <tbody>
                                        <tr>
                                            <td><b><%= rsTareasCerradas.getString("idTarea")%></b></td>
                                            <td><%= rsTareasCerradas.getString("nombreEstado")%></td>
                                            <td><% if (rsTareasCerradas.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsTareasCerradas.getString("importancia")%><p> <%} %>
                                                <% if (rsTareasCerradas.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsTareasCerradas.getString("importancia")%><p> <%} %>
                                                <% if (rsTareasCerradas.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsTareasCerradas.getString("importancia")%><p> <%}%></td>
                                            <td><b><center><%= rsTareasCerradas.getString("nombreTipoTarea")%></center></b></td>
                                            <td><%= rsTareasCerradas.getString("nombreOrdenTrabajo")%></td>
                                            <td><%= rsTareasCerradas.getString("fecha_inicio")%></td>
                                            <td><a href="/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=<%= rsTareasCerradas.getString("idTarea")%>" class="btn blue-grey darken-3">Detalle</a></td>
                                        </tr>
                                        <%}
                                        } else {%>
                                    <p class="orange-text">Por el momento no hay tareas cerradas...</p>
                                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </li>
                        
                    </ul>
                </div>
            </div>
            </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/Chart.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker();
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('.collapsible').collapsible();
        });
    </script>
</body>
</html>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %>
<%    ResultSet rsTareasAsignadas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea !=5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion")
                + " and tarea.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasAsignadas = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareasAsignadasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea !=5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion")
                + " and tarea.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasAsignadasContador = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="/aeLita/css/materialize.min.css"  media="screen,projection"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <div class="row">
                <div class="col m12">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Tareas asignadas</div>
                            <div class="collapsible-body white">
                                <% if (rsTareasAsignadasContador.next()) {%>
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
                                    <%while (rsTareasAsignadas.next()) {%>  
                                    <tbody>
                                        <tr>
                                            <td><b><%= rsTareasAsignadas.getString("idTarea")%></b></td>
                                            <td><%= rsTareasAsignadas.getString("nombreEstado")%></td>
                                            <td><% if (rsTareasAsignadas.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsTareasAsignadas.getString("importancia")%><p> <%} %>
                                                <% if (rsTareasAsignadas.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsTareasAsignadas.getString("importancia")%><p> <%} %>
                                                <% if (rsTareasAsignadas.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsTareasAsignadas.getString("importancia")%><p> <%}%></td>
                                            <td><b><center><%= rsTareasAsignadas.getString("nombreTipoTarea")%></center></b></td>
                                            <td><%= rsTareasAsignadas.getString("nombreOrdenTrabajo")%></td>
                                            <td><%= rsTareasAsignadas.getString("fecha_inicio")%></td>
                                            <td><a href="/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=<%= rsTareasAsignadas.getString("idTarea")%>" class="btn">Detalle</a></td>
                                        </tr>
                                        <%}
                                        } else {%>
                                    <p class="orange-text">Por el momento no hay tareas asignadas...</p>
                                    <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </li>
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
</body>
</html>
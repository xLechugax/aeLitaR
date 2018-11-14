<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %>
<%    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado where estado.idEstado != 5 and estado.idEmpresa = " + hs.getAttribute("idEmpresa") + " or estado.idEmpresa = 0 and estado.idEstado != 5";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstados = pst.executeQuery();
    } catch (SQLException e) { 
        out.println("Excepción de SQL:" + e);
        return;
    }
    
    String estado = request.getParameter("idEstadoFiltro");
    String importancia = request.getParameter("importanciaFiltro");
    
    ResultSet rsTareasAsignadas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea !=5" //ID 5 de tarea Cerrada
                + " and tarea.idEmpresa=" + hs.getAttribute("idEmpresa")
                + " and orden_trabajo.supervisor=" + hs.getAttribute("idUsuarioSesion");
        
        if (estado != null) { 
            sql = sql + " and tarea.estadoTarea ="+estado; 
        }
        if (importancia != null) { 
            sql = sql + " and orden_trabajo.importancia='"+importancia+"'"; 
        }
        
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasAsignadas = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e + estado + importancia);
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
                + " and tarea.idEmpresa=" + hs.getAttribute("idEmpresa")
                + " and orden_trabajo.supervisor=" + hs.getAttribute("idUsuarioSesion");
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
                <div class="col m12">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Tareas</a> 
                                <br/>
                                <form action="#" method="post">
                                    <div class="input-field col  m2">
                                        <select class="icons" name="idEstadoFiltro">
                                            <option value="" disabled selected>Seleccione Estado</option>
                                            <% while (rsEstados.next()) {%>                                                  
                                            <option value="<%= rsEstados.getString("idEstado")%>"><%= rsEstados.getString("nombreEstado")%></option>
                                            <%}%>
                                        </select>
                                        <label>Estado</label>
                                    </div>
                                    <div class="input-field col m2">
                                        <select class="icons" name="importanciaFiltro">
                                            <option value="" disabled selected>Seleccione Importancia</option>
                                            <option value="Alta">Alta</option>
                                            <option value="Media">Media</option>
                                            <option value="Baja">Baja</option>
                                        </select>
                                        <label>Importancia</label>
                                    </div>
                                    <div class="input-field col m1">
                                        <input class="waves-effect waves-light btn blue-grey darken-3"  type="submit" value="Filtrar" />
                                    </div>
                                </form><br/><br/><br/>
                                <table border="1">
                                    <tbody>
                                        <tr>
                                            <td><b>idTarea</b></td>
                                            <td><b>Importancia</b></td>
                                            <td><b>Ejecutor</b></td>
                                            <td><b>Estado</b></td>
                                            <td><b>Tipo Tarea</b></td>
                                            <td><b>Nombre OT</b></td>
                                            <td><b>Fecha Inicio</b></td>
                                            <td><b>Operaciones</b></td>
                                        </tr>
                                        <% if (rsTareasAsignadasContador.next()) {%>
                                            <% while (rsTareasAsignadas.next()) {%>
                                            <tr>
                                                <td><%= rsTareasAsignadas.getString("idTarea") %></td>
                                                <td>
                                                    <% if (rsTareasAsignadas.getString("importancia").equals("Alta")){%><p class="red-text center-align"><%=rsTareasAsignadas.getString("importancia")%><p><%}%>
                                                    <% if (rsTareasAsignadas.getString("importancia").equals("Media")){%><p class="orange-text center-align"><%=rsTareasAsignadas.getString("importancia")%><p><%}%>
                                                    <% if (rsTareasAsignadas.getString("importancia").equals("Baja")){%><p class="green-text center-align"><%=rsTareasAsignadas.getString("importancia")%><p><%}%>
                                                </td>
                                                <td><%= rsTareasAsignadas.getString("nombreUsuario") %></td>
                                                <td><%= rsTareasAsignadas.getString("nombreEstado") %></td>
                                                <td><%= rsTareasAsignadas.getString("nombreTipoTarea") %></td>
                                                <td><%= rsTareasAsignadas.getString("nombreOrdenTrabajo") %></td>
                                                <td><%= rsTareasAsignadas.getString("fecha_inicio") %></td>
                                                <td><a href="/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=<%= rsTareasAsignadas.getString("idTarea")%>" class="btn blue-grey darken-3">Detalle</a></td>
                                            </tr>
                                            <% }%>
                                        <% }%>
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
            $('select').material_select();
        });
    </script>
</body>
</html>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%    String idOrdenTrabajoSeleccionada = request.getParameter("idOT");
    String idTipoTareaAsignar = request.getParameter("idtipoTareaAsignar");
    String idEjecutorAsignar = request.getParameter("idEjecutorAsignar");

    if (idEjecutorAsignar != null && idEjecutorAsignar != null) {
        try {
            Connection conn = ConexionBD.getConexion();
            String sql = "insert into tarea (idTipoTarea,idOrdenTrabajo,ejecutor) values (?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, idTipoTareaAsignar);
            pst.setString(2, idOrdenTrabajoSeleccionada);
            pst.setString(3, idEjecutorAsignar);
            pst.execute();
        } catch (Exception e) {
            out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
        }
    }
    ResultSet rsOrdenTrabajo = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from orden_trabajo,usuario,estado where orden_trabajo.idOrdenTrabajo = " + idOrdenTrabajoSeleccionada + " and orden_trabajo.supervisor = usuario.idUsuario and orden_trabajo.estado = estado.idEstado";
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsOrdenTrabajo = pstOrdenTrabajo.executeQuery();
        rsOrdenTrabajo.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsUsuarioEjecutor = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlUsuariosEjecutores = "select * from usuario where tipoCuenta='Ejecutor'";
        PreparedStatement pstUsuariosEjecutores = conn.prepareStatement(sqlUsuariosEjecutores);
        rsUsuarioEjecutor = pstUsuariosEjecutores.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTipoTarea = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from tipo_tarea";
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsTipoTarea = pstOrdenTrabajo.executeQuery();
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
                    <ul class="collapsible" data-collapsible="expandible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">assignment</i><b><%= rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></b></div>
                            <div class="collapsible-body white"> 
                                <table class="" border="0" >
                                    <tr>
                                        <td><b>ID</b></td>
                                        <td><b>Importancia</b></td>
                                        <td><b>Supervisor</b></td>
                                    </tr>
                                    <tr>
                                        <td><%= rsOrdenTrabajo.getString("idOrdenTrabajo")%></td> 
                                        <td><% if (rsOrdenTrabajo.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsOrdenTrabajo.getString("importancia")%><p> <%} %>
                                            <% if (rsOrdenTrabajo.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsOrdenTrabajo.getString("importancia")%><p> <%} %>
                                            <% if (rsOrdenTrabajo.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsOrdenTrabajo.getString("importancia")%><p> <%}%></td>
                                        <td><%= rsOrdenTrabajo.getString("nombreUsuario")%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Fecha Inicio</b></td>
                                        <td><b>Fecha Fin</b></td>
                                        <td><b>Estado</b></td>
                                    </tr>
                                    <td><%= rsOrdenTrabajo.getString("fecha_inicio")%></td> 
                                    <td><% if (rsOrdenTrabajo.getString("fecha_fin") == null) {%> <p class="green-text">OT en proceso...</p> <%} else {%> <%=rsOrdenTrabajo.getString("fecha_fin")%> <%}%></td>
                                    <td><%= rsOrdenTrabajo.getString("nombreEstado")%></td>
                                </table>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">content_paste</i>Asignar Tareas a la Orden de Trabajo</div>
                            <div class="collapsible-body white">
                                <form action="gestorOTDetalle.jsp" >
                                    <input type="hidden" name="idOT" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                    <table border="0">
                                        <tbody>
                                            <tr>
                                                <td><b>Tipo de Tarea</b></td>
                                                <td>
                                                    <select name="idtipoTareaAsignar" required="">
                                                        <option value="" selected="" disabled="">Seleccione Tipo de Tarea</option>
                                                        <% while (rsTipoTarea.next()) {%>                                                            
                                                        <option value="<%= rsTipoTarea.getString("idTipoTarea")%>"><%= rsTipoTarea.getString("nombreTipoTarea")%></option>
                                                        <%}%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><b>Ejecutor</b></td>
                                                <td>
                                                    <select name="idEjecutorAsignar" required="">
                                                        <option value="" selected="" disabled="">Seleccione Tipo de Tarea</option>
                                                        <% while (rsUsuarioEjecutor.next()) {%>                                                            
                                                        <option value="<%= rsUsuarioEjecutor.getString("idUsuario")%>"><%= rsUsuarioEjecutor.getString("nombreUsuario")%></option>
                                                        <%}%>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <center>
                                        <input class="waves-effect waves-light btn" type="submit" value="Asignar Tarea" />
                                    </center>
                                </form>
                            </div>
                        </li> 
                    </ul>
                </div>
                <div class="col m7">
                    <ul class="collapsible" data-collapsible="expandible">
                        <li>
                            <div class="collapsible-header active" ><i class="material-icons">filter_drama</i>Tareas para <%= rsOrdenTrabajo.getString("nombreOrdenTrabajo") %></div>
                            <div class="collapsible-body white">
                                
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">place</i>Últimos Avances de la Orden de Trabajo</div>
                            <div class="collapsible-body white"><span>Lorem ipsum dolor sit amet.</span></div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">whatshot</i>Third</div>
                            <div class="collapsible-body"><span>Lorem ipsum dolor sit amet.</span></div>
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
            $('select').material_select();
            $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});
        });
    </script>
</body>
</html>
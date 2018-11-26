<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%    String idOrdenTrabajoSeleccionada = request.getParameter("idOT");
    String idTipoTareaAsignar = request.getParameter("idtipoTareaAsignar");
    String idEjecutorAsignar = request.getParameter("idEjecutorAsignar");
    String comentarioOT = request.getParameter("comentarioOT");
    String fecha_compromiso = request.getParameter("fecha_compromiso");

    if (comentarioOT != null) {
        try {
            Connection conn = ConexionBD.getConexion();
            String sql = "insert into avance (idOrdenTrabajo_fk,comentario,usuario) values (?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, idOrdenTrabajoSeleccionada);
            pst.setString(2, comentarioOT);
            pst.setString(3, ("" + hs.getAttribute("idUsuarioSesion")));
            pst.execute();
            response.sendRedirect("/aeLita/supervisor/gestorOTDetalle.jsp?idOT=" + idOrdenTrabajoSeleccionada);
            return;
        } catch (Exception e) {
            out.println("Excepción de SQL:" + e);
        }
    }
    //Asignar una tarea dentro de una OT.
    if (idEjecutorAsignar != null && idEjecutorAsignar != null) {
        try {
            int estadoTareaPorDefecto = 1;

            String idEmrpesaString = "" + hs.getAttribute("idEmpresa"); //Extrae el String del ID de la empresa del Objeto HS
            int idEmpresa = Integer.parseInt(idEmrpesaString); // Se convierte en Int

            Connection conn = ConexionBD.getConexion();
            String sql = "insert into tarea (idTipoTarea,idOrdenTrabajo,fecha_compromiso,usuario,estadoTarea,idEmpresa) values (?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, idTipoTareaAsignar);
            pst.setString(2, idOrdenTrabajoSeleccionada);
            pst.setString(3, fecha_compromiso);
            pst.setString(4, idEjecutorAsignar);
            pst.setInt(5, estadoTareaPorDefecto);
            pst.setInt(6, idEmpresa);
            pst.execute();
            response.sendRedirect("/aeLita/supervisor/gestorOTDetalle.jsp?idOT=" + idOrdenTrabajoSeleccionada);
            return;
        } catch (Exception e) {
            out.println("Excepción de SQL acaa: " + e);
        }
    }
    ResultSet rsOrdenTrabajo = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select orden_trabajo.idOrdenTrabajo, "
                + "orden_trabajo.idEmpresa, "
                + "orden_trabajo.supervisor,"
                + "orden_trabajo.idProcedimiento, "
                + "orden_trabajo.estado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "DATE_FORMAT(orden_trabajo.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio,"
                + "DATE_FORMAT(orden_trabajo.fecha_compromiso, '%d/%m/%Y %T') as fecha_compromiso,"
                + "DATE_FORMAT(orden_trabajo.fecha_fin, '%d/%m/%Y %T') as fecha_fin,"
                + "orden_trabajo.detalleOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "usuario.nombreUsuario "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.idOrdenTrabajo = " + idOrdenTrabajoSeleccionada + " "
                + "and orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado";
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
        String sqlUsuariosEjecutores = "select usuario.idUsuario, usuario.nombreUsuario from usuario,trabaja where trabaja.idUsuario = usuario.idUsuario and  trabaja.tipoCuenta= 'Ejecutor' and  trabaja.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pstUsuariosEjecutores = conn.prepareStatement(sqlUsuariosEjecutores);
        rsUsuarioEjecutor = pstUsuariosEjecutores.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
        return;
    }
    ResultSet rsTipoTarea = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from tipo_tarea where tipo_tarea.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsTipoTarea = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTipoTareaContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from tipo_tarea where tipo_tarea.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsTipoTareaContador = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTipoTareaContadorDos = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from tipo_tarea where tipo_tarea.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsTipoTareaContadorDos = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsContadorTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select tarea.idTarea, tipo_tarea.nombreTipoTarea, estado.nombreEstado,  usuario.nombreUsuario, tarea.fecha_inicio from tarea,usuario,tipo_tarea,estado where tarea.estadoTarea = estado.idEstado and tarea.usuario = usuario.idUsuario and tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idOrdenTrabajo =" + idOrdenTrabajoSeleccionada;
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsContadorTareas = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareasBajoLaOT = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select tarea.idTarea, tipo_tarea.nombreTipoTarea, estado.nombreEstado,  usuario.nombreUsuario, DATE_FORMAT(tarea.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio from tarea,usuario,tipo_tarea,estado where tarea.estadoTarea = estado.idEstado and tarea.usuario = usuario.idUsuario and tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idOrdenTrabajo =" + idOrdenTrabajoSeleccionada;
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsTareasBajoLaOT = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsComentariosOTContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from avance,usuario where usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk=" + idOrdenTrabajoSeleccionada;
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsComentariosOTContador = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsComentariosOT = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select trabaja.tipoCuenta, usuario.nombreUsuario, avance.comentario, DATE_FORMAT(avance.fecha_publicacion, '%d/%m/%Y %T') as fecha_publicacion, avance.fecha_publicacion as fecha_publicacionOrdenar from avance,usuario,trabaja where usuario.idUsuario = trabaja.idUsuario and trabaja.idEmpresa = " + hs.getAttribute("idEmpresa") + " and usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk= " + idOrdenTrabajoSeleccionada + " order by fecha_publicacionOrdenar desc";
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsComentariosOT = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from estado where estado.nombreEstado != 'Suspensión' and estado.nombreEstado != 'Generada' and estado.nombreEstado != 'Ejecutada' and estado.nombreEstado != 'Cerrada'  and estado.idEmpresa = 0 or estado.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsEstados = pstEstados.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsProcedimientos = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlProcedimientos = "select procedimiento.idProcedimiento, procedimiento.nombreProcedimiento from procedimiento where idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pstProcedimientos = conn.prepareStatement(sqlProcedimientos);
        rsProcedimientos = pstProcedimientos.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsHistorico = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from cambio_estado where cambio_estado.idOrdenTrabajo = " + idOrdenTrabajoSeleccionada + " order by fecha_realizacion desc";
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsHistorico = pstEstados.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsHistoricoContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from cambio_estado where cambio_estado.idOrdenTrabajo = " + idOrdenTrabajoSeleccionada;
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsHistoricoContador = pstEstados.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsSuspensiones = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlSuspensiones = "select * from cambio_estado";
        PreparedStatement pstSuspensiones = conn.prepareStatement(sqlSuspensiones);
        rsSuspensiones = pstSuspensiones.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
        return;
    }
    double numero = Math.random();
    String numeroPalabra = Double.toString(numero);
    String StringEntero = numeroPalabra.replace("0.", "");

    ResultSet rsTareasRestantes = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select count(*) as tareasRestantes from tarea where tarea.idOrdenTrabajo = " + idOrdenTrabajoSeleccionada + " and tarea.estadoTarea != 5";
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsTareasRestantes = pstEstados.executeQuery();
        rsTareasRestantes.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    String tareasRestantes = rsTareasRestantes.getString("tareasRestantes");
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
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">assignment</i><b>OT: <%= rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></b></div>
                            <div class="collapsible-body white"> 
                                <table>
                                    <tr> 
                                        <td><b>ID</b></td>
                                        <td><%= rsOrdenTrabajo.getString("idOrdenTrabajo")%></td> 
                                    </tr>
                                    <tr>
                                        <td><b>Importancia</b></td>
                                        <td><% if (rsOrdenTrabajo.getString("importancia").equals("Alta")) {%><p class="red-text "><%=rsOrdenTrabajo.getString("importancia")%><p> <%} %>
                                            <% if (rsOrdenTrabajo.getString("importancia").equals("Media")) {%><p class="orange-text "><%=rsOrdenTrabajo.getString("importancia")%><p> <%} %>
                                            <% if (rsOrdenTrabajo.getString("importancia").equals("Baja")) {%><p class="green-text"><%=rsOrdenTrabajo.getString("importancia")%><p> <%}%></td>
                                    </tr>    
                                    <tr>
                                        <td><b>Supervisor</b></td>
                                        <td><%= rsOrdenTrabajo.getString("nombreUsuario")%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Fecha Inicio</b></td>
                                        <td><%= rsOrdenTrabajo.getString("fecha_inicio")%></td> 
                                    </tr>
                                    <tr>
                                        <td><b>Fecha Fin Compromiso</b></td>
                                        <td><%= rsOrdenTrabajo.getString("fecha_compromiso")%></td> 
                                    </tr>
                                    <tr>
                                        <td><b>Fecha Fin</b></td>
                                        <td><% if (rsOrdenTrabajo.getString("fecha_fin") == null) {%> <p class="green-text">OT en proceso...</p> <%} else {%> <%=rsOrdenTrabajo.getString("fecha_fin")%> <%}%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Estado</b></td>
                                        <td>
                                            <!-- Modal Trigger -->
                                            <a class="waves-effect waves-light btn-flat modal-trigger  blue-grey darken-1 white-text" href="#modalGestorEstados"><%= rsOrdenTrabajo.getString("nombreEstado")%></a>
                                            <!-- Modal Structure -->
                                            <div id="modalGestorEstados" class="modal modal-fixed-footer">
                                                <div class="modal-content">
                                                    <nav class="nav-extended">
                                                        <div class="nav-content blue-grey">
                                                            <ul class="tabs tabs-transparent">
                                                                <li class="tab"><a class="active" href="#historial">Historial</a></li>
                                                                <li class="tab"><a href="#cambiarEstado">Cambiar Estado</a></li>
                                                                <li class="tab"><a href="#suspender">Suspender</a></li>
                                                                <li class="tab"><a href="#cerrarOT">Cerrar OT</a></li>
                                                                    <%if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {%>
                                                                    <%if (rsOrdenTrabajo.getString("estado").equals("5")) {%>
                                                                <li class="tab"><a href="#regenerarTarea">Regenerar OT</a></li>
                                                                    <%}%>
                                                                    <%}%>
                                                            </ul>
                                                        </div>
                                                    </nav>
                                                    <div id="historial" class="col s12">
                                                        <% if (rsHistoricoContador.next()) {%>
                                                        <table border="1" class="highlight bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th>ID Log</th>
                                                                    <th>Motivo</th>
                                                                    <th>Relizado</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% while (rsHistorico.next()) {%>
                                                                <tr>
                                                                    <td><%=rsHistorico.getString("idCambioEstado")%></td>
                                                                    <td><%=rsHistorico.getString("motivo")%></td>
                                                                    <td><%=rsHistorico.getString("fecha_realizacion")%></td>
                                                                </tr>
                                                                <%}%>
                                                            </tbody>
                                                        </table>
                                                        <%} else {%>
                                                        <p class="orange-text">No existen cambios de estado o suspensiones...</p>
                                                        <%}%>
                                                    </div>
                                                    <div id="cambiarEstado" class="col s12">
                                                        <% if (rsOrdenTrabajo.getString("estado").equals("00000000003")) {%>
                                                        <p class="orange-text">No es posible cambiar el estado de esta orden de trabajo, se encuentra suspendida...</p>
                                                        <% } else if (rsOrdenTrabajo.getString("estado").equals("00000000005")) {%>
                                                        <p class="orange-text">No es posible cambiar el estado de esta orden de trabajo, se encuentra cerrada...</p>
                                                        <% } else {%>
                                                        <form action="/aeLita/cambiarEstadoOrdenTrabajo" method="post">
                                                            <input type="hidden" name="idOT" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                                            <select name="idEstado">
                                                                <%while (rsEstados.next()) {%>
                                                                <option value="<%= rsEstados.getString("idEstado")%>"><%= rsEstados.getString("nombreEstado")%></option>
                                                                <%}%>
                                                            </select>
                                                            <input type="submit" class="btn blue-grey darken-3" value="Cambiar Estado">
                                                        </form>
                                                        <% } %>
                                                    </div>
                                                    <div id="suspender" class="col s12">
                                                        <% if (rsOrdenTrabajo.getString("estado").equals("00000000003")) {%>
                                                        <p class="orange-text">No es posible supender esta orden de trabajo, se encuentra suspendida...</p>
                                                        <% } else if (rsOrdenTrabajo.getString("estado").equals("00000000005")) {%>
                                                        <p class="orange-text">No es posible suspender esta orden de trabajo, se encuentra cerrada...</p>
                                                        <% } else {%>
                                                        <form action="/aeLita/suspenderOrdenTrabajo" method="post">
                                                            <input type="hidden" name="idEmpresa" value="<%= hs.getAttribute("idEmpresa")%>">
                                                            <input type="hidden" name="idOrdenTrabajo" value="<%= idOrdenTrabajoSeleccionada%>">
                                                            <input type="hidden" name="identidad" value="<%=StringEntero%>">
                                                            <br/>
                                                            <br/>
                                                            <br/>
                                                            <div class="row">
                                                                <div class="input-field col s12">
                                                                    <input class="validate" type="text" name="motivo" required="" id="motivo" placeholder="Motivo de la suspensión">
                                                                    <label for="motivo">Motivo</label>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="input-field col s12">
                                                                    <text class="grey-text darken-4">Fecha de Termino</text>
                                                                    <input class="validate" type="datetime-local" name="fecha_fin" required="" id="fecha_fin">
                                                                </div>
                                                            </div>
                                                            <input type="submit" class="btn blue-grey darken-3" value="Suspender">
                                                        </form>
                                                        <% } %>
                                                    </div>
                                                    <div id="cerrarOT" class="col s12">
                                                        <% if (tareasRestantes.equals("1")) {%>
                                                        <p class="orange-text">Aún queda <%=tareasRestantes%> tarea restante en proceso...</p>
                                                        <%} else if (!tareasRestantes.equals("0")) {%>
                                                        <p class="orange-text">Aún quedan <%=tareasRestantes%> tareas restantes en proceso...</p>
                                                        <%} else if (tareasRestantes.equals("0")) {%>
                                                        <br/><br/>
                                                        <p class="center-align orange-text">Asegúrese que las actividades no requieren ser regeneradas y que la orden de trabajo a terminado por completo.</p>
                                                        <br/>
                                                        <form name="cerrarTarea" action="/aeLita/cerrarOrdenTrabajo" method="POST">
                                                            <center><input type="submit" class="waves-effect waves-light btn red darken-3 center-align" value="Cerrar Orden de Trabajo"></center>
                                                        </form>
                                                        <%}%>
                                                    </div> 
                                                    <%if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {%>
                                                    <%if (rsOrdenTrabajo.getString("estado").equals("5")) {%>
                                                    <div id="regenerarTarea" class="col s12">Test 4</div>
                                                    <%}%>
                                                    <%}%>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <b>Detalle:</b>
                                <p><%= rsOrdenTrabajo.getString("detalleOrdenTrabajo")%></p>
                                <form method="get" action="/aeLita/reporteSupervisorOrdenTrabajoCerrada">
                                    <input type="hidden" name="idOT" value="<%= idOrdenTrabajoSeleccionada%>">
                                    <input type="submit" class="btn blue-grey darken-4" value="Ver Reporte"/>
                                </form>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">content_paste</i>Asignar tareas a la Orden de Trabajo</div>
                            <div class="collapsible-body white">
                                <% if (rsOrdenTrabajo.getString("estado").equals("5")) {%>
                                <form action="gestorOTDetalle.jsp" method="post">
                                    <input type="hidden" name="idOT" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                    <table border="0">
                                        <tbody>
                                            <tr>
                                                <td><b>Tipo de Tarea</b></td>
                                                <td>
                                                    <select disabled="" name="idtipoTareaAsignar" required="">
                                                        <option value="" selected="" disabled="">Seleccione Tipo de Tarea</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><b>Ejecutor</b></td>
                                                <td>
                                                    <select disabled="" name="idEjecutorAsignar" required="">
                                                        <option value="" selected="" disabled="">Seleccione Ejecutor</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <center>
                                        <input disabled="" class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Asignar Tarea" />
                                    </center>
                                </form>
                                <%} else {%> 
                                <form action="gestorOTDetalle.jsp" method="post">
                                    <input type="hidden" name="idOT" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                    <table border="0">
                                        <tbody>
                                            <tr>
                                                <td><b>Tipo de Tarea</b></td>
                                                <td>
                                                    <% if (rsTipoTareaContador.next()) {%>
                                                    <select name="idtipoTareaAsignar" required="">
                                                        <option value="" selected="" disabled="">Seleccione Tipo de Tarea</option>
                                                        <% while (rsTipoTarea.next()) {%>                                                            
                                                        <option value="<%= rsTipoTarea.getString("idTipoTarea")%>"><%= rsTipoTarea.getString("nombreTipoTarea")%></option>
                                                        <%}%>
                                                    </select>
                                                    <%} else { %>
                                                    <p class="red-text">No se han ingresado tipos de tareas</p>
                                                    <%}%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><b>Ejecutor</b></td>
                                                <td>
                                                    <select name="idEjecutorAsignar" required="">
                                                        <option value="" selected="" disabled="">Seleccione Ejecutor</option>
                                                        <% while (rsUsuarioEjecutor.next()) {%>                                                            
                                                        <option value="<%= rsUsuarioEjecutor.getString("idUsuario")%>"><%= rsUsuarioEjecutor.getString("nombreUsuario")%></option>
                                                        <%}%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><b>Procedimiento</b></td>
                                                <td>
                                                    <select class="icons" name="idProcedimiento">
                                                        <option value="" disabled selected>Seleccione Procedimiento</option>
                                                        <% while (rsProcedimientos.next()) {%>                                                  
                                                        <option value="<%= rsProcedimientos.getString("idProcedimiento")%>"><%= rsProcedimientos.getString("nombreProcedimiento")%></option>
                                                        <%}%>
                                                    </select>
                                                </td> 
                                            </tr>
                                            <tr>
                                                <td><b>Fecha de compromiso</b></td>
                                                <td><div class="input-field">
                                                        <input name="fecha_compromiso" type="datetime-local" class="validate" required="">
                                                    </div></td>    
                                            </tr>
                                        </tbody>
                                    </table>
                                    <center>
                                        <% if (rsTipoTareaContadorDos.next()) {%>
                                        <input class="btn blue-grey darken-3" type="submit" value="Asignar Tarea"/>
                                        <%} else { %>
                                        <input class="btn blue-grey darken-3" type="submit" value="Asignar Tarea" disabled=""/>
                                        <%}%>
                                    </center>
                                </form>
                                <%}%>
                            </div>
                        </li> 
                        <li>
                            <div class="collapsible-header"><i class="material-icons">archive</i>Archivos</div>
                            <div class="collapsible-body white">
                                <table border="1">
                                    <tbody>
                                        <tr>
                                            <td><b>idArchivo<b/></td>
                                            <td><b>Nombre<b/></td>
                                            <td><b>Fecha Creación<b/></td>
                                            <td><b>Operaciones<b/></td>
                                        </tr>
                                        <tr>
                                            <td>0000001</td>
                                            <td>Gestiones.pdf</td>
                                            <td>2018-10-02 11:41</td>
                                            <td>Eliminar</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <form name="subirArchivo" action="#" method="POST">
                                    <div class="file-field input-field ">
                                        <div class="btn blue-grey darken-3">
                                            <span>File</span>
                                            <input type="file" multiple>
                                        </div>
                                        <div class="file-path-wrapper ">
                                            <input class="file-path validate " type="text" placeholder="Selecciones los archivos que desea subir...">
                                        </div>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align blue-grey darken-3" type="submit" value="Subir Archivo" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <li>
                            <a href="../gestores/gestorProcedimientosDetalle.jsp?idProcedimiento=<%= rsOrdenTrabajo.getString("idProcedimiento")%>"><div class="collapsible-header"><i class="material-icons">call_split</i>Ver Procedimiento Asignado</div></a>
                        </li>
                    </ul>
                </div>
                <div class="col m7">
                    <ul class="collapsible" data-collapsible="expandible">
                        <li>
                            <div class="collapsible-header" ><i class="material-icons">filter_drama</i>Tareas para <%= rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></div>
                            <div class="collapsible-body white">
                                <% if (rsContadorTareas.next()) {%>
                                <table border="0" class="highlight">
                                    <thead>
                                        <tr>
                                            <td><b>ID</b></td>
                                            <td><b>Tipo Tarea</b></td>
                                            <td><b>Estado</b></td>
                                            <td><b>Ejecutor</b></td>
                                            <td><b>Fecha Inicio</b></td>
                                            <td><b>Operaciones</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsTareasBajoLaOT.next()) {%>
                                        <tr>
                                            <td><%= rsTareasBajoLaOT.getString("idTarea")%></td>
                                            <td><%= rsTareasBajoLaOT.getString("nombreTipoTarea")%></td>
                                            <td><%= rsTareasBajoLaOT.getString("nombreEstado")%></td>
                                            <td><%= rsTareasBajoLaOT.getString("nombreUsuario")%></td>
                                            <td><%= rsTareasBajoLaOT.getString("fecha_inicio")%></td>
                                            <td><a href="/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=<%= rsTareasBajoLaOT.getString("idTarea")%>" class="btn blue-grey darken-3">Detalle</a></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>

                                <%} else {%>
                                <p class="orange-text">No se han asignado tareas para esta Orden de Trabajo...</p>
                                <%}%>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">record_voice_over</i>Agregar comentario a la Orden de Trabajo</div>
                            <div class="collapsible-body white">
                                <% if (rsOrdenTrabajo.getString("estado").equals("5")) { %>
                                <form action="gestorOTDetalle.jsp" method="post">
                                    <div class="input-field">
                                        <textarea disabled="" id="textarea1" name="comentarioOT" required="" class="materialize-textarea"></textarea>
                                        <label for="textarea1">Comentario</label>
                                    </div>
                                    <div class="center-align">
                                        <input disabled="" class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Documentar" />
                                    </div>
                                </form>
                                <%} else {%>
                                <form action="gestorOTDetalle.jsp" method="post">
                                    <input type="hidden" name="idOT" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                    <div class="input-field">
                                        <textarea id="textarea1" name="comentarioOT" required="" class="materialize-textarea"></textarea>
                                        <label for="textarea1">Comentario</label>
                                    </div>
                                    <div class="center-align">
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Documentar" />
                                    </div>
                                </form>
                                <%}%>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">comment</i>Últimos avances</div>
                            <div class="collapsible-body white">
                                <% if (rsComentariosOTContador.next()) {
                                        while (rsComentariosOT.next()) {%>
                                <ul class="collection">
                                    <li class="collection-item avatar">
                                        <% if (rsComentariosOT.getString("tipoCuenta").equals("Supervisor")) {%>
                                        <i class="material-icons circle blue-grey darken-4">person</i>
                                        <%} else {%>
                                        <i class="material-icons circle blue-grey">person</i>
                                        <%}%>
                                        <span class="title"><%= rsComentariosOT.getString("nombreUsuario")%></span>
                                        <p><%= rsComentariosOT.getString("comentario")%></p>
                                        <p class="right-align"><%= rsComentariosOT.getString("fecha_publicacion")%></p>
                                    </li>
                                </ul>
                                <%}
                                } else {%>
                                <p class="orange-text">Por el momento no hay avances...</p>
                                <%}%>
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
            $('.modal').modal();
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('select').material_select();
            $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});
        });
    </script>
</body>
</html>
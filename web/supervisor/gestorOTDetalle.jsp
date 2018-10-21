<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%  
    String idOrdenTrabajoSeleccionada = request.getParameter("idOT");
    String idTipoTareaAsignar = request.getParameter("idtipoTareaAsignar");
    String idEjecutorAsignar = request.getParameter("idEjecutorAsignar");
    String comentarioOT = request.getParameter("comentarioOT");

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
            String sql = "insert into tarea (idTipoTarea,idOrdenTrabajo,usuario,estadoTarea,idEmpresa) values (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, idTipoTareaAsignar);
            pst.setString(2, idOrdenTrabajoSeleccionada);
            pst.setString(3, idEjecutorAsignar);
            pst.setInt(4, estadoTareaPorDefecto);
            pst.setInt(5, idEmpresa);
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
        String sqlOrdenTrabajo = "select tarea.idTarea, tipo_tarea.nombreTipoTarea, estado.nombreEstado,  usuario.nombreUsuario, tarea.fecha_inicio from tarea,usuario,tipo_tarea,estado where tarea.estadoTarea = estado.idEstado and tarea.usuario = usuario.idUsuario and tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idOrdenTrabajo =" + idOrdenTrabajoSeleccionada;
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
        String sqlOrdenTrabajo = "select * from avance,usuario where usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk=" + idOrdenTrabajoSeleccionada + " order by fecha_publicacion desc";
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsComentariosOT = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from estado where estado.idEstado > 1";
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsEstados = pstEstados.executeQuery();
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
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">assignment</i><b><%= rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></b></div>
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
                                        <td><b>Fecha Fin</b></td>
                                        <td><% if (rsOrdenTrabajo.getString("fecha_fin") == null) {%> <p class="green-text">OT en proceso...</p> <%} else {%> <%=rsOrdenTrabajo.getString("fecha_fin")%> <%}%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Estado</b></td>
                                        <td>
                                            <!-- Modal Trigger --> 
                                            <a class="waves-effect waves-light btn-flat modal-trigger  blue-grey darken-1 white-text" href="#modal1"><%= rsOrdenTrabajo.getString("nombreEstado")%></a>
                                            <!-- Modal Structure -->
                                            <% if (hs.getAttribute("tipoCuenta").equals("Supervisor")) { %>
                                            <% if (rsOrdenTrabajo.getString("estado").equals("5")) {%>
                                            <form method="get" action="/aeLita/cambiarEstado">
                                                <div id="modal1" class="modal modal-fixed-footer">
                                                    <div class="modal-content">
                                                        <h4>Cambiar Estado</h4>
                                                        <p>Ya no es posible cambiar el estado de esta orden de trabajo, se encuentra cerrada.</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Salir...</a>
                                                    </div>
                                                </div>
                                            </form>
                                            <%} else {%> 
                                            <form method="get" action="/aeLita/cambiarEstadoOrdenesTrabajo">
                                                <input type="hidden" name="idOrdenTrabajo" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                                <div id="modal1" class="modal modal-fixed-footer">
                                                    <div class="modal-content">
                                                        <h4>Cambiar Estado</h4>
                                                        <p>Selecciona el siguiente estado para la orden de trabajo: <%=rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></p>
                                                        <select id="idEstado" name="idEstado">
                                                            <% while (rsEstados.next()) {%>                                                           
                                                            <option value="<%=rsEstados.getString("idEstado")%>" ><%=rsEstados.getString("nombreEstado")%></option>
                                                            <% }%>
                                                        </select>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="submit" class="left modal-close waves-effect waves-green btn-flat" value="Cambiar Estado"/>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Salir...</a>
                                                    </div>
                                                </div>
                                            </form> 
                                            <%}%>
                                            <%} else {%>
                                            <form method="get" action="/aeLita/cambiarEstadoOrdenesTrabajo">
                                                <input type="hidden" name="idOrdenTrabajo" value="<%= rsOrdenTrabajo.getString("idOrdenTrabajo")%>">
                                                <div id="modal1" class="modal modal-fixed-footer">
                                                    <div class="modal-content">
                                                        <h4>Cambiar Estado</h4>
                                                        <p>Selecciona el siguiente estado para la orden de trabajo: <%=rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></p>
                                                        <select id="idEstado" name="idEstado">
                                                            <% while (rsEstados.next()) {%>                                                           
                                                            <option value="<%=rsEstados.getString("idEstado")%>" ><%=rsEstados.getString("nombreEstado")%></option>
                                                            <% }%>
                                                        </select>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="submit" class="left modal-close waves-effect waves-green btn-flat" value="Cambiar Estado"/>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Salir...</a>
                                                    </div>
                                                </div>
                                            </form> 
                                            <%}%>
                                        </td>
                                    </tr>
                                </table>
                                <b>Detalle:</b>
                                <p><%= rsOrdenTrabajo.getString("detalleOrdenTrabajo")%></p>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">content_paste</i>Asignar Tareas a la Orden de Trabajo</div>
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
                                                        <option value="" selected="" disabled="">Seleccione Tipo de Tarea</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <center>
                                        <input disabled="" class="waves-effect waves-light btn" type="submit" value="Asignar Tarea" />
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
                                    <div class="file-field input-field">
                                        <div class="btn">
                                            <span>File</span>
                                            <input type="file" multiple>
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" placeholder="Selecciones los archivos que desea subir...">
                                        </div>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align" type="submit" value="Subir Archivo" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <li>
                            <a href="../gestores/gestorProcedimientosDetalle.jsp"><div class="collapsible-header"><i class="material-icons">call_split</i>Ver Procedimiento Asignado</div></a>
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
                                            <td>
                                                <!-- Modal Trigger -->
                                                <a class="waves-effect waves-light btn modal-trigger blue-grey darken-4 white-text" href="#modal2"><%= rsTareasBajoLaOT.getString("nombreUsuario")%></a>

                                                <!-- Modal Structure -->
                                                <div id="modal2" class="modal">
                                                    <div class="modal-content">
                                                        <h4>Cambiar ejecutor</h4>
                                                        <p>Seleccione el nuevo ejecutor de la tarea</p>
                                                        <select name="idEjecutorAsignar" required="">
                                                            <option value="" selected="" disabled="">Seleccione Tipo de Tarea</option>
                                                            <% while (rsUsuarioEjecutor.next()) {%>                                                            
                                                            <option value="<%= rsUsuarioEjecutor.getString("idUsuario")%>"><%= rsUsuarioEjecutor.getString("nombreUsuario")%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><%= rsTareasBajoLaOT.getString("fecha_inicio")%></td>
                                            <td><a href="/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=<%= rsTareasBajoLaOT.getString("idTarea")%>" class="btn">Detalle</a></td>
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
                                        <input disabled="" class="waves-effect waves-light btn" type="submit" value="Documentar" />
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
                                        <input class="waves-effect waves-light btn" type="submit" value="Documentar" />
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
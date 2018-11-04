<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%    
    String idTareaSeleccionada = request.getParameter("idTarea");
    String comentarioOT = request.getParameter("comentarioOT");
    ResultSet rsAux = null; // Contiene el ID de la Orden de trabajo seleccionada.
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select tarea.idOrdenTrabajo from tarea where tarea.idTarea = " + idTareaSeleccionada + " and tarea.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsAux = pstOrdenTrabajo.executeQuery();
        rsAux.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsOrdenTrabajo = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from orden_trabajo,usuario,estado where orden_trabajo.idOrdenTrabajo = " + rsAux.getString("idOrdenTrabajo") + " and orden_trabajo.supervisor = usuario.idUsuario and orden_trabajo.estado = estado.idEstado and orden_trabajo.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsOrdenTrabajo = pstOrdenTrabajo.executeQuery();
        rsOrdenTrabajo.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareaSeleccionada = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select usuario.nombreUsuario, tarea.idProcedimiento, tarea.idTarea, tarea.estadoTarea, estado.nombreEstado, tipo_tarea.nombreTipoTarea, tarea.fecha_inicio, tarea.fecha_fin from tarea,usuario,estado,tipo_tarea where tarea.usuario = usuario.idUsuario and tarea.estadoTarea = estado.idEstado and tarea.idTipoTarea = tipo_tarea.idTipoTarea and tarea.idTarea =" + idTareaSeleccionada + " and tarea.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsTareaSeleccionada = pstOrdenTrabajo.executeQuery();
        rsTareaSeleccionada.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsComentariosOTContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from avance,usuario where usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk=" + rsAux.getString("idOrdenTrabajo") + " and avance.idEmpresa = " + hs.getAttribute("idEmpresa");
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsComentariosOTContador = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsComentariosOT = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenTrabajo = "select * from avance,usuario where usuario.idUsuario = avance.usuario and avance.idOrdenTrabajo_fk=" + rsAux.getString("idOrdenTrabajo") + " and avance.idEmpresa = " + hs.getAttribute("idEmpresa") + " order by fecha_publicacion desc";
        PreparedStatement pstOrdenTrabajo = conn.prepareStatement(sqlOrdenTrabajo);
        rsComentariosOT = pstOrdenTrabajo.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    if (comentarioOT != null) {
        try {
            String idEmpresaAux = "" + hs.getAttribute("idEmpresa");
            int idEmpresa = Integer.parseInt(idEmpresaAux);
            Connection conn = ConexionBD.getConexion();
            String sql = "insert into avance (idTarea_fk,idOrdenTrabajo_fk,comentario,usuario,idEmpresa) values (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, idTareaSeleccionada);
            pst.setString(2, rsAux.getString("idOrdenTrabajo"));
            pst.setString(3, comentarioOT);
            pst.setString(4, ("" + hs.getAttribute("idUsuarioSesion")));
            pst.setInt(5, idEmpresa);
            pst.execute();
            response.sendRedirect("/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=" + idTareaSeleccionada);
            return;
        } catch (Exception e) {
            out.println("Excepción de SQL:" + e);
        }
    }
    // Para el DropdownList para cambiar el estado de las tareas
    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from estado where estado.idEmpresa = 0 or estado.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsEstados = pstEstados.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsUsuarioEjecutor = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlUsuariosEjecutores = "select usuario.idUsuario, usuario.nombreUsuario from usuario,trabaja where trabaja.idUsuario = usuario.idUsuario and  usuario.tipoCuenta= 'Ejecutor' and  trabaja.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pstUsuariosEjecutores = conn.prepareStatement(sqlUsuariosEjecutores);
        rsUsuarioEjecutor = pstUsuariosEjecutores.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL rsUsuarioEjecutor:" + e);
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
                            <div class="collapsible-header white active"><i class="material-icons">filter_drama</i><b>Tarea:&nbsp;</b><%= rsTareaSeleccionada.getString("nombreTipoTarea")%></div>
                            <div class="collapsible-body white">
                                <table>
                                    <tr>
                                        <td><b>ID Tarea</b></td> 
                                        <td><%= rsTareaSeleccionada.getString("idTarea")%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Asignado</b></td> 
                                        <td>
                                            <a class="waves-effect waves-light btn-flat modal-trigger  blue-grey darken-1 white-text" href="#ModalCambiarAsignadoTarea"><%= rsTareaSeleccionada.getString("nombreUsuario")%></a>
                                            <form method="get" action="/aeLita/cambiarUsuarioAsignadoTarea">
                                                <input type="hidden" name="idTarea" value="<%= idTareaSeleccionada %>">
                                                <div id="ModalCambiarAsignadoTarea" class="modal modal-fixed-footer">
                                                    <div class="modal-content">
                                                        <h4>Cambiar usuario asignado</h4>
                                                        <p>Seleccione el nuevo usuario asignado</p>
                                                        <select id="idNuevoUsuarioEjecutor" name="idNuevoUsuarioEjecutor">
                                                            <% while (rsUsuarioEjecutor.next()) {%>
                                                            <option value="<%= rsUsuarioEjecutor.getString("idUsuario")%>" ><%= rsUsuarioEjecutor.getString("nombreUsuario")%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <input type="submit" class="left modal-close waves-effect waves-green btn-flat" value="Cambiar Asginado"/>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat">Salir...</a>
                                                    </div>
                                                </div> 
                                            </form>
                                        </td>
                                    </tr>
                                    <td><b>Estado</b></td>
                                    <td>
                                        <!-- Modal Trigger -->
                                        <a class="waves-effect waves-light btn-flat modal-trigger  blue-grey darken-1 white-text" href="#modal1"><%= rsTareaSeleccionada.getString("nombreEstado")%></a>
                                        <!-- Modal Structure -->
                                        <% if (rsOrdenTrabajo.getString("estado").equals("5")) { %>
                                        <form method="get" action="/aeLita/cambiarEstado">
                                            <div id="modal1" class="modal modal-fixed-footer">
                                                <div class="modal-content">
                                                    <h4>Cambiar Estado</h4>
                                                    <p>Ya no es posible cambiar el estado de esta tarea, la orden de trabajo se encuentra cerrada.</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Salir...</a>
                                                </div>
                                            </div>
                                        </form>
                                        <%} else {%>
                                        <%if (hs.getAttribute("tipoCuenta").equals("Ejecutor")) {%>
                                        <% if (rsTareaSeleccionada.getString("estadoTarea").equals("5")) {%>
                                        <form method="get" action="/aeLita/cambiarEstado">
                                            <div id="modal1" class="modal modal-fixed-footer">
                                                <div class="modal-content">
                                                    <h4>Cambiar Estado</h4>
                                                    <p>Ya no es posible cambiar el estado de esta tarea, se encuentra cerrada.</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <a href="#!" class="modal-close waves-effect waves-green btn-flat">Salir...</a>
                                                </div>
                                            </div>
                                        </form>
                                        <%} else {%>
                                        <form method="get" action="/aeLita/cambiarEstado">
                                            <input type="hidden" name="idTarea" value="<%= rsTareaSeleccionada.getString("idTarea")%>">
                                            <div id="modal1" class="modal modal-fixed-footer">
                                                <div class="modal-content">
                                                    <h4>Cambiar Estado</h4>
                                                    <p>Selecciona el siguiente estado para la tarea de <%=rsTareaSeleccionada.getString("nombreTipoTarea")%></p>
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
                                        <form method="get" action="/aeLita/cambiarEstado">
                                            <input type="hidden" name="idTarea" value="<%= rsTareaSeleccionada.getString("idTarea")%>">
                                            <div id="modal1" class="modal modal-fixed-footer">
                                                <div class="modal-content">
                                                    <h4>Cambiar Estado</h4>
                                                    <p>Selecciona el siguiente estado para la tarea de <%=rsTareaSeleccionada.getString("nombreTipoTarea")%></p>
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
                                        <%}%>
                                    </td>
                                    <tr>
                                        <td><b>Tipo Tarea</b></td>
                                        <td><%= rsTareaSeleccionada.getString("nombreTipoTarea")%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Fecha Inicio</b></td>
                                        <td><%= rsTareaSeleccionada.getString("fecha_inicio")%></td>
                                    </tr>
                                    <tr>
                                        <td><b>Fecha Fin</b></td>
                                        <td><%if (rsTareaSeleccionada.getString("fecha_fin") == null) {%><p class="green-text">Tarea en proceso...</p><%}%></td>
                                    </tr>
                                </table>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header "><i class="material-icons">assignment</i><b>Orden de Trabajo:</b>&nbsp;<%= rsOrdenTrabajo.getString("nombreOrdenTrabajo")%></div>
                            <div class="collapsible-body white"> 
                                <table class="" border="0" > 
                                    <tr>
                                        <td><b>ID</b></td>
                                        <td><%= rsOrdenTrabajo.getString("idOrdenTrabajo")%></td> 
                                    </tr>   
                                    <tr>
                                        <td><b>Importancia</b></td>
                                        <td><% if (rsOrdenTrabajo.getString("importancia").equals("Alta")) {%><p class="red-text "><%=rsOrdenTrabajo.getString("importancia")%><p> <%} %>
                                            <% if (rsOrdenTrabajo.getString("importancia").equals("Media")) {%><p class="orange-text "><%=rsOrdenTrabajo.getString("importancia")%><p> <%} %>
                                            <% if (rsOrdenTrabajo.getString("importancia").equals("Baja")) {%><p class="green-text"><%=rsOrdenTrabajo.getString("importancia")%><p> <%}%>
                                        </td>
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
                                        <td><%= rsOrdenTrabajo.getString("nombreEstado")%></td> 
                                    </tr>
                                </table>
                                <b>Detalle:</b>
                                <p><%= rsOrdenTrabajo.getString("detalleOrdenTrabajo")%></p>
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
                        <% if (rsTareaSeleccionada.getString("idProcedimiento").equals("0")) {%>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">call_split</i><text class="orange-text">Sin procedimiento asignado...</text></div>
                            <div class="collapsible-body white"><span class="red-text">Aún no son asociadas actividades...</span></div>
                        </li>
                        <%} else {%>
                        <li>
                            <a href="../gestores/gestorProcedimientosDetalle.jsp?idProcedimiento=<%= rsTareaSeleccionada.getString("idProcedimiento") %>" target="_blank"><div class="collapsible-header"><i class="material-icons">call_split</i>Ver Procedimiento Asignado</div></a>
                        </li>
                        <%}%>
                    </ul>
                </div>
                <div class="col m7">
                    <ul class="collapsible" data-collapsible="expandible">
                        <li>
                            <div class="collapsible-header"><i class="material-icons">record_voice_over</i>Agregar comentario a la Orden de Trabajo</div>
                            <div class="collapsible-body white">
                                <% if (rsTareaSeleccionada.getString("estadoTarea").equals("5")) {%>
                                <form action="gestorTareasDetalle.jsp" method="post">
                                    <div class="input-field">
                                        <textarea disabled="" id="textarea1" name="comentarioOT" required="" class="materialize-textarea"></textarea>
                                        <label for="textarea1">Comentario</label>
                                    </div>
                                    <div class="center-align">
                                        <input disabled="" class="waves-effect waves-light btn" type="submit" value="Documentar" />
                                    </div>
                                </form>
                                <%} else {%>
                                <form action="gestorTareasDetalle.jsp" method="post">
                                    <input type="hidden" name="idTarea" value="<%= rsTareaSeleccionada.getString("idTarea")%>">
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
                                        <% if (rsComentariosOT.getString("tipoCuenta").equals("Supervisor")) {%> <i class="material-icons circle blue-grey darken-4">person</i> <%} else {%> <i class="material-icons circle blue-grey">person</i> <%}%>
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
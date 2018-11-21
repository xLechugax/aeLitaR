<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA ABIERTA PARA EL USUARIO.

    ResultSet rsEmpresasSinSuscripcion = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from empresa where empresa.idSuscripcion is null";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEmpresasSinSuscripcion = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsEmpresasConSuscripcion = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select empresa.idEmpresa, suscripcion.idSuscripcion, empresa.nombre, empresa.direccion, empresa.correo, empresa.rut, empresa.telefono, "
                + "DATE_FORMAT(suscripcion.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio, "
                + "DATE_FORMAT(suscripcion.fecha_fin, '%d/%m/%Y %T') as fecha_fin, "
                + "suscripcion.activo, TIMESTAMPDIFF(SECOND,(NOW()),suscripcion.fecha_fin) as tiempoRestante, TIMESTAMPDIFF(SECOND,suscripcion.fecha_inicio,(NOW())) as tiempoTranscurrido, TIMESTAMPDIFF(SECOND,suscripcion.fecha_inicio,suscripcion.fecha_fin) as tiempoContratado from empresa,suscripcion where empresa.idEmpresa = suscripcion.idEmpresa and empresa.idSuscripcion = suscripcion.idSuscripcion order by tiempoRestante asc";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEmpresasConSuscripcion = pst.executeQuery();
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
        <link type="text/css" rel="stylesheet" href="../css/materialize.min.css"  media="screen,projection"/>
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
                                <nav class="nav-extended">
                                    <div class="nav-content">
                                        <ul class="tabs tabs-transparent blue-grey darken-3">
                                            <li class="tab"><a class="active" href="#empresasConSuscripcion">Empresas con suscripción</a></li>
                                            <li class="tab"><a href="#empresasSinSuscripcion">Empresas Sin suscripción</a></li>
                                        </ul>
                                    </div>
                                </nav>
                                <div id="empresasConSuscripcion" class="col s12">
                                    <table>
                                        <thead>
                                        <th>ID Empresa</th>
                                        <th>Rut</th>
                                        <th>Nombre</th>
                                        <th>Fecha Inicio</th>
                                        <th>Fecha Fin </td>
                                        <th>Tiempo Transcurrido</th>
                                        <th>Tiempo Restante</th>
                                        <th>Total Contratado</th>
                                        <th>Operaciones</th>
                                        </thead>
                                        <% while (rsEmpresasConSuscripcion.next()) {%>
                                        <tr>
                                            <td><%= rsEmpresasConSuscripcion.getString("idEmpresa")%></td>
                                            <td><%= rsEmpresasConSuscripcion.getString("rut")%></td>
                                            <td><%= rsEmpresasConSuscripcion.getString("nombre")%></td>
                                            <td><%= rsEmpresasConSuscripcion.getString("fecha_inicio")%></td> 
                                            <td><%= rsEmpresasConSuscripcion.getString("fecha_fin")%></td> 
                                            <td><%
                                                ResultSet rsTiempoTranscurrido = null;
                                                try {
                                                    Connection conn = ConexionBD.getConexion();
                                                    String sqlTiempo = "select FN_DEVOLVERTIEMPO(" + rsEmpresasConSuscripcion.getString("tiempoTranscurrido") + ") as tiempoTranscurrido";
                                                    PreparedStatement pstTiempoRealTranscurrido = conn.prepareStatement(sqlTiempo);
                                                    rsTiempoTranscurrido = pstTiempoRealTranscurrido.executeQuery();
                                                    rsTiempoTranscurrido.next();
                                                } catch (SQLException e) {
                                                    out.println("Excepción de SQL:" + e);
                                                    return;
                                                }
                                                out.print(rsTiempoTranscurrido.getString("tiempoTranscurrido"));
                                                %></td> 
                                            <td><%
                                                ResultSet rsTiempoRestante = null;
                                                try {
                                                    Connection conn = ConexionBD.getConexion();
                                                    String sqlTiempo = "select FN_DEVOLVERTIEMPO(" + rsEmpresasConSuscripcion.getString("tiempoRestante") + ") as tiempoRestante";
                                                    PreparedStatement pstTiempoRealTranscurrido = conn.prepareStatement(sqlTiempo);
                                                    rsTiempoRestante = pstTiempoRealTranscurrido.executeQuery();
                                                    rsTiempoRestante.next();
                                                } catch (SQLException e) {
                                                    out.println("Excepción de SQL:" + e);
                                                    return;
                                                }
                                                out.print(rsTiempoRestante.getString("tiempoRestante"));
                                                %></td> 
                                            <td><%
                                                ResultSet rsTiempoTotalContratado = null;
                                                try {
                                                    Connection conn = ConexionBD.getConexion();
                                                    String sqlTiempo = "select FN_DEVOLVERTIEMPO(" + rsEmpresasConSuscripcion.getString("tiempoContratado") + ") as tiempoContratado";
                                                    PreparedStatement pstTiempoRealTranscurrido = conn.prepareStatement(sqlTiempo);
                                                    rsTiempoTotalContratado = pstTiempoRealTranscurrido.executeQuery();
                                                    rsTiempoTotalContratado.next();
                                                } catch (SQLException e) {
                                                    out.println("Excepción de SQL:" + e);
                                                    return;
                                                }
                                                out.print(rsTiempoTotalContratado.getString("tiempoContratado"));
                                                
                                                %></td> 
                                        </tr>
                                        <%}%>
                                    </table>
                                </div>
                                <div id="empresasSinSuscripcion" class="col s12"><br/>
                                    <a>Gestión Empresas</a> <br/><br/>
                                    <!-- Modal Trigger -->
                                    <a class="btn-floating btn-large waves-effect waves-light red right-aligned modal-trigger" href="#modal1"><i class="material-icons">add</i></a>&nbsp;&nbsp;<b>Agregar Empresa</b>
                                    <!-- Modal Structure -->
                                    <div id="modal1" class="modal modal-fixed-footer">
                                        <div class="modal-content">
                                            <form action="/aeLita/crearEmpresa" method="get"> 
                                                <h4>Crear Empresa</h4>
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input id="input_rut" type="text" name="rut" required="required" title="Debe ser un Rut 11222333-4" class="validate"/>
                                                        <label>Rut</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="nombre" type="text" class="validate" required="">
                                                        <label>Nombre</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="direccion" type="text" class="validate" required="">
                                                        <label>Dirección</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="correo" type="email" class="validate" required="">
                                                        <label>Correo</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="confirmar_correo" type="email" class="validate" required="">
                                                        <label>Confirmar Correo</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="telefono" placeholder="+562" type="number" class="validate" required="">
                                                        <label>Teléfono</label>
                                                    </div>
                                                </div>
                                                <center>
                                                    <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Crear Empresa" />
                                                </center>
                                            </form>
                                        </div>
                                    </div>
                                    <table>
                                        <thead>
                                        <td><b>ID Empresa</b></td>
                                        <td><b>Rut</b></td>
                                        <td><b>Suscripción</b></td>
                                        <td><b>Nombre</b></td>
                                        <td><b>Operaciones</b></td>
                                        </thead>
                                        <tbody>
                                            <% while (rsEmpresasSinSuscripcion.next()) {%>
                                        <td><%= rsEmpresasSinSuscripcion.getString("idEmpresa")%></td>
                                        <td><%= rsEmpresasSinSuscripcion.getString("rut")%></td>
                                        <td><input type="btn" class="btn blue-grey darken-3" value="Suscribir"></td>
                                        <td><%= rsEmpresasSinSuscripcion.getString("nombre")%></td>
                                        <td>Operaciones</td>
                                        <%}%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="../js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../js/materialize.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/jquery.Rut.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.modal').modal();
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('select').material_select();
            $('.collapsible').collapsible();
        });
    </script>
    <script>
        $('#input_rut').Rut({
            on_error: function () {
                alert('Rut incorrecto');
                $('#input_rut').val('');
            },
        });
    </script>
</body>
</html>
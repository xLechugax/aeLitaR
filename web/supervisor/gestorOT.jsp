<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from estado where estado.idEstado != 5 and estado.idEmpresa = " + hs.getAttribute("idEmpresa") + " or estado.idEmpresa = 0 and estado.idEstado != 5";
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsEstados = pstEstados.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    String idEstadoFiltro = request.getParameter("idEstadoFiltro");
    String importanciaFiltro = request.getParameter("importanciaFiltro");

    ResultSet rsOrdenesTrabajo = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAsignado = "select orden_trabajo.idOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "usuario.nombreUsuario as supervisor,"
                + "orden_trabajo.fecha_inicio as fecha_inicioOrdenar, "
                + "DATE_FORMAT(orden_trabajo.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio, "
                + "TIMESTAMPDIFF(SECOND,orden_trabajo.fecha_inicio,(NOW())) as tiempoRealTranscurrido ,"
                + "TIMESTAMPDIFF(SECOND,(NOW()),orden_trabajo.fecha_compromiso) as tiempoRestante "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado "
                + "and usuario.idUsuario=" + hs.getAttribute("idUsuarioSesion");
        if (idEstadoFiltro != null) {
            sqlAsignado = sqlAsignado + " and orden_trabajo.estado = '" + idEstadoFiltro + "'";
        }
        if (importanciaFiltro != null) {
            sqlAsignado = sqlAsignado + " and orden_trabajo.importancia ='" + importanciaFiltro + "'";
        }
        sqlAsignado = sqlAsignado + " and orden_trabajo.idEmpresa = " + hs.getAttribute("idEmpresa") + " and orden_trabajo.estado !=5 order by fecha_inicioOrdenar desc";
        PreparedStatement pstOrdenesTrabajo = conn.prepareStatement(sqlAsignado);
        rsOrdenesTrabajo = pstOrdenesTrabajo.executeQuery();
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
            <div class="col m12 m12">
                <div class="card horizontal">
                    <div class="card-image">
                    </div>
                    <div class="card-stacked">
                        <div class="card-content">
                            <div class="row">
                                <div class="input-field col  m4">
                                    <a class="btn blue-grey darken-3" href="gestorOTGenerar.jsp">Generar Órden de Trabajo</a> 
                                </div>
                                <form action="gestorOT.jsp" method="post">
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
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </div>
                                </form>
                            </div>
                        </div>
                        <table class="highlight bordered">
                            <thead>
                            <td class="center-align"><b>ID</b></td>
                            <td><b>Estado</b></td>
                            <td class="center-align"><b>Importancia</b></td>
                            <td><b>Orden de Trabajo</b></td>
                            <td><b>Fecha Inicio</b></td>
                            <td><b>Tiempo Real Transcurrido</b></td>
                            <td><b>Tiempo Restante</b></td>
                            <td><b>Operaciones</b></td>
                            </thead>
                            <% while (rsOrdenesTrabajo.next()) {%>
                            <tbody>
                            <td class="center-align"><b><%= rsOrdenesTrabajo.getString("idOrdenTrabajo")%></b></td>
                            <td><%= rsOrdenesTrabajo.getString("nombreEstado")%></td>
                            <td>
                                <% if (rsOrdenesTrabajo.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsOrdenesTrabajo.getString("importancia")%><p> <%} %>
                                <% if (rsOrdenesTrabajo.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsOrdenesTrabajo.getString("importancia")%><p> <%} %>
                                <% if (rsOrdenesTrabajo.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsOrdenesTrabajo.getString("importancia")%><p> <%}%>
                            </td>
                            <td><%= rsOrdenesTrabajo.getString("nombreOrdenTrabajo")%></td>
                            <td><%= rsOrdenesTrabajo.getString("fecha_inicio")%></td>
                            <td><%
                                ResultSet rsTiempoRealTranscurrido = null;
                                try {
                                    Connection conn = ConexionBD.getConexion();
                                    String sqlTiempo = "select FN_DEVOLVERTIEMPO(" + rsOrdenesTrabajo.getString("tiempoRealTranscurrido") + ") as tiempoRealTranscurrido";
                                    PreparedStatement pstTiempoRealTranscurrido = conn.prepareStatement(sqlTiempo);
                                    rsTiempoRealTranscurrido = pstTiempoRealTranscurrido.executeQuery();
                                    rsTiempoRealTranscurrido.next();
                                } catch (SQLException e) {
                                    out.println("Excepción de SQL:" + e);
                                    return;
                                }
                                %><%= rsTiempoRealTranscurrido.getString("tiempoRealTranscurrido")%></td> 
                            <td><%
                                ResultSet rsTiempoRestante = null;
                                try {
                                    Connection conn = ConexionBD.getConexion();
                                    String sqlTiempo = "select FN_DEVOLVERTIEMPO(" + rsOrdenesTrabajo.getString("tiempoRestante") + ") as tiempoRestante";
                                    PreparedStatement pstTiempoRestante = conn.prepareStatement(sqlTiempo);
                                    rsTiempoRestante = pstTiempoRestante.executeQuery();
                                    rsTiempoRestante.next();
                                } catch (SQLException e) {
                                    out.println("Excepción de SQL:" + e);
                                    return;
                                }%>
                                <a class="waves-effect waves-light btn blue-grey darken-1" ><%= rsTiempoRestante.getString("tiempoRestante")%></a>
                                </td> 
                            <td><a href="/aeLita/supervisor/gestorOTDetalle.jsp?idOT=<%= rsOrdenesTrabajo.getString("idOrdenTrabajo")%>" class="btn blue-grey darken-3">Detalle</a></td>
                            </tbody>
                            <%}%>
                        </table>
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
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%    ResultSet rsProcedimientos = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlProcedimientos = "select * from procedimiento where procedimiento.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pstProcedimientos = conn.prepareStatement(sqlProcedimientos);
        rsProcedimientos = pstProcedimientos.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsResponsable = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlResponsable = "select * from usuario where tipoCuenta='Supervisor'";
        PreparedStatement pstResponsable = conn.prepareStatement(sqlResponsable);
        rsResponsable = pstResponsable.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    String idEstadoFiltro = request.getParameter("idEstadoFiltro");
    String importanciaFiltro = request.getParameter("importanciaFiltro");
    String idUsuarioFiltro = request.getParameter("idUsuarioFiltro");

    ResultSet rsOrdenesTrabajo = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAsignado = "select orden_trabajo.idOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "usuario.nombreUsuario as supervisor,"
                + "orden_trabajo.fecha_inicio "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado and usuario.idUsuario";

        if (idUsuarioFiltro != null) {
            sqlAsignado = sqlAsignado + " and orden_trabajo.supervisor = '" + idUsuarioFiltro + "'";
        }
        if (idEstadoFiltro != null) {
            sqlAsignado = sqlAsignado + " and orden_trabajo.estado = '" + idEstadoFiltro + "'";
        }
        if (importanciaFiltro != null) {
            sqlAsignado = sqlAsignado + " and orden_trabajo.importancia ='" + importanciaFiltro + "'";
        }

        sqlAsignado = sqlAsignado + " order by orden_trabajo.fecha_inicio desc";
        System.out.println(idEstadoFiltro + " + " + importanciaFiltro);

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
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Procedimientos</div>
                            <div class="collapsible-body white">
                                <!-- Modal Trigger -->
                                <a class="waves-effect waves-light btn modal-trigger right" href="#agregarProcedimiento">Agregar Procedimiento</a>
                                <!-- Modal Structure -->
                                <div id="agregarProcedimiento" class="modal modal-fixed-footer">
                                    <form action="/aeLita/gestorProcedimientosAgregar" method="post">
                                        <div class="modal-content">
                                            <h4>Agregar Procedimiento</h4>
                                            <br/> 
                                            <div class="input-field col6 m6">
                                                <input id="nombreProcedimiento" type="text" class="validate">
                                                <label for="nombreProcedimiento">Nombre del Procedimiento</label>
                                                <div class="input-field">
                                                    <textarea name="detalleOT" style="height: 200px" id="textarea1" required="" class="materialize-textarea"></textarea>
                                                    <label for="textarea1" ><b>Detalle de Procedimiento</b></label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input class="waves-effect waves-light btn" type="submit" value="Crear Procedimiento" />
                                        </div>
                                    </form>
                                </div>
                                <table class="highlight bordered">
                                    <td class="center-align"><b>ID</b></td>
                                    <td><b>Nombre Procedimiento</b></td>
                                    <td><b>Fecha Creación</b></td>
                                    <td><b>Operaciones</b></td>
                                    <tbody>
                                        <% while (rsProcedimientos.next()) {%>                                                
                                    <td><%= rsProcedimientos.getString("idProcedimiento")%></td>
                                    <td><%= rsProcedimientos.getString("nombreProcedimiento")%></td>
                                    <td><%= rsProcedimientos.getString("fecha_creacion")%></td>
                                    <td><a href="/aeLita/gestores/gestorProcedimientosDetalle.jsp?idProcedimiento=<%= rsProcedimientos.getString("idProcedimiento")%>" class="btn">Detalle</a></td>
                                    <%}%>
                                    </tbody>
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
                                    $('.modal').modal();
                                });
                            </script>
                            </body>
                            </html>
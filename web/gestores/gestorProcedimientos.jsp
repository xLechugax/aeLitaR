<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%  ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from estado";
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsEstados = pstEstados.executeQuery();
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
                <div class="col m3">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>First</div>
                            <div class="collapsible-body white">
                                <a class="btn" href="/aeLita/supervisor/gestorOTGenerar.jsp">Crear Procedimiento</a> 
                                <form action="gestorOT.jsp" method="post">
                                    <br/>
                                    <div class="input-field col6 m6">
                                        <input id="nombreArchivo" type="text" class="validate">
                                        <label for="last_name">Nombre del Procedimiento</label>
                                    </div>
                                    <div class="input-field col6 m6">
                                        <input class="waves-effect waves-light btn" type="submit" value="Filtrar" />
                                    </div>
                                </form>
                            </div>
                        </li>
                    </ul>

                </div>
                <div class="col m9">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>First</div>
                            <div class="collapsible-body white">
                                <table class="highlight bordered">
                                    <td class="center-align"><b>ID</b></td>
                                    <td><b>Nombre Procedimiento</b></td>
                                    <td><b>Operaciones</b></td>
                                    <tbody>
                                    <td>00000000001</td>
                                    <td>Generar informe de Servivios</td>
                                    <td><a href="/aeLita/gestores/gestorProcedimientosDetalle.jsp" class="btn">Detalle</a></td>
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
                                });
                            </script>
                            </body>
                            </html>
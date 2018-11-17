<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<%    String idOT = request.getParameter("idOT");
    String desde = request.getParameter("desde");
    String hasta = request.getParameter("hasta");
    ResultSet rsOrdenesTrabajoCerradas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenesTrabajoCerradas = "select orden_trabajo.idOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "usuario.nombreUsuario as supervisor,"
                + "DATE_FORMAT(orden_trabajo.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio, "
                + "orden_trabajo.fecha_inicio as fecha_inicioOrdenar "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado and usuario.idUsuario=" + hs.getAttribute("idUsuarioSesion") + " "
                + "and orden_trabajo.estado = 5";

        if (idOT != null) {
            if (idOT != "") {
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and orden_trabajo.idOrdenTrabajo='" + idOT + "'";
            }
        }
        if (desde != null && hasta != null) {
            if (desde != "" && hasta != "") {
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and fecha_inicio BETWEEN '" + desde + "' and '" + hasta + "'";
            }
            if (desde != "") {
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and fecha_inicio BETWEEN '" + desde + "' and CURRENT_DATE()";
            }
        }
        sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " order by fecha_inicioOrdenar desc";
        PreparedStatement pstOrdenesTrabajoCerradas = conn.prepareStatement(sqlOrdenesTrabajoCerradas);
        rsOrdenesTrabajoCerradas = pstOrdenesTrabajoCerradas.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsOrdenesTrabajoCerradasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenesTrabajoCerradasContador = "select orden_trabajo.idOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "usuario.nombreUsuario as supervisor,"
                + "orden_trabajo.fecha_inicio "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado and usuario.idUsuario=" + hs.getAttribute("idUsuarioSesion") + " "
                + "and orden_trabajo.estado = 5";

        sqlOrdenesTrabajoCerradasContador = sqlOrdenesTrabajoCerradasContador + " order by orden_trabajo.fecha_inicio desc";
        PreparedStatement pstOrdenesTrabajoCerradasContador = conn.prepareStatement(sqlOrdenesTrabajoCerradasContador);
        rsOrdenesTrabajoCerradasContador = pstOrdenesTrabajoCerradasContador.executeQuery();
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
                <div class="col s4 m4">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_list</i>Filtro por ID de OT</div>
                            <div class="collapsible-body white">
                                <form>
                                    ID de Tarea
                                    <input id="idTarea" name="idOT" type="text" >
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_list</i>Filtro por Fecha</div>
                            <div class="collapsible-body white">
                                <form>
                                    Desde
                                    <input id="fechaDesde" type="date" name="desde" required="">
                                    Hasta
                                    <input id="fechaHasta" type="date" name="hasta">
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </center>
                                </form>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="col s8 m8">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">history</i>Ordenes de trabajo cerradas</div>
                            <div class="collapsible-body white">
                                <% if (rsOrdenesTrabajoCerradasContador.next()) {%>
                                <table class="highlight bordered">
                                    <thead>
                                    <td class="center-align"><b>ID</b></td>
                                    <td><b>Estado</b></td>
                                    <td class="center-align"><b>Importancia</b></td>
                                    <td><b>Orden de Trabajo</b></td>
                                    <td><b>Supervisor</b></td>
                                    <td><b>Fecha Inicio</b></td>
                                    <td><b>Operaciones</b></td>
                                    </thead>
                                    <% while (rsOrdenesTrabajoCerradas.next()) {%>
                                    <tbody>
                                    <td class="center-align"><b><%= rsOrdenesTrabajoCerradas.getString("idOrdenTrabajo")%></b></td>
                                    <td><%= rsOrdenesTrabajoCerradas.getString("nombreEstado")%></td>
                                    <td>
                                        <% if (rsOrdenesTrabajoCerradas.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsOrdenesTrabajoCerradas.getString("importancia")%><p> <%} %>
                                        <% if (rsOrdenesTrabajoCerradas.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsOrdenesTrabajoCerradas.getString("importancia")%><p> <%} %>
                                        <% if (rsOrdenesTrabajoCerradas.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsOrdenesTrabajoCerradas.getString("importancia")%><p> <%}%>
                                    </td>
                                    <td><%= rsOrdenesTrabajoCerradas.getString("nombreOrdenTrabajo")%></td>
                                    <td><%= rsOrdenesTrabajoCerradas.getString("supervisor")%></td>
                                    <td><%= rsOrdenesTrabajoCerradas.getString("fecha_inicio")%></td>
                                    <td><a href="/aeLita/supervisor/gestorOTDetalle.jsp?idOT=<%= rsOrdenesTrabajoCerradas.getString("idOrdenTrabajo")%>" class="btn blue-grey darken-3">Detalle</a></td>
                                    </tbody>
                                    <%}%>
                                </table>
                                <%} else {%>
                                <p class="orange-text">Por el momento no hay ordenes de trabajo cerradas...</p>
                                <%}%>
                                </tbody>
                                </table>
                            </div>
                        </li>
                        <%--<li>
                            <div class="collapsible-header"><i class="material-icons">show_chart</i>Estadísticas</div>
                            <div class="collapsible-body white">
                                <canvas id="chartEstadisticas" width="400" height="200"></canvas>
                            </div>
                        </li>--%>
                    </ul>
                </div>
            </div>
            </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/Chart.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.datepicker').datepicker();
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('.collapsible').collapsible();
        });
    </script>
    <script>
        var canvas = document.getElementById('chartEstadisticas');
        var data = {
            labels: ["January", "<%= hs.getAttribute("nombre")%>", "March", "April", "May", "June", "July", "caca"],
            datasets: [
                {
                    label: "My First dataset",
                    backgroundColor: "rgba(102,127,153,0.2)",
                    borderColor: "rgba(255,99,132,1)",
                    borderWidth: 2,
                    hoverBackgroundColor: "rgba(255,99,132,0.4)",
                    hoverBorderColor: "rgba(255,99,132,1)",
                    data: [65, 59, 30, 81, 56, 55, 40, 100],
                }
            ]
        };
        var option = {animation: {duration: 5000}};
        var myBarChart = Chart.Bar(canvas, {data: data, options: option});
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>

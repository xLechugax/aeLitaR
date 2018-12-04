<%@page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<%  String idOT = request.getParameter("idOT");
    String desde = request.getParameter("desde");
    String hasta = request.getParameter("hasta");
    /*String desde1 = request.getParameter("desde1");
    String hasta1 = request.getParameter("hasta1");
    String desde2 = request.getParameter("desde2");
    String hasta2 = request.getParameter("hasta2");*/
    String chart = request.getParameter("chart");
    ResultSet rsOrdenesTrabajoCerradas = null;
    //ResultSet rsOrdenesTrabajoCerradas2 = null;
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
        /*
        String sqlOrdenesTrabajoCerradas2 = sqlOrdenesTrabajoCerradas;
        if (desde1 != null && hasta1 != null) {
            if (desde1 != "" && hasta1 != "") {
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and fecha_inicio BETWEEN '" + desde1 + "' and '" + hasta1 + "'";
            }
        }
        if (desde2 != null && hasta2 != null) {
            if (desde2 != "" && hasta2 != "") {
                sqlOrdenesTrabajoCerradas2 = sqlOrdenesTrabajoCerradas2 + " and fecha_inicio BETWEEN '" + desde2 + "' and '" + hasta2 + "'";
                
            }
        }
        */
        sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " order by fecha_inicioOrdenar desc";
        PreparedStatement pstOrdenesTrabajoCerradas = conn.prepareStatement(sqlOrdenesTrabajoCerradas);
        rsOrdenesTrabajoCerradas = pstOrdenesTrabajoCerradas.executeQuery();
        /*
        sqlOrdenesTrabajoCerradas2 = sqlOrdenesTrabajoCerradas2 + " order by fecha_inicioOrdenar desc";
        PreparedStatement pstOrdenesTrabajoCerradas2 = conn.prepareStatement(sqlOrdenesTrabajoCerradas2);
        rsOrdenesTrabajoCerradas2 = pstOrdenesTrabajoCerradas2.executeQuery();
        */
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
                            <div class="collapsible-header"><i class="material-icons">filter_list</i>Filtro por ID de OT</div>
                            <div class="collapsible-body white">
                                <form>
                                    ID de OT:
                                    <input id="idOT" name="idOT" type="text" >
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_list</i>Filtro por Fecha</div>
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
                        <li class="collapsible" />
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_chart</i>Gráfico: Filtro por Fecha</div>
                            <div class="collapsible-body white">
                                <form>
                                    Rango 1: <br/>
                                    Desde
                                    <input id="fechaDesde1" type="date" name="desde1" required>
                                    Hasta
                                    <input id="fechaHasta1" type="date" name="hasta2" required>
                                    Rango 2: <br/>
                                    Desde
                                    <input id="fechaDesde2" type="date" name="desde1" required>
                                    Hasta
                                    <input id="fechaHasta2" type="date" name="hasta2" required>
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Filtrar" />
                                    </center>
                                </form>
                            </div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_chart</i>Periodos</div>
                            <div class="collapsible-body white">
                                <form>
                                    Filtrar por los ultimos:
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="30 dias" />
                                    </center> <br/>
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="3 meses" />
                                    </center> <br/>
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="6 meses" />
                                    </center> <br/>
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="anual" />
                                    </center>
                                </form>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="col s8 m8">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header"><i class="material-icons">history</i>Ordenes de trabajo cerradas</div>
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
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">show_chart</i>Estadísticas</div>
                            <div class="collapsible-body white">
                                <canvas id="chartEstadisticas" width="400" height="200"></canvas>
                            </div>
                        </li>
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
        <%
            rsOrdenesTrabajoCerradas.beforeFirst();
            LocalDateTime ld = LocalDateTime.now();
            DateTimeFormatter mmyyyy = DateTimeFormatter.ofPattern("MM/yyyy");
            DateTimeFormatter ddmm = DateTimeFormatter.ofPattern("dd/MM");
            DateTimeFormatter datetime = DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm:ss");
            String date="";
            String[] registro = null;
            int[] datos = null;
            
            if ((chart == null || chart == "") || chart.equals("30 dias")) {
                registro = new String[30];
                datos = new int[30];
                for(int i=29; i >= 0; i--){
                    registro[i] = ld.format(ddmm);
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_inicio");
                        date = date.substring(0, 5);
                        if (ld.format(ddmm).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsOrdenesTrabajoCerradas.beforeFirst();
                    ld = ld.minusDays(1);
                }
            } 
            else if (chart.equals("3 meses")) {
                registro = new String[90];
                datos = new int[90];
                for(int i=89; i >= 0; i--){
                    registro[i] = ld.format(ddmm);
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_inicio");
                        date = date.substring(0, 5);
                        if (ld.format(ddmm).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsOrdenesTrabajoCerradas.beforeFirst();
                    ld = ld.minusDays(1);
                }
            }
            else if (chart.equals("6 meses")) {
                registro = new String[6];
                datos = new int[6];
                for(int i=5; i >= 0; i--){
                    registro[i] = ld.format(mmyyyy);
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_inicio");
                        date = date.substring(3, 10);
                        if (ld.format(mmyyyy).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsOrdenesTrabajoCerradas.beforeFirst();
                    ld = ld.minusMonths(1);
                }
            }
            else if (chart.equals("anual")) {
                registro = new String[]{"Enero","Febrero","Marzo","Abril","Mayor","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre",};
                datos = new int[12];
                for(int i=11; i >= 0; i--){
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_inicio");
                        date = date.substring(3, 10);
                        if (ld.format(mmyyyy).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsOrdenesTrabajoCerradas.beforeFirst();
                    ld = ld.minusMonths(1);
                }
            }
        %>
                
        var data = {
            
            <% if ((chart == null || chart == "") || chart.equals("30 dias")){ %>
                labels: [ <% for(int i=0; i < 30; i++){ 
                                out.print("\""+registro[i]+"\",");
                            } %> ],
                datasets: [
                    {
                        label: "Resumen 30 días",
                        backgroundColor: "rgba(102,127,153,0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        borderWidth: 2,
                        hoverBackgroundColor: "rgba(255,99,132,0.4)",
                        hoverBorderColor: "rgba(255,99,132,1)",
                        data: [ <% for(int i=0; i < 30; i++){ 
                                    out.print("\""+datos[i]+"\",");
                                } %> ],
                    }
                ]
            <% } 
            
            else if (chart.equals("3 meses")){ %>
                labels: [ <% for(int i=0; i < 90; i++){ 
                                out.print("\""+registro[i]+"\",");
                            } %> ],
                datasets: [
                    {
                        label: "Resumen 3 meses",
                        backgroundColor: "rgba(102,127,153,0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        borderWidth: 2,
                        hoverBackgroundColor: "rgba(255,99,132,0.4)",
                        hoverBorderColor: "rgba(255,99,132,1)",
                        data: [ <% for(int i=0; i < 90; i++){ 
                                    out.print("\""+datos[i]+"\",");
                                } %> ],
                    }
                ]
            <% }
            
            else if (chart.equals("6 meses")){ %>
                labels: [ <% for(int i=0; i < 6; i++){ 
                                out.print("\""+registro[i]+"\",");
                            } %> ],
                datasets: [
                    {
                        label: "Resumen 6 meses",
                        backgroundColor: "rgba(102,127,153,0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        borderWidth: 2,
                        hoverBackgroundColor: "rgba(255,99,132,0.4)",
                        hoverBorderColor: "rgba(255,99,132,1)",
                        data: [ <% for(int i=0; i < 6; i++){ 
                                    out.print("\""+datos[i]+"\",");
                                } %> ],
                    }
                ]
            <% }
            
            else if (chart.equals("anual")){ %>
                labels: [ <% for(int i=0; i < 12; i++){ 
                                out.print("\""+registro[i]+"\",");
                            } %> ],
                datasets: [
                    {
                        label: "Resumen anual",
                        backgroundColor: "rgba(102,127,153,0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        borderWidth: 2,
                        hoverBackgroundColor: "rgba(255,99,132,0.4)",
                        hoverBorderColor: "rgba(255,99,132,1)",
                        data: [ <% for(int i=0; i < 12; i++){ 
                                    out.print("\""+datos[i]+"\",");
                                } %> ],
                    }
                ]
            <% }
            
            %>
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

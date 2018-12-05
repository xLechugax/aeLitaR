<%@page import="java.time.*, java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<%    
    
    String desde = request.getParameter("fechaDesde");
    String hasta = request.getParameter("fechaHasta");
    String idOT = request.getParameter("idOT");
    String desde1 = request.getParameter("desde1");
    String hasta1 = request.getParameter("hasta1");
    String desde2 = request.getParameter("desde2");
    String hasta2 = request.getParameter("hasta2");
    String chart = request.getParameter("chart");
    
    ResultSet rsOrdenesTrabajoCerradas = null;
    ResultSet rsOrdenesTrabajoCerradas1 = null;
    ResultSet rsOrdenesTrabajoCerradas2 = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlOrdenesTrabajoCerradas = "select orden_trabajo.idOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "usuario.nombreUsuario as supervisor,"
                + "DATE_FORMAT(orden_trabajo.fecha_fin, '%d/%m/%Y %T') as fecha_fin, "
                + "orden_trabajo.fecha_fin as fecha_finOrdenar "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado "
                + "and orden_trabajo.estado = 5";
        String sqlOrdenesTrabajoCerradas1 = sqlOrdenesTrabajoCerradas;
        String sqlOrdenesTrabajoCerradas2 = sqlOrdenesTrabajoCerradas;
        
        if (idOT != null) {
            if (idOT != "") {
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and orden_trabajo.idOrdenTrabajo='" + idOT + "'";
            }
        }
        if (desde != null && hasta != null) {
            if (desde != "" && hasta != "") {
                String temp = hasta;
                if ((hasta.substring(5, 7) +"-"+ hasta.substring(8, 10)).equals("12-31")){
                    temp = hasta.substring(0, 4) +"-12-30";
                }
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and fecha_fin BETWEEN '" + desde + "' and date('" + temp + "') + 1";
            }
            if (desde != "") {
                sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " and fecha_fin BETWEEN '" + desde + "' and CURRENT_DATE() + 1";
            }
        }
        
        
        if (desde1 != null && hasta1 != null) {
            if (desde1 != "" && hasta1 != "") {
                String temp = hasta1;
                if ((hasta1.substring(5, 7) +"-"+ hasta1.substring(8, 10)).equals("12-31")){
                    temp = hasta1.substring(0, 4) +"-12-30";
                }          
                sqlOrdenesTrabajoCerradas1 = sqlOrdenesTrabajoCerradas1 + " and fecha_fin BETWEEN '" + desde1 + "' and date('" + temp + "') + 1";
            }
        }
        if (desde2 != null && hasta2 != null) {
            if (desde2 != "" && hasta2 != "") {
                String temp = hasta2;
                if ((hasta2.substring(5, 7) +"-"+ hasta2.substring(8, 10)).equals("12-31")){
                    temp = hasta2.substring(0, 4) +"-12-30";
                }       
                sqlOrdenesTrabajoCerradas2 = sqlOrdenesTrabajoCerradas2 + " and fecha_fin BETWEEN '" + desde2 + "' and date('" + temp + "') + 1";
                
            }
        }
        
        sqlOrdenesTrabajoCerradas = sqlOrdenesTrabajoCerradas + " order by fecha_finOrdenar desc";
        PreparedStatement pstOrdenesTrabajoCerradas = conn.prepareStatement(sqlOrdenesTrabajoCerradas);
        rsOrdenesTrabajoCerradas = pstOrdenesTrabajoCerradas.executeQuery();
        
        sqlOrdenesTrabajoCerradas1 = sqlOrdenesTrabajoCerradas1 + " order by fecha_finOrdenar desc";
        PreparedStatement pstOrdenesTrabajoCerradas1 = conn.prepareStatement(sqlOrdenesTrabajoCerradas1);
        rsOrdenesTrabajoCerradas1 = pstOrdenesTrabajoCerradas1.executeQuery();
        
        sqlOrdenesTrabajoCerradas2 = sqlOrdenesTrabajoCerradas2 + " order by fecha_finOrdenar desc";
        PreparedStatement pstOrdenesTrabajoCerradas2 = conn.prepareStatement(sqlOrdenesTrabajoCerradas2);
        rsOrdenesTrabajoCerradas2 = pstOrdenesTrabajoCerradas2.executeQuery();
        
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
                + "orden_trabajo.fecha_fin "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado "
                + "and orden_trabajo.estado = 5";

        sqlOrdenesTrabajoCerradasContador = sqlOrdenesTrabajoCerradasContador + " order by orden_trabajo.fecha_fin desc";
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
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_chart</i>Gráfico: Filtro por Fecha</div>
                            <div class="collapsible-body white">
                                <form>
                                    Selección de periodo a camparar: <br/>
                                    Desde
                                    <input id="fechaDesde1" type="date" name="desde1" required>
                                    Hasta
                                    <input id="fechaHasta1" type="date" name="hasta1" required>
                                    Segundo periodo a cual comparar: <br/>
                                    Desde
                                    <input id="fechaDesde2" type="date" name="desde2" required>
                                    Hasta
                                    <input id="fechaHasta2" type="date" name="hasta2" required>
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
                            <div class="collapsible-header <% if(!(idOT == null || idOT == "") || !(desde == null || desde == "")){out.print("active");} %> "><i class="material-icons">history</i>Ordenes de trabajo cerradas</div>
                            <div class="collapsible-body white">
                                <% if (rsOrdenesTrabajoCerradasContador.next()) {%>
                                <table class="highlight bordered">
                                    <thead>
                                    <td class="center-align"><b>ID</b></td>
                                    <td><b>Estado</b></td>
                                    <td class="center-align"><b>Importancia</b></td>
                                    <td><b>Orden de Trabajo</b></td>
                                    <td><b>Supervisor</b></td>
                                    <td><b>Fecha de Cierre</b></td>
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
                                    <td><%= rsOrdenesTrabajoCerradas.getString("fecha_fin")%></td>
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
                                <form>
                                    Filtrar por los ultimos:
                                    <center>
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="30 dias" />
                                        &nbsp&nbsp
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="3 meses" />
                                        &nbsp&nbsp
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="6 meses" />
                                        &nbsp&nbsp
                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" name="chart" value="anual" />
                                    </center> <br />
                                </form>
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
            LocalDateTime ld = LocalDateTime.now();
            DateTimeFormatter ddmm = DateTimeFormatter.ofPattern("dd/MM");
            DateTimeFormatter mmyyyy = DateTimeFormatter.ofPattern("MM/yyyy");
            rsOrdenesTrabajoCerradas.beforeFirst();
            rsOrdenesTrabajoCerradas1.beforeFirst();
            rsOrdenesTrabajoCerradas2.beforeFirst();
            String[] registro = null;
            int[] datos = null;
            String date="";
            String date2="";
            int count1 = 0;
            int count2 = 0;
            
            if(!(desde1 == null || desde1 == "")){
                while(rsOrdenesTrabajoCerradas1.next()){
                        count1++;
                    }
                desde1 = desde1.substring(8, 10) +"/"+ desde1.substring(5, 7) +"/"+ desde1.substring(0, 4);
                hasta1 = hasta1.substring(8, 10) +"/"+ hasta1.substring(5, 7) +"/"+ hasta1.substring(0, 4);
                date = desde1 + " - " + hasta1;
                while(rsOrdenesTrabajoCerradas2.next()){
                        count2++;
                    }
                desde2 = desde2.substring(8, 10) +"/"+ desde2.substring(5, 7) +"/"+ desde2.substring(0, 4);
                hasta2 = hasta2.substring(8, 10) +"/"+ hasta2.substring(5, 7) +"/"+ hasta2.substring(0, 4);
                date2 = desde2 + " - " + hasta2;
            }            
            else if ((chart == null || chart == "") || chart.equals("30 dias")) {
                registro = new String[30];
                datos = new int[30];
                for(int i=29; i >= 0; i--){
                    registro[i] = ld.format(ddmm);
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_fin");
                        date = date.substring(0, 5);
                        if (ld.format(ddmm).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsOrdenesTrabajoCerradas.beforeFirst();
                    ld = ld.minusDays(1);
                }
            } 
            else if (chart.equals("3 meses")) {
                registro = new String[3];
                datos = new int[3];
                for(int i=2; i >= 0; i--){
                    registro[i] = ld.format(mmyyyy);
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_fin");
                        date = date.substring(3, 10);
                        if (ld.format(mmyyyy).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsOrdenesTrabajoCerradas.beforeFirst();
                    ld = ld.minusMonths(1);
                }
            }
            else if (chart.equals("6 meses")) {
                registro = new String[6];
                datos = new int[6];
                for(int i=5; i >= 0; i--){
                    registro[i] = ld.format(mmyyyy);
                    while(rsOrdenesTrabajoCerradas.next()){
                        date = rsOrdenesTrabajoCerradas.getString("fecha_fin");
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
                        date = rsOrdenesTrabajoCerradas.getString("fecha_fin");
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
            
            <% if (!(desde1 == null || desde1 == "")){ %>
                labels: [ <%=   "\""+date+"\",\""+date2+"\"," %> ],
                datasets: [
                    {
                        label: "Periodos",
                        backgroundColor: "rgba(102,127,153,0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        borderWidth: 2,
                        hoverBackgroundColor: "rgba(255,99,132,0.4)",
                        hoverBorderColor: "rgba(255,99,132,1)",
                        data: [ <%=   "\""+count1+"\",\""+count2+"\"," %> ],
                    }
                ]
            <% }

            else if ((chart == null || chart == "") || chart.equals("30 dias")){ %>
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
                labels: [ <% for(int i=0; i < 3; i++){ 
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
                        data: [ <% for(int i=0; i < 3; i++){ 
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
            <% } %>
        };
        
        //var option = {animation: {duration: 5000}};
        var option = {scales: {yAxes: [{ ticks: {beginAtZero:true, fixedStepSize: 1}}]}};
        var myBarChart = Chart.Bar(canvas, {data: data, options: option});
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
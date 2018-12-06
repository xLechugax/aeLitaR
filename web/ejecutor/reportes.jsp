<%@page import="java.time.*, java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<%    
    ResultSet rsTareasCerradas = null;
    ResultSet rsTareasCerradas1 = null;
    ResultSet rsTareasCerradas2 = null;
    String idTarea = request.getParameter("idTarea");
    String desde = request.getParameter("desde");
    String hasta = request.getParameter("hasta");
    String desde1 = request.getParameter("desde1");
    String hasta1 = request.getParameter("hasta1");
    String desde2 = request.getParameter("desde2");
    String hasta2 = request.getParameter("hasta2");
    String chart = request.getParameter("chart");
    
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, DATE_FORMAT(tarea.fecha_fin, '%d/%m/%Y %T') as fecha_fin, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea =5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion");
        String sql1 = sql;
        String sql2 = sql;
        
        if (idTarea != null) {
            if (idTarea != "") {
                sql = sql + " and tarea.idTarea='"+idTarea+"'";
            }
        }
        if ( desde != null && hasta != null) {
            if ( desde != "" && hasta != "") {
                String temp = hasta;
                if ((hasta.substring(5, 7) +"-"+ hasta.substring(8, 10)).equals("12-31")){
                    temp = hasta.substring(0, 4) +"-12-30";
                }
                sql = sql + " and tarea.fecha_fin BETWEEN '"+desde+"' and date('"+temp+"') + 1";
            }
            if ( desde != "" ) {
                sql = sql + " and tarea.fecha_fin BETWEEN '"+desde+"' and CURRENT_DATE() + 1";
            }
        }
        
        if ( desde1 != null && hasta1 != null) {
            if ( desde1 != "" && hasta1 != "") {
                String temp = hasta1;
                if ((hasta1.substring(5, 7) +"-"+ hasta1.substring(8, 10)).equals("12-31")){
                    temp = hasta1.substring(0, 4) +"-12-30";
                }          
                sql1 = sql1 + " and tarea.fecha_fin BETWEEN '"+desde1+"' and date('"+temp+"') + 1";
            }
        }
        if ( desde2 != null && hasta2 != null) {
            if ( desde2 != "" && hasta2 != "") {
                String temp = hasta2;
                if ((hasta2.substring(5, 7) +"-"+ hasta2.substring(8, 10)).equals("12-31")){
                    temp = hasta2.substring(0, 4) +"-12-30";
                }        
                sql2 = sql2 + " and tarea.fecha_fin BETWEEN '"+desde2+"' and date('"+temp+"') + 1";
            }
        }
        
        sql = sql + " order by fecha_fin desc";        
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasCerradas = pst.executeQuery();
        
        sql1 = sql1 + " order by fecha_fin desc";        
        PreparedStatement pst1 = conn.prepareStatement(sql1);
        rsTareasCerradas1 = pst1.executeQuery();
        
        sql2 = sql2 + " order by fecha_fin desc";        
        PreparedStatement pst2 = conn.prepareStatement(sql2);
        rsTareasCerradas2 = pst2.executeQuery();
            
        
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareasCerradasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_fin, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea =5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasCerradasContador = pst.executeQuery();
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
                            <div class="collapsible-header"><i class="material-icons">filter_list</i>Filtro por ID de Tarea</div>
                            <div class="collapsible-body white">
                                <form>
                                    ID de Tarea:
                                    <input id="idTarea" name="idTarea" type="text">
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
                                    <input id="desde" name="desde" type="date" required="">
                                    Hasta
                                    <input id="hasta" name="hasta" type="date">
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
                            <div class="collapsible-header <% if(!(idTarea == null || idTarea == "") || !(desde == null || desde == "")){out.print("active");} %> "><i class="material-icons">history</i>Tareas cerradas</div>
                            <div class="collapsible-body white">
                                <% if (rsTareasCerradasContador.next()) {%>
                                <table border="1" class="highlight">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Estado</th>
                                            <th>Criticidad</th>
                                            <th><center>Tarea</center></th>
                                    <th>Orden de Trabajo</th>
                                    <th>Fecha de Cierre</th>
                                    <th>Operaciones</th>
                                    </tr>
                                    </thead>
                                    <%while (rsTareasCerradas.next()) {%>  
                                    <tbody>
                                        <tr>
                                            <td><b><%= rsTareasCerradas.getString("idTarea")%></b></td>
                                            <td><%= rsTareasCerradas.getString("nombreEstado")%></td>
                                            <td><% if (rsTareasCerradas.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsTareasCerradas.getString("importancia")%><p> <%} %>
                                                <% if (rsTareasCerradas.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsTareasCerradas.getString("importancia")%><p> <%} %>
                                                <% if (rsTareasCerradas.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsTareasCerradas.getString("importancia")%><p> <%}%></td>
                                            <td><b><center><%= rsTareasCerradas.getString("nombreTipoTarea")%></center></b></td>
                                            <td><%= rsTareasCerradas.getString("nombreOrdenTrabajo")%></td>
                                            <td><%= rsTareasCerradas.getString("fecha_fin")%></td>
                                            <td><a href="/aeLita/ejecutor/gestorTareasDetalle.jsp?idTarea=<%= rsTareasCerradas.getString("idTarea")%>" class="btn blue-grey darken-3">Detalle</a></td>
                                        </tr>
                                        <%}
                                        } else {%>
                                    <p class="orange-text">Por el momento no hay tareas cerradas...</p>
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
            rsTareasCerradas.beforeFirst();
            rsTareasCerradas1.beforeFirst();
            rsTareasCerradas2.beforeFirst();
            String[] registro = null;
            int[] datos = null;
            String date="";
            String date2="";
            int count1 = 0;
            int count2 = 0;
            
            if(!(desde1 == null || desde1 == "")){
                while(rsTareasCerradas1.next()){
                        count1++;
                    }
                desde1 = desde1.substring(8, 10) +"/"+ desde1.substring(5, 7) +"/"+ desde1.substring(0, 4);
                hasta1 = hasta1.substring(8, 10) +"/"+ hasta1.substring(5, 7) +"/"+ hasta1.substring(0, 4);
                date = desde1 + " - " + hasta1;
                while(rsTareasCerradas2.next()){
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
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_fin");
                        date = date.substring(0, 5);
                        if (ld.format(ddmm).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsTareasCerradas.beforeFirst();
                    ld = ld.minusDays(1);
                }
            } 
            else if (chart.equals("3 meses")) {
                registro = new String[3];
                datos = new int[3];
                for(int i=2; i >= 0; i--){
                    registro[i] = ld.format(mmyyyy);
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_fin");
                        date = date.substring(3, 10);
                        if (ld.format(mmyyyy).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsTareasCerradas.beforeFirst();
                    ld = ld.minusMonths(1);
                }
            }
            else if (chart.equals("6 meses")) {
                registro = new String[6];
                datos = new int[6];
                for(int i=5; i >= 0; i--){
                    registro[i] = ld.format(mmyyyy);
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_fin");
                        date = date.substring(3, 10);
                        if (ld.format(mmyyyy).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsTareasCerradas.beforeFirst();
                    ld = ld.minusMonths(1);
                }
            }
            else if (chart.equals("anual")) {
                registro = new String[]{"Enero","Febrero","Marzo","Abril","Mayor","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre",};
                datos = new int[12];
                for(int i=11; i >= 0; i--){
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_fin");
                        date = date.substring(3, 10);
                        if (ld.format(mmyyyy).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsTareasCerradas.beforeFirst();
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
            <% }
            
            %>
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
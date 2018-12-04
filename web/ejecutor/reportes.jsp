<%@page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<%    
    ResultSet rsTareasCerradas = null;
    String chart = request.getParameter("chart");
    
    try {

        String idTarea = request.getParameter("idTarea");
        String desde = request.getParameter("desde");
        String hasta = request.getParameter("hasta");

        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, DATE_FORMAT(tarea.fecha_inicio, '%d/%m/%Y %T') as fecha_inicio, tarea.fecha_fin, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
                + " from tarea,usuario,estado,orden_trabajo,tipo_tarea"
                + " where tarea.usuario = usuario.idUsuario"
                + " and tarea.estadoTarea = estado.idEstado"
                + " and tarea.idOrdenTrabajo = orden_trabajo.idOrdenTrabajo"
                + " and tarea.idTipoTarea = tipo_tarea.idTipoTarea"
                + " and tarea.estadoTarea =5" //ID 5 de tarea Cerrada
                + " and tarea.usuario =" + hs.getAttribute("idUsuarioSesion");
        
        if (idTarea != null) {
            if (idTarea != "") {
                sql = sql + " and tarea.idTarea='"+idTarea+"'";
            }
        }
        if ( desde != null && hasta != null) {
            if ( desde != "" && hasta != "") {
                sql = sql + " and tarea.fecha_inicio BETWEEN '"+desde+"' and '"+hasta+"'";
            }
            if ( desde != "" ) {
                sql = sql + " and tarea.fecha_inicio BETWEEN '"+desde+"' and CURRENT_DATE()";
            }
        }
        sql = sql + " order by fecha_fin desc";        
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareasCerradas = pst.executeQuery();
        
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsTareasCerradasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select tarea.idTarea, tarea.fecha_inicio, orden_trabajo.importancia, usuario.nombreUsuario, estado.nombreEstado,tipo_tarea.nombreTipoTarea, orden_trabajo.nombreOrdenTrabajo"
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
                                    ID de Tarea
                                    <input id="idTarea" name="idTarea" type="text">
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
                            <div class="collapsible-header"><i class="material-icons">history</i>Tareas cerradas</div>
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
                                    <th>Fecha Inicio</th>
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
                                            <td><%= rsTareasCerradas.getString("fecha_inicio")%></td>
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
            rsTareasCerradas.beforeFirst();
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
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_inicio");
                        date = date.substring(0, 5);
                        if (ld.format(ddmm).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsTareasCerradas.beforeFirst();
                    ld = ld.minusDays(1);
                }
            } 
            else if (chart.equals("3 meses")) {
                registro = new String[90];
                datos = new int[90];
                for(int i=89; i >= 0; i--){
                    registro[i] = ld.format(ddmm);
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_inicio");
                        date = date.substring(0, 5);
                        if (ld.format(ddmm).equals(date))
                            datos[i] = datos[i] + 1;
                    }
                    rsTareasCerradas.beforeFirst();
                    ld = ld.minusDays(1);
                }
            }
            else if (chart.equals("6 meses")) {
                registro = new String[6];
                datos = new int[6];
                for(int i=5; i >= 0; i--){
                    registro[i] = ld.format(mmyyyy);
                    while(rsTareasCerradas.next()){
                        date = rsTareasCerradas.getString("fecha_inicio");
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
                        date = rsTareasCerradas.getString("fecha_inicio");
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
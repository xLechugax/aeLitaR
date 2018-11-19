<%@page import="bd.ConexionBD"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSet"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp"%>
<!DOCTYPE html>
<%    if (hs.getAttribute("idEmpresa") == null) { //Setear el HS unicamente si viene null, o sea, recien iniciando la sessión
        String idEmpresa = request.getParameter("idEmpresa"); // Toma el ID de la empresa y lo deja en el HS
        hs.setAttribute("idEmpresa", idEmpresa);
    }
%>
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
            <div class="container"> 
                <div class="row">
                    <div class="col s12 m12">
                        <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <p>¡Bienvenido a æLita <b><%=hs.getAttribute("nombre")%></b>!</p> 
                                <br/>
                                <%
                                    ResultSet rsTareasEnAtencion = null;
                                    try {
                                        Connection conn = ConexionBD.getConexion();
                                        String sqlTareasEnAtencion = "select count(*)  from tarea where tarea.idEmpresa = " + hs.getAttribute("idEmpresa") + " and usuario = " + hs.getAttribute("idUsuarioSesion") + " and tarea.estadoTarea != 5";
                                        PreparedStatement pstTareasEnAtencion = conn.prepareStatement(sqlTareasEnAtencion);
                                        rsTareasEnAtencion = pstTareasEnAtencion.executeQuery();
                                        rsTareasEnAtencion.next();
                                    } catch (SQLException e) {
                                        out.println("Excepción de SQL:" + e);
                                        return;
                                    }
                                    ResultSet rsTareasCerradas = null;
                                    try {
                                        Connection conn = ConexionBD.getConexion();
                                        String sqlTareasCerradas = "select count(*) from tarea where tarea.idEmpresa = " + hs.getAttribute("idEmpresa") + " and tarea.usuario = " + hs.getAttribute("idUsuarioSesion") + " and tarea.estadoTarea = 5";
                                        PreparedStatement pstTareasCerradas = conn.prepareStatement(sqlTareasCerradas);
                                        rsTareasCerradas = pstTareasCerradas.executeQuery();
                                        rsTareasCerradas.next();
                                    } catch (SQLException e) {
                                        out.println("Excepción de SQL:" + e);
                                        return;
                                    }
                                    ResultSet rsAvances = null;
                                    try {
                                        Connection conn = ConexionBD.getConexion();
                                        String sqlAvances = "select count(*) from avance where avance.idEmpresa = " + hs.getAttribute("idEmpresa") + " and avance.usuario = " + hs.getAttribute("idUsuarioSesion");
                                        PreparedStatement pstAvances = conn.prepareStatement(sqlAvances);
                                        rsAvances = pstAvances.executeQuery();
                                        rsAvances.next();
                                    } catch (SQLException e) {
                                        out.println("Excepción de SQL:" + e);
                                        return;
                                    }
                                %>
                                <div class="collection">
                                    <a class="collection-item"><span class="badge green white-text"><%= rsTareasEnAtencion.getInt(1)%></span>Tareas en Atención</a>
                                    <a class="collection-item"><span class="badge grey white-text"><%= rsTareasCerradas.getInt(1)%></span>Tareas Cerradas</a>
                                    <a class="collection-item"><span class="badge orange white-text"><%= rsAvances.getInt(1)%></span>Cantidad de Avances</a>
                                </div>
                            </div>
                        </div>
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
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
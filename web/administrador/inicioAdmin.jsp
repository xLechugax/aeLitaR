<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp"%>
<%    if (hs.getAttribute("idEmpresa") == null) { //Setear el HS unicamente si viene null, o sea, recien iniciando la sessión
        String idEmpresa = request.getParameter("idEmpresa"); // Toma el ID de la empresa y lo deja en el HS
        hs.setAttribute("idEmpresa", idEmpresa);
    }

    Connection conn = ConexionBD.getConexion();
    //Activa de manera global los Eventos
    String sqlActivarEventosEnMySQL = "SET GLOBAL event_scheduler = ON";
    PreparedStatement pstActivarEventosEnMySQL = conn.prepareStatement(sqlActivarEventosEnMySQL);
    pstActivarEventosEnMySQL.execute();

    String idEmpresa = "" + hs.getAttribute("idEmpresa");
    String idUsuario = "" + hs.getAttribute("idUsuarioSesion");

    ResultSet rsOTAtencion = null;
    try {
        String sqlTareasEnAtencion = "select count(*) from orden_trabajo where orden_trabajo.idEmpresa= " + idEmpresa;
        PreparedStatement pstTareasEnAtencion = conn.prepareStatement(sqlTareasEnAtencion);
        rsOTAtencion = pstTareasEnAtencion.executeQuery();
        rsOTAtencion.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsOTCerradas = null;
    try {
        String sqlTareasCerradas = "select count(*) from orden_trabajo where orden_trabajo.supervisor = " + idUsuario + " and orden_trabajo.estado = 5 and orden_trabajo.idEmpresa = " + idEmpresa;
        PreparedStatement pstTareasCerradas = conn.prepareStatement(sqlTareasCerradas);
        rsOTCerradas = pstTareasCerradas.executeQuery();
        rsOTCerradas.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsAvances = null;
    try {
        String sqlAvances = "select count(*) from avance where avance.idEmpresa = " + idEmpresa + " and avance.usuario = " + idUsuario;
        PreparedStatement pstAvances = conn.prepareStatement(sqlAvances);
        rsAvances = pstAvances.executeQuery();
        rsAvances.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsUsuariosRegistrados = null;
    try {
        String sqlUsuariosRegistrados = "select count(*) as cantidad from trabaja where trabaja.idEmpresa = "+idEmpresa;
        PreparedStatement pstUsuariosRegistrados = conn.prepareStatement(sqlUsuariosRegistrados);
        rsUsuariosRegistrados = pstUsuariosRegistrados.executeQuery();
        rsUsuariosRegistrados.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsUsuariosRegistradosActivos = null;
    try {
        String sqlUsuariosRegistradosActivos = "select count(*) as cantidad from trabaja where trabaja.idEmpresa = "+idEmpresa+" and activo='S'";
        PreparedStatement pstUsuariosRegistradosActivos = conn.prepareStatement(sqlUsuariosRegistradosActivos);
        rsUsuariosRegistradosActivos = pstUsuariosRegistradosActivos.executeQuery();
        rsUsuariosRegistradosActivos.next();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsUsuariosRegistradosDesactivados = null;
    try {
        String sqlUsuariosRegistradosDesactivados = "select count(*) as cantidad from trabaja where trabaja.idEmpresa = "+idEmpresa+" and activo='N'";
        PreparedStatement pstUsuariosRegistradosDesactivados = conn.prepareStatement(sqlUsuariosRegistradosDesactivados);
        rsUsuariosRegistradosDesactivados = pstUsuariosRegistradosDesactivados.executeQuery();
        rsUsuariosRegistradosDesactivados.next();
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
            <div class="container"> 
                <div class="row">
                    <div class="col s12 m12">
                        <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <p>Bienvenido a æLita <%=hs.getAttribute("nombre")%>, ha ingresado con la empresa <%= hs.getAttribute("nombreEmpresa") %></p>
                                <br/>
                                <p>Estadísticas Usuarios</p>
                                <div class="collection">
                                    <a href="#!" class="collection-item"><span class="blue-grey darken-3 badge white-text"><%= rsUsuariosRegistrados.getString("cantidad") %></span>Usuarios Registrados</a>
                                    <a href="#!" class="collection-item"><span class="green white-text badge white-text"><%= rsUsuariosRegistradosActivos.getString("cantidad") %></span>Usuarios Activados</a>
                                    <a href="#!" class="collection-item"><span class="red  white-text badge"><%= rsUsuariosRegistradosDesactivados.getString("cantidad") %></span>Usuarios Desactivados</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
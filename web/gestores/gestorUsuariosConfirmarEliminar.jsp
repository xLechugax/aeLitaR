<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%
    String idUsuario = request.getParameter("idUsuario");

    ResultSet rsUsuarioSeleccionado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlUsuarioSeleccionado = "select * from usuario where idUsuario="+idUsuario;
        PreparedStatement pstUsuarioSeleccionado = conn.prepareCall(sqlUsuarioSeleccionado);
        rsUsuarioSeleccionado = pstUsuarioSeleccionado.executeQuery();
        rsUsuarioSeleccionado.next();
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
                <div class="col m12">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Confirmación de Eliminación</a> 
                                    <p class="center-align">¿<%= hs.getAttribute("nombre")%> estas seguro de querer eliminar al usuario <%= rsUsuarioSeleccionado.getString("nombreUsuario")%>?</p>
                                    <center>
                                        <a class="btn" href="gestorUsuarios.jsp?accion=2&id=<%= rsUsuarioSeleccionado.getString("idUsuario")%>">SI</a>
                                        <a class="btn" href="gestorUsuarios.jsp">NO</a>
                                    </center>
                            </div>
                        </div>
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
        });
    </script>
</body>
</html>
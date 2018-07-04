<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<%@ include file="../accesoDenegado.jsp" %>
<%        return;
    }
    String idTarea = request.getParameter("idTarea");

    ResultSet rsTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tarea";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareas = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsTareaSeleccionada = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tarea where idTarea=" + idTarea;
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareaSeleccionada = pst.executeQuery();
        rsTareaSeleccionada.next();
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
    <style>
        body {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
        }

        main {
            flex: 1 0 auto;
        }
    </style>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <div class="row">
                <div class="col m5">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Modificar Tarea</a> 
                                <form action="gestorTareasModificarSub.jsp" method="post">
                                    <input name="idUsuario" value="<%= hs.getAttribute("idUsuarioSesion")%>" type="hidden"></td>
                                    <table>
                                        <tbody>
                                            <tr> 
                                                <td>Nombre Tarea:</td>
                                                <td><input name="nombre_tarea" class="validate" required="" placeholder="<%= rsTareaSeleccionada.getString("nombreTarea")%>"></td>
                                        <input name="idTarea" type="hidden" value="<%= rsTareaSeleccionada.getString("idTarea")%>">
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_tarea" class="materialize-textarea" data-length="120" required="" placeholder="<%= rsTareaSeleccionada.getString("detalleTarea")%>"></textarea>
                                        <label for="textarea1">Detalle de tarea</label>
                                    </div>
                                    <center>
                                        <input class="btn" type="submit" value="Modificar Tarea" /><br/><br/>
                                        <a href="gestorTareas.jsp" class="btn left-align">Cancelar</a>
                                    </center>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col m7">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-content">
                                <table class="highlight">
                                    <thead>
                                        <tr>
                                            <td>ID</td>
                                            <td>Tarea</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsTareas.next()) {%>
                                        <tr>
                                            <td><%= rsTareas.getString("idTarea")%></td>
                                            <td><%= rsTareas.getString("nombreTarea")%></td>
                                            <td>
                                                <a href="gestorTareasEliminar.jsp?idTarea=<%=rsTareas.getLong("idTarea")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorTareasModificar.jsp?idTarea=<%=rsTareas.getLong("idTarea")%>">
                                                    <img src="img/modificar.jpg" title="Modificar"/>
                                                </a>
                                            </td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
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
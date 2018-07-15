<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    ResultSet rsTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tipo_tarea";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareas = pst.executeQuery();
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
                <div class="col m5">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Crear Tipo de Tarea</a> 
                                <form action="gestorTipoTareasAgregar.jsp" method="post">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Nombre Tipo Tarea:</td>
                                                <td><input placeholder="Nombre..." name="nombre_tipo_tarea" class="validate" required=""></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_tipo_tarea" class="materialize-textarea" data-length="120" required=""></textarea>
                                        <label for="textarea1">Detalle de tipo tarea</label>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align" type="submit" value="Crear Tipo de Tarea " />
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
                                            <td>Tipo de Tarea</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsTareas.next()) {%>
                                        <tr>
                                            <td><%= rsTareas.getString("idTipoTarea")%></td>
                                            <td><%= rsTareas.getString("nombreTipoTarea")%></td>
                                            <td>
                                                <a href="gestorTipoTareasConfirmarEliminar.jsp?idTipoTarea=<%=rsTareas.getLong("idTipoTarea")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorTipoTareasModificar.jsp?idTipoTarea=<%=rsTareas.getLong("idTipoTarea")%>">
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
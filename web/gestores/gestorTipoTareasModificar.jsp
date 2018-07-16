<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%     
    String idTipoTarea = request.getParameter("idTipoTarea");

    ResultSet rsTipoTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tipo_tarea";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTipoTareas = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsTipoTareaSeleccionada = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tipo_tarea where idTipoTarea=" + idTipoTarea;
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTipoTareaSeleccionada = pst.executeQuery();
        rsTipoTareaSeleccionada.next();
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
                                <a>Modificar Tipo de Tarea</a> 
                                <form action="gestorTipoTareasModificarSub.jsp" method="post">
                                    <input name="idUsuario" value="<%= hs.getAttribute("idUsuarioSesion")%>" type="hidden"></td>
                                    <table>
                                        <tbody>
                                            <tr> 
                                                <td>Nombre Tipo de Tarea:</td>
                                                <td><input name="nombre_tipo_tarea" class="validate" required="" placeholder="<%= rsTipoTareaSeleccionada.getString("nombreTipoTarea")%>"></td>
                                        <input name="idTipoTarea" type="hidden" value="<%= rsTipoTareaSeleccionada.getString("idTipoTarea")%>">
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_tipo_tarea" class="materialize-textarea" data-length="120" required="" placeholder="<%= rsTipoTareaSeleccionada.getString("detalleTipoTarea")%>"></textarea>
                                        <label for="textarea1">Detalle tipo de tarea...</label>
                                    </div>
                                    <center>
                                        <input class="btn" type="submit" value="Modificar Tipo de Tarea" /><br/><br/>
                                        <a href="gestorTipoTareas.jsp" class="btn left-align">Cancelar</a>
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
                                        <% while (rsTipoTareas.next()) {%>
                                        <tr>
                                            <td><%= rsTipoTareas.getString("idTipoTarea")%></td>
                                            <td><%= rsTipoTareas.getString("nombreTipoTarea")%></td>
                                            <td>
                                                <a href="gestorTipoTareasConfirmarEliminar.jsp?idTipoTarea=<%=rsTipoTareas.getLong("idTipoTarea")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorTipoTareasModificar.jsp?idTipoTarea=<%=rsTipoTareas.getLong("idTipoTarea")%>">
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
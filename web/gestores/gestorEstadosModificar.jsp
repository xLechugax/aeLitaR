<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<% 
    String idEstado = request.getParameter("idEstado");

    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado where estado.idEstado != 5 and estado.idEmpresa = " + hs.getAttribute("idEmpresa") + " or estado.idEmpresa = 0 and estado.idEstado != 5";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstados = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
        return;
    }

    ResultSet rsEstadoSeleccionado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado where idEstado=" + idEstado;
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstadoSeleccionado = pst.executeQuery();
        rsEstadoSeleccionado.next();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
        return;
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="/aeLita/css/materialize.min.css"  media="screen,projection"/>
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
                                <a>Modificar Estado</a> 
                                <form action="/aeLita/gestorEstadosModificarSub" method="post"> <%-- Se implementa como Servlet --%>
                                    <input name="idUsuario" value="<%= hs.getAttribute("idUsuarioSesion")%>" type="hidden"></td>
                                    <table>
                                        <tbody>
                                            <tr> 
                                                <td>Nombre Estado:</td>
                                                <td><input name="nombre_estado" class="validate" required="" placeholder="<%= rsEstadoSeleccionado.getString("nombreEstado")%>"></td>
                                        <input name="idEstado" type="hidden" value="<%= rsEstadoSeleccionado.getString("idEstado")%>">
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_estado" class="materialize-textarea" data-length="120" required="" placeholder="<%= rsEstadoSeleccionado.getString("detalleEstado")%>"></textarea>
                                        <label for="textarea1">Detalle de estado</label>
                                    </div>
                                    <center>
                                        <input class="btn blue-grey darken-4" type="submit" value="Modificar Estado" /><br/><br/>
                                        <a href="gestorEstados.jsp" class="btn left-align blue-grey darken-4">Cancelar</a>
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
                                            <td>Estado</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsEstados.next()) {%>
                                        <tr>
                                            <td><%= rsEstados.getString("idEstado") %></td>
                                            <td><%= rsEstados.getString("nombreEstado") %></td>
                                            <td>
                                                <% if ( Integer.parseInt(rsEstados.getString("idEstado")) < 6 ) {%>
                                                <p class="grey-text">Estado B�sico<p>
                                                <% } else { %>
                                                    <!-- <a href="gestorEstadosConfirmarEliminar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>"> 
                                                        <img src="img/eliminar.png" title="Eliminar"/>
                                                    </a>--->
                                                    <a class="orange-text" href="gestorEstadosModificar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>">
                                                        <i class="material-icons tiny orange-text" title="Editar">edit</i>&nbsp;Editar
                                                    </a>
                                                <% } %>
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
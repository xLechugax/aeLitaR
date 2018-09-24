<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%
    String idEstado = request.getParameter("idEstado");

    ResultSet rsEstados = null;
    ResultSet rsEstadoSeleccionado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstados = pst.executeQuery();
        
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlTareaSeleccionada = "select * from estado where idEstado="+idEstado;
        PreparedStatement pstTipoTareaSeleccionada = conn.prepareCall(sqlTareaSeleccionada);
        rsEstadoSeleccionado = pstTipoTareaSeleccionada.executeQuery();
        rsEstadoSeleccionado.next();
        
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
                                <a>Confirmación de Eliminación</a> 
                                    <p class="center-align">¿<%= hs.getAttribute("nombre")%> estas seguro de querer eliminar el estado <%= rsEstadoSeleccionado.getString("nombreEstado")%>?</p>
                                    <center>
                                        <a class="btn" href="/aeLita/gestorEstadosEliminar?idEstado=<%= rsEstadoSeleccionado.getString("idEstado")%>">SI</a>
                                        <a class="btn" href="gestorEstados.jsp">NO</a>
                                    </center>
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
                                                <p class="grey-text">Estado Básico<p>
                                                <% } else { %>
                                                    <a href="gestorEstadosConfirmarEliminar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>">
                                                        <img src="img/eliminar.png" title="Eliminar"/>
                                                    </a>
                                                    <a href="gestorEstadosModificar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>">
                                                        <img src="img/modificar.jpg" title="Modificar"/>
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
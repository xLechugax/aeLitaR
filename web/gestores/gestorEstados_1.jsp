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

    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstados = pst.executeQuery();
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
                                <a>Crear Estados</a> 
                                <form action="gestorEstadosAgregar.jsp" method="post">
                                    <input name="idUsuario" value="<%= hs.getAttribute("idUsuarioSesion")%>" type="hidden"></td>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Nombre Estado:</td>
                                                <td><input name="nombre_estado" class="validate" required=""></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_estado" class="materialize-textarea" data-length="120" required=""></textarea>
                                        <label for="textarea1">Detalle de estado</label>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align" type="submit" value="Crear Estado" />
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
                                                <a href="gestorEstadosEliminar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorEstadosModificar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>">
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
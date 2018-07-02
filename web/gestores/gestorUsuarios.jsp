<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA
    // ABIERTA para el usuario.

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
    <%@ include file="accesoDenegado.jsp" %>
<%   
        return;
    }

    ResultSet rsUsuarios = null;

    String accion = request.getParameter("accion");
    int ava = 0;
    if (accion != null) {
        if (accion.equals("1")) {
            long idUsuario = Long.parseLong(request.getParameter("id"));

            // Recuperar el estado actual del registros del usuario.
            Connection conn = ConexionBD.getConexion();
 
            String sql = "select activo from usuario where idUsuario=?";
            PreparedStatement pst1 = conn.prepareStatement(sql);
            pst1.setLong(1, idUsuario);
            ResultSet rs1 = pst1.executeQuery();

            // Leer el estado del usuario, para cambiarlo por el contrario.
            rs1.next();
            if (rs1.getString("activo").equals("S")) {
                String sql2 = "update usuario set activo=? where idUsuario=?";
                PreparedStatement pst2 = conn.prepareStatement(sql2);
                pst2.setString(1, "N");
                pst2.setLong(2, idUsuario);
                pst2.execute();
            } else {
                String sql2 = "update usuario set activo=? where idUsuario=?";
                PreparedStatement pst2 = conn.prepareStatement(sql2);

                pst2.setString(1, "S");
                pst2.setLong(2, idUsuario);
                pst2.execute();
            }
        } else if (accion.equals("2")) {
            long idUsuario = Long.parseLong(request.getParameter("id"));
            String idUsuarioSesion = request.getParameter("id");

            //Impide la eliminiacion del Admin Principal.
            if (idUsuario == 1) {
                out.println("Error: no se puede eliminar al administrador principal.");
                //Impide la eliminacion del Admin actual.
            } else if (hs.getAttribute("idUsuarioSesion").equals(idUsuarioSesion)) {
                out.println("Error: no se puede eliminar al administrador en sesion.");
            } else {
                // Recuperar el estado actual del registros del usuario.
                Connection conn = ConexionBD.getConexion();
                String sql = "delete from usuario where idUsuario=?";
                PreparedStatement pst1 = conn.prepareStatement(sql);
                pst1.setLong(1, idUsuario);
                pst1.execute();
            }
        }
    }
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuarios = pst.executeQuery();
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
            <%@ include file="barraNav.jsp" %>
            <div class=""> 
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <table class="highlight bordered">
                                    <tr>
                                        <td>ID</td>
                                        <td>Nombre</td>
                                        <td>Nombre Usuario</td>
                                        <td>Dirección</td>
                                        <td>Correo</td>
                                        <td>Celular</td>
                                        <td>Fijo</td>
                                        <td>Área/Departamento</td>
                                        <td>Rol</td>
                                        <td>Activo</td>
                                        <td>Operaciones</td>
                                    </tr>            
                                    <% while (rsUsuarios.next()) {%>
                                    <tr>
                                        <td><%=rsUsuarios.getLong("idUsuario")%></td>
                                        <td><%=rsUsuarios.getString("nombre") + " " + rsUsuarios.getString("apellido")%></td>
                                        <td><%=rsUsuarios.getString("nombreUsuario")%></td>
                                        <td><%=rsUsuarios.getString("direccion")%></td>
                                        <td><%=rsUsuarios.getString("email")%></td>
                                        <td><%=rsUsuarios.getString("telefono_m")%></td>
                                        <td><%=rsUsuarios.getString("telefono_f")%></td>
                                        <td><%=rsUsuarios.getString("area_departamento")%></td>
                                        <td><%=rsUsuarios.getString("tipoCuenta")%></td>
                                        </td>
                                        <td><center>
                                            <a href="gestorUsuarios.jsp?accion=1&id=<%=rsUsuarios.getLong("idUsuario")%>">
                                                <%
                                                    if (rsUsuarios.getString("activo").equals("S")) {
                                                %>
                                                <img src="img/circuloverde.png" title="Desactivar" />
                                                <% } else { %>
                                                <img src="img/circulorojo.png" title="Activar"/>
                                                <% }%>  
                                            </a></center>
                                        </td>
                                        <td><center>
                                            <a href="gestorUsuarios.jsp?accion=2&id=<%=rsUsuarios.getLong("idUsuario")%>">
                                                <img src="img/eliminar.png" title="Eliminar"/>
                                            </a>
                                            &nbsp;
                                            <a href="FormModificacionUsuario.jsp?id=<%=rsUsuarios.getLong("idUsuario")%>">
                                                <img src="img/modificar.jpg" title="Modificar"/>
                                            </a></center>
                                        </td>
                                        </tr>
                                        <% }%>
                                </table>
                            </div>
                            <div class="container">  
                                <div class="row">
                                </div>  
                            </div>     
                        </div>
                    </div>
                </div>
            </div>
    </main>
    <%@ include file="../footer.jsp" %>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
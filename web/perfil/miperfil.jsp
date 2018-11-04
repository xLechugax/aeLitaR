<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %>
<%
    ResultSet rsUsuario = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario,area_departamento where usuario.area_departamento=area_departamento.idAreaDepartamento and usuario.idUsuario="+hs.getAttribute("idUsuarioSesion");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuario = pst.executeQuery();
        rsUsuario.next(); 
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsEmpresa = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select empresa.nombre from empresa where idEmpresa="+hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEmpresa = pst.executeQuery();
        rsEmpresa.next(); 
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
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Hola <%=hs.getAttribute("nombre")%>, estos son los datos de tu perfil</p>
                            </div>
                            <div class="container">
                                <table class="highlight">
                                    <tbody>
                                        <tr>
                                            <td><b>Empresa</b></td>
                                            <td><%= rsEmpresa.getString("nombre") %></td>
                                        </tr>
                                        <tr>
                                            <td><b>Nombre</b></td>
                                            <td><%= rsUsuario.getString("nombre") + " " + rsUsuario.getString("apellido")%></td>
                                        </tr>
                                        <tr>
                                            <td><b>Correo</b></td>
                                            <td><%= rsUsuario.getString("email")%></td>
                                        </tr>
                                        <tr>
                                            <td><b>Teléfono Fijo</b></td>
                                            <td><%= rsUsuario.getString("telefono_f")%></td>
                                        </tr>
                                        <tr>
                                            <td><b>Teléfono Móvil</b></td>
                                            <td><%= rsUsuario.getString("telefono_m")%></td>
                                        </tr>
                                        <tr>
                                            <td><b>Dirección</b></td>
                                            <td><%= rsUsuario.getString("direccion")%></td>
                                        </tr>
                                        <tr>
                                            <td><b>Área/Departamento</b></td>
                                            <td><%= rsUsuario.getString("nombreAreaDepartamento")%></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="collection">
                                    <a href="editar.jsp" class="collection-item center-align"><i class="tiny material-icons">edit</i>Editar</a>
                                </div>
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
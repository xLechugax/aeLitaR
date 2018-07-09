<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESI�N DEL USUARIO YA INICIADO

    ResultSet rsUsuario = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario,area_departamento where usuario.area_departamento=area_departamento.idAreaDepartamento and usuario.idUsuario="+hs.getAttribute("idUsuarioLogeado");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuario = pst.executeQuery();
        rsUsuario.next();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
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
                                            <td>Nombre:</td>
                                            <td><%= rsUsuario.getString("nombre") + " " + rsUsuario.getString("apellido")%></td>
                                        </tr>
                                        <tr>
                                            <td>Correo:</td>
                                            <td><%= rsUsuario.getString("email")%></td>
                                        </tr>
                                        <tr>
                                            <td>Tel�fono Fijo:</td>
                                            <td><%= rsUsuario.getString("telefono_f")%></td>
                                        </tr>
                                        <tr>
                                            <td>Tel�fono M�vil:</td>
                                            <td><%= rsUsuario.getString("telefono_m")%></td>
                                        </tr>
                                        <tr>
                                            <td>Direcci�n:</td>
                                            <td><%= rsUsuario.getString("direccion")%></td>
                                        </tr>
                                        <tr>
                                            <td>�rea/Departamento:</td>
                                            <td><%= rsUsuario.getString("nombreAreaDepartamento")%></td>
                                        </tr>
                                        <tr>
                                            <td>Clave:</td>
                                            <td>*****************</td>
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
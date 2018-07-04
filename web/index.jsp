<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESI”N YA ABIERTA PARA EL USUARIO.
    ResultSet rsUsuarios = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuarios = pst.executeQuery();
    } catch (SQLException e) {
        out.println("ExcepciÛn de SQL:" + e);
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
            <!INICIO - BARRA DE NAVEGACI”N FIXED>
        <ul class="side-nav" id="mobile-demo">
            <li><a href="/aeLita/registro/registrarNuevoUsuario.jsp">Registro</a></li>
        </ul>
        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper blue-grey darken-3">
                    <a href="#!" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;ÊLita</a>
                    <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                    <ul class="right hide-on-med-and-down">
                        <li><a href="/aeLita/registro/registrarNuevoUsuario.jsp">Registro</a></li>
                    </ul>
                </div>
            </nav>
        </div>
        <!FINAL - BARRA DE NAVEGACI”N FIXED>   
        <div class="container"> 
            <div class="col m3 m3">
                <div class="card horizontal">
                    <div class="card-image">
                    </div>
                    <div class="card-stacked">
                        <div class="card-content">
                            <p>Bienvenido a ÊLita.</p>
                        </div>
                        <div class="container">  
                            <div class="row">
                                <form class="col s12" action="/aeLita/validarUsuario.jsp">
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="nombreUsuario" id="nombreUsuario" type="text" class="validate" style="text-transform: uppercase" required="">
                                            <label>Nombre de Usuario</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="clave" id="claveUsuario" type="password" class="validate" required="">
                                            <label>ContraseÒa</label>
                                        </div>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn" type="submit" value="Ingresar" />
                                    </center>
                                </form>
                            </div>
                        </div>     
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
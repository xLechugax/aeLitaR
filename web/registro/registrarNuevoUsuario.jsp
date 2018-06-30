<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA ABIERTA PARA EL USUARIO.
    ResultSet rsUsuarios = null;
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
            <!INICIO - BARRA DE NAVEGACIÓN FIXED>
        <ul class="side-nav" id="mobile-demo">
            <li><a href="pagina.jsp">Registro</a></li>
        </ul>
        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper blue-grey darken-3">
                    <a href="#!" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
                    <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                </div>
            </nav>
        </div>
        <!FINAL - BARRA DE NAVEGACIÓN FIXED>   
        <div class="container"> 
            <div class="col m3 m3">
                <div class="card horizontal">
                    <div class="card-image">
                    </div>
                    <div class="card-stacked">
                        <br/><br/>  
                        <div class="container">  
                            <div class="row">
                                <form class="col s12">
                                    <div class="row">
                                        <div class="input-field col s6">
                                            <input id="first_name" type="text" class="validate" style="text-transform: uppercase">
                                            <label>Nombre</label>
                                        </div>
                                        <div class="input-field col s6">
                                            <input id="last_name" type="text" class="validate" style="text-transform: uppercase">
                                            <label>Apellido</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input id="correo" type="email" class="validate">
                                            <label>Correo</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s6">
                                            <input id="first_name" type="number" class="validate">
                                            <label>Teléfono Móvil</label>
                                        </div>
                                        <div class="input-field col s6">
                                            <input id="last_name" type="number" class="validate">
                                            <label>Teléfono Fijo</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input id="otro" type="text" class="validate">
                                            <label>Area / Departamento</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s6">
                                            <input id="password" type="password" class="validate">
                                            <label>Contraseña</label>
                                        </div>
                                        <div class="input-field col s6">
                                            <input id="password" type="password" class="validate">
                                            <label>Confirmar Contraseña</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input id="otro" type="text" class="validate">
                                            <label>Dirección</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input id="otro" type="text" class="validate">
                                            <label>Dirección</label>
                                            <p>
                                                <label>
                                                    <input name="group1" type="radio" checked />
                                                    <span>Red</span>
                                                </label>
                                            </p>
                                            <p>
                                                <label>
                                                    <input name="group1" type="radio" />
                                                    <span>Yellow</span>
                                                </label>
                                            </p>
                                            <p>
                                                <label>
                                                    <input class="with-gap" name="group1" type="radio"  />
                                                    <span>Green</span>
                                                </label>
                                            </p>
                                            <p>
                                                <label>
                                                    <input name="group1" type="radio" disabled="disabled" />
                                                    <span>Brown</span>
                                                </label>
                                            </p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>     
                        <div class="card-action">
                            <a class="waves-effect waves-light btn">Registrarse</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="/footer.jsp" %>
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
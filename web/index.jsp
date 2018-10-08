<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <!-- Modal Trigger -->
            <BR/>
            <a class="btn waves-effect waves-teal btn modal-trigger right" href="#modal1"><i class="material-icons left">help_outline</i>Ayuda</a>
            <div class="container"> 
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Bienvenido a æLita.</p>
                            </div>
                            <div class="container">  
                                <div class="row">
                                    <form class="col s12" action="/aeLita/validarUsuario.jsp" method="post">
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <input name="nombreUsuario" id="nombreUsuario" type="text" class="validate" style="text-transform: uppercase" required="">
                                                <label>Nombre de Usuario</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <input name="clave" id="claveUsuario" type="password" class="validate" required="">
                                                <label>Contraseña</label>
                                            </div>
                                        </div>
                                        <center>
                                            <input class="waves-effect waves-light btn" type="submit" value="Ingresar" />
                                        </center>
                                    </form>

                                    <!-- Modal Structure -->
                                    <div id="modal1" class="modal">
                                        <div class="modal-content">
                                            <h4>Ayuda</h4>
                                            <p>aeLita a creado su nombre de usuario en base a su nombre y apellido, debe ingresar de la siguiente manera: NOMBRE.APELLIDO</p>
                                            <BR/>
                                            <p>Ejemplo</p>
                                            <p>MARISOL.CARRASCO</p>
                                        </div>
                                        <div class="modal-footer">
                                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Gracias</a>
                                        </div>
                                    </div>
                                    <div id="RecuperarClave" class="modal">
                                        <div class="modal-content">
                                            <h4>Recuperar Contraseña</h4>
                                            <form action="#">

                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="nombreUsuario" id="nombreUsuario" type="email" class="validate" style="text-transform: uppercase" required="">
                                                        <label>Correo Electrónico</label>
                                                    </div>
                                                </div>
                                        </div>
                                        </form>
                                        <div class="modal-footer">
                                            <a href="#!" class="modal-close waves-effect waves-green btn-flat">Recuperar</a>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                        </div>
                    </div>
                </div>
            </div>
            <a class="btn waves-effect waves-teal btn modal-trigger right" href="#RecuperarClave"><i class="material-icons left">face</i>Recuperar Contraseña</a><br/><br/>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
        document.addEventListener('DOMContentLoaded', function () {
            var elems = document.querySelectorAll('.modal');
            var instances = M.Modal.init(elems, options);
        });

        // Or with jQuery

        $(document).ready(function () {
            $('.modal').modal();
        });
    </script>
</body>
</html>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESI�N YA ABIERTA PARA EL USUARIO.
%>  
<!DOCTYPE html>
<html>
    <head>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <!-- Modal Trigger -->
            <BR/>
            <a class="btn waves-effect waves-teal btn modal-trigger right blue-grey darken-3" href="#modal1"><i class="material-icons left">help_outline</i>Ayuda</a>
            <div class="container"> 
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Bienvenido a �Lita.</p>
                            </div>
                            <div class="container">  
                                <div class="row">
                                    <form class="col s12" action="validarUsuario.jsp" method="post">
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <input name="nombreUsuario" id="nombreUsuario" type="text" class="validate" style="text-transform: uppercase" required="">
                                                <label>Nombre de Usuario</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="input-field col s12">
                                                <input name="clave" id="claveUsuario" type="password" class="validate" required="">
                                                <label>Contrase�a</label>
                                            </div>
                                        </div>
                                        <center>
                                            <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Ingresar" />
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
                                            <p></p>
                                            <p>De igual forma puede ingresar con su correo electr�nico.</p>
                                        </div>
                                        <div class="modal-footer">
                                            <a href="#!" class="modal-close waves-effect waves-green btn-flat blue-grey darken-3 white-text">Gracias</a>
                                        </div>
                                    </div>
                                    <div id="RecuperarClave" class="modal">
                                        <div class="modal-content">
                                            <h4>Recuperar Contrase�a</h4>
                                            <form action="/aeLita/recuperarClave" method="post">

                                                <div class="row">
                                                    <div class="input-field col s12">
                                                        <input name="correo" id="nombreUsuario" type="email" class="validate" required="">
                                                        <label>Correo Electr�nico</label>
                                                    </div>
                                                </div>
                                                <center><input type="submit" class="waves-effect waves-green btn-flat blue-grey darken-3 white-text" value="Recuperar"> </center><br/>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>     
                        </div>
                    </div>
                </div>
            </div>
            <a class="btn waves-effect waves-teal btn modal-trigger right blue-grey darken-3" href="#RecuperarClave"><i class="material-icons left">face</i>Recuperar Contrase�a</a><br/><br/>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>
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
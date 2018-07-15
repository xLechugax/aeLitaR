<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

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
                                <form class="col s12" action="enviarContacto.jsp" method="post">
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="nombre" type="text" class="validate" required="">
                                            <label>Nombre</label>
                                        </div>
                                    </div> 
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="asunto" type="text" class="validate" required="">
                                            <label>Asunto</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="email" type="email" class="validate" required="">
                                            <label>Correo</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input placeholder="+56 " name="telefono" type="number" class="validate" required="">
                                            <label>Teléfono</label>
                                        </div>
                                    </div>
                                    <div class="input-field col s12">
                                        <textarea name="mensaje" class="materialize-textarea" data-length="520" required="" style="height: 300px"></textarea>
                                        <label for="textarea1">Cuéntanos, ¿Cuál es el problema...?</label>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn" type="submit" value="Enviar" />
                                    </center>
                                </form>
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
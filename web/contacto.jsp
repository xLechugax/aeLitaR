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
                                    <%if (hs == null || hs.getAttribute("tipoCuenta") == null){%> 
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="nombre" type="text" class="validate" required="">
                                            <label>Nombre</label>
                                        </div>
                                    </div>
                                    <%} else { 
                                    String nombre = ""+hs.getAttribute("nombre");
                                    String apellido = ""+hs.getAttribute("apellido");
                                    String nombreCompleto = nombre+" "+apellido;
                                    String idEmpresa = ""+hs.getAttribute("idEmpresa");
                                    String idUsuario = ""+hs.getAttribute("idUsuarioSesion");
                                    %>
                                    <div class="row">
                                        <input type="hidden" name="nombre" value="<%=nombreCompleto%>">
                                        <input type="hidden" name="idEmpresa" value="<%=idEmpresa%>">
                                        <input type="hidden" name="idUsuario" value="<%=idUsuario%>">

                                        <div class="input-field col s12">
                                            <input name="nombre" type="text" value="<%=nombreCompleto%>" class="validate" disabled="" required="">
                                            <label>Nombre</label>
                                        </div>
                                    </div> 
                                    <%}%>
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="asunto" type="text" class="validate" required="">
                                            <label>Asunto</label>
                                        </div>
                                    </div>
                                    <%if (hs == null || hs.getAttribute("tipoCuenta") == null){%> 
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="email" type="email" class="validate" required="">
                                            <label>Correo</label>
                                        </div>
                                    </div>
                                    <%} else {
                                    String correo = ""+hs.getAttribute("email");
                                    %>
                                    <div class="row">
                                        <input type="hidden" name="email" value="<%=correo%>">
                                        <div class="input-field col s12">
                                            <input name="email" type="email" class="validate" required="" value="<%=correo%>" disabled="">
                                            <label>Correo</label>
                                        </div>
                                    </div>
                                    <%}%>
                                    <%if (hs == null || hs.getAttribute("tipoCuenta") == null){%> 
                                    <div class="row">
                                        <div class="input-field col s12">
                                            <input name="telefono" type="number" class="validate" required="">
                                            <label>Teléfono</label>
                                        </div>
                                    </div>
                                    <%} else {
                                    String telefono = ""+hs.getAttribute("telefono");
                                    %>
                                    <div class="row">
                                        <input type="hidden" name="telefono" value="<%=telefono%>">
                                        <div class="input-field col s12">
                                            <input name="telefono" type="text" class="validate" required="" disabled="" value="<%=telefono%>">
                                            <label>Teléfono</label>
                                        </div>
                                    </div>
                                    <%}%>
                                    <div class="input-field col s12">
                                        <textarea name="mensaje" class="materialize-textarea" data-length="520" required="" style="height: 300px"></textarea>
                                        <label for="textarea1">Cuéntanos, ¿Cuál es el problema o sugerencia...?</label>
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
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
                        <div class="row">
                    <div class="col s12 m12">
                      <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <p>Bienvenido a æLita <%=hs.getAttribute("nombre")%>.</p>
                            <h5 class="white-text">Links de Útilidad</h5>
                                <ul>
                                    <li><a class="grey-text text-lighten-3" href="http://172.17.40.45/plataforma_datos/vis_equipos_datoslist.asp?cmd=resetall"><i class="material-icons">router</i>Equipos Actualizados</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://despachonacional.cl/despachonacional/siad_pyme/index.php/Login"><i class="material-icons">dashboard</i>SIAD Pyme</a></li>
                                    <li><a class="grey-text text-lighten-3" href="https://macvendors.com/"><i class="material-icons">fingerprint</i>MacVendors</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://10.41.4.141/sac/Login_input"><i class="material-icons">keyboard</i>HFC Incognito</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://agenda/Organigrama/"><i class="material-icons">local_phone</i>Organigrama</a></li>
                                </ul>
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
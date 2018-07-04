<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    if (hs == null || hs.getAttribute("tipoCuenta") == null) {
%>
<%@ include file="../../accesoDenegado.jsp" %>
<%        
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
            <%@ include file="../../barraNav.jsp" %>
            <div class="container"> 
            <div class="row">
                    <div class="col s12 m12">
                      <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                            <h5 class="white-text">Escalamientos</h5>
                                <ul>
                                    <li><a class="grey-text text-lighten-3" href="../escalamientos/ENTEL.PDF"><i class="material-icons">picture_as_pdf</i>Escalamientos Entel</a></li>
                                    <li><a class="grey-text text-lighten-3" href="../escalamientos/MOVISTAR.PDF"><i class="material-icons">picture_as_pdf</i>Escalamientos Movistar</a></li>
                                    <li><a class="grey-text text-lighten-3" href="../escalamientos/GTD.PDF"><i class="material-icons">picture_as_pdf</i>Escalamientos GTD</a></li>
                                    <li><a class="grey-text text-lighten-3" href="../escalamientos/INOC.PDF"><i class="material-icons">picture_as_pdf</i>Escalamientos INOC</a></li>
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
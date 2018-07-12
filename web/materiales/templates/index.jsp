<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    if (hs == null || hs.getAttribute("tipoCuenta") == null) {
%>
<%@ include file="../../accesoDenegado.jsp" %>
<%        return;
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0"  charset="iso-8859-1"/>
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
                <div class="col s12 m12">
                    <div class="card blue-grey darken-1">
                        <div class="card-content white-text">
                            <div class="row">
                                <div class="col s6 m6">
                                    <h5 class="white-text">Templates</h5>    
                                    <ul>
                                        <li><a class="grey-text text-lighten-3" href="maestra.xlsx" target="_blank"><i class=material-icons>picture_as_pdf</i>Planitalla Templates Actualizados</a></li>
                                        <li><a class="grey-text text-lighten-3" href="Cierre con EDAC.txt" target="_blank"><i class=material-icons>picture_as_pdf</i>T. Cierre con EDAC</a></li>
                                        <li><a class="grey-text text-lighten-3" href="PBX 2018.xls" target="_blank"><i class=material-icons>picture_as_pdf</i>T. Plantilla PBX 2018</a></li>
                                        <li><a class="grey-text text-lighten-3" href="Sonda.txt" target="_blank"><i class=material-icons>picture_as_pdf</i>T. Sonda</a></li>
                                        <li><a class="grey-text text-lighten-3" href="Suministro.txt" target="_blank"><i class=material-icons>picture_as_pdf</i>T. Suministro</a></li>
                                    </ul>    
                                </div>
                                <div class="col s6 m6">
                                    <br/><br/>
                                    <ul>
                                        <li><a class="grey-text text-lighten-3" href="T Planta Interna.txt" target="_blank"><i class=material-icons>picture_as_pdf</i>T. Planta Interna</a></li>
                                        <li><a class="grey-text text-lighten-3" href="T Proveedores.txt" target="_blank"><i class=material-icons>picture_as_pdf</i>T. Proveedores</a></li>
                                    </ul>
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
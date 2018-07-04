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
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <div class="row">
                                    <div class="col s1 m1"></div>
                                    <div class="col s5 m5">
                                        <h5>Planta Externa</h5>
                                        <ul>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Rene - 59070004</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Alex - 77935843</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Juan - 98634924</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Ferrada - 98651103</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Victor - 96097169</a></li>
                                        </ul>
                                        <h5 class="white-text">Proveedores</h5>
                                        <ul>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Movistar - 28989926</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Telsur - 800600750</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Entel - 800104123</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>GTD - 24139205</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>GTD Tec. 24139960</a></li>
                                        </ul>
                                    </div>
                                    <div class="col s6 m6">
                                        <h5>Anexos</h5>
                                        <ul>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Sebastian Cancino- 42149</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Daniel Arenas - 42139</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Camilo Yañez - 42138</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Oriel Pincheira - 42137</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Rodrigo Carreño - 42135</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Gisselle San Martin - 42132</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Fernando San Juan - 42131</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Patricio Contreras - 42130</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Manuel Garate - 42129</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Claudio Espinoza - 42128</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Alonso Pineda - 42127</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Simon Nahuelan - 42121</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Jorge Salgado - 42115</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Alvaro Soto  - 42109</a></li>
                                        </ul>
                                        <h5>Sonda</h5>
                                        <ul>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Cesar Astudillo 6575687 | 79097758</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Arturo Venegas 6575689 | 87745359</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Sebastian Hermosilla 6575695</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Nicolas Marambio 6575688 | 79097948</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Eduardo Diaz 6575679 | 79478904</a></li>
                                            <li><a class="text-lighten-3"><i class=material-icons>telephone</i>Jose Miranda 6575692 | 79097013</a></li>
                                        </ul>
                                    </div>
                                    <div class="col s4 m4">
                                    </div>
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
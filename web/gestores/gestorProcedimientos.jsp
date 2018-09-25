<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %>
<%
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
                                <p>Gestión de Procedimientos</p>
                            </div>
                            <div class="container">  
                                <div class="row">
                                    <ul id="tabs-swipe-demo" class="tabs">
                                        <li class="tab col s3"><a href="#test-swipe-1">Test 1</a></li>
                                        <li class="tab col s3"><a class="active" href="#test-swipe-2">Test 2</a></li>
                                        <li class="tab col s3"><a href="#test-swipe-3">Test 3</a></li>
                                    </ul>
                                    <div id="test-swipe-1" class="col s12 blue">Test 1</div>
                                    <div id="test-swipe-2" class="col s12 red">Test 2</div>
                                    <div id="test-swipe-3" class="col s12 green">Test 3</div>
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
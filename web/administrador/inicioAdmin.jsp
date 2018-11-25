<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp"%>
<%    if (hs.getAttribute("idEmpresa") == null) { //Setear el HS unicamente si viene null, o sea, recien iniciando la sessi�n
        String idEmpresa = request.getParameter("idEmpresa"); // Toma el ID de la empresa y lo deja en el HS
        hs.setAttribute("idEmpresa", idEmpresa);
    }

    Connection conn = ConexionBD.getConexion();
    //Activa de manera global los Eventos
    String sqlActivarEventosEnMySQL = "SET GLOBAL event_scheduler = ON";
    PreparedStatement pstActivarEventosEnMySQL = conn.prepareStatement(sqlActivarEventosEnMySQL);
    pstActivarEventosEnMySQL.execute();
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
                <div class="row">
                    <div class="col s12 m12">
                        <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <p>Bienvenido a �Lita <%=hs.getAttribute("nombre")%>.</p>
                                <h5 class="white-text">Links de �tilidad</h5>
                                <ul>
                                    <li><a class="grey-text text-lighten-3" href="http://172.17.40.45/plataforma_datos/vis_equipos_datoslist.asp?cmd=resetall" target="_blank"><i class="material-icons">router</i>Equipos Actualizados</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://despachonacional.cl/despachonacional/siad_pyme/index.php/Login" target="_blank"><i class="material-icons">dashboard</i>SIAD Pyme</a></li>
                                    <li><a class="grey-text text-lighten-3" href="https://macvendors.com/" target="_blank"><i class="material-icons">fingerprint</i>MacVendors</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://10.41.4.141/sac/Login_input" target="_blank"><i class="material-icons">keyboard</i>HFC Incognito</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://agenda/Organigrama/"  target="_blank"><i class="material-icons">local_phone</i>Organigrama</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://200.27.8.220/acceso.php"  target="_blank"><i class="material-icons">accessibility</i>ID Ingreso a Nodo</a></li>
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
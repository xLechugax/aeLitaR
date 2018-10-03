<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %>
<%    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstados = pst.executeQuery();
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
            <div class="row">
                <div class="col m4">
                    <% if (hs.getAttribute("tipoCuenta").equals("Ejecutor")) { %>
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Detalle del Procedimiento</div>
                            <div class="collapsible-body white"></div>
                        </li>
                    </ul>
                    <%} else {%>
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Detalle del Procedimiento</div>
                            <div class="collapsible-body white"><span>...</span></div> 
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">place</i>Agregar Actividad</div>
                            <div class="collapsible-body white">
                                <div class="input-field col s12">
                                    <input id="last_name" type="text" class="validate">
                                    <label for="last_name">Nombre de Actividad</label>
                                </div>


                                <div class="input-field col s12">
                                    <textarea id="textarea1" class="materialize-textarea" style="height: 150px;"></textarea>
                                    <label for="textarea1">Detalle Actividad</label>
                                </div>

                                <div class="file-field input-field col s12">
                                    <div class="btn">
                                        <span>File</span>
                                        <input type="file" multiple>
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input class="file-path validate" type="text" placeholder="Selecciones archivos...">
                                    </div>
                                </div>
                                <center>
                                    <input class="waves-effect waves-light btn right-align" type="submit" value="Agregar Actividad" />
                                </center>
                            </div>
                        </li>
                    </ul>
                    <%}%>
                </div>
                <div class="col m8">
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_drama</i>Actividad I</div>
                            <div class="collapsible-body white"><span>...</span></div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">place</i>Actividad II</div>
                            <div class="collapsible-body white"><span>...</span></div>
                        </li>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">whatshot</i>Actividad III</div>
                            <div class="collapsible-body white"><span>...</span></div>
                        </li>
                    </ul>
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
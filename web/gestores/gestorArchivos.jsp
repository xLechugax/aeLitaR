<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
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
                <div class="col m3">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Filtro de Busqueda</a> 
                                <br/>
                                <form action="#">
                                    <p>
                                    <div class="input-field col m12">
                                        <input id="nombreArchivo" type="text" class="validate">
                                        <label for="last_name">Nombre de Archivo</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="OrdendeTrabajo">
                                        <label for="OrdendeTrabajo">Orden de Trabajo</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Tarea">
                                        <label for="Tarea">Tarea</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Avance">
                                        <label for="Avance">Avance</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Procedimiento">
                                        <label for="Procedimiento">Procedimiento</label>
                                    </div>
                                    </p>
                                    <p>
                                    <div>
                                        <input type="checkbox" id="Actividad">
                                        <label for="Actividad">Actividad</label>
                                    </div>
                                    </p>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align" type="submit" value="buscar" />
                                    </center>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col m9">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Archivos</a> 
                                <table border="1">
                                    <tbody>
                                        <tr>
                                            <td><b>idArchivo</b></td>
                                            <td><b>Avance</b></td>
                                            <td><b>Tarea</b></td>
                                            <td><b>OT</b></td>
                                            <td><b>Procedimiento</b></td>
                                            <td><b>Nombre</b></td>
                                            <td><b>Detalle</b></td>
                                            <td><b>Archivo</b></td>
                                            <td><b>Operaciones</b></td>
                                        </tr>
                                    </tbody>
                                </table>
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
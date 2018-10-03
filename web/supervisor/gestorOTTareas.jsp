<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %>
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
                <div class="col m12">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                
                                <a>Tareas</a> 
                                <br/>
                                <form action="#" method="post">
                                    <div class="input-field col  m2">
                                        <select class="icons" name="idEstadoFiltro">
                                            <option value="" disabled selected>Seleccione Estado</option>
                                            <% while (rsEstados.next()) {%>                                                  
                                            <option value="<%= rsEstados.getString("idEstado")%>"><%= rsEstados.getString("nombreEstado")%></option>
                                            <%}%>
                                        </select>
                                        <label>Estado</label>
                                    </div>
                                    <div class="input-field col m2">
                                        <select class="icons" name="importanciaFiltro">
                                            <option value="" disabled selected>Seleccione Importancia</option>
                                            <option value="Alta">Alta</option>
                                            <option value="Media">Media</option>
                                            <option value="Baja">Baja</option>
                                        </select>
                                        <label>Importancia</label>
                                    </div>
                                    <div class="input-field col m1">
                                        <input class="waves-effect waves-light btn" type="submit" value="Filtrar" />
                                    </div>
                                </form><br/><br/><br/>
                                <table border="1">
                                    <tbody>
                                        <tr>
                                            <td><b>idTarea</b></td>
                                            <td><b>Tipo</b></td>
                                            <td><b>Orden de Trabajo</b></td>
                                            <td><b>Usuario</b></td>
                                            <td><b>Fecha Inicio</b></td>
                                            <td><b>Fecha Fin</b></td>
                                            <td><b>Estado</b></td>
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
            $('select').material_select();
        });
    </script>
</body>
</html>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%  ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlEstados = "select * from estado";
        PreparedStatement pstEstados = conn.prepareStatement(sqlEstados);
        rsEstados = pstEstados.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsResponsable = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlResponsable = "select * from usuario where tipoCuenta='Supervisor'"; 
        PreparedStatement pstResponsable = conn.prepareStatement(sqlResponsable);
        rsResponsable = pstResponsable.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsAsignado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAsignado = "select * from usuario where tipoCuenta='Ejecutor'";
        PreparedStatement pstAsignado = conn.prepareStatement(sqlAsignado);
        rsAsignado = pstAsignado.executeQuery();
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
            <div class="col m12 m12">
                <div class="card horizontal">
                    <div class="card-image">
                    </div>
                    <div class="card-stacked">
                        <div class="card-content">
                            <div class="row">
                                <div class="input-field col  m2">
                                    <a class="btn" href="gestorOTGenerar.jsp">Generar Órden de Trabajo</a> 
                                </div>
                                <form>
                                    <div class="input-field col  m2">
                                        <select class="icons">
                                            <option value="" disabled selected>Seleccione Estado</option>
                                            <% while (rsEstados.next()) {%>                                                  
                                            <option value="<%= rsEstados.getString("idEstado")%>"><%= rsEstados.getString("nombreEstado")%></option>
                                            <%}%>
                                        </select>
                                        <label>Estado</label>
                                    </div>
                                    <div class="input-field col  m2">
                                        <select class="icons">
                                            <option value="" disabled selected>Seleccione Responsable</option>
                                            <% while (rsResponsable.next()) {%>                                                  
                                            <option value="<%= rsResponsable.getString("idUsuario")%>"><%= rsResponsable.getString("nombreUsuario")%></option>
                                            <%}%>
                                        </select>
                                        <label>Responsable</label>
                                    </div>
                                    <div class="input-field col  m2">
                                        <select class="icons">
                                            <option value="" disabled selected>Seleccione Asignado</option>
                                            <% while (rsAsignado.next()) {%>                                                  
                                            <option value="<%= rsAsignado.getString("idUsuario")%>"><%= rsAsignado.getString("nombreUsuario")%></option>
                                            <%}%>
                                        </select>
                                        <label>Asignado</label>
                                    </div>
                                    <div class="input-field col m2">
                                        <select class="icons">
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
                                </form>
                            </div>
                        </div>
                        <div class="container">  
                            <div class="row">

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
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
    
    String idEstadoFiltro = request.getParameter("idEstadoFiltro");
    String importanciaFiltro = request.getParameter("importanciaFiltro");
    String idUsuarioFiltro = request.getParameter("idUsuarioFiltro");
    
    ResultSet rsOrdenesTrabajo = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAsignado = "select orden_trabajo.idOrdenTrabajo, "
                + "estado.nombreEstado, "
                + "orden_trabajo.importancia, "
                + "orden_trabajo.nombreOrdenTrabajo, "
                + "usuario.nombreUsuario as supervisor,"
                + "orden_trabajo.fecha_inicio "
                + "from orden_trabajo,usuario,estado "
                + "where orden_trabajo.supervisor = usuario.idUsuario "
                + "and orden_trabajo.estado = estado.idEstado and usuario.idUsuario";
        
        if (idUsuarioFiltro != null) { 
            sqlAsignado = sqlAsignado+" and orden_trabajo.supervisor = '"+idUsuarioFiltro+"'";
        }
        if (idEstadoFiltro != null) { 
            sqlAsignado = sqlAsignado+" and orden_trabajo.estado = '"+idEstadoFiltro+"'";
        }
        if (importanciaFiltro != null) {
            sqlAsignado = sqlAsignado+" and orden_trabajo.importancia ='"+importanciaFiltro+"'";
        }
        
        System.out.println(idEstadoFiltro+" + "+importanciaFiltro);
        
        PreparedStatement pstOrdenesTrabajo = conn.prepareStatement(sqlAsignado);
        rsOrdenesTrabajo = pstOrdenesTrabajo.executeQuery();
        
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
                                <div class="input-field col  m3">
                                    <a class="btn" href="#">Generar Órden de Trabajo</a> 
                                </div>
                                <form action="gestorOT.jsp" method="post">
                                    <div class="input-field col  m2">
                                        <select class="icons" name="idEstadoFiltro">
                                            <option value="" disabled selected>Seleccione Estado</option>
                                            <% while (rsEstados.next()) {%>                                                  
                                            <option value="<%= rsEstados.getString("idEstado")%>"><%= rsEstados.getString("nombreEstado")%></option>
                                            <%}%>
                                        </select>
                                        <label>Estado</label>
                                    </div>
                                    <div class="input-field col  m3">
                                        <select class="icons" name="idUsuarioFiltro">
                                            <option value="" disabled selected>Seleccione Supervisor</option>
                                            <% while (rsResponsable.next()) {%>                                                  
                                            <option value="<%= rsResponsable.getString("idUsuario")%>"><%= rsResponsable.getString("nombreUsuario")%></option>
                                            <%}%>
                                        </select>
                                        <label>Supervisor</label>
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
                                </form>
                            </div>
                        </div>
                        <table>
                            <thead>
                            <td class="center-align"><b>ID</b></td>
                            <td><b>Estado</b></td>
                            <td class="center-align"><b>Importancia</b></td>
                            <td><b>Orden de Trabajo</b></td>
                            <td><b>Supervisor</b></td>
                            <td><b>Fecha Inicio</b></td>
                            <td><b>Operaciones</b></td>
                            </thead>
                            <% while (rsOrdenesTrabajo.next()) {%>
                            <tbody>
                            <td class="center-align"><b><%= rsOrdenesTrabajo.getString("idOrdenTrabajo")%></b></td>
                            <td><%= rsOrdenesTrabajo.getString("nombreEstado")%></td>
                            <td>
                                <% if (rsOrdenesTrabajo.getString("importancia").equals("Alta")) {%><p class="red-text center-align"><%=rsOrdenesTrabajo.getString("importancia")%><p> <%} %>
                                <% if (rsOrdenesTrabajo.getString("importancia").equals("Media")) {%><p class="orange-text center-align"><%=rsOrdenesTrabajo.getString("importancia")%><p> <%} %>
                                <% if (rsOrdenesTrabajo.getString("importancia").equals("Baja")) {%><p class="green-text center-align"><%=rsOrdenesTrabajo.getString("importancia")%><p> <%} %>
                            </td>
                            <td><%= rsOrdenesTrabajo.getString("nombreOrdenTrabajo")%></td>
                            <td><%= rsOrdenesTrabajo.getString("supervisor")%></td>
                            <td><%= rsOrdenesTrabajo.getString("fecha_inicio")%></td>
                            <td><a href="#" class="btn">Detalle</a></td>
                            </tbody>
                            <%}%>
                        </table>
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
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %>
<%    
    
    String idProcedimiento = request.getParameter("idProcedimiento");

    ResultSet rsProcedimientoSeleccionado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from procedimiento where idProcedimiento=" + idProcedimiento + " and procedimiento.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsProcedimientoSeleccionado = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsActividades = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from actividad where idProcedimiento=" + idProcedimiento + " and actividad.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsActividades = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsActividadesContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select count(*) from actividad where idProcedimiento=" + idProcedimiento + " and actividad.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsActividadesContador = pst.executeQuery();
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
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Detalle del Procedimiento</div>
                            <div class="collapsible-body white">
                                <% rsProcedimientoSeleccionado.next();%>
                                Nombre:  <%= rsProcedimientoSeleccionado.getString("nombreProcedimiento")%><br/>
                                Detalle: <%= rsProcedimientoSeleccionado.getString("detalleProcedimiento")%>
                                Detalle: <%= hs.getAttribute("tipoCuenta")%>
                            </div> 
                        </li>
                        <% if ( hs.getAttribute("tipoCuenta").equals("Supervisor") || hs.getAttribute("tipoCuenta").equals("Administrador")) {%>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">place</i>Agregar Actividad</div>
                            <div class="collapsible-body white">
                                <form action="/aeLita/gestorProcedimientosAgregarActividad" method="post">
                                    <input type="hidden" name="idProcedimiento" value="<%= idProcedimiento%>">
                                    <div class="input-field col s12">
                                        <input id="nombreActividad" name="nombreActividad" type="text" class="validate" required="">
                                        <label for="nombreActividad">Nombre de Actividad</label>
                                    </div>
                                    <div class="input-field col s12">
                                        <textarea id="detalleActividad" name="detalleActividad" class="materialize-textarea" style="height: 150px;" required=""></textarea>
                                        <label for="detalleActividad">Detalle Actividad</label>
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
                                </form>
                            </div>
                        </li>
                        <%}%>
                    </ul>
                </div>
                <div class="col m8">
                    <ul class="collapsible" data-collapsible="accordion">
                        <% rsActividadesContador.next();
                            int CantidadActividades = rsActividadesContador.getInt(1);
                            if (CantidadActividades >= 1) {%>
                        <% while (rsActividades.next()) {%>
                        <li>
                            <div class="collapsible-header"><i class="material-icons">filter_drama</i><%= rsActividades.getString("nombreActividad")%></div>
                            <div class="collapsible-body white"><span><%= rsActividades.getString("detalleActividad")%></span></div>
                        </li>
                        <%}%>
                        <%} else {%>
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i><text class="orange-text">Sin actividades...</text></div>
                            <div class="collapsible-body white"><span class="red-text">Aún no son asociadas actividades...</span></div>
                        </li>
                        <%}%>
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
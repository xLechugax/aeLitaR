<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%    
    ResultSet rsProcedimientos = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlProcedimientos = "select procedimiento.idProcedimiento, procedimiento.nombreProcedimiento, DATE_FORMAT(procedimiento.fecha_creacion, '%d/%m/%Y %T') as fecha_creacion from procedimiento where procedimiento.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pstProcedimientos = conn.prepareStatement(sqlProcedimientos);
        rsProcedimientos = pstProcedimientos.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
    ResultSet rsProcedimientosContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlProcedimientos = "select procedimiento.idProcedimiento, procedimiento.nombreProcedimiento, DATE_FORMAT(procedimiento.fecha_creacion, '%d/%m/%Y %T') as fecha_creacion from procedimiento where procedimiento.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pstProcedimientos = conn.prepareStatement(sqlProcedimientos);
        rsProcedimientosContador = pstProcedimientos.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="/aeLita/css/materialize.min.css"  media="screen,projection"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <div class="row">
                <div class="col m12">
                    <ul class="collapsible">
                        <li>
                            <div class="collapsible-header active"><i class="material-icons">filter_drama</i>Procedimientos</div>
                            <div class="collapsible-body white">
                                <!-- Modal Trigger -->
                                <a class="btn-floating btn-large waves-effect waves-light red right-aligned modal-trigger" href="#agregarProcedimiento"><i class="material-icons">add</i></a>&nbsp;&nbsp;<b>Agregar Procedimiento</b>
                                <!-- Modal Structure -->
                                <div id="agregarProcedimiento" class="modal modal-fixed-footer">
                                    <form action="/aeLita/gestorProcedimientosAgregar" method="post">
                                        <div class="modal-content">
                                            <h4>Agregar Procedimiento</h4>
                                            <br/> 
                                            <div class="input-field col6 m6">
                                                <input id="nombreProcedimiento" type="text" name="nombreProcedimiento" class="validate">
                                                <label for="nombreProcedimiento">Nombre del Procedimiento</label>
                                                <div class="input-field">
                                                    <textarea name="detalleProcedimiento" style="height: 200px" id="detalleProcedimiento" required="" class="materialize-textarea"></textarea>
                                                    <label for="detalleProcedimiento" ><b>Detalle de Procedimiento</b></label> 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Crear Procedimiento" />
                                        </div>
                                    </form>
                                </div>
                                <% if (rsProcedimientosContador.next()) {%>
                                <table class="highlight bordered">
                                    <td class="center-align"><b>ID</b></td>
                                    <td><b>Nombre Procedimiento</b></td>
                                    <td><b>Fecha Creación</b></td>
                                    <td><b>Operaciones</b></td>
                                    <% while (rsProcedimientos.next()) {%>                                                
                                    <tbody>
                                        <td><%= rsProcedimientos.getString("idProcedimiento")%></td>
                                        <td><%= rsProcedimientos.getString("nombreProcedimiento")%></td>
                                        <td><%= rsProcedimientos.getString("fecha_creacion")%></td>
                                        <td><a href="/aeLita/gestores/gestorProcedimientosDetalle.jsp?idProcedimiento=<%= rsProcedimientos.getString("idProcedimiento")%>" class="btn blue-grey darken-3">Detalle</a></td>
                                    </tbody> 
                                    <%}%>
                                </table>
                                <%} else {%>
                                <br/>
                                <br/> 
                                <text class="orange-text">No se han agregado procedimientos...</text>
                                <%}%>
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
                                    $('.modal').modal();
                                });
                            </script>
                            </body>
                            </html>
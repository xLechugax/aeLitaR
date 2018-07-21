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
        out.println("Excepci�n de SQL:" + e);
        return;
    }
    ResultSet rsResponsable = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlResponsable = "select * from usuario where tipoCuenta='Supervisor'";
        PreparedStatement pstResponsable = conn.prepareStatement(sqlResponsable);
        rsResponsable = pstResponsable.executeQuery();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
        return;
    }
    ResultSet rsAsignado = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAsignado = "select * from usuario";
        PreparedStatement pstAsignado = conn.prepareStatement(sqlAsignado);
        rsAsignado = pstAsignado.executeQuery();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
        return;
    }
    ResultSet ContadorTipoTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlTipoTareas = "select * from tipo_tarea";
        PreparedStatement pstTipoTarea = conn.prepareStatement(sqlTipoTareas);
        ContadorTipoTareas = pstTipoTarea.executeQuery();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
        return;
    }
    ResultSet rsTipoTareas = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlTipoTareas = "select * from tipo_tarea";
        PreparedStatement pstTipoTarea = conn.prepareStatement(sqlTipoTareas);
        rsTipoTareas = pstTipoTarea.executeQuery();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
        return;
    }
    ResultSet rsTipoTareasContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlTipoTareas = "select * from tipo_tarea";
        PreparedStatement pstTipoTarea = conn.prepareStatement(sqlTipoTareas);
        rsTipoTareasContador = pstTipoTarea.executeQuery();
    } catch (SQLException e) {
        out.println("Excepci�n de SQL:" + e);
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
                <div class="col s12 m12">
                    <div class="card">
                        <div class="card-action">
                            <a>Generar Orden de Trabajo</a> 
                        </div>
                        <div class="row">
                            <form action="gestorOTGenerarSub.jsp" >
                                <div class="col m5">
                                    <table>
                                        <tr>
                                            <td><b>Importancia</b></td>
                                            <td><select name="importancia" class="icons" required="">
                                                    <option value="" disabled selected>Seleccione Importancia</option>
                                                    <option value="Alta">Alta</option>
                                                    <option value="Media">Media</option>
                                                    <option value="Baja">Baja</option>
                                                </select>
                                                <label for="importancia">asdasd</label></td>
                                        </tr>
                                        <tr>
                                            <td><b>Nombre Solicitud</b></td>
                                            <td><div class="input-field">
                                            <input name="nombreOT" type="text" class="validate" required="">
                                        </div></td>    
                                        </tr>
                                        <tr>
                                            <td><b>Supervisor</b></td> 
                                            <td>
                                                <select class="icons" required="" name="idSupervisor">
                                                    <option value="" disabled selected>Seleccione Supervisor</option>
                                                    <% while (rsResponsable.next()) {%>                                                  
                                                    <option value="<%= rsResponsable.getString("idUsuario")%>"><%= rsResponsable.getString("nombreUsuario")%></option>
                                                    <%}%>
                                                </select>
                                            </td>    
                                        </tr>
                                    </table>
                                    <%--<div class="card-content">
                                        <div class="file-field input-field">
                                            <div class="btn">
                                                <span>Archivos</span>
                                                <input type="file" multiple>
                                            </div>
                                            <div class="file-path-wrapper">
                                                <input class="file-path validate" type="text" placeholder="Subir uno o m�s archivos">
                                            </div>
                                        </div>            
                                        <b>Tareas</b>  
                                        <% if (rsTipoTareasContador.next() == false) {%>
                                        <br/><p class="red-text">No se han ingresado Tipos de Tareas, favor contactese con el administrador...</p>
                                        <% } else {
                                            Connection connn = ConexionBD.getConexion();
                                            int tareaNumero = 1;
                                            while (rsTipoTareas.next()) {%> 
                                        <p> 
                                            <input type="checkbox" id="<%= rsTipoTareas.getString("idTipoTarea")%>"/>

                                            <label for="<%= rsTipoTareas.getString("idTipoTarea")%>">
                                                <%= rsTipoTareas.getString("nombreTipoTarea")%> 
                                            </label>
                                        </p>
                                        <%
                                            Statement stmt = connn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            Statement stmt2 = connn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                            ResultSet rsUsuarioDropDown = stmt.executeQuery("SELECT * from usuario where tipoCuenta='Ejecutor'");
                                            ResultSet rsUsuarioDropDownCantidad = stmt2.executeQuery("SELECT * from usuario where tipoCuenta='Ejecutor'");
                                        %>
                                        <select class="icons" name="idUsuarioSeleccionado<%= tareaNumero%>">
                                            <option value="" disabled selected>Seleccione Asignado para <%= rsTipoTareas.getString("nombreTipoTarea")%></option>
                                            <% while (rsUsuarioDropDown.next()) {%>
                                            <option value="<%= rsUsuarioDropDown.getString("idUsuario") %>"><%= rsUsuarioDropDown.getString("nombreUsuario")%></option>
                                            <% }
                                            %>
                                        </select>
                                        <% tareaNumero++;
                                            }
                                        %>
                                    </div>--%>
                                </div>
                                <div class="col m7">
                                    <div class="card-content">
                                        <div class="row">
                                            <div class="input-field">
                                                <textarea name="detalleOT" style="height: 300px" id="textarea1" required="" class="materialize-textarea" placeholder="Se solicita a todos los participantes de la Orden de Trabajo terminar sus tareas a tiempo.

A continuaci�n se detallan los archivos de apoyo que deben ser modificados:

1.- Gesti�n de Cambios.pdf -- Pablo Flores
2.- Gesti�n de Aranceles.xlxs -- Vicente Arriagada
3.- Informe T�cnico PRRT.doc -- David Aravena
4.- Acta de aceptaci�n.pdf -- Lisa Alfredo

Cada uno de ellos debe de ser completado por los participantes en sus respectivas tareas designadas.
"></textarea>
                                                <label for="textarea1"><b>Detalle de solicitud...</b></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="center-align">
                                    <input class="waves-effect waves-light btn" type="submit" value="Generar OT" />
                                </div>
                                <br/>
                                <%--<%}%>--%>
                            </form>
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
            $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});
        });
    </script>
</body>
</html>
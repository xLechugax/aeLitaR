<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%   
    ResultSet rsResponsable = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlResponsable = "select usuario.idUsuario, usuario.nombreUsuario from usuario,trabaja where trabaja.idUsuario = usuario.idUsuario and  usuario.tipoCuenta= 'Supervisor' and  trabaja.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pstResponsable = conn.prepareStatement(sqlResponsable);
        rsResponsable = pstResponsable.executeQuery();
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
                <div class="col s12 m12">
                    <div class="card">
                        <div class="card-action">
                            <a>Generar Orden de Trabajo</a> 
                        </div>
                        <div class="row">
                            <form action="/aeLita/gestorOTGenerar" method="get"> 
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
                                </div>
                                <div class="col m7">
                                    <div class="card-content">
                                        <div class="row">
                                            <div class="input-field">
                                                <textarea name="detalleOT" style="height: 300px" id="textarea1" required="" class="materialize-textarea" placeholder="Se solicita a todos los participantes de la Orden de Trabajo terminar sus tareas a tiempo.

A continuación se detallan los archivos de apoyo que deben ser modificados:

1.- Gestión de Cambios.pdf -- Pablo Flores
2.- Gestión de Aranceles.xlxs -- Vicente Arriagada
3.- Informe Técnico PRRT.doc -- David Aravena
4.- Acta de aceptación.pdf -- Lisa Alfredo

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
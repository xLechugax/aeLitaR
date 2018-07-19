<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    String idUsuario = request.getParameter("idUsuario");

    ResultSet rsUsuario = null;
    ResultSet rsAreaDepa = null;

        if (idUsuario.equals("1"))  { %>
        <html>
            <head>
                <meta http-equiv="Refresh" content="5;url=/aeLita/gestores/gestorUsuarios.jsp">
                <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
            </head>
            <body class="blue-grey lighten-5">
                <br /><br /><br /><br /><br /><br /><br /><br />
                <center>
                    <div class="row">
                        <div class="col s12 m12">
                            <div class="card blue-grey darken-1">
                                <div class="card-content white-text">
                                    <span class="card-title">¡Hey, cuidado!</span>
                                    <p>No puedes editar el tipo de cuenta del administrador principal...</p>
                                </div>
                                <div class="card-action">
                                    <a href="/aeLita/gestores/gestorUsuarios.jsp">Volver...</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </center>
            </body>
        </html>            
        <%return; }

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario where idUsuario=" + idUsuario;
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuario = pst.executeQuery();
        rsUsuario.next();
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
            <div class="container"> 
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">

                        </div>
                        <div class="card-stacked">
                            <div class="container">
                                <br/>
                                <p>Estamos editando el tipo de cuenta de <%= rsUsuario.getString("nombre")%> <%= rsUsuario.getString("apellido")%> </p>
                                <form action="guardarCambiosTipoCuenta.jsp" method="post">
                                    <input name="idUsuario" value="<%= rsUsuario.getString("idUsuario")%>" type="hidden"></td>
                                    <table class="">
                                        <tbody>
                                            <tr>
                                                <td>Tipo de Cuenta:</td>
                                                <td>
                                                    <select required name="tipoCuenta">
                                                        <option value="" selected="" disabled="">Seleccione tipo de cuenta...</option>
                                                        <option value="Administrador">Administrador</option>
                                                        <option value="Supervisor">Supervisor</option>
                                                        <option value="Ejecutor">Ejecutor</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <center>
                                        <input class="waves-effect waves-light btn" type="submit" value="Guardar Cambios" />
                                    </center><br/>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>   
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
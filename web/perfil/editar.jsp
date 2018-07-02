<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    ResultSet rsUsuario = null;
    ResultSet rsAreaDepa = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario where idUsuario=" + hs.getAttribute("idUsuarioSesion");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuario = pst.executeQuery();
        rsUsuario.next();

        String sqlAreaDepa = "select * from area_departamento";
        PreparedStatement pstAreaDepa = conn.prepareStatement(sqlAreaDepa);
        rsAreaDepa = pstAreaDepa.executeQuery();

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
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <style>
        body {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
        }

        main {
            flex: 1 0 auto;
        }
    </style>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <div class="container"> 
                <div class="col m3 m3">
                    <div class="card horizontal">
                        <div class="card-image">
                        </div>
                        <div class="card-stacked">
                            <div class="card-content">
                                <p>Hola <%=hs.getAttribute("nombre")%>, estos son los datos de tu perfil </p>
                            </div>
                            <div class="container">
                                <form action="guardarCambios.jsp" method="post">
                                    <input name="idUsuario" value="<%= hs.getAttribute("idUsuarioSesion") %>" type="hidden"></td>
                                    <table class="highlight">
                                        <tbody>
                                            <tr>
                                                <td>Nombre:</td>
                                                <td><%= rsUsuario.getString("nombre") + " " + rsUsuario.getString("apellido")%></td>
                                            </tr>
                                            </tr>
                                            <tr>
                                                <td>Correo:</td>
                                                <td><input name="correo" type="email" class="validate" required=""></td>
                                            </tr>
                                            <tr>
                                                <td>Confirmar Correo:</td>
                                                <td><input name="confirmar_correo" class="validate" type="email" required=""></td>
                                            </tr>
                                            <tr>
                                                <td>Área/Departamento:</td>
                                                <td>
                                                    <select required name="area_departamento">
                                                        <option value="">Seleccione...</option>
                                                        <% while (rsAreaDepa.next()) {%>
                                                        <option value="<%= rsAreaDepa.getString("idAreaDepartamento")%>"><%= rsAreaDepa.getString("nombreAreaDepartamento")%></option>
                                                        <% }%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Teléfono Fijo:</td>
                                                <td><input name="telefono_f" class="validate" placeholder="+562" required=""></td>
                                            </tr>
                                            <tr>
                                                <td>Teléfono Móvil:</td>
                                                <td><input name="telefono_m" class="validate" placeholder="+569" required=""></td>                                        
                                            </tr>
                                            <tr>
                                                <td>Dirección:</td>
                                                <td><input name="direccion" class="validate" required=""></td>
                                            </tr>
                                            <tr>
                                                <td>Clave:</td>
                                                <td><input name="clave" class="validate" type="password" required=""></td>
                                            </tr>
                                            <tr>
                                                <td>Confirmar Clave:</td>
                                                <td><input name="confirmar_clave" class="validate" type="password" required=""></td>
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
    <script type="text/javascript" src="../js/code.jquery.com_jquery-3.2.1.min.js"></script>
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
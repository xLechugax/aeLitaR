<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<%@ include file="../accesoDenegado.jsp" %>
<%        return;
    }
    String idAreaDepartamento2 = request.getParameter("idAreaDepartamento");

    ResultSet rsAreasDepartamentos = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from area_departamento";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsAreasDepartamentos = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsAreaDepartamentoSeleccionada = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from area_departamento where idAreaDepartamento=" + idAreaDepartamento2;
        PreparedStatement pst = conn.prepareStatement(sql);
        rsAreaDepartamentoSeleccionada = pst.executeQuery();
        rsAreaDepartamentoSeleccionada.next();
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
            <div class="row">
                <div class="col m5">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Modificar Área/Departamento</a> 
                                <form action="/aeLita/gestores/gestorAreasDepartamentosModificarSub.jsp" method="post">
                                    <table>
                                        <tbody>
                                            <tr> 
                                                <td>Nombre Área/Departamento:</td>
                                                <input name="idAreaDepartamento" type="hidden" value="<%= rsAreaDepartamentoSeleccionada.getString("idAreaDepartamento")%>">
                                                <td><input name="nombre_areaDepartamento" class="validate" required="" placeholder="<%= rsAreaDepartamentoSeleccionada.getString("nombreAreaDepartamento")%>"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_areaDepartamento" class="materialize-textarea" data-length="120" required="" placeholder="<%= rsAreaDepartamentoSeleccionada.getString("detalleAreaDepartamento")%>"></textarea>
                                        <label for="textarea1">Detalle de Área/Departamento</label>
                                    </div> 
                                    <center>
                                        <input class="btn" type="submit" value="Modificar Estado" /><br/><br/>
                                        <a href="/aeLita/gestores/gestorAreasDepartamentos.jsp" class="btn left-align">Cancelar</a>
                                    </center>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col m7">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-content">
                                <table class="highlight">
                                    <thead>
                                        <tr>
                                            <td>ID</td>
                                            <td>Área/Departamento</td>
                                        </tr> 
                                    </thead>
                                    <tbody>
                                        <% while (rsAreasDepartamentos.next()) {%>
                                        <tr>
                                            <td><%= rsAreasDepartamentos.getString("idAreaDepartamento")%></td>
                                            <td><%= rsAreasDepartamentos.getString("nombreAreaDepartamento")%></td>
                                        </tr>
                                        <%}%>
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
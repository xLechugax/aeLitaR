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
    
    String idAreaDepartamentoEliminar = request.getParameter("idAreaDepartamento");

    ResultSet rsAreasDepartamentos = null;
    ResultSet rsAreaDepartamentoAEliminar = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from area_departamento";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsAreasDepartamentos = pst.executeQuery();

        String sqlAreaDepartamentoAEliminar = "select * from area_departamento where idAreaDepartamento=" + idAreaDepartamentoEliminar;
        PreparedStatement pstAreaDepartamentoAEliminar = conn.prepareStatement(sqlAreaDepartamentoAEliminar);
        rsAreaDepartamentoAEliminar = pstAreaDepartamentoAEliminar.executeQuery();
        rsAreaDepartamentoAEliminar.next();

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
                                <a>Confirmación de Eliminación</a> 
                                    <p class="center-align">¿<%= hs.getAttribute("nombre")%> estas seguro de querer eliminar el área/departamento <%= rsAreaDepartamentoAEliminar.getString("nombreAreaDepartamento")%>?</p>
                                    <center>
                                        <a class="btn" href="gestorAreasDepartamentosEliminar.jsp?idAreaDepartamento=<%= rsAreaDepartamentoAEliminar.getString("idAreaDepartamento")%>">SI</a>
                                        <a class="btn" href="gestorAreasDepartamentos.jsp">NO</a>
                                    </center>
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
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsAreasDepartamentos.next()) {%>
                                        <tr>
                                            <td><%= rsAreasDepartamentos.getString("idAreaDepartamento") %></td>
                                            <td><%= rsAreasDepartamentos.getString("nombreAreaDepartamento") %></td>
                                            <td>
                                                <a href="gestorAreasDepartamentosEliminar.jsp?idAreaDepartamento=<%=rsAreasDepartamentos.getLong("idAreaDepartamento")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorAreasDepartamentosModificar.jsp?idAreaDepartamento=<%=rsAreasDepartamentos.getLong("idAreaDepartamento")%>">
                                                    <img src="img/modificar.jpg" title="Modificar"/>
                                                </a>
                                            </td>
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
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO
    
    String idTarea = request.getParameter("idTarea");

    ResultSet rsTareas = null;
    ResultSet rsTareaSeleccionada = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tarea";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTareas = pst.executeQuery();
        
        String sqlTareaSeleccionada = "select * from tarea where idTarea="+idTarea;
        PreparedStatement pstTareaSeleccionada = conn.prepareCall(sqlTareaSeleccionada);
        rsTareaSeleccionada = pstTareaSeleccionada.executeQuery();
        rsTareaSeleccionada.next();
        
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
                                    <p class="center-align">¿<%= hs.getAttribute("nombre")%> estas seguro de querer eliminar la tarea <%= rsTareaSeleccionada.getString("nombreTarea")%>?</p>
                                    <center>
                                        <a class="btn" href="gestorTareasEliminar.jsp?idTarea=<%= rsTareaSeleccionada.getString("idTarea")%>">SI</a>
                                        <a class="btn" href="gestorTareas.jsp">NO</a>
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
                                            <td>Tarea</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsTareas.next()) {%>
                                        <tr>
                                            <td><%= rsTareas.getString("idTarea") %></td>
                                            <td><%= rsTareas.getString("nombreTarea") %></td>
                                            <td>
                                                <a href="gestorTareasConfirmarEliminar.jsp?idTarea=<%=rsTareas.getLong("idTarea")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorTareasModificar.jsp?idTarea=<%=rsTareas.getLong("idTarea")%>">
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
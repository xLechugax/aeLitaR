<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO
    
    String idTipoTarea = request.getParameter("idTipoTarea");

    ResultSet rsTipoTareas = null;
    ResultSet rsTipoTareaSeleccionada = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from tipo_tarea";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsTipoTareas = pst.executeQuery();
        
        String sqlTareaSeleccionada = "select * from tipo_tarea where idTipoTarea="+idTipoTarea;
        PreparedStatement pstTipoTareaSeleccionada = conn.prepareCall(sqlTareaSeleccionada);
        rsTipoTareaSeleccionada = pstTipoTareaSeleccionada.executeQuery();
        rsTipoTareaSeleccionada.next();
        
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
                <div class="col m5">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Confirmación de Eliminación</a> 
                                    <p class="center-align">¿<%= hs.getAttribute("nombre")%> estas seguro de querer eliminar el tipo de tarea <%= rsTipoTareaSeleccionada.getString("nombreTipoTarea")%>?</p>
                                    <center>
                                        <a class="btn" href="gestorTipoTareasEliminar.jsp?idTipoTarea=<%= rsTipoTareaSeleccionada.getString("idTipoTarea")%>">SI</a>
                                        <a class="btn" href="gestorTipoTareas.jsp">NO</a>
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
                                            <td>Tipo de Tarea</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsTipoTareas.next()) {%>
                                        <tr>
                                            <td><%= rsTipoTareas.getString("idTipoTarea") %></td>
                                            <td><%= rsTipoTareas.getString("nombreTipoTarea") %></td>
                                            <td>
                                                <a href="gestorTipoTareasConfirmarEliminar.jsp?idTarea=<%=rsTipoTareas.getLong("idTipoTarea")%>">
                                                    <img src="img/eliminar.png" title="Eliminar"/>
                                                </a>
                                                <a href="gestorTipoTareasModificar.jsp?idTarea=<%=rsTipoTareas.getLong("idTipoTarea")%>">
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
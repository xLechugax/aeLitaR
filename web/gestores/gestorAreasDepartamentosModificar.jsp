<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%  
    String idAreaDepartamento = request.getParameter("idAreaDepartamento");

    ResultSet rsAreasDepartamentos = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from area_departamento where area_departamento.idEmpresa = 0 or area_departamento.idEmpresa =" + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsAreasDepartamentos = pst.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsAreaDepartamento = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from area_departamento where idAreaDepartamento=" + idAreaDepartamento + " and area_departamento.idEmpresa= " + hs.getAttribute("idEmpresa");
        PreparedStatement pst = conn.prepareStatement(sql);
        rsAreaDepartamento = pst.executeQuery();
        rsAreaDepartamento.next();
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
                                <a>Modificar Área/Departamento</a> 
                                <form action="/aeLita/gestorAreasDepartamentosModificar" method="post">
                                    <table>
                                        <tbody> 
                                            <tr> 
                                                <td>Nombre Área/Departamento:</td>
                                                <input name="idAreaYDepartamento" type="hidden" value="<%= rsAreaDepartamento.getString("idAreaDepartamento")%>">
                                                <td><input name="nombreAreaYDepartamento" class="validate" required="" placeholder="<%= rsAreaDepartamento.getString("nombreAreaDepartamento")%>"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalleAreaYDepartamento" class="materialize-textarea" data-length="120" required="" placeholder="<%= rsAreaDepartamento.getString("detalleAreaDepartamento")%>"></textarea>
                                        <label for="textarea1">Detalle Área/Departamento</label>
                                    </div>
                                    <center>
                                        <input class="btn" type="submit" value="Modificar Área/Departamento" /><br/><br/>
                                        <a href="gestorAreasDepartamentos.jsp" class="btn left-align">Cancelar</a>
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
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead> 
                                    <tbody>
                                        <% while (rsAreasDepartamentos.next()) {%>
                                        <tr>
                                            <td><%= rsAreasDepartamentos.getString("idAreaDepartamento")%></td>
                                            <td><%= rsAreasDepartamentos.getString("nombreAreaDepartamento")%></td>
                                            <td>
                                                <%if (rsAreasDepartamentos.getString("idAreaDepartamento").equals("00000000000")) { %>
                                                <p class="grey-text">Estado Básico      </p>
                                                <%} else {%>
                                                <!-- Modal Trigger -->
                                                <a class=" modal-trigger" href="#modal<%= rsAreasDepartamentos.getString("idAreaDepartamento")%>"><img src="img/eliminar.png" title="Modificar"/></a>

                                                <!-- Modal Structure -->
                                                <div id="modal<%= rsAreasDepartamentos.getString("idAreaDepartamento")%>" class="modal bottom-sheet">
                                                    <div class="modal-content">
                                                        <h4>¿Cofirmar eliminación de "<%= rsAreasDepartamentos.getString("nombreAreaDepartamento")%>"?</h4>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <a href="/aeLita/gestorAreasDepartamentosEliminar?idAreaDepartamento=<%=rsAreasDepartamentos.getLong("idAreaDepartamento")%>" class="modal-close waves-effect waves-green btn-flat green white-text left">Si</a>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat red white-text">No</a>
                                                    </div>
                                                </div> 
                                                <a href="gestorAreasDepartamentosModificar.jsp?idAreaDepartamento=<%=rsAreasDepartamentos.getLong("idAreaDepartamento")%>">
                                                    <img src="img/modificar.jpg" title="Modificar"/>
                                                </a>
                                                <%}%>
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
            $('.modal').modal();
        });
    </script>
</body>
</html>
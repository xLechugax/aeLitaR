<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    ResultSet rsEstados = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from estado where estado.idEstado != 5 and estado.idEmpresa = " + hs.getAttribute("idEmpresa") + " or estado.idEmpresa = 0 and estado.idEstado != 5";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsEstados = pst.executeQuery();
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
                <div class="col m5">
                    <div class="card horizontal">
                        <div class="card-stacked">
                            <div class="card-action">
                                <a>Crear Estados</a> 
                                <form action="/aeLita/gestorEstadosAgregar" method="post"> <%-- Se hace ahora en un servlet --%>
                                    <input name="idUsuario" value="<%= hs.getAttribute("idUsuarioSesion")%>" type="hidden"></td>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>Nombre Estado:</td>
                                                <td><input placeholder="Nombre..." name="nombre_estado" class="validate" required=""></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="input-field col s12">
                                        <textarea name="detalle_estado" class="materialize-textarea" data-length="120" required=""></textarea>
                                        <label for="textarea1">Detalle de estado</label>
                                    </div>
                                    <center>
                                        <input class="waves-effect waves-light btn right-align blue-grey darken-4" type="submit" value="Crear Estado" />
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
                                            <td>Estado</td>
                                            <td>Operaciones</td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% while (rsEstados.next()) {%>
                                        <tr>
                                            <td><%= rsEstados.getString("idEstado")%></td>
                                            <td><%= rsEstados.getString("nombreEstado")%></td>
                                            <td>
                                                <% if (Integer.parseInt(rsEstados.getString("idEstado")) < 6) {%>
                                                <p class="grey-text">Estado B�sico<p>
                                                    <% } else {%>
                                                    <!-- Modal Trigger -->
                                                    <!-- <a class=" modal-trigger" href="#modal<%= rsEstados.getString("idEstado")%>"><img src="img/eliminar.png" title="Modificar"/></a> -->

                                                    <!-- Modal Structure -->
                                                <div id="modal<%= rsEstados.getString("idEstado")%>" class="modal bottom-sheet">
                                                    <div class="modal-content">
                                                        <h4>�Cofirmar eliminaci�n de "<%= rsEstados.getString("nombreEstado")%>"?</h4>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <a href="/aeLita/gestorEstadosEliminar?idEstado=<%=rsEstados.getLong("idEstado")%>" class="modal-close waves-effect waves-green btn-flat green white-text left">Si</a>
                                                        <a href="#!" class="modal-close waves-effect waves-green btn-flat  blue-grey darken-4 red white-text">No</a>
                                                    </div>
                                                </div> 
                                                <a class="orange-text" href="gestorEstadosModificar.jsp?idEstado=<%=rsEstados.getLong("idEstado")%>">
                                                    <i class="material-icons tiny orange-text" title="Editar">edit</i>&nbsp;Editar
                                                </a>
                                                <% } %>
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
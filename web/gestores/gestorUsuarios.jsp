<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    String idEmpresa = "" + hs.getAttribute("idEmpresa");
    ResultSet rsAreaDepa = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAreaDepa = "select * from area_departamento where area_departamento.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pstAreaDepa = conn.prepareStatement(sqlAreaDepa);
        rsAreaDepa = pstAreaDepa.executeQuery();

    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    ResultSet rsUsuariosNoPresentesEmpresaActual = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlUsuariosNoPresentesEmpresaActual = "select DISTINCTROW usuario.idUsuario, usuario.nombreUsuario from usuario,trabaja where usuario.idUsuario = trabaja.idUsuario and trabaja.idEmpresa !=" + idEmpresa + " and usuario.idUsuario != 1";
        PreparedStatement pstUsuariosNoPresentesEmpresaActual = conn.prepareStatement(sqlUsuariosNoPresentesEmpresaActual);
        rsUsuariosNoPresentesEmpresaActual = pstUsuariosNoPresentesEmpresaActual.executeQuery();
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

    String accion = request.getParameter("accion");
    if (accion != null) {
        if (accion.equals("1")) {
            long idUsuario = Long.parseLong(request.getParameter("id"));
            // Recuperar el estado actual del registros del usuario.
            Connection conn = ConexionBD.getConexion();

            String sql = "select activo from trabaja where idUsuario=?";
            PreparedStatement pst1 = conn.prepareStatement(sql);
            pst1.setLong(1, idUsuario);
            ResultSet rs1 = pst1.executeQuery();

            // Leer el estado del usuario, para cambiarlo por el contrario.
            rs1.next();
            if (rs1.getString("activo").equals("S")) {
                String sql2 = "update trabaja set activo=? where idUsuario=?";
                PreparedStatement pst2 = conn.prepareStatement(sql2);
                pst2.setString(1, "N");
                pst2.setLong(2, idUsuario);
                pst2.execute();
            } else {
                String sql2 = "update trabaja set activo=? where idUsuario=?";
                PreparedStatement pst2 = conn.prepareStatement(sql2);

                pst2.setString(1, "S");
                pst2.setLong(2, idUsuario);
                pst2.execute();
            }
        }
    }

    String textobusqueda = request.getParameter("textobusqueda");
    String tipobusqueda = request.getParameter("tipobusqueda");

    // 3.- Si la accion es igual a '2', entonces eliminar al usuario indicado.
    ResultSet rsUsuarios = null;
    try {
        Connection conn = ConexionBD.getConexion();
        Statement st = conn.createStatement();

        String sql = "select usuario.idUsuario,usuario.rut,trabaja.activo,usuario.nombreUsuario, usuario.email, area_departamento.nombreAreaDepartamento, trabaja.tipoCuenta from usuario,trabaja,area_departamento where usuario.area_departamento=area_departamento.idAreaDepartamento and trabaja.idUsuario = usuario.idUsuario and trabaja.idEmpresa = " + idEmpresa + " and usuario.idUsuario > 1 ";

        // 2.- Aplicar un filtro de búsqueda si es necesario
        if (textobusqueda != null && tipobusqueda != null) {
            // Aplicar el filtro respectivo...
            if (tipobusqueda.equals("nombre")) {
                sql = sql + " and usuario.nombre like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("apellido")) {
                sql = sql + " and usuario.apellido like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("dire")) {
                sql = sql + " and usuario.direccion like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("correo")) {
                sql = sql + " and usuario.email like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("movil")) {
                sql = sql + " and usuario.telefono_m like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("fijo")) {
                sql = sql + " and usuario.telefono_f like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("area_departamento")) {
                sql = sql + " and area_departamento.nombreAreaDepartamento like '%" + textobusqueda + "%' order by usuario.idUsuario";
            } else if (tipobusqueda.equals("rol")) {
                sql = sql + " and trabaja.tipoCuenta like '%" + textobusqueda + "%' order by usuario.idUsuario";
            }
        }

        if (textobusqueda == null && tipobusqueda == null) {
            sql = sql + " order by usuario.idUsuario";
        }

        rsUsuarios = st.executeQuery(sql);
    } catch (SQLException e) {
        out.println("Excepción de SQL: " + e);
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
            <ul class="collapsible">
                <li>
                    <div class="collapsible-header"><i class="material-icons">search</i>Filtro de busqueda</div>
                    <div class="collapsible-body white">
                        <form method="post" action="gestorUsuarios.jsp">
                            <div class="row">
                                <div class="input-field col s12">
                                    <input name="textobusqueda" id="nombreUsuario" type="text" class="validate">
                                    <label>Texto de busqueda...</label>
                                </div>
                                <div class="input-field col s12">
                                    <select name="tipobusqueda">
                                        <option value="" selected="" disabled="">No filtrar</option>
                                        <option value="nombre">Nombre</option>
                                        <option value="apellido">Apellido</option>
                                        <option value="dire">Dirección</option>
                                        <option value="correo">Correo</option>
                                        <option value="movil">Teléfono Móvil</option>                
                                        <option value="fijo">Teléfono Fijo</option>                
                                        <option value="area_departamento">Area/Departamento</option>                
                                        <option value="rol">Rol</option>                
                                    </select>   
                                    <input class="btn blue-grey darken-3" type="submit" value="¡Realizar búsqueda!" />
                                </div>
                            </div>
                        </form>
                    </div>
                </li>
            </ul>
            <div class="col m3 m3">
                <div class="card horizontal">
                    <div class="card-stacked">
                        <div class="card-content">
                            <a class="btn-floating btn-large waves-effect waves-light red right-aligned modal-trigger" href="#modal1"><i class="material-icons">add</i></a>&nbsp;&nbsp;<b>Agregar Usuario</b>
                            <!-- Modal Structure -->
                            <div id="modal1" class="modal">
                                <div class="modal-content">
                                    <nav class="nav-extended">
                                        <div class="nav-content blue-grey darken-1">
                                            <ul class="tabs tabs-transparent">
                                                <li class="tab"><a class="active"href="#test1">Agregar Usuario</a></li>
                                                <li class="tab"><a href="#test2">Vincular Usuario Existente</a></li>
                                            </ul>
                                        </div>
                                    </nav>
                                    <div id="test1" class="col s12">
                                        <form class="col s12" action="/aeLita/crearUsuario" method="post">
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input id="input_rut" type="text" name="rut" required="required" title="Debe ser un Rut 11222333-4" class="validate"/>
                                                    <label>Rut</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s6">
                                                    <input name="nombre" type="text" class="validate" required="">
                                                    <label>Nombre</label>
                                                </div>
                                                <div class="input-field col s6">
                                                    <input name="apellido" type="text" class="validate" required="">
                                                    <label>Apellido</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input name="correo" type="email" class="validate" required="">
                                                    <label>Correo</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input name="confirmar_correo" type="email" class="validate" required="">
                                                    <label>Confirmar Correo</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s6">
                                                    <input placeholder="+569" name="telefono_m" type="number" class="validate" required="">
                                                    <label>Teléfono Móvil</label>
                                                </div>
                                                <div class="input-field col s6">
                                                    <input name="telefono_f" placeholder="+562" type="number" class="validate" required="">
                                                    <label>Teléfono Fijo</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <select required name="area_departamento">
                                                        <option value="">Seleccione Área/Departamento...</option>
                                                        <% while (rsAreaDepa.next()) {%>
                                                        <option value="<%= rsAreaDepa.getString("idAreaDepartamento")%>"><%= rsAreaDepa.getString("nombreAreaDepartamento")%></option>
                                                        <% }%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s6">
                                                    <input name="clave" type="password" class="validate" required="">
                                                    <label>Contraseña</label>
                                                </div>
                                                <div class="input-field col s6">
                                                    <input name="confirmar_clave" type="password" class="validate" required="">
                                                    <label>Confirmar Contraseña</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-field col s12">
                                                    <input name="direccion" type="text" class="validate" required="">
                                                    <label>Dirección</label>
                                                </div>
                                            </div>
                                            <a>
                                                Rol
                                            </a>
                                            <div class="row">
                                                <p>
                                                    <input name="rol" type="radio" id="rolAdministrador" value="Administrador" required=""/>
                                                    <label for="rolAdministrador">Administrador</label>
                                                </p>
                                                <p>
                                                    <input name="rol" type="radio" id="rolSupervisor" value="Supervisor" required=""/>
                                                    <label for="rolSupervisor">Supervisor</label>
                                                </p>
                                                <p>
                                                    <input name="rol" type="radio" id="rolEjecutor" value="Ejecutor" required=""/>
                                                    <label for="rolEjecutor">Ejecutor</label>
                                                </p> 
                                            </div>
                                            <center>
                                                <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Crear Usuario" />
                                            </center>
                                        </form>
                                    </div>
                                    <div id="test2" class="col s12" style="height: 400px;">
                                        <form action="/aeLita/vincularUsuarioEmpresa" method="post">
                                            <input type="hidden" name="idEmpresa" value="<%= idEmpresa %>">
                                            <div class="input-field col s12">
                                                <select required name="idUsuario">
                                                    <option value="">Seleccione usuario a vincular</option>
                                                    <% while (rsUsuariosNoPresentesEmpresaActual.next()) {%>
                                                    <option value="<%= rsUsuariosNoPresentesEmpresaActual.getString("idUsuario")%>"><%= rsUsuariosNoPresentesEmpresaActual.getString("nombreUsuario")%></option>
                                                    <% }%>
                                                </select>
                                            </div>
                                            <a>
                                                Rol
                                            </a>
                                            <div class="row">
                                                <p>
                                                    <input name="rolUsuario" type="radio" id="rolAdministradorVincular" value="Administrador" required=""/>
                                                    <label for="rolAdministradorVincular">Administrador</label>
                                                </p>
                                                <p>
                                                    <input name="rolUsuario" type="radio" id="rolSupervisorVincular" value="Supervisor" required=""/>
                                                    <label for="rolSupervisorVincular">Supervisor</label>
                                                </p>
                                                <p>
                                                    <input name="rolUsuario" type="radio" id="rolEjecutorVincular" value="Ejecutor" required=""/>
                                                    <label for="rolEjecutorVincular">Ejecutor</label>
                                                </p> 
                                            </div>
                                            <center>
                                                <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Vincular Usuario" />
                                            </center> 
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <table class="highlight bordered">
                                <tr>
                                    <td><b>ID</b></td>
                                    <td><b>Rut</b></td>
                                    <td><b>Nombre Usuario</b></td>
                                    <td><b>Correo</b></td>
                                    <td><b>Área/Departamento</b></td>
                                    <td><b>Rol</b></td>
                                    <td><b>Activo</b></td>
                                    <td><b>Operaciones</b></td>
                                </tr>            
                                <% while (rsUsuarios.next()) {%>

                                <tr>
                                    <td><b><%=rsUsuarios.getLong("idUsuario")%></b></td>
                                    <td><b><%=rsUsuarios.getString("rut")%></b></td>
                                    <td><%=rsUsuarios.getString("nombreUsuario")%></td>
                                    <td><%=rsUsuarios.getString("email")%></td>
                                    <td><a href="gestorUsuariosEditarAreaDepartamento.jsp?idUsuario="></a>
                                        <%
                                            String idUsuario = request.getParameter("idUsuario");

                                            ResultSet rsUsuario = null;
                                            ResultSet rsAreaDepaEditar = null;
                                            try {
                                                Connection conn = ConexionBD.getConexion();
                                                String sql = "select * from usuario where idUsuario=" + idUsuario;
                                                PreparedStatement pst = conn.prepareStatement(sql);
                                                rsUsuario = pst.executeQuery();
                                                rsUsuario.next();

                                                String sqlAreaDepa = "select * from area_departamento where area_departamento.idEmpresa=" + hs.getAttribute("idEmpresa") + " or area_departamento.idEmpresa=0";
                                                PreparedStatement pstAreaDepa = conn.prepareStatement(sqlAreaDepa);
                                                rsAreaDepaEditar = pstAreaDepa.executeQuery();

                                            } catch (SQLException e) {
                                                out.println("Excepción de SQL:" + e);
                                                return;
                                            }
                                        %>
                                        <!-- Modal Trigger -->
                                        <a class="waves-effect waves-light btn modal-trigger blue-grey darken-3" href="#modalAreaDepartamento<%=rsUsuarios.getLong("idUsuario")%>"><%=rsUsuarios.getString("nombreAreaDepartamento")%></a>

                                        <!-- Modal Structure -->
                                        <div id="modalAreaDepartamento<%=rsUsuarios.getLong("idUsuario")%>" class="modal">
                                            <div class="modal-content" style="height: 400px">
                                                <h4>Editar Área/Departamento</h4>
                                                <form action="guardarCambiosAreaDepartamento.jsp" method="post">
                                                    <input type="hidden" name="idUsuario" value="<%=rsUsuarios.getLong("idUsuario")%>">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>Área/Departamento:</td>
                                                                <td>
                                                                    <select required name="area_departamento">
                                                                        <option value="">Seleccione...</option>
                                                                        <% while (rsAreaDepaEditar.next()) {%>
                                                                        <option value="<%= rsAreaDepaEditar.getString("idAreaDepartamento")%>"><%= rsAreaDepaEditar.getString("nombreAreaDepartamento")%></option>
                                                                        <% }%>
                                                                    </select>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table> 
                                                    <center>
                                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Guardar Cambios" />
                                                    </center><br/>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <!-- Modal Trigger -->
                                        <a class="waves-effect waves-light btn modal-trigger blue-grey darken-1" href="#modalEditarTipoCuenta<%=rsUsuarios.getLong("idUsuario")%>"><%=rsUsuarios.getString("tipoCuenta")%></a>

                                        <!-- Modal Structure -->
                                        <div id="modalEditarTipoCuenta<%=rsUsuarios.getLong("idUsuario")%>" class="modal">
                                            <div class="modal-content" style="height: 400px">
                                                <form action="/aeLita/cambiarTipoCuenta" method="post">
                                                    <input type="hidden" name="idUsuario" value="<%=rsUsuarios.getLong("idUsuario")%>">
                                                    <input type="hidden" name="idEmpresa" value="<%= hs.getAttribute("idEmpresa")%>">
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
                                                        <input class="waves-effect waves-light btn blue-grey darken-3" type="submit" value="Guardar Cambios" />
                                                    </center><br/>
                                                </form>
                                            </div>
                                        </div>
                                    </td>
                                    </td>
                                    <td><center>
                                    <a href="gestorUsuarios.jsp?accion=1&id=<%=rsUsuarios.getLong("idUsuario")%>">
                                        <%
                                            if (rsUsuarios.getString("activo").equals("S")) {
                                        %>
                                        <img src="img/circuloverde.png" title="Desactivar" />
                                        <% } else { %>
                                        <img src="img/circulorojo.png" title="Activar"/>
                                        <% }%>  
                                    </a></center>
                                </td>
                                <td><center>
                                    <%--<a href="gestorUsuariosConfirmarEliminar.jsp?idUsuario=<%=rsUsuarios.getLong("idUsuario")%>">
                                        <img src="img/eliminar.png" title="Eliminar"/>
                                    </a>--%>
                                    &nbsp;
                                    <a class="orange-text" href="gestorUsuariosEditar.jsp?idUsuario=<%=rsUsuarios.getLong("idUsuario")%>">
                                        <i class="material-icons tiny orange-text" title="Editar">edit</i>&nbsp;Editar
                                    </a></center>
                                </td>
                                </tr>
                                <% }%>
                            </table>
                        </div>
                        <div class="container">  
                            <div class="row">
                            </div>  
                        </div>     
                    </div>
                </div>
            </div>
    </main>
    <%@ include file="../footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/jquery.Rut.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.modal').modal();
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('select').material_select();
            $('.collapsible').collapsible();
            $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});
        });
        document.addEventListener('DOMContentLoaded', function () {
            var elems = document.querySelectorAll('.collapsible');
            var instances = M.Collapsible.init(elems, options);
        });
    </script>
    <script>
        $('#input_rut').Rut({
            on_error: function () {
                alert('Rut incorrecto');
                $('#input_rut').val('');
            },
        });
    </script>
</body>
</html>
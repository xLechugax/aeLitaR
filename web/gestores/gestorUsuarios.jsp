<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%    ResultSet rsAreaDepa = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sqlAreaDepa = "select * from area_departamento where area_departamento.idEmpresa=" + hs.getAttribute("idEmpresa");
        PreparedStatement pstAreaDepa = conn.prepareStatement(sqlAreaDepa);
        rsAreaDepa = pstAreaDepa.executeQuery();

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

            String sqlConsulta = "select * from usuario where idUsuario=?";
            PreparedStatement pstConsultaUsuario = conn.prepareStatement(sqlConsulta);
            pstConsultaUsuario.setLong(1, idUsuario);
            ResultSet rsUsuarioConsulta = pstConsultaUsuario.executeQuery();
            rsUsuarioConsulta.next();

            if (rsUsuarioConsulta.getString("tipoCuenta").equals("Administrador")) {
%>
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
                        <p>No puedes desactivar la cuenta de un administrador...</p>
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
<%      return;
    }

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
} else if (accion.equals("2")) {
    long idUsuario = Long.parseLong(request.getParameter("id"));
    String idUsuarioSesion = request.getParameter("id");
    Connection conn = ConexionBD.getConexion();

    String sqlConsulta = "select * from usuario where idUsuario=?";
    PreparedStatement pstConsultaUsuario = conn.prepareStatement(sqlConsulta);
    pstConsultaUsuario.setLong(1, idUsuario);
    ResultSet rsUsuarioConsulta = pstConsultaUsuario.executeQuery();
    rsUsuarioConsulta.next();

    if (rsUsuarioConsulta.getString("tipoCuenta").equals("Administrador")) {
%>
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
                        <p>No puedes eliminar un administrador...</p>
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
<%
                return;
                //Impide la eliminacion del Admin actual.
            } else if (hs.getAttribute("idUsuarioSesion").equals(idUsuarioSesion)) {
                out.println("Error: no se puede eliminar al administrador en sesion.");
            } else {
                // Recuperar el estado actual del registros del usuario.
                Connection connDos = ConexionBD.getConexion();
                String sql = "delete from usuario where idUsuario=?";
                PreparedStatement pst1 = connDos.prepareStatement(sql);
                pst1.setLong(1, idUsuario);
                pst1.execute();
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

        String sql = "select * from usuario,trabaja,area_departamento where usuario.area_departamento=area_departamento.idAreaDepartamento and trabaja.idUsuario = usuario.idUsuario and trabaja.idEmpresa = " + hs.getAttribute("idEmpresa") + " and usuario.idUsuario > 1 ";

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
                sql = sql + " and usuario.tipoCuenta like '%" + textobusqueda + "%' order by usuario.idUsuario";
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
                                    <input class="btn" type="submit" value="¡Realizar búsqueda!" />
                                </div>
                            </div>
                        </form>
                    </div>
                </li>
            </ul>
            <div class="col m3 m3">
                <div class="card horizontal">
                    <div class="card-image">
                    </div>
                    <div class="card-stacked">
                        <div class="card-content">
                            <a class="btn-floating btn-large waves-effect waves-light red right-aligned modal-trigger" href="#modal1"><i class="material-icons">add</i></a>&nbsp;&nbsp;<b>Agregar Usuario</b>

                            <!-- Modal Structure -->
                            <div id="modal1" class="modal">
                                <div class="modal-content">
                                    <h4>Agregar Usuario</h4>
                                    <form class="col s12" action="/aeLita/crearUsuario" method="post">

                                        <div class="row">
                                            <div class="input-field col s12">
                                                <input type="text" name="rut" required="required" pattern="\d{3,8}-[\d|kK]{1}" title="Debe ser un Rut 11222333-4" class="validate"/>
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
                                            <input class="waves-effect waves-light btn" type="submit" value="Crear Usuario" />
                                        </center>
                                    </form>
                                </div>
                            </div>

                            <table class="highlight bordered">
                                <tr>
                                    <td><b>ID</b></td>
                                    <td><b>Rut</b></td>
                                    <td><b>Nombre Usuario</b></td>
                                    <td><b>Correo</b></td>
                                    <td><b>Celular</b></td>
                                    <td><b>Fijo</b></td>
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
                                    <td><%=rsUsuarios.getString("telefono_m")%></td>
                                    <td><%=rsUsuarios.getString("telefono_f")%></td>
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
                                                        <input class="waves-effect waves-light btn" type="submit" value="Guardar Cambios" />
                                                    </center><br/>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                            </div>
                                        </div>
                                    </td>
                                    <td><a href="gestorUsuariosEditarTipoCuenta.jsp?idUsuario="></a>
                                        <!-- Modal Trigger -->
                                        <a class="waves-effect waves-light btn modal-trigger blue-grey darken-1" href="#modalEditarTipoCuenta<%=rsUsuarios.getLong("idUsuario")%>"><%=rsUsuarios.getString("tipoCuenta")%></a>

                                        <!-- Modal Structure -->
                                        <div id="modalEditarTipoCuenta<%=rsUsuarios.getLong("idUsuario")%>" class="modal">
                                            <div class="modal-content" style="height: 400px">
                                                <form action="guardarCambiosTipoCuenta.jsp" method="post">
                                                    <input type="hidden" name="idUsuario" value="<%=rsUsuarios.getLong("idUsuario")%>">
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
                                    <a href="gestorUsuariosEditar.jsp?idUsuario=<%=rsUsuarios.getLong("idUsuario")%>">
                                        <img src="img/modificar.jpg" title="Modificar"/>
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
</body>
</html>
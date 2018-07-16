<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA
    // ABIERTA para el usuario.

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>   
<%@ include file="../barraNav.jsp" %>
<%        return;
    }

    String accion = request.getParameter("accion");
    int ava = 0;
    if (accion != null) {
        if (accion.equals("1")) {
            long idUsuario = Long.parseLong(request.getParameter("id"));
            // Recuperar el estado actual del registros del usuario.
            Connection conn = ConexionBD.getConexion();

            if (idUsuario == 1) {
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
                        <p>No puedes desactivar la cuenta del administrador principal...</p>
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

            String sql = "select activo from usuario where idUsuario=?";
            PreparedStatement pst1 = conn.prepareStatement(sql);
            pst1.setLong(1, idUsuario);
            ResultSet rs1 = pst1.executeQuery();

            // Leer el estado del usuario, para cambiarlo por el contrario.
            rs1.next();
            if (rs1.getString("activo").equals("S")) {
                String sql2 = "update usuario set activo=? where idUsuario=?";
                PreparedStatement pst2 = conn.prepareStatement(sql2);
                pst2.setString(1, "N");
                pst2.setLong(2, idUsuario);
                pst2.execute();
            } else {
                String sql2 = "update usuario set activo=? where idUsuario=?";
                PreparedStatement pst2 = conn.prepareStatement(sql2);

                pst2.setString(1, "S");
                pst2.setLong(2, idUsuario);
                pst2.execute();
            }
        } else if (accion.equals("2")) {
            long idUsuario = Long.parseLong(request.getParameter("id"));
            String idUsuarioSesion = request.getParameter("id");
            //Impide la eliminiacion del Admin Principal.
            if (idUsuario == 1) {
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
                        <p>No puedes eliminar al administrador principal...</p>
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
                Connection conn = ConexionBD.getConexion();
                String sql = "delete from usuario where idUsuario=?";
                PreparedStatement pst1 = conn.prepareStatement(sql);
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
        String sql = "select * from usuario,area_departamento where usuario.area_departamento=area_departamento.idAreaDepartamento";

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
                            <table class="highlight bordered">
                                <tr>
                                    <td>ID</td>
                                    <td>Nombre</td>
                                    <td>Nombre Usuario</td>
                                    <td>Dirección</td>
                                    <td>Correo</td>
                                    <td>Celular</td>
                                    <td>Fijo</td>
                                    <td>Área/Departamento</td>
                                    <td>Rol</td>
                                    <td>Activo</td>
                                    <td>Operaciones</td>
                                </tr>            
                                <% while (rsUsuarios.next()) {%>
                                <tr>
                                    <td><%=rsUsuarios.getLong("idUsuario")%></td>
                                    <td><%=rsUsuarios.getString("nombre") + " " + rsUsuarios.getString("apellido")%></td>
                                    <td><%=rsUsuarios.getString("nombreUsuario")%></td>
                                    <td><%=rsUsuarios.getString("direccion")%></td>
                                    <td><%=rsUsuarios.getString("email")%></td>
                                    <td><%=rsUsuarios.getString("telefono_m")%></td>
                                    <td><%=rsUsuarios.getString("telefono_f")%></td>
                                    <td>
                                        <a href="gestorUsuariosEditarAreaDepartamento.jsp?idUsuario=<%=rsUsuarios.getLong("idUsuario")%>">
                                            <%=rsUsuarios.getString("nombreAreaDepartamento")%>
                                        </a>
                                    </td>
                                    <td><%=rsUsuarios.getString("tipoCuenta")%></td>
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
                                    <a href="gestorUsuarios.jsp?accion=2&id=<%=rsUsuarios.getLong("idUsuario")%>">
                                        <img src="img/eliminar.png" title="Eliminar"/>
                                    </a>
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
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA ABIERTA PARA EL USUARIO.
    ResultSet rsUsuarios = null;
    ResultSet rsAreaDepa = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from usuario";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuarios = pst.executeQuery();

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
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8"/>
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
            <!INICIO - BARRA DE NAVEGACIÓN FIXED>
        <ul class="side-nav" id="mobile-demo">
            <li><a href="/aeLita/index.jsp">Volver</a></li>
        </ul>
        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper blue-grey darken-3">
                    <a href="/aeLita/index.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
                    <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                </div>
            </nav>
        </div>
        <!FINAL - BARRA DE NAVEGACIÓN FIXED>   
        <div class="container"> 
            <div class="col m3 m3">
                <div class="card horizontal">
                    <div class="card-image">
                    </div>
                    <div class="card-stacked">
                        <br/><br/>  
                        <div class="container">  
                            <div class="row">
                                <form class="col s12" action="RegistroUsuarioSub.jsp" method="post">
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
                                                <option value="">Seleccione...</option>
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
            $('select').material_select();
            $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});
        });
    </script>
</body>
</html>
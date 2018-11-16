<%@page import="javax.servlet.http.HttpSession, bd.ConexionBD, java.sql.*"%>
<%
    // 1.- Recuperar los datos del formulario de 'login'.
    String nombreUsuario = request.getParameter("nombreUsuario").trim().toUpperCase();
    String clave = request.getParameter("clave").trim();
    ResultSet rsUsuario, rsContadorEmpresas, rsListadoEmpresas = null;

    HttpSession hs = request.getSession(true);

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT * from usuario WHERE nombreUsuario='" + nombreUsuario + "' and clave='" + clave + "'";
        PreparedStatement pst = conn.prepareStatement(sql);

        rsUsuario = pst.executeQuery();  // Crea una nueva sesión para el usuario actual.

        if (rsUsuario.next() == true) {
            if (nombreUsuario.equals(rsUsuario.getString("nombreUsuario")) & clave.equals(rsUsuario.getString("clave"))) { //Verifica si existe realmente

                String idUsuario = rsUsuario.getString("idUsuario");

                String sqlListadoEmpresas = "select empresa.idEmpresa,empresa.nombre from usuario,trabaja,empresa where trabaja.idEmpresa = empresa.idEmpresa  and usuario.idUsuario = trabaja.idUsuario  and usuario.idUsuario =" + idUsuario;
                PreparedStatement pstListadoEmpresas = conn.prepareStatement(sqlListadoEmpresas);
                rsListadoEmpresas = pstListadoEmpresas.executeQuery();

                String sqlContadorEmpresas = "select count(*) from trabaja where idUsuario =" + idUsuario;
                PreparedStatement pstContadorEmpresas = conn.prepareStatement(sqlContadorEmpresas);
                rsContadorEmpresas = pstContadorEmpresas.executeQuery();

                if (rsContadorEmpresas.next()) {
                    int numeroDeEmpresas = rsContadorEmpresas.getInt(1);
                    if (numeroDeEmpresas > 1) {%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <body class="blue-grey lighten-5">
        <br /><br /><br /><br /><br /><br /><br /><br /><br />
    <center>
        <div class="row">
            <div class="col s12 m12">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">Hemos detectado que trabaja en más de una empresa.<br/>
                            Seleccione la empresa con la que desea ingresar<br/>  
                        </span>
                        <form action="/aeLita/verificarUsuarioActivo.jsp" method="POST">
                            <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                            <select name="idEmpresa">
                                <% while (rsListadoEmpresas.next()) {%>
                                <option value="<%=rsListadoEmpresas.getString("idEmpresa")%>"><%=rsListadoEmpresas.getString("nombre")%></option>
                                <%}%>
                            </select>
                            <input class="btn blue-grey darken-3" type="submit" value="Ingresar" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('select').material_select();
        });
    </script>
</body>
</html>
<%
        } else {
            while (rsListadoEmpresas.next()) {
                String idEmpresa = rsListadoEmpresas.getString("idEmpresa");
                response.sendRedirect("/aeLita/verificarUsuarioActivo.jsp?idUsuario="+idUsuario+"&idEmpresa="+idEmpresa);
            }
        }
    }
} else {%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/index.jsp">
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <body class="blue-grey lighten-5">
        <br /><br /><br /><br /><br /><br /><br /><br /><br />
    <center>
        <div class="row">
            <div class="col s12 m12">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">¡Error!</span>
                        <p>El usuario o contraseña que ingresaste, no son validos...</p>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%          }
} else {%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/index.jsp">
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <body class="blue-grey lighten-5">
        <br /><br /><br /><br /><br /><br /><br /><br /><br />
    <center>
        <div class="row">
            <div class="col s12 m12">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">¡Error!</span>
                        <p>El usuario o contraseña que ingresaste, no son validos...</p>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%          }

    } catch (Exception e) {
        out.print("Error: " + e);
    }
%>

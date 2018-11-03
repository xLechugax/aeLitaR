<%@page import="javax.servlet.http.HttpSession, bd.ConexionBD, java.sql.*"%>
<%
    // 1.- Recuperar los datos del formulario de 'login'.
    String nombreUsuario = request.getParameter("nombreUsuario").trim().toUpperCase();
    String clave = request.getParameter("clave").trim();
    ResultSet rsUsuario = null;
    
    HttpSession hs = request.getSession(true);

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT * from USUARIO WHERE nombreUsuario='" + nombreUsuario + "' and clave='" + clave + "'";
        PreparedStatement pst = conn.prepareStatement(sql);

        rsUsuario = pst.executeQuery();  // Crea una nueva sesión para el usuario actual.

        if (rsUsuario.next() == true) {
            if (nombreUsuario.equals(rsUsuario.getString("nombreUsuario")) & clave.equals(rsUsuario.getString("clave"))) {
                String Activo = rsUsuario.getString("activo");
                if (Activo.equalsIgnoreCase("S")) {
                    hs.setAttribute("nombre", rsUsuario.getString("nombre"));
                    hs.setAttribute("nombreUsuario", rsUsuario.getString("nombreUsuario"));
                    hs.setAttribute("tipoCuenta", rsUsuario.getString("tipoCuenta"));
                    hs.setAttribute("idUsuarioSesion", rsUsuario.getString("idUsuario"));
                    hs.setAttribute("nombre", rsUsuario.getString("nombre"));
                    hs.setAttribute("apellido", rsUsuario.getString("apellido"));
                    hs.setAttribute("email", rsUsuario.getString("email"));
                    hs.setAttribute("telefono", rsUsuario.getString("telefono_f"));
                    String tipoCuenta = rsUsuario.getString("tipoCuenta");
                    if (tipoCuenta.equals("Administrador")) {
                        //response.sendRedirect("/aeLita/administrador/inicioAdmin.jsp");
                        response.sendRedirect("/aeLita/selectorEmpresa.jsp?idUsuario="+rsUsuario.getString("idUsuario"));
                    }
                    if (tipoCuenta.equals("Supervisor")) {
                        //response.sendRedirect("/aeLita/supervisor/inicioSupervisor.jsp");
                        response.sendRedirect("/aeLita/selectorEmpresa.jsp?idUsuario="+rsUsuario.getString("idUsuario"));
                    }
                    if (tipoCuenta.equals("Ejecutor")) {
                        //response.sendRedirect("/aeLita/ejecutor/inicioEjecutor.jsp");
                        response.sendRedirect("/aeLita/selectorEmpresa.jsp?idUsuario="+rsUsuario.getString("idUsuario"));
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
                        <span class="card-title">¡Oh no!</span>
                        <p>La cuenta esta deshabilitada...<br/> Contácta al administrador.</p>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%            return;
        }
    }
} else {
%>
<%
        }

    } catch (Exception e) {
        out.print("Error: " + e);
    }
%>
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
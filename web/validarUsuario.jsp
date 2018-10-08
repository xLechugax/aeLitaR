<%@page import="javax.servlet.http.HttpSession, bd.ConexionBD, java.sql.*"%>
<%
    // 1.- Recuperar los datos del formulario de 'login'.
    String nombreUsuario = request.getParameter("nombreUsuario").trim().toUpperCase();
    String clave = request.getParameter("clave").trim();
    ResultSet rsUsuario = null;
    ResultSet rsExtraerEmpresas = null;
    ResultSet rsContadorExtraerEmpresas = null;
    
    HttpSession hs = request.getSession(true);

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "SELECT * from USUARIO WHERE nombreUsuario='" + nombreUsuario + "' and clave='" + clave + "'";
        PreparedStatement pst = conn.prepareStatement(sql);

        rsUsuario = pst.executeQuery();  // Crea una nueva sesi�n para el usuario actual.

        if (rsUsuario.next() == true) {
            if (nombreUsuario.equals(rsUsuario.getString("nombreUsuario")) & clave.equals(rsUsuario.getString("clave"))) {
                String Activo = rsUsuario.getString("activo");
                if (Activo.equalsIgnoreCase("S")) {

                    //
                    
                    String sqlExtraerEmpresas = "select usuario.nombreUsuario,empresa.nombre from usuario,trabaja,empresa "
                            + "where trabaja.idEmpresa = empresa.idEmpresa "
                            + "and usuario.idUsuario = trabaja.idUsuario "
                            + "and usuario.idUsuario =" + rsUsuario.getString("idUsuario");
                    PreparedStatement pstExtraerEmpresas = conn.prepareStatement(sqlExtraerEmpresas);
                    rsExtraerEmpresas = pstExtraerEmpresas.executeQuery();
                    
                    String sqlContadorExtraerEmpresas = "select usuario.nombreUsuario,empresa.nombre from usuario,trabaja,empresa "
                            + "where trabaja.idEmpresa = empresa.idEmpresa "
                            + "and usuario.idUsuario = trabaja.idUsuario "
                            + "and usuario.idUsuario =" + rsUsuario.getString("idUsuario");
                    PreparedStatement pstContadorExtraerEmpresas = conn.prepareStatement(sqlExtraerEmpresas);
                    rsContadorExtraerEmpresas = pstContadorExtraerEmpresas.executeQuery();
                    
                    //if (rsExtraerEmpresas.next() == true) {
                    //    if (rsContadorExtraerEmpresas.) {
                    //            
                    //        }
                    //}

                    hs.setAttribute("nombre", rsUsuario.getString("nombre"));
                    hs.setAttribute("nombreUsuario", rsUsuario.getString("nombreUsuario"));
                    hs.setAttribute("tipoCuenta", rsUsuario.getString("tipoCuenta"));
                    hs.setAttribute("idUsuarioSesion", rsUsuario.getString("idUsuario"));
                    String tipoCuenta = rsUsuario.getString("tipoCuenta");
                    if (tipoCuenta.equals("Administrador")) {
                        response.sendRedirect("/aeLita/administrador/inicioAdmin.jsp");
                    }
                    if (tipoCuenta.equals("Supervisor")) {
                        response.sendRedirect("/aeLita/supervisor/inicioSupervisor.jsp");
                    }
                    if (tipoCuenta.equals("Ejecutor")) {
                        response.sendRedirect("/aeLita/ejecutor/inicioEjecutor.jsp");
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
                        <span class="card-title">�Oh no!</span>
                        <p>La cuenta esta deshabilitada...<br/> Cont�cta al administrador.</p>
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
                        <span class="card-title">�Error!</span>
                        <p>El usuario o contrase�a que ingresaste, no son validos...</p>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
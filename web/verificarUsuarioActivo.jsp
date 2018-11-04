<%@page import="javax.servlet.http.HttpSession, bd.ConexionBD, java.sql.*"%>
<%
    HttpSession hs = request.getSession(false);

    String idUsuario = request.getParameter("idUsuario");
    String idEmpresa = request.getParameter("idEmpresa");

    ResultSet rsActivo, rsUsuario = null;

    try {
        Connection conn = ConexionBD.getConexion();
        String sqlVerificaActivo = "select activo from trabaja where trabaja.idEmpresa = " + idEmpresa + " and trabaja.idUsuario = " + idUsuario;
        PreparedStatement pst = conn.prepareStatement(sqlVerificaActivo);
        rsActivo = pst.executeQuery();
            rsActivo.next();

        if (rsActivo.getString("activo").equals("S")) {

            conn = ConexionBD.getConexion();
            String sqlInformacionUsuario = "select * from usuario where idUsuario = " + idUsuario;
            PreparedStatement pstInformacionUsuario = conn.prepareStatement(sqlInformacionUsuario);
            rsUsuario = pstInformacionUsuario.executeQuery();
            rsUsuario.next();

            hs.setAttribute("idEmpresa", idEmpresa);
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
                response.sendRedirect("/aeLita/administrador/inicioAdmin.jsp?idEmpresa=" + idEmpresa);
            }
            if (tipoCuenta.equals("Supervisor")) {
                response.sendRedirect("/aeLita/supervisor/inicioSupervisor.jsp?idEmpresa=" + idEmpresa);
            }
            if (tipoCuenta.equals("Ejecutor")) {
                response.sendRedirect("/aeLita/ejecutor/inicioEjecutor.jsp?idEmpresa=" + idEmpresa);
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
                        <p>Su cuenta de usuario se encuentra deshabilitada.</p>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<% return;}

    } catch (Exception e) {
    }
%>   
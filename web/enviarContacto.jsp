<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String asunto = request.getParameter("asunto");
    String telefono = request.getParameter("telefono");
    String mensaje = request.getParameter("mensaje");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "insert into contacto "
                + "(nombre,asunto, email, telefono, mensaje) values "
                + "(?,?,?,?,?)";

        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombre);
        pst.setString(2, asunto);
        pst.setString(3, email);
        pst.setString(4, telefono);
        pst.setString(5, mensaje);
        pst.execute();

        if (hs == null || hs.getAttribute("tipoCuenta") == null) { %>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/index.jsp">
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
                        <span class="card-title">¡Listo!</span>
                        <p>Hemos enviado los detalles de tu problema al administrador, recibirás respuesta vía correo electrónico.</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/index.jsp">¡OK!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<% } else if (hs.getAttribute("tipoCuenta").equals("Administrador")) { %>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/administrador/inicioAdmin.jsp">
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
                        <span class="card-title">¡Listo!</span>
                        <p>Hemos enviado los detalles de tu problema al administrador, recibirás respuesta vía correo electrónico.</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/administrador/inicioAdmin.jsp">¡OK!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<% } else if (hs.getAttribute("tipoCuenta").equals("Supervisor")) { %>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/supervisor/inicioSupervisor.jsp">
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
                        <span class="card-title">¡Listo!</span>
                        <p>Hemos enviado los detalles de tu problema al administrador, recibirás respuesta vía correo electrónico.</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/supervisor/inicioSupervisor.jsp">¡OK!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<% } else { %>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/ejecutor/inicioEjecutor.jsp">
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
                        <span class="card-title">¡Listo!</span>
                        <p>Hemos enviado los detalles de tu problema al administrador, recibirás respuesta vía correo electrónico.</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/ejecutor/inicioEjecutor.jsp">¡OK!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<% }
    } catch (Exception e) {
        out.println(e );
    }   %>
<%@page import="java.sql.*, bd.ConexionBD" %>
<link rel="stylesheet" type="text/css" href="newcss.css"><link>
<%
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String correo = request.getParameter("correo");
    String confirmar_correo = request.getParameter("confirmar_correo");
    String telefono_m = request.getParameter("telefono_m");
    String telefono_f = request.getParameter("telefono_f");
    String area_departamento = request.getParameter("area_departamento");
    String clave = request.getParameter("clave");
    String confirmar_clave = request.getParameter("confirmar_clave");
    String direccion = request.getParameter("direccion");
    String rol = request.getParameter("rol");

    String nombreUsuario = nombre.trim().toUpperCase() + "." + apellido.trim().replaceAll("\\s", "").toUpperCase();

    String sql = null;
    try {
        Connection conn = ConexionBD.getConexion();
        if (!(clave.trim().equals(confirmar_clave.trim()))) {

            out.print("<meta http-equiv='Refresh' content='2;url=/aeLita/registro/registrarNuevoUsuario.jsp'>");
            return;
        } else if (!(correo.trim().equals(confirmar_correo.trim()))) {
            out.print("<meta http-equiv='Refresh' content='2;url=/aeLita/errores/CorreosNoCoinciden.jsp'>");
            out.print("<meta http-equiv='Refresh' content='2;url=/aeLita/registro/registrarNuevoUsuario.jsp'>");
            return;
        } else {
            sql = "INSERT INTO USUARIO (nombre, apellido, nombreUsuario, email, telefono_m, telefono_f, area_departamento,"
                    + "direccion, tipoCuenta, clave, activo)"
                    + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, nombre);
            pst.setString(2, apellido);
            pst.setString(3, nombreUsuario);
            pst.setString(4, correo);
            pst.setString(5, telefono_m);
            pst.setString(6, telefono_f);
            pst.setString(7, area_departamento);
            pst.setString(8, direccion);
            pst.setString(9, rol);
            pst.setString(10, clave);
            pst.setString(11, "N");

            pst.execute();
%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/index.jsp">
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8"/>
    </head>
    <body class="blue-grey lighten-5">
        <br /><br /><br /><br /><br /><br /><br /><br />
        <center>
            <div class="row">
                <div class="col s12 m12">
                    <div class="card blue-grey darken-1">
                        <div class="card-content white-text">
                            <span class="card-title">¡Cuenta Creada!</span>
                            <p>Tus datos se han ingresado correctamente, te estamos redirigendo al comienzo,si no quieres esperar haz click...</p>
                        </div>
                        <div class="card-action">
                            <a href="/aeLita/index.jsp">¡AQUÍ!</a>
                        </div>
                    </div>
                </div>
            </div>
        </center>
    </body>
</html>
<%        }
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e + sql);
    }
%>
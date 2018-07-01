<%@page import="java.sql.*, bd.ConexionBD" %>
<link rel="stylesheet" type="text/css" href="newcss.css"><link>
<%
    String rut          = request.getParameter("rut");
    String tipoCliente  = request.getParameter("tipoCliente");
    String nombre       = request.getParameter("nombre");
    String apellido     = request.getParameter("apellido");
    String pais         = request.getParameter("pais");
    String ciudad       = request.getParameter("ciudad");
    String avatar       = request.getParameter("avatar");
    String comuna       = request.getParameter("comuna");
    String direccion    = request.getParameter("direccion");
    String correo       = request.getParameter("correo");
    String confCorreo   = request.getParameter("confirmarCorreo");
    String telefonoF    = request.getParameter("telefonoFijo");
    String telefonoM    = request.getParameter("telefonoMovil");
    String dia          = request.getParameter("dia");
    String mes          = request.getParameter("mes");
    String año          = request.getParameter("ano");
    String rol          = request.getParameter("rol");
    String clave        = request.getParameter("claveUsuario");
    String confClave    = request.getParameter("confirmarClave");
    
    int telefonoFijo = Integer.parseInt(telefonoF.trim());
    int telefonoMovil = Integer.parseInt(telefonoM.trim());
    String fechaNac = año+"-"+mes+"-"+dia;
    String sql2         = null;
    if (avatar==null) {
            avatar="0";
        }
    if (pais.equals("0") || ciudad.equals("0") || comuna.equals("Selecciona una Comuna")) {
            out.print("Los campos de País, Ciudad y Comuna son obligatorios");
            out.print("<meta http-equiv='Refresh' content='2;url=FormRegistroUsuario.jsp'>");
                return;
                 
            }
    ResultSet rs = null;
    if (ciudad.equals("La")) {
            ciudad = ciudad + " Serena";
        }
    if (ciudad.equals("Buenos")) {
            ciudad = ciudad + " Aires";
        }
    if (ciudad.equals("Puerto")) {
            ciudad = ciudad + " Montt";
        }
    try{
        Connection conn = ConexionBD.getConexion();
        Connection conn2 = ConexionBD.getConexion();
        String sql = "select * from regUsuario";
        PreparedStatement pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        while (rs.next()) {
            if (rs.getString("rut").equals(rut)) {
                out.print("Usuario ya registrado");
                out.print("<meta http-equiv='Refresh' content='2;url=FormRegistroUsuario.jsp'>");
                return;
                 
            }
        }
        if (!(clave.trim().equals(confClave.trim()))) {
            out.print("Contraseñas no coinciden...");
            out.print("<meta http-equiv='Refresh' content='2;url=FormRegistroUsuario.jsp'>");
                return;
        } else if (!(correo.trim().equals(confCorreo.trim()))) {
            out.print("Correos no coinciden...");
            out.print("<meta http-equiv='Refresh' content='2;url=FormRegistroUsuario.jsp'>");
                return;
                 
            }
        else {
          
            sql2 = "insert into regusuario "
                    + "(rut, nombre, apellido, pais, ciudad, comuna, direccion, e_mail, telefono_p, telefono_m, clave,"
                    + " rol, estaActivo, tipoCliente, fechaNac, avatar) values "
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement pst2 = conn2.prepareStatement(sql2);
                pst2.setString(1, rut);           
                pst2.setString(2, nombre);           
                pst2.setString(3, apellido);           
                pst2.setString(4, pais);           
                pst2.setString(5, ciudad);           
                pst2.setString(6, comuna);           
                pst2.setString(7, direccion);           
                pst2.setString(8, correo);          
                pst2.setInt(9, telefonoFijo);         
                pst2.setInt(10, telefonoMovil);           
                pst2.setString(11, clave);           
                pst2.setString(12, rol);                     
                pst2.setString(13, "N");                 
                pst2.setString(14, tipoCliente);                                    
                pst2.setString(15, fechaNac);   
                pst2.setString(16, avatar);   
                pst2.execute();
%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=index.jsp">
                <link rel="stylesheet" type="text/css" href="newcss.css"><link>
    </head>
    <body>
        <br /><br /><br /><br /><br /><br /><br /><br />
        <table align="center" height="200" width="800">
            <tr>
                <td style="font-family: sans-serif; font-size: 20px;"><br /><br /><center>¡Tus datos han sido ingresados correctamente!<br /><br />
            Te estamos redirigendo al comienzo, si no quieres esperar haz click<br/><br/>
            <a href="index.jsp">  ¡AQUÍ! </a></p>
            </center></td>
            </tr>
        </table>
    </body>
</html>
<%        }
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
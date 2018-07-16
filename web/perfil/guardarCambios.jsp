<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyLogged.jsp" %>
<%
    String correo = request.getParameter("correo");
    String confirmar_correo = request.getParameter("confirmar_correo");
    //String area_departamento = request.getParameter("area_departamento");
    String telefono_f = request.getParameter("telefono_f");
    String telefono_m = request.getParameter("telefono_m");
    String direccion = request.getParameter("direccion");
    String clave = request.getParameter("clave");
    String confirmar_clave = request.getParameter("confirmar_clave");
    String idUsuario = request.getParameter("idUsuario");
    
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
            sql = "update USUARIO set email=?,telefono_m=?,telefono_f=?,direccion=?,clave=? where idUsuario=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, correo);
            pst.setString(2, telefono_m);
            pst.setString(3, telefono_f);
            pst.setString(4, direccion);
            pst.setString(5, clave);
            pst.setString(6, idUsuario);

            pst.execute();
            response.sendRedirect("miperfil.jsp");
            }
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e +sql);
    }
%>
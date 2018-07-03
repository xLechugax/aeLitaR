<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA
    // ABIERTA para el usuario.

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<%@ include file="../accesoDenegado.jsp" %>
<%            return;
    }
    String nombreEstado = request.getParameter("nombre_estado");
    String detalleEstado = request.getParameter("detalle_estado");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "insert into estado (nombreEstado,detalleEstado) values (?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreEstado);
        pst.setString(2, detalleEstado);
        pst.execute();
        response.sendRedirect("gestorEstados.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
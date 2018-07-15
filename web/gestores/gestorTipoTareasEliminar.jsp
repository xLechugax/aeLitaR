<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
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
    String idTarea = request.getParameter("idTipoTarea");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "delete tipo_tarea from tipo_tarea where idTipoTarea=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, idTarea);
        pst.execute();
        response.sendRedirect("gestorTipoTareas.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESI�N YA
    // ABIERTA para el usuario.

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<%@ include file="../accesoDenegado.jsp" %>
<%            return;
    }
    String idTarea = request.getParameter("idTarea");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "delete tarea from tarea where idTarea=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, idTarea);
        pst.execute();
        response.sendRedirect("gestorTareas.jsp");
    } catch (Exception e) {
        out.println("Excepci�n de SQL (RegistroUsuario.jsp): " + e);
    }
%>
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
    String nombreTarea = request.getParameter("nombre_tarea");
    String detalleTarea = request.getParameter("detalle_tarea");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "insert into tarea (nombreTarea,detalleTarea) values (?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreTarea);
        pst.setString(2, nombreTarea);
        pst.execute();
        response.sendRedirect("gestorTareas.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
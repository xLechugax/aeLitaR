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
    String nombreTipoTarea = request.getParameter("nombre_tipo_tarea");
    String detalleTipoTarea = request.getParameter("detalle_tipo_tarea");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "insert into tipo_tarea (nombreTipoTarea,detalleTipoTarea) values (?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreTipoTarea);
        pst.setString(2, detalleTipoTarea);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorTipoTareas.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
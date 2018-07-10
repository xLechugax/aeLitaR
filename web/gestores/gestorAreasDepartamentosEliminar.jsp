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
    String idAreaDepartamento = request.getParameter("idAreaDepartamento");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "delete area_departamento from area_departamento where idAreaDepartamento=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, idAreaDepartamento);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorAreasDepartamentos.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
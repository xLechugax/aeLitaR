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
    String nombreAreaDepartamento = request.getParameter("nombre_areaDepartamento");
    String detalleAreaDepartamento = request.getParameter("detalle_areaDepartamento");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "insert into area_departamento (nombreAreaDepartamento,detalleAreaDepartamento) values (?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreAreaDepartamento);
        pst.setString(2, detalleAreaDepartamento);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorAreasDepartamentos.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
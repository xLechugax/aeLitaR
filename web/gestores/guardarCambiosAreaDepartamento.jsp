<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%
    String area_departamento = request.getParameter("area_departamento");
    String idUsuario = request.getParameter("idUsuario");

    String sql = null;
    try {
        Connection conn = ConexionBD.getConexion();
        sql = "update USUARIO set area_departamento=? where idUsuario=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, area_departamento);
        pst.setString(2, idUsuario);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorUsuarios.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e + sql);
    }
%>
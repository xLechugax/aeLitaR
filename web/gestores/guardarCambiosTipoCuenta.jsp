<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%
    String tipoCuenta = request.getParameter("tipoCuenta");
    String idUsuario = request.getParameter("idUsuario");
    String idEmpresa = request.getParameter("idEmpresa");

    String sql = null;
    try {
        Connection conn = ConexionBD.getConexion();
        sql = "update USUARIO set tipoCuenta=? where idUsuario=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, tipoCuenta);
        pst.setString(2, idUsuario);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorUsuarios.jsp");
    } catch (Exception e) {
        out.println("Excepci�n de SQL (RegistroUsuario.jsp): " + e + sql);
    }
%>
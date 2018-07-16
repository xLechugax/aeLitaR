<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%  
    String idEstado = request.getParameter("idEstado");

    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "delete estado from estado where idEstado=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, idEstado);
        pst.execute();
        response.sendRedirect("gestorEstados.jsp");
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>
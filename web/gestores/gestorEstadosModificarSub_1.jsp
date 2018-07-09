<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<%@ include file="../accesoDenegado.jsp" %>
<%        return;
    }

    String idEstado = request.getParameter("idEstado");
    String nombreEstado = request.getParameter("nombre_estado");
    String detalleEstado = request.getParameter("detalle_estado");
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "update estado set nombreEstado=?,detalleEstado=? where idEstado=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreEstado);
        pst.setString(2, detalleEstado);
        pst.setString(3, idEstado);
        pst.execute();
        response.sendRedirect("gestorEstados.jsp");
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

%>

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

    String idTarea = request.getParameter("idTarea");
    String nombreTarea = request.getParameter("nombre_tarea");
    String detalleTarea = request.getParameter("detalle_tarea");
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "update tarea set nombreTarea=?,detalleTarea=? where idTarea=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreTarea);
        pst.setString(2, detalleTarea);
        pst.setString(3, idTarea);
        pst.execute();
        response.sendRedirect("gestorTareas.jsp");
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

%>

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

    String idTipoTarea = request.getParameter("idTipoTarea");
    String nombreTipoTarea = request.getParameter("nombre_tipo_tarea");
    String detalleTipoTarea = request.getParameter("detalle_tipo_tarea");
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "update tipo_tarea set nombreTipoTarea=?,detalleTipoTarea=? where idTipoTarea=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nombreTipoTarea);
        pst.setString(2, detalleTipoTarea);
        pst.setString(3, idTipoTarea);
        pst.execute();
        response.sendRedirect("gestorTipoTareas.jsp");
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

%>

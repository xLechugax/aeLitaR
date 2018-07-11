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

    String idAreaDepartamento = request.getParameter("idAreaDepartamento");
    String nombre_areaDepartamento = request.getParameter("nombre_areaDepartamento");
    String detalle_areaDepartamento = request.getParameter("detalle_areaDepartamento");
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "update area_departamento set nombreAreaDepartamento=?, detalleAreaDepartamento=? where idAreaDepartamento=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, idAreaDepartamento);
        pst.setString(2, nombre_areaDepartamento);
        pst.setString(3, detalle_areaDepartamento);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorAreasDepartamentos.jsp");
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

%>

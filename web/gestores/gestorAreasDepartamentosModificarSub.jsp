<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADM.jsp" %>
<%
    if (hs == null || hs.getAttribute("tipoCuenta") == null
            || !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<%@ include file="../accesoDenegado.jsp" %>
<%        return;
    }

    String idAreaDepartamento = request.getParameter("idAreaYDepartamento");
    String nomrbeAreaDepartamento = request.getParameter("nombreAreaYDepartamento");
    String detalleAreaDepartamento = request.getParameter("detalleAreaYDepartamento");
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "update area_departamento set nombreAreaDepartamento=?,detalleAreaDepartamento=? where idAreaDepartamento=?";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, nomrbeAreaDepartamento);
        pst.setString(2, detalleAreaDepartamento);
        pst.setString(3, idAreaDepartamento);
        pst.execute();
        response.sendRedirect("/aeLita/gestores/gestorAreasDepartamentos.jsp");
    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }

%>

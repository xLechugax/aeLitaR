<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%@ include file="../accesoDenegadoOnlyADMSUPER.jsp" %> <!ACCESO PERMITIDO UNICAMENTE PARA LOS ADMINISTRADORES Y SUPERVISORES>
<%  
    
    String importancia = request.getParameter("importancia");
    String idSupervisor = request.getParameter("idSupervisor");
    String nombreOT = request.getParameter("nombreOT");
    String detalleOT = request.getParameter("detalleOT");
    String estado = "1";
    
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "insert into orden_trabajo (importancia,supervisor,nombreOrdenTrabajo,detalleOrdenTrabajo,estado) values (?,?,?,?,?)";
        PreparedStatement pst = conn.prepareStatement(sql);
        pst.setString(1, importancia);
        pst.setString(2, idSupervisor);
        pst.setString(3, nombreOT);
        pst.setString(4, detalleOT);
        pst.setString(5, estado);
        pst.execute();
        if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
            response.sendRedirect("/aeLita/administrador/gestorOT.jsp");
        }
        if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {
            response.sendRedirect("/aeLita/supervisor/gestorOT.jsp");
        }
    } catch (Exception e) {
        out.println("Excepción de SQL (RegistroUsuario.jsp): " + e);
    }
%>

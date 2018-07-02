<%@page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession hs = request.getSession(false);
    
    if(hs != null)
        hs.invalidate();    // Eliminar la sesión y los datos del usuario.
    
    response.sendRedirect("/aeLita/index.jsp");
%>
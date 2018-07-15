<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO
    // Recuperar la sesión del usuario actual
    try {
        if (hs == null || hs.getAttribute("tipoCuenta") == null
                || !(hs.getAttribute("tipoCuenta").equals("Administrador"))
                || hs.getAttribute("tipoCuenta").equals("Supervisor")
                || hs.getAttribute("tipoCuenta").equals("Ejecutor")) {
%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/index.jsp">
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <body class="blue-grey lighten-5">
        <br /><br /><br /><br /><br /><br /><br /><br />
    <center>
        <div class="row">
            <div class="col s12 m12">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title">¡Oh no!</span>
                        <p>Debes estar logeado para poder ingresar, te estamos redirigiendo, si no quieres esperar has clic...</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/index.jsp">¡AQUÍ!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%
            return;
        }

    } catch (Exception e) {
        return;
    }
    String accion = request.getParameter("accion");
    if (accion != null) {
        if (accion.equals("1")) {
            String idContacto = request.getParameter("idContacto");
            try {
                Connection conn = ConexionBD.getConexion();
                String sql = "delete from contacto where idContacto=?";
                PreparedStatement pst1 = conn.prepareStatement(sql);
                pst1.setString(1, idContacto);
                pst1.execute();
            } catch (SQLException e) {
                out.println("Excepción de SQL:" + e + idContacto);
                return;
            }
        }
    }
    ResultSet rsContactos = null;
    ResultSet rsContactosContador = null;
    try {
        Connection conn = ConexionBD.getConexion();
        String sql = "select * from contacto";
        PreparedStatement pst = conn.prepareStatement(sql);
        rsContactos = pst.executeQuery();

        String sqlContador = "select * from contacto";
        PreparedStatement pstContador = conn.prepareStatement(sql);
        rsContactosContador = pstContador.executeQuery();

    } catch (SQLException e) {
        out.println("Excepción de SQL:" + e);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="/aeLita/css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../barraNav.jsp" %>
            <div class="container"> 
                <div class="row">
                    <div class="col s12 m12">
                        <div class="card white"> 
                            <% if ( rsContactosContador.next() == false ) {%>
                            <div class="card-content">
                                <p><%=hs.getAttribute("nombre")%>, no hay contactos en la bandeja de entrada.</p>
                            </div>        
                            <%} else { %>
                            <div class="card-content">
                                <p><%=hs.getAttribute("nombre")%>, estos son los últimos contactos.</p>
                            </div>
                            <%}%>
                        </div>
                        <ul class="collapsible popout" data-collapsible="expandable">
                        <% while (rsContactos.next()) {%>
                            <li>
                                <div class="collapsible-header"><i class="material-icons">contact_mail</i><%= rsContactos.getString("asunto")%></div>
                                <div class="collapsible-body white">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td><b>Nombre</b></td>
                                                <td><%= rsContactos.getString("nombre")%></td>
                                            </tr>
                                            <tr>
                                                <td><b>Correo</b></td>
                                                <td><%= rsContactos.getString("email")%></td>
                                            </tr>
                                            <tr>
                                                <td><b>Teléfono</b></td>
                                                <td><%= rsContactos.getString("telefono")%></td>
                                            </tr>
                                            <tr>
                                                <td><b>Mensaje</b></td>
                                                <td><%= rsContactos.getString("mensaje")%></td>
                                            </tr>
                                            <tr>
                                                <td><b>Fecha</b></td>
                                                <td><%= rsContactos.getString("fecha")%></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="card-action right-align">
                                        <a href="entradaContacto.jsp?accion=1&idContacto=<%= rsContactos.getString("idContacto")%>"><i class="material-icons">delete</i></a>
                                    </div>            
                                </div>
                            </li>
                        <%}%>
                        </ul>
                    </div>
                </div>
            </div>

    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('.collapsible').collapsible();
        });
    </script>
</body>
</html>
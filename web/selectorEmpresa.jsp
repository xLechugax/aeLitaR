<%@page import="javax.servlet.http.HttpSession, bd.ConexionBD, java.sql.*"%>
<%
    HttpSession hs = request.getSession(false);

    ResultSet rsCantidadDeEmpresas = null;
    ResultSet rsListadoEmpresas = null;

    String idUsuario = request.getParameter("idUsuario");

    try {
        Connection conn = ConexionBD.getConexion();
        String sqlCantidadDeEmpresas = "select count(*) from usuario,trabaja,empresa where trabaja.idEmpresa = empresa.idEmpresa  and usuario.idUsuario = trabaja.idUsuario  and usuario.idUsuario =" + idUsuario;
        PreparedStatement pst = conn.prepareStatement(sqlCantidadDeEmpresas);
        rsCantidadDeEmpresas = pst.executeQuery();

        String sqlListadoEmpresas = "select empresa.idEmpresa,empresa.nombre from usuario,trabaja,empresa where trabaja.idEmpresa = empresa.idEmpresa  and usuario.idUsuario = trabaja.idUsuario  and usuario.idUsuario =" + idUsuario;
        PreparedStatement pstListadoEmpresas = conn.prepareStatement(sqlListadoEmpresas);
        rsListadoEmpresas = pstListadoEmpresas.executeQuery();

        if (rsCantidadDeEmpresas.next()) {
            int numeroDeEmpresas = rsCantidadDeEmpresas.getInt(1);
            if (numeroDeEmpresas > 1) {%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css"><link>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="iso-8859-1"/>
    </head>
    <body class="blue-grey lighten-5">
        <br /><br /><br /><br /><br /><br /><br /><br /><br />
    <center>
        <div class="row">
            <div class="col s12 m12">
                <div class="card blue-grey darken-1">
                    <div class="card-content white-text">
                        <span class="card-title"> Hemos detectado que trabaja en más de una empresa. <br/>
                            Seleccione la empresa con la que desea ingresar<br/>  
                        </span>
                        <form action="definirEmpresa" method="POST">
                            <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                            <select name="idEmpresa">
                                <% while (rsListadoEmpresas.next()) {%>
                                <option value="<%=rsListadoEmpresas.getString("idEmpresa")%>"><%=rsListadoEmpresas.getString("nombre")%></option>
                                <%}%>
                            </select>
                            <br/>
                            <center>
                                <input class="waves-effect waves-light btn" type="submit" value="Crear Usuario" />
                            </center>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </center>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
            $('select').material_select();
        });
    </script>
</body>
</html>
<%
                if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
                    //response.sendRedirect("/aeLita/administrador/inicioAdmin.jsp");
                    response.sendRedirect("/aeLita/selectorEmpresa.jsp?idUsuario=" + idUsuario);
                }
                if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {
                    //response.sendRedirect("/aeLita/supervisor/inicioSupervisor.jsp");
                    response.sendRedirect("/aeLita/selectorEmpresa.jsp?idUsuario=" + idUsuario);
                }
                if (hs.getAttribute("tipoCuenta").equals("Ejecutor")) {
                    //response.sendRedirect("/aeLita/ejecutor/inicioEjecutor.jsp");
                    response.sendRedirect("/aeLita/selectorEmpresa.jsp?idUsuario=" + idUsuario);
                }
            }
        } 
    } catch (Exception e) {
        out.print("Aca "+e);
    }
%>
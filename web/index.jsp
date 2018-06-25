<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession(false);  // RECUPERAR LA SESIÓN YA ABIERTA PARA EL USUARIO.
    ResultSet rsUsuarios = null;
    try
    {
        Connection conn = ConexionBD.getConexion();        
        String sql      = "select * from usuario";        
        PreparedStatement pst = conn.prepareStatement(sql);
        rsUsuarios      = pst.executeQuery();   
    }
    catch(SQLException e)
    {
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
      <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body class="blue-grey lighten-5">
        <!BARRA DE NAVEGACIÓN FIXED>
        <ul id="dropdown2" class="dropdown-content blue-grey lighten-5">
            <li><a href="#!">Escalamientos</a></li>
            <li><a href="#!">Manuales</a></li>
            <li><a href="#!">Templates</a></li>
            <li><a href="#!">Teléfonos</a></li>
            <li><a href="#!">Procedimientos</a></li>
        </ul>
        <ul class="side-nav" id="mobile-demo">
          <li><a href="pagina.jsp">Inicio</a></li>
          <li><a class="dropdown-button" href="#!" data-activates="dropdown2">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
          <li><a href="pagina.jsp">Gestor OT</a></li>
          <li><a href="pagina.jsp">Gestor Tareas</a></li>
          <li><a href="pagina.jsp">Gestor Procedimientos</a></li>
          <li><a href="pagina.jsp">Gestor Reportes</a></li>
          <li><a href="pagina.jsp">Gestor Usuarios</a></li>
          <li><a href="pagina.jsp">Gestor Estados</a></li>
        </ul>
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="#!">Escalamientos</a></li>
            <li><a href="#!">Manuales</a></li>
            <li><a href="#!">Templates</a></li>
            <li><a href="#!">Teléfonos</a></li>
            <li><a href="#!">Procedimientos</a></li>
        </ul>
        <div class="navbar-fixed">
            <nav>
              <div class="nav-wrapper blue-grey darken-3">
                <a href="#!" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
                <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                <ul class="right hide-on-med-and-down">
                  <li><a href="pagina.jsp">Inicio</a></li>
                  <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                  <li><a href="pagina.jsp">Gestor OT</a></li>
                  <li><a href="pagina.jsp">Gestor Tareas</a></li>
                  <li><a href="pagina.jsp">Gestor Procedimientos</a></li>
                  <li><a href="pagina.jsp">Gestor Reportes</a></li>
                  <li><a href="pagina.jsp">Gestor Usuarios</a></li>
                  <li><a href="pagina.jsp">Gestor Estados</a></li>
                </ul>
              </div>
            </nav>
        </div>    
    <p>
    </p>
      <!--Import jQuery before materialize.js-->
      <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script>
          $( document ).ready(function(){
              $(".button-collapse").sideNav();
              $(".dropdown-button").dropdown();
          });
      </script>
    </body>
  </html>
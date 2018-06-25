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
<!INICIO - BARRA DE NAVEGACIÓN FIXED>
        <ul id="DropDownDelNavVar" class="dropdown-content blue-grey lighten-5">
            <li><a href="#!">Escalamientos</a></li>
            <li><a href="#!">Manuales</a></li>
            <li><a href="#!">Templates</a></li>
            <li><a href="#!">Teléfonos</a></li>
            <li><a href="#!">Procedimientos</a></li>
        </ul>
        <ul class="side-nav" id="mobile-demo">
          <li><a class="dropdown-button" href="#!" data-activates="DropDownDelNavVar">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
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
<!FINAL - BARRA DE NAVEGACIÓN FIXED>   
 <div class="container"> 
    <div class="col m3 m3">
    <div class="card horizontal">
      <div class="card-image">
      </div>
      <div class="card-stacked">
        <div class="card-content">
          <p>Bienvenido a æLita.</p>
        </div>
        <div class="row">
            <form>
                <div class="input-field col m12">
                    <input id="last_name" type="text" class="validate">
                    <label for="last_name">Last Name</label>
                </div>
                <div class="input-field col m12">
                    <input id="password" type="password" class="validate">
                    <label for="password">Password</label>
                </div>
                <a class="waves-effect waves-light btn right">Ingresar</a>
            </form>  
        </div>  
        <div class="card-action">
            <a class="waves-effect waves-light btn">Registrarse</a>
        </div>
      </div>
    </div>
  </div>
</div>

        <footer class="page-footer blue-grey">
            <div class="container">
                <div class="row">
                    <div class="col l6 s12">
                        <h5 class="white-text">Footer Content</h5>
                        <p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
                    </div>
                    <div class="col l4 offset-l2 s12">
                        <h5 class="white-text">Links</h5>
                        <ul>
                            <li><a class="grey-text text-lighten-3" href="#!">Link 1</a></li>
                            <li><a class="grey-text text-lighten-3" href="#!">Link 2</a></li>
                            <li><a class="grey-text text-lighten-3" href="#!">Link 3</a></li>
                            <li><a class="grey-text text-lighten-3" href="#!">Link 4</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="footer-copyright">
                <div class="container">
                    © 2014 Copyright Text
                    <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
                </div>
            </div>
        </footer>
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
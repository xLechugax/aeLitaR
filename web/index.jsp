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
<html>
    <head>
        <!--ICONOS-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> 
        <!--CSS-->
        <link type="text/css" rel="stylesheet" href="css/materialize.css"  media="screen,projection"/>
         <!--UTF-8-->   
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--JAVA SCRIPT-->   
        <script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script>  
    </head>
    <!--EL CUERPO DEL DELITO-->   
    <body class="lime lighten-1">
        <main>
            <div class="container">
                <h3>æLita | Material Mantenimiento</h3>
                <ul id="dropdownManuales" class="dropdown-content">
                    <li><a href="../../aeLita/manuales/datos/indiceManualesDatos.html">Internet y Datos</a></li>
                    <li><a href="../../aeLita/manuales/telefonia/indiceManualesTelefonia.html">Teléfonia</a></li>
                </ul>
                <ul id="dropdownProcedimientos" class="dropdown-content">
                    <li><a href="../../aeLita/procedimientos/datos/indiceProcedimientosDatos.html">Internet y Datos</a></li>
                    <li><a href="../../aeLita/procedimientos/telefonia/indiceProcedimientosTelefonia.html">Teléfonia</a></li>
                </ul>
                <!-- BARRA DE NAVEGACIÓN -->
                <nav>
                  <div class="nav-wrapper lime darken-2">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <img src="img/wifi_78333.png" width="82" height="82" style="position: absolute; top: -10px;">
                    <ul class="right hide-on-med-and-down">
                        <li><a href="../../aeLita/index.html">Inicio</a></li>
                        <li><a href="../../aeLita/escalamientos/indexEscalamientos.html">Escalamientos</a></li>
                        <li><a class="dropdown-button" href="#!" data-target="dropdown1" data-activates = "dropdownManuales">Manuales<i class="material-icons right">arrow_drop_down</i></a></li>
                        <li><a href="../../aeLita/templates/indexTemplates.html">Templates</a></li>
                        <li><a href="../../aeLita/telefonos/indexTelefonos.html">Teléfonos</a></li>
                        <li><a class="dropdown-button" href="#!" data-target="dropdown1" data-activates = "dropdownProcedimientos">Procedimientos<i class="material-icons right">arrow_drop_down</i></a></li>
                      <!-- Dropdown Trigger -->
                    </ul>
                  </div>
                </nav>
                </br>
                <!--CARD DEL MEDIO-->   
                <div class="row">
                    <div class="col s12 m12">
                      <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                            <h5 class="white-text">Links de Útilidad</h5>
                                <ul>
                                    <li><a class="grey-text text-lighten-3" href="http://172.17.40.45/plataforma_datos/vis_equipos_datoslist.asp?cmd=resetall"><i class="material-icons">router</i>Equipos Actualizados</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://despachonacional.cl/despachonacional/siad_pyme/index.php/Login"><i class="material-icons">dashboard</i>SIAD Pyme</a></li>
                                    <li><a class="grey-text text-lighten-3" href="https://macvendors.com/"><i class="material-icons">fingerprint</i>MacVendors</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://10.41.4.141/sac/Login_input"><i class="material-icons">keyboard</i>HFC Incognito</a></li>
                                    <li><a class="grey-text text-lighten-3" href="http://agenda/Organigrama/"><i class="material-icons">local_phone</i>Organigrama</a></li>
                                </ul>
                            </div>
                      </div>
                    </div>
                </div>
                </br></br>
            </div>
        </main>
        <!--PIE DE PAGINA-->
        <footer class="page-footer lime darken-2">
            <div class="container">
                <div class="row">
                  <div class="col 12 s12">
                    <h5 class="white-text">Actualizado 22/03/2018</h5>
                    <p class="grey-text text-lighten-4">
                        Si quieres agregar contenido envía un correo a fernando.sanjuan@clarochile.cl con asunto "aeLita's".</p>
                  </div>
                </div>
            </div>
            <div class="footer-copyright">
              <div class="container">
              © Framework Materialize - Material interno perteneciente a ClaroChile. - Desarrollo: Fernando San Juan - 
              <a class="grey-text text-lighten-4 right" href="#!">Easter Egg</a>
              </div>
            </div>
        </footer>
      <!--JavaScript at end of body for optimized loading-->
      <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>
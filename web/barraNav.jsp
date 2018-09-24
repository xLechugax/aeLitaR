<%
    if (hs == null || hs.getAttribute("tipoCuenta") == null) {
%>
        <!INICIO - BARRA DE NAVEGACIÓN FIXED>
        <ul class="side-nav" id="mobile-demo">
            <li><a href="/aeLita/registro/registrarNuevoUsuario.jsp">Registro</a></li>
        </ul>
        <div class="navbar-fixed">
            <nav>
                <div class="nav-wrapper blue-grey darken-3">
                    <a href="/aeLita/index.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
                    <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                    <ul class="right hide-on-med-and-down">
                        <li><a href="/aeLita/registro/registrarNuevoUsuario.jsp">Registrate</a></li>
                    </ul>
                </div>
            </nav>
        </div>
        <!FINAL - BARRA DE NAVEGACIÓN FIXED>  
<% 
}  else  if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<!INICIO - BARRA DE NAVEGACIÓN FIXED>
<ul id="DropDownDelNavVar" class="dropdown-content blue-grey lighten-5">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<ul class="side-nav" id="mobile-demo">
    <li><a href="/aeLita/perfil/miperfil.jsp"><b>Hola <%= hs.getAttribute("nombre") %>!</b></a></li>
    <li><a class="dropdown-button" href="#!" data-activates="DropDownDelNavVar">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
    <li><a href="/aeLita/administrador/gestorOT.jsp">Órdenes de Trabajo</a></li>
    <li><a href="/aeLita/gestores/gestorTipoTareas.jsp">Gestor Tipo Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Gestor Procedimientos</a></li>
    <li><a href="/aeLita/gestores/gestorUsuarios.jsp">Gestor Usuarios</a></li>
    <li><a href="/aeLita/gestores/gestorEstados.jsp">Gestor Estados</a></li>
    <li><a href="/aeLita/administrador/entradaContacto.jsp">Contacto</a></li>
    <li><a href="/aeLita/administrador/reportes.jsp">Reportes</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="DropDownManuales" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<ul id="DropDownGestores" class="dropdown-content">
    <li><a href="/aeLita/administrador/gestorOT.jsp">Órdenes de Trabajo</a></li>
    <li><a href="/aeLita/gestores/gestorTipoTareas.jsp">Tipo Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorUsuarios.jsp"> Usuarios</a></li>
    <li><a href="/aeLita/gestores/gestorEstados.jsp"> Estados</a></li>
    <li><a href="/aeLita/gestores/gestorAreasDepartamentos.jsp">Area/Departamento</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp"> Procedimientos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/administrador/inicioAdmin.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="/aeLita/perfil/miperfil.jsp"><b>Hola <%= hs.getAttribute("nombre") %>!</b></a></li>
                <li><a class="dropdown-button" href="#!" data-activates="DropDownManuales">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a style="width: 180px" class="dropdown-button" href="#!" data-activates="DropDownGestores">Gestores<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/administrador/entradaContacto.jsp">Contacto</a></li>
                <li><a href="/aeLita/administrador/reportes.jsp">Reportes</a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
} else if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {
%>
<!INICIO - BARRA DE NAVEGACIÓN FIXED>
<ul id="DropDownDelNavVar" class="dropdown-content blue-grey lighten-5">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<ul class="side-nav" id="mobile-demo">
    <li><a href="/aeLita/perfil/miperfil.jsp"><b>Hola <%= hs.getAttribute("nombre") %>!</b></a></li>
    <li><a class="dropdown-button" href="#!" data-activates="DropDownDelNavVar">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
    <li><a href="/aeLita/supervisor/gestorOT.jsp">Gestor Órdenes de Trabajo</a></li>
    <li><a href="/aeLita/supervisor/reportes.jsp">Reportes</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/supervisor/inicioSupervisor.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="/aeLita/perfil/miperfil.jsp"><b>Hola <%= hs.getAttribute("nombre") %>!</b></a></li>
                <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/supervisor/gestorOT.jsp">Gestor Órdenes de Trabajo</a></li>
                <li><a href="/aeLita/supervisor/reportes.jsp">Reportes</a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
} else { //De lo contrario es: Ejecutor.
%>
<!INICIO - BARRA DE NAVEGACIÓN FIXED>
<ul id="DropDownDelNavVar" class="dropdown-content blue-grey lighten-5">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<ul class="side-nav" id="mobile-demo">
    <li><a class="dropdown-button" href="#!" data-activates="DropDownDelNavVar">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
    <li><a href="/aeLita/perfil/miperfil.jsp">Hola <%= hs.getAttribute("nombre") %></a></li>
    <li><a href="/aeLita/ejecutor/gestorTareas.jsp">Gestor Tareas</a></li>
    <li><a href="/aeLita/ejecutor/reportes.jsp">Reportes</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/ejecutor/inicioEjecutor.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="/aeLita/perfil/miperfil.jsp"><b>Hola <%= hs.getAttribute("nombre") %>!</b></a></li>
                <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/ejecutor/gestorTareas.jsp">Gestor Tareas</a></li>
                <li><a href="/aeLita/ejecutor/reportes.jsp">Reportes</a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
    }
%>
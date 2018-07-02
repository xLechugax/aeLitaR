<%
    if (hs.getAttribute("tipoCuenta").equals("Administrador")){
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
    <li><a href="/aeLita/gestores/gestorOT.jsp">Gestor OT</a></li>
    <li><a href="/aeLita/gestores/gestorTareas.jsp">Gestor Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Gestor Procedimientos</a></li>
    <li><a href="/aeLita/gestores/gestorReportes.jsp">Gestor Reportes</a></li>
    <li><a href="/aeLita/gestores/gestorUsuarios.jsp">Gestor Usuarios</a></li>
    <li><a href="/aeLita/gestores/gestorEstados.jsp">Gestor Estados</a></li>
    <li><a href="/aeLita/perfil/miperfil.jsp">Perfil</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/teléfonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/administrador/inicioAdmin.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/gestores/gestorOT.jsp">Gestor OT</a></li>
                <li><a href="/aeLita/gestores/gestorTareas.jsp">Gestor Tareas</a></li>
                <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Gestor Procedimientos</a></li>
                <li><a href="/aeLita/gestores/gestorReportes.jsp">Gestor Reportes</a></li>
                <li><a href="/aeLita/gestores/gestorUsuarios.jsp">Gestor Usuarios</a></li>
                <li><a href="/aeLita/gestores/gestorEstados.jsp">Gestor Estados</a></li>
                <li><a href="/aeLita/gestores/gestorAreasDepartamentos.jsp">Gestor A/D</a></li>
                <li><a href="/aeLita/perfil/miperfil.jsp">Perfil</a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
   }else if(hs.getAttribute("tipoCuenta").equals("Supervisor")){
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
    <li><a href="/aeLita/gestores/gestorOT.jsp">Gestor OT</a></li>
    <li><a href="/aeLita/gestores/gestorTareas.jsp">Gestor Tareas</a></li>
    <li><a href="/aeLita/perfil/miperfil.jsp">Perfil</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/teléfonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/administrador/inicioAdmin.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/gestores/gestorOT.jsp">Gestor OT</a></li>
                <li><a href="/aeLita/gestores/gestorTareas.jsp">Gestor Tareas</a></li>
                <li><a href="/aeLita/perfil/miperfil.jsp">Perfil</a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
   }else{
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
    <li><a href="/aeLita/gestores/gestorTareas.jsp">Gestor Tareas</a></li>
    <li><a href="/aeLita/perfil/miperfil.jsp">Perfil</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/teléfonos/index.jsp">Teléfonos</a></li>
    <li><a href="/aeLita/materiales/procedimientos/index.jsp">Procedimientos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/administrador/inicioAdmin.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;æLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a class="dropdown-button" href="#!" data-activates="dropdown1">Materiales<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/gestores/gestorTareas.jsp">Gestor Tareas</a></li>
                <li><a href="/aeLita/perfil/miperfil.jsp">Perfil</a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
   }
%>
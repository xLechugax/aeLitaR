<% 
    if (hs == null || hs.getAttribute("tipoCuenta") == null) {
%>
<!INICIO - BARRA DE NAVEGACI”N FIXED>
<ul class="side-nav" id="mobile-demo">
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/index.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;ÊLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
            </ul>
        </div>
    </nav>
</div>
<!FINAL - BARRA DE NAVEGACI”N FIXED>  
<%
} else if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<!INICIO - BARRA DE NAVEGACI”N FIXED>
<ul class="side-nav" id="mobile-demo">
    <li><a href="/aeLita/perfil/miperfil.jsp"><b>°Hola <%= hs.getAttribute("nombre")%>!</b></a></li>
    <li><a href="/aeLita/administrador/gestorOT.jsp">”rdenes de Trabajo</a></li>
    <li><a href="/aeLita/gestores/gestorTipoTareas.jsp">Gestor Tipo Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Gestor Procedimientos</a></li>
    <li><a href="/aeLita/gestores/gestorUsuarios.jsp">Gestor Usuarios</a></li>
    <li><a href="/aeLita/gestores/gestorEstados.jsp">Gestor Estados</a></li>
    <li><a href="/aeLita/administrador/entradaContacto.jsp">Contacto</a></li>
    <li><a href="/aeLita/administrador/reportes.jsp">Reportes</a></li>
    <% if (hs.getAttribute("idUsuarioSesion").equals("0000000001")) {%><li><a href="/aeLita/administrador/empresas.jsp">Empresas</a></li><%}%>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="DropDownGestores" class="dropdown-content">
    <li><a href="/aeLita/administrador/gestorOT.jsp">”rdenes de Trabajo</a></li>
    <li><a href="/aeLita/gestores/gestorTipoTareas.jsp">Tipos de Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorUsuarios.jsp"> Usuarios</a></li>
    <li><a href="/aeLita/gestores/gestorEstados.jsp"> Estados</a></li>
    <li><a href="/aeLita/gestores/gestorAreasDepartamentos.jsp">¡rea/Departamento</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Procedimientos</a></li>
    <li><a href="/aeLita/gestores/gestorArchivos.jsp">Archivos</a></li>
    <% if (hs.getAttribute("idUsuarioSesion").equals("0000000001")) {%><li><a href="/aeLita/administrador/empresas.jsp">Empresas</a></li><%}%>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/administrador/inicioAdmin.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;ÊLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="/aeLita/perfil/miperfil.jsp"><b>°Hola <%= hs.getAttribute("nombre")%>!</b></a></li>
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
<!INICIO - BARRA DE NAVEGACI”N FIXED>
<ul id="DropDownDelNavVarGestores" class="dropdown-content blue-grey lighten-5">
    <li><a href="/aeLita/supervisor/gestorOT.jsp">”rdenes de Trabajo</a></li>
    <li><a href="/aeLita/supervisor/gestorOTTareas.jsp">Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Procedimientos</a></li>
    <li><a href="/aeLita/supervisor/reportes.jsp">Reportes</a></li>
</ul>
<ul class="side-nav" id="mobile-demo">
    <li><a href="/aeLita/perfil/miperfil.jsp"><b>°Hola <%= hs.getAttribute("nombre")%>!</b></a></li>
    <li><a class="dropdown-button" href="#!" data-activates="DropDownDelNavVarGestores">Gestores<i class="material-icons right">arrow_drop_down</i></a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">TelÈfonos</a></li>
</ul>
<ul id="dropdownGestores" class="dropdown-content">
    <li><a href="/aeLita/supervisor/gestorOT.jsp">”rdenes de Trabajo</a></li>
    <li><a href="/aeLita/supervisor/gestorOTTareas.jsp">Tareas</a></li>
    <li><a href="/aeLita/gestores/gestorProcedimientos.jsp">Procedimientos</a></li>
    <li><a href="/aeLita/supervisor/reportes.jsp">Reportes</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/supervisor/inicioSupervisor.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;ÊLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="/aeLita/perfil/miperfil.jsp"><b>°Hola <%= hs.getAttribute("nombre")%>!</b></a></li>
                <li><a class="dropdown-button" style="width: 180px;" href="#!" data-activates="dropdownGestores">Gestores<i class="material-icons right">arrow_drop_down</i></a></li>
                <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li> 
            </ul>
        </div>
    </nav>
</div>
<%
} else { //De lo contrario es: Ejecutor.
%>
<!INICIO - BARRA DE NAVEGACI”N FIXED>
<ul id="DropDownDelNavVar" class="dropdown-content blue-grey lighten-5">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">TelÈfonos</a></li>
</ul>
<ul class="side-nav" id="mobile-demo">
    <li><a href="/aeLita/perfil/miperfil.jsp">°Hola <%= hs.getAttribute("nombre")%></a></li>
    <li><a href="/aeLita/ejecutor/gestorTareas.jsp">Gestor Tareas</a></li>
    <li><a href="/aeLita/ejecutor/reportes.jsp">Reportes</a></li>
    <li><a href="/aeLita/CerrarSesion.jsp"><i class="material-icons right">exit_to_app</i>Salir</a></li>
</ul>
<ul id="dropdown1" class="dropdown-content">
    <li><a href="/aeLita/materiales/escalamientos/index.jsp">Escalamientos</a></li>
    <li><a href="/aeLita/materiales/manuales/index.jsp">Manuales</a></li>
    <li><a href="/aeLita/materiales/templates/index.jsp">Templates</a></li>
    <li><a href="/aeLita/materiales/telefonos/index.jsp">TelÈfonos</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper blue-grey darken-3">
            <a href="/aeLita/ejecutor/inicioEjecutor.jsp" class="brand-logo">&nbsp;&nbsp;&nbsp;&nbsp;ÊLita</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="/aeLita/perfil/miperfil.jsp"><b>°Hola <%= hs.getAttribute("nombre")%>!</b></a></li>
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
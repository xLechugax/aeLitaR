<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO
    // Recuperar la sesión del usuario actual
    try {
        if (hs == null || hs.getAttribute("tipoCuenta") == null) {
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
    if ( !hs.getAttribute("tipoCuenta").equals("Supervisor") && !hs.getAttribute("tipoCuenta").equals("Administrador")) {
%> 
<html>
    <head>
        <% if (hs.getAttribute("tipoCuenta").equals("Supervisor")) { %> 
         <meta http-equiv="Refresh" content="5;url=/aeLita/supervisor/inicioSupervisor.jsp">
        <%} else { %> 
            <meta http-equiv="Refresh" content="5;url=/aeLita/ejecutor/inicioEjecutor.jsp">
        <%}%> 
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
                            <p>No tienes permisos para poder acceder a este lugar... <br/> Te estamos redirigiendo, si no quieres esperar haz clic</p>
                        </div>
                        <div class="card-action">
                            <% if (hs.getAttribute("tipoCuenta").equals("Supervisor")) { %> 
                            <a href="/aeLita/supervisor/inicioSupervisor.jsp">¡AQUÍ!</a>
                            <% } else { %> 
                            <a href="/aeLita/ejecutor/inicioEjecutor.jsp">¡AQUÍ!</a>
                            <%}%> 
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

%>
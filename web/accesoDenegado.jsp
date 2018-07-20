<%
    if (hs.getAttribute("tipoCuenta").equals("Administrador")) {
%>
<html>  
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/administrador/inicioAdmin.jsp">
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
                        <span class="card-title">¡ACCESO DENEGADO!</span>
                        <p>No tienes permisos suficientes para estar aca, te estamos redirigendo al comienzo,si no quieres esperar haz click...</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/administrador/inicioAdmin.jsp">¡AQUÍ!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%
} else if (hs.getAttribute("tipoCuenta").equals("Supervisor")) {
%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/supervisor/inicioSupervisor.jsp">
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
                        <span class="card-title">¡ACCESO DENEGADO!</span>
                        <p>No tienes permisos suficientes para estar aca, te estamos redirigendo al comienzo,si no quieres esperar haz click...</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/supervisor/inicioSupervisor.jsp">¡AQUÍ!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%
} else if (hs.getAttribute("tipoCuenta").equals("Ejecutor")) {
%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/ejecutor/inicioEjecutor.jsp">
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
                        <span class="card-title">¡ACCESO DENEGADO!</span>
                        <p>No tienes permisos suficientes para estar aca, te estamos redirigendo al comienzo,si no quieres esperar haz click...</p>
                    </div>
                    <div class="card-action">
                        <a href="/aeLita/ejecutor/inicioEjecutor.jsp">¡AQUÍ!</a>
                    </div>
                </div>
            </div>
        </div>
    </center>
</body>
</html>
<%
} else {
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
                        <span class="card-title">¡ACCESO DENEGADO!</span>
                        <p>No tienes permisos suficientes para estar aca, te estamos redirigendo al comienzo,si no quieres esperar haz click...</p>
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
    }
%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO
    // Recuperar la sesión del usuario actual
    try {
        if (hs == null || hs.getAttribute("tipoCuenta") == null) {
%>
<html>
    <head>
        <meta http-equiv="Refresh" content="5;url=/aeLita/index.jsp">
        <link rel="stylesheet" type="text/css" href="/aeLita/css/materialize.min.css" media="print"><link>
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
} else {
%>

<%
        }

    } catch (Exception e) {
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
                        <div class="card">
                            <div class="card-content">
                                Hola <%= hs.getAttribute("nombre")%>, estas son tus estadisticas:
                            </div>
                            <canvas id="myChart" width="400" height="200"></canvas>
                        </div>
                    </div>
                </div>
            </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/Chart.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        var canvas = document.getElementById('myChart');
        var data = {
            labels: ["January", "<%= hs.getAttribute("nombre") %>", "March", "April", "May", "June", "July", "caca"],
            datasets: [
                {
                    label: "My First dataset",
                    backgroundColor: "rgba(102,127,153,0.2)",
                    borderColor: "rgba(255,99,132,1)",
                    borderWidth: 2,
                    hoverBackgroundColor: "rgba(255,99,132,0.4)",
                    hoverBorderColor: "rgba(255,99,132,1)",
                    data: [65, 59, 30, 81, 56, 55, 40,100],
                }
            ]
        };
        var option = { animation: { duration: 5000 } };
        var myBarChart = Chart.Line(canvas, { data: data, options: option });
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
<style>
        body {
            display: flex;
            min-height: 100vh;
            flex-direction: column;
        }

        main {
            flex: 1 0 auto;
        }
</style>
<footer class="page-footer blue-grey">
        <div class="container">
            <div class="row">
                <div class="col l6 s12">
                    <%
                    if (hs == null || hs.getAttribute("tipoCuenta") == null) {%>
                    <h5 class="white-text">¿Quieres contratar nuestro servicio?</h5> 
                    <a href="/aeLita/contacto.jsp" class="grey-text text-lighten-4">Contáctanos...</a>
                    <%} else {%>
                    <h5 class="white-text">¿Tienes algún problema, sugerencia o comentario?</h5> 
                    <a href="/aeLita/contacto.jsp" class="grey-text text-lighten-4">Contáctanos...</a>                    
                    <%}%>
                </div>
            </div>
        </div>
        <div class="footer-copyright">
            <div class="container">
                <div class="right-align">
                    © 2018 æLita Copyright
                    <%--<a class="grey-text text-lighten-4 right" href="#!">More Links</a>--%>
                </div>
            </div>
        </div>
    </footer>
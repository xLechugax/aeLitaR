<%@page import="java.sql.*,bd.*,javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession hs = request.getSession(false); //RECUPERA LA SESIÓN DEL USUARIO YA INICIADO

    if (hs == null || hs.getAttribute("tipoCuenta") == null) {
%>
<%@ include file="../../accesoDenegado.jsp" %>
<%        
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
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
    <main>
        <body class="blue-grey lighten-5">
            <%@ include file="../../barraNav.jsp" %>
            <div class="container"> 
            <div class="col s12 m12">
                      <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <div class="row">
                                    <div class="col s6 m6">
                                        <h5 class="white-text">Mini Manuales</h5>    
                                        <ul>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Adyacencia por BGP.txt"><i class=material-icons>picture_as_pdf</i>Ver Adyacencia por BGP</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/ChileXpress Matriz ADDPAC.txt"><i class=material-icons>picture_as_pdf</i>User/Pass Addpack</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/WAN ANDESAT.txt"><i class=material-icons>picture_as_pdf</i>WAN Concentrador Andesat</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/Ver Adyacencia por BGP.txt"><i class=material-icons>picture_as_pdf</i>Ver Adyacencia por BGP</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/Ver trafico en Fortinet.txt"><i class=material-icons>picture_as_pdf</i>Ver trafico (Sniffer) en Fortinet</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/VLAN MISMATCH.txt"><i class=material-icons>picture_as_pdf</i>Quitar error VLAN MISMATCH</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/Revision zyxel.txt"><i class=material-icons>picture_as_pdf</i>Revision Zyxel</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/revisar ATM.txt"><i class=material-icons>picture_as_pdf</i>Revisar ATM</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/Quitar errores dns.txt"><i class=material-icons>picture_as_pdf</i>Quitar errores de DNS</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/Homologaciones.txt"><i class=material-icons>picture_as_pdf</i>Homologaciones </a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/homologar en huawei.txt"><i class=material-icons>picture_as_pdf</i>Homologar en Huawei</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/IP Accounintg.txt"><i class=material-icons>picture_as_pdf</i>Realizar IP Accounintg</a></li>
                                                <li><a class="grey-text text-lighten-3" href="../datos/Configurar LOG en RT.txt"><i class=material-icons>picture_as_pdf</i>Configurar LOG de Eventos en Cisco</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/QG_Alta Disponibilidad.pdf"><i class=material-icons>picture_as_pdf</i>Comandos HSRP / Alta Disponibilidad</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Ejemplo configuración BGP con telefonia.txt"><i class=material-icons>picture_as_pdf</i>Ejemplo configuración BGP con telefonia</a></li>
                                            <br/>
                                        </ul>    
                                    </div>
                                    <div class="col s6 m6">
                                        <h5 class="white-text">Manuales</h5>
                                        <ul>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Como revisar un servicio de Datos.pdf"><i class=material-icons>picture_as_pdf</i>Cómo revisar un servicio de Datos</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Claro Introducción IOS XR.ppt"><i class=material-icons>picture_as_pdf</i>Introducción a IOS XR</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Comandos para revisar router Cisco.docx"><i class=material-icons>picture_as_pdf</i>Comandos básicos para revisar router Cisco</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Alta Disponibilidad.pdf"><i class=material-icons>picture_as_pdf</i>Cenceptos básicos de Alta Disponibilidad / Cisco</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Quick Guide_Como seguir una VLAN.pdf"><i class=material-icons>picture_as_pdf</i>Quick Guide - Como seguir una VLAN</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/comandos-huawei-Cisco.pdf"><i class=material-icons>picture_as_pdf</i>Comandos de Huawei a Cisco y Cisco a Huawei</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Como revisar un servicio de Datos que esta encapsulado en Q-in-Q.docx"><i class=material-icons>picture_as_pdf</i>Como revisar Datos encapsulado en Q-in-Q</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Anchos_BandaATM.xls"><i class=material-icons>picture_as_pdf</i>Anchos de Banda en ATM</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/configuracion QoS router cisco huawei.txt"><i class=material-icons>picture_as_pdf</i>Configurar QoS router Cisco y Huawei</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Como se sigue una VLAN.pdf"><i class=material-icons>picture_as_pdf</i>Cómo se sigue una VLAN?</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/MANUAL_IMC-Media Converter.pdf"><i class=material-icons>picture_as_pdf</i>Equipo IMC Media Converter</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Port-Channel Acceso Clientes.pdf"><i class=material-icons>picture_as_pdf</i>Guia del Port-Channel / Acceso Clientes</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/QoS Cisco.xlsx"><i class=material-icons>picture_as_pdf</i>QoS Cisco</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/QoS Huawei.docx"><i class=material-icons>picture_as_pdf</i>QoS Huawei</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/RED M1000 EFE COMPLETA.pdf"><i class=material-icons>picture_as_pdf</i>RED M1000 EFE Completa</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Guia Configuracion Fortigate 200D.pdf"><i class=material-icons>picture_as_pdf</i>Guia Configuracion Fortigate 200D</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Guia Configuracion Fortigate 50E.pdf"><i class=material-icons>picture_as_pdf</i>Guia Configuracion Fortigate 50E</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Guia Configuracion Fortigate 60D.pdf"><i class=material-icons>picture_as_pdf</i>Guia Configuracion Fortigate 60D</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Guia Configuracion Fortigate 80D.PDF"><i class=material-icons>picture_as_pdf</i>Guia Configuracion Fortigate 80D</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Guia Configuracion Fortigate 80D_v2.pdf"><i class=material-icons>picture_as_pdf</i>Guia Configuracion Fortigate 80D V2</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../datos/Troubleshooting Fortinet.pdf"><i class=material-icons>picture_as_pdf</i>Realizar Troubleshooting Fortinet</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                      </div>
                    </div>
                <div class="row">
                    <div class="col s12 m12">
                      <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <div class="row">
                                    <div class="col s6 m6">
                                        <h5 class="white-text">Manuales de Teléfonia</h5>    
                                        <ul>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Capacitacion CCE Trazas CC08 y NGN.pdf"><i class=material-icons>picture_as_pdf</i>Capacitacion CCE Trazas CC08 y NGN</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/CC08 NGN.docx"><i class=material-icons>picture_as_pdf</i>Manual CC08 NGN</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Comandos PRA NGN.txt"><i class=material-icons>picture_as_pdf</i>Comandos PRA NGN</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Configuración tel‚fono SIP Trunk para pruebas en terreno..pdf"><i class=material-icons>picture_as_pdf</i>Configuración de teléfono SIP Trunk para pruebas en terreno</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Datos para configuración de E1 PRI Claro 2015.doc"><i class=material-icons>picture_as_pdf</i>Datos para configuración de E1 PRI Claro 2015</a></li>
                                        </ul>    
                                    </div>
                                    <div class="col s6 m6">
                                        <br/><br/>
                                        <ul>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/FAX MEDIANT.txt"><i class=material-icons>picture_as_pdf</i>Codecs necesarios para habilitar FAX en Mediant</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Revision Call Manager Basica.txt"><i class=material-icons>picture_as_pdf</i>Revision Call Manager Básica</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Tracear PRA NGN.docx"><i class=material-icons>picture_as_pdf</i>Tracear PRA en NGN</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/tutorial telefonia final.docx"><i class=material-icons>picture_as_pdf</i>Tutorial Teféfonia Final</a></li>
                                            <li><a class="grey-text text-lighten-3" href="../telefonia/Ver el Traducido de un 600.txt"><i class=material-icons>picture_as_pdf</i>Ver el Traducido de un N° 600 en NGN</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                      </div>
                    </div>
                </div>
                </div>
        </div>
    </main>
    <%@ include file="/footer.jsp" %>
    <script type="text/javascript" src="/aeLita/js/code.jquery.com_jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/aeLita/js/materialize.min.js"></script>
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
            $(".dropdown-button").dropdown();
        });
    </script>
</body>
</html>
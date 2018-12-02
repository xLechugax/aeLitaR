package bd;

import static java.lang.System.out;
import java.sql.*;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Email {

    public boolean enviarCorreo(String para) throws SQLException {
        boolean enviado = false;
        String de = "recuperarclave@aelitasoft.cl";
        String clave = "(GF-5,jH^lsB";
        ResultSet rsUsuarioRecuperado = null;
        ResultSet rsUsuarioRecuperadoContador = null;
        try {
            Connection conn = ConexionBD.getConexion();
            String sqlRecuperarClave = "SELECT * from usuario WHERE email='" + para + "'";
            PreparedStatement pstRecuperarClave = conn.prepareStatement(sqlRecuperarClave);
            PreparedStatement pstRecuperarClaveContador = conn.prepareStatement(sqlRecuperarClave);
            rsUsuarioRecuperado = pstRecuperarClave.executeQuery();
            rsUsuarioRecuperadoContador = pstRecuperarClaveContador.executeQuery();
            rsUsuarioRecuperado.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        if (rsUsuarioRecuperadoContador.next() == false) {
            enviado = false;
        } else {
            String mensaje = "Hola " + rsUsuarioRecuperado.getString("nombre") + " " + rsUsuarioRecuperado.getString("apellido") + "\n"
                    + "\n"
                    + "\n"
                    + "La clave para ingresar a aeLitaSoft es: " + rsUsuarioRecuperado.getString("clave");
            try {
                String host = "mocha3026.mochahost.com";
                Properties prop = System.getProperties();
                prop.put("mail.smtp.starttls.enable", "true");
                prop.put("mail.smtp.host", host);
                prop.put("mail.smtp.user", de);
                prop.put("mail.smtp.password", clave);
                prop.put("mail.smtp.port", 2525);
                prop.put("mail.smtp.auth", "true");
                Session sesion = Session.getDefaultInstance(prop, null);
                MimeMessage message = new MimeMessage(sesion);
                message.setFrom(new InternetAddress(de));
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(para));
                message.setSubject("Clave Recuperada: aeLitaSoft.cl");
                message.setText(mensaje);
                Transport transport = sesion.getTransport("smtp");
                transport.connect(host, de, clave);
                transport.sendMessage(message, message.getAllRecipients());
                transport.close();
                enviado = true;
            } catch (MessagingException e) {
                System.out.println(e);
            }
        }
        return enviado;
    }
}

package bd;

import java.sql.*;

public class ConexionBDHosting {

    private static String user = "soller99_user";
    private static String pass = "soller99_user";
    private static Connection conn = null;

    public static Connection getConexion() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String unicode = "useSSL=false&autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8";
            return DriverManager.getConnection("jdbc:mysql://mysql1005.mochahost.com/soller99_aelita?" + unicode, user, pass);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            System.out.println("couldn't connect!");
            throw new RuntimeException(ex);
        }
    }
}
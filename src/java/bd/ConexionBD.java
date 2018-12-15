package bd;

import java.sql.*;

public class ConexionBD {

    private static String url = "jdbc:mysql://127.0.0.1:3306/aelita";
    private static String user = "root";
    private static String pass = "Teleco123";
    private static Connection conn = null;

    public static Connection getConexion() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String unicode = "useSSL=false&autoReconnect=true&useUnicode=yes&characterEncoding=UTF-8";
            return DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/aelita?" + unicode, user, pass);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            System.out.println("couldn't connect!");
            throw new RuntimeException(ex);
        }
    }
}
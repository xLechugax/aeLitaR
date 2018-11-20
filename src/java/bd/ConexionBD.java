package bd;
import java.sql.*;

public class ConexionBD 
{
    private static String url = "jdbc:mysql://127.0.0.1:3306/aelita";
    private static String user= "root";
    private static String pass= "Teleco123";
    private static Connection conn = null;
    
    public static Connection getConexion() {
        try {
            if(conn==null) {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url,user,pass);
            }

            return conn;
        }
        catch(Exception e) {
            System.err.println("Excepción de Conexión de SQL: " + e);
            return null;
        }
    }
}

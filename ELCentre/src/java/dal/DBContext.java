package dal;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    private static DBContext instance = new DBContext();
    private Connection connection;

    public static DBContext getInstance() {
        return instance;
    }

    public Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                String user = "sa";
                String password = "123";
                String url = "jdbc:sqlserver://localhost:1433;databaseName=ELCentre;user=sa;password=YourPassword;encrypt=true;trustServerCertificate=true";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url, user, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
            connection = null;
        }
        return connection;
    }

    private DBContext() {
        getConnection(); 
    }

    
    public static void main(String[] args) {
        DBContext db = new DBContext();
        
    }
}
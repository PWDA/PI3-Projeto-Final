package br.com.senac.pi3.pwda.db.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionUtils {
    
     public static Connection getConnection()
        throws ClassNotFoundException, SQLException {

        Class.forName("com.mysql.jdbc.Driver");


        Connection connection = null;
        String dbURL = "jdbc:mysql://localhost:3306/PWDA";
  
        Properties properties = new Properties();
        properties.put("user", "root");


        connection = DriverManager.getConnection(dbURL, properties);
        
        return connection;
    }
}

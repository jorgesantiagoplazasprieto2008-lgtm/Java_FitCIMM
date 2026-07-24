package Util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConexionDB {

    private static final Properties propiedades = new Properties();

    static {

        try (InputStream input = ConexionDB.class
                .getClassLoader()
                .getResourceAsStream("application.properties")) {

            if (input == null) {
                throw new RuntimeException("No se encontró el archivo application.properties.");
            }

            propiedades.load(input);

            Class.forName(propiedades.getProperty("db.driver"));

        } catch (IOException | ClassNotFoundException e) {

            throw new RuntimeException("Error al cargar la configuración de la base de datos.", e);

        }
    }

    public static Connection obtenerConexion() throws SQLException {

        return DriverManager.getConnection(
                propiedades.getProperty("db.url"),
                propiedades.getProperty("db.user"),
                propiedades.getProperty("db.password")
        );

    }

}
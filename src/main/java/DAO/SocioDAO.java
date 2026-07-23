package DAO;

import Modelo.Socio;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SocioDAO {

    public boolean RegistrarSocios(Socio socio) throws SQLException{
        String query = "INSERT INTO socio(documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement PS = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            PS.setString(1, socio.getDocumento());
            PS.setString(2, socio.getNombres());
            PS.setString(3, socio.getApellidos());
            PS.setString(4, socio.getTelefono());
            PS.setString(5, socio.getCorreo());
            PS.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            PS.setBoolean(7, socio.getActivo());

            int filasAfectadas = PS.executeUpdate();
            if (filasAfectadas > 0) {
                try (ResultSet rs = PS.getGeneratedKeys())
                {
                    if (rs.next()) {
                        socio.setIdSocio(rs.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }
    public List<Socio> listarTodos() throws  SQLException {
        List<Socio> socios = new ArrayList<>();
        String query = "SELECT id_socio, documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo FROM socio ORDER BY apellidos ASC";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement PS = con.prepareStatement(query); ResultSet rs = PS.executeQuery()) {
            while (rs.next()) {
                socios.add(mapearSocio(rs));
            }
        }
        return socios;
    }

    private Socio mapearSocio(ResultSet rs) throws SQLException {
        return new Socio(
                rs.getInt("id_socio"),
                rs.getString("documento"),
                rs.getString("nombres"),
                rs.getString("apellidos"),
                rs.getString("telefono"),
                rs.getString("correo"),
                rs.getDate("fecha_nacimiento").toLocalDate(), // Conversión directa a java.time.LocalDate
                rs.getBoolean("activo")
        );
    }
    }


package DAO;

import Modelo.Socio;
import Util.*;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SocioDAO {

    // RF 01
    public void RegistrarSocios(Socio socio) throws SQLException {
        String query = "INSERT INTO socio(documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement PS = con.prepareStatement(query)) {
            PS.setString(1, socio.getDocumento());
            PS.setString(2, socio.getNombres());
            PS.setString(3, socio.getApellidos());
            PS.setString(4, socio.getTelefono());
            PS.setString(5, socio.getCorreo());
            PS.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            PS.setBoolean(7, socio.getActivo());

            PS.executeUpdate();
        }
    }

    // RF 02
    public List<Socio> listarTodos() throws SQLException {
        List<Socio> socios = new ArrayList<>();
        String query = "SELECT id_socio, documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo FROM socio ORDER BY apellidos ASC";
        try (Connection con = ConexionDB.obtenerConexion(); PreparedStatement PS = con.prepareStatement(query); ResultSet rs = PS.executeQuery()) {
            while (rs.next()) {
                socios.add(mapearSocio(rs));
            }
        }
        return socios;
    }

    //RF 03
    public Socio obtenerPorId(int idSocio) throws SQLException {
        String query = "SELECT id_socio, documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo FROM socio WHERE id_socio = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearSocio(rs);
                }
            }
        }
        return null;
    }


    public Socio buscarSocioPorDocumento(String documento) throws SQLException {
        String sql = "SELECT id_socio, documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo FROM socio WHERE documento = ?";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, documento);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Socio s = new Socio();
                    s.setIdSocio(rs.getInt("id_socio"));
                    s.setDocumento(rs.getString("documento"));
                    s.setNombres(rs.getString("nombres"));
                    s.setApellidos(rs.getString("apellidos"));
                    s.setTelefono(rs.getString("telefono"));
                    s.setCorreo(rs.getString("correo"));
                    // Conversión directa a java.time.LocalDate
                    s.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    s.setActivo(rs.getBoolean("activo"));
                    return s;
                }
            }
        }
        return null;
    }
    // RF 04
    public boolean actualizar(Socio socio) throws SQLException {
        String query = "UPDATE socio SET documento = ?, nombres = ?, apellidos = ?, telefono = ?, correo = ?, fecha_nacimiento = ?, activo = ? WHERE id_socio = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, socio.getDocumento());
            ps.setString(2, socio.getNombres());
            ps.setString(3, socio.getApellidos());
            ps.setString(4, socio.getTelefono());
            ps.setString(5, socio.getCorreo());
            ps.setDate(6, Date.valueOf(socio.getFechaNacimiento()));
            ps.setBoolean(7, socio.getActivo());
            ps.setInt(8, socio.getIdSocio());

            return ps.executeUpdate() > 0;
        }
    }

    //RF 05

    public boolean inactivar(int idSocio) throws SQLException {
        String query = "UPDATE socio SET activo = 0 WHERE id_socio = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, idSocio);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean activar(int idSocio) throws SQLException {
        String query = "UPDATE socio SET activo = 1 WHERE id_socio = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(query))  {
            ps.setInt(1, idSocio);
            return ps.executeUpdate() > 0;
        }
    }
    //RF 06
    public List<Socio> buscar(String criterio) throws SQLException {
        List<Socio> socios = new ArrayList<>();
        String query = "SELECT id_socio, documento, nombres, apellidos, telefono, correo, fecha_nacimiento, activo FROM socio " +
                "WHERE (documento LIKE ? OR apellidos LIKE ?) AND activo = 1 ORDER BY apellidos ASC";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(query)) {

            String parametro = "%" + criterio + "%";
            ps.setString(1, parametro);
            ps.setString(2, parametro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    socios.add(mapearSocio(rs));
                }
            }
        }
        return socios;
    }

    // EXTRAS / AYUDA

    public boolean existeDocumento(String doc) throws SQLException {
        String sql = "SELECT 1 FROM socio WHERE documento = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, doc);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
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


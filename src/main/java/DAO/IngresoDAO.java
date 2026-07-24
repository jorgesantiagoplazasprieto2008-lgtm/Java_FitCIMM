package DAO;

import Modelo.Ingreso;
import Util.ConexionDB;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class IngresoDAO {

    public void RegistrarIngreso(Ingreso ing) throws SQLException {
        String sql = "INSERT INTO ingreso (id_socio, fecha_ingreso, hora_ingreso) VALUES (?, ?, ?)";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, ing.getIdSocio());
            ps.setDate(2, Date.valueOf(ing.getFechaIngreso()));
            ps.setTime(3, Time.valueOf(ing.getHoraIngreso()));
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    ing.setIdIngreso(rs.getInt(1));
                }
            }
        }
    }
    // RN-06: Comprueba si el socio ya ingresó en el día de hoy
    public boolean yaIngresoHoy(int idSocio, LocalDate fecha) throws SQLException {
        String sql = "SELECT 1 FROM ingreso WHERE id_socio = ? AND fecha_ingreso = ?";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idSocio);
            ps.setDate(2, Date.valueOf(fecha));

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Retorna true si ya existe una fila para hoy
            }
        }
    }
    // RF-14: Listar ingresos por fecha (Une la tabla de ingresos con socios)
    public List<Ingreso> consultarPorFecha(LocalDate fecha) throws SQLException {
        List<Ingreso> ingresos = new ArrayList<>();
        String sql = "SELECT i.id_ingreso, i.id_socio, i.fecha_ingreso, i.hora_ingreso, s.documento, s.nombres, s.apellidos " +
                "FROM ingreso i " +
                "INNER JOIN socio s ON i.id_socio = s.id_socio " +
                "WHERE i.fecha_ingreso = ? " +
                "ORDER BY i.hora_ingreso DESC";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(fecha));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ingreso ing = new Ingreso(
                            rs.getInt("id_ingreso"),
                            rs.getInt("id_socio"),
                            rs.getDate("fecha_ingreso").toLocalDate(),
                            rs.getTime("hora_ingreso").toLocalTime()
                    );
                    ing.setDocumentoSocio(rs.getString("documento"));
                    ing.setNombreCompletoSocio(rs.getString("nombres") + " " + rs.getString("apellidos"));
                    ingresos.add(ing);
                }
            }
        }
        return ingresos;
    }
}
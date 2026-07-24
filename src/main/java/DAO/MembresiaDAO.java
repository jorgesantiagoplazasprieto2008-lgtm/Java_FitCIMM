package DAO;

import Modelo.Membresia;
import Util.ConexionDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MembresiaDAO {
    public void InsertarMembresia(Membresia m) throws SQLException {
        String sql = "INSERT INTO membresia (id_socio, id_plan, fecha_inicio, fecha_fin, valor_pagado) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, m.getIdSocio());
            ps.setInt(2, m.getIdPlan());
            ps.setDate(3, Date.valueOf(m.getFechaInicio()));
            ps.setDate(4, Date.valueOf(m.getFechaFin()));
            ps.setBigDecimal(5, m.getValorPagado());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    m.setIdMembresia(rs.getInt(1));
                }
            }
        }
    }

    public Membresia obtenerUltimaPorSocio(int idSocio) throws SQLException {
        String sql = "SELECT TOP 1 m.id_membresia, m.id_socio, m.id_plan, m.fecha_inicio, m.fecha_fin, m.valor_pagado, p.nombre AS nombre_plan "
                + "FROM membresia m "
                + "INNER JOIN Planes p ON m.id_plan = p.id_plan "
                + "WHERE m.id_socio = ? "
                + "ORDER BY m.fecha_fin DESC, m.id_membresia DESC";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Membresia m = mapearMembresia(rs);
                    m.setNombrePlan(rs.getString("nombre_plan"));
                    return m;
                }
            }
        }
        return null;
    }

    public List<Membresia> listarHistorialPorSocio(int idSocio) throws SQLException {
        List<Membresia> historial = new ArrayList<>();
        String sql = "SELECT m.id_membresia, m.id_socio, m.id_plan, m.fecha_inicio, m.fecha_fin, m.valor_pagado, p.nombre AS nombre_plan "
                + "FROM membresia m "
                + "INNER JOIN Planes p ON m.id_plan = p.id_plan "
                + "WHERE m.id_socio = ? "
                + "ORDER BY m.fecha_inicio DESC";
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idSocio);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Membresia m = mapearMembresia(rs);
                    m.setNombrePlan(rs.getString("nombre_plan"));
                    historial.add(m);
                }
            }
        }
        return historial;
    }

    private Membresia mapearMembresia(ResultSet rs) throws SQLException {
        return new Membresia(
                rs.getInt("id_membresia"),
                rs.getInt("id_socio"),
                rs.getInt("id_plan"),
                rs.getDate("fecha_inicio").toLocalDate(),
                rs.getDate("fecha_fin").toLocalDate(),
                rs.getBigDecimal("valor_pagado")
        );
    }
}

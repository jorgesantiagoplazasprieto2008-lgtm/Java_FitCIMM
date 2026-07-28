package DAO;

import Modelo.*;
import Util.ConexionDB;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ReportesDAO {

    // RF-15: Listar socios activos con membresía vigente actualmente
    public List<Socio> obtenerSociosActivosVigentes(LocalDate hoy) throws SQLException {
        List<Socio> socios = new ArrayList<>();
        String sql = "SELECT DISTINCT s.id_socio, s.documento, s.nombres, s.apellidos, s.telefono, s.correo, s.fecha_nacimiento " +
                "FROM socio s " +
                "INNER JOIN membresia m ON s.id_socio = m.id_socio " +
                "WHERE s.activo = 1 " +
                "AND ? BETWEEN m.fecha_inicio AND m.fecha_fin"; // Se pasa la fecha de Java

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(hoy));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Socio s = new Socio();
                    s.setIdSocio(rs.getInt("id_socio"));
                    s.setDocumento(rs.getString("documento"));
                    s.setNombres(rs.getString("nombres"));
                    s.setApellidos(rs.getString("apellidos"));
                    s.setTelefono(rs.getString("telefono"));
                    s.setCorreo(rs.getString("correo"));
                    s.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                    s.setActivo(true);
                    socios.add(s);
                }
            }
        }
        return socios;
    }

    // RF-16: Total recaudado en un rango de fechas
    public List<ReporteRecaudacion> obtenerRecaudacionPorPlanes(LocalDate inicio, LocalDate fin) throws SQLException {
        List<ReporteRecaudacion> reporte = new ArrayList<>();
        String sql = "SELECT p.nombre AS plan_nombre, SUM(m.valor_pagado) AS total_recaudado, COUNT(m.id_membresia) AS cantidad_ventas " +
                "FROM membresia m " +
                "INNER JOIN Planes p ON m.id_plan = p.id_plan " +
                "WHERE m.fecha_inicio BETWEEN ? AND ? " +
                "GROUP BY p.nombre " +
                "ORDER BY total_recaudado DESC";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(inicio));
            ps.setDate(2, Date.valueOf(fin));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reporte.add(new ReporteRecaudacion(
                            rs.getString("plan_nombre"),
                            rs.getBigDecimal("total_recaudado"),
                            rs.getInt("cantidad_ventas")
                    ));
                }
            }
        }
        return reporte;
    }

    // RF-17: Reportar el plan más vendido del mes corriente
    public ReporteRecaudacion obtenerPlanMasVendidoMes(int mes, int anio) throws SQLException {
        String sql = "SELECT TOP 1 p.nombre AS plan_nombre, COUNT(m.id_membresia) AS cantidad_ventas, SUM(m.valor_pagado) AS total_recaudado " +
                "FROM membresia m " +
                "INNER JOIN Planes p ON m.id_plan = p.id_plan " +
                "WHERE DATEPART(month, m.fecha_inicio) = ? " +
                "  AND DATEPART(year, m.fecha_inicio) = ? " +
                "GROUP BY p.nombre " +
                "ORDER BY cantidad_ventas DESC";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, mes);
            ps.setInt(2, anio);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ReporteRecaudacion(
                            rs.getString("plan_nombre"),
                            rs.getBigDecimal("total_recaudado"),
                            rs.getInt("cantidad_ventas")
                    );
                }
            }
        }
        return null;
    }

    // Contar cuántos ingresos se registraron por día durante la última semana
    public List<ReporteIngresoSemanal> obtenerIngresosUltimaSemana(LocalDate desde, LocalDate hasta) throws SQLException {
        List<ReporteIngresoSemanal> reporte = new ArrayList<>();
        String sql = "SELECT fecha_ingreso, COUNT(id_ingreso) AS total_ingresos " +
                "FROM ingreso " +
                "WHERE fecha_ingreso BETWEEN ? AND ? " +
                "GROUP BY fecha_ingreso " +
                "ORDER BY fecha_ingreso ASC";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(desde));
            ps.setDate(2, Date.valueOf(hasta));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reporte.add(new ReporteIngresoSemanal(
                            rs.getDate("fecha_ingreso").toLocalDate(),
                            rs.getInt("total_ingresos")
                    ));
                }
            }
        }
        return reporte;
    }

    // Encontrar socios activos que NUNCA han registrado un ingreso
    public List<Socio> obtenerSociosSinIngresos() throws SQLException {
        List<Socio> socios = new ArrayList<>();
        String sql = "SELECT id_socio, documento, nombres, apellidos, telefono, correo, fecha_nacimiento " +
                "FROM socio " +
                "WHERE activo = 1 " +
                "AND id_socio NOT IN (SELECT DISTINCT id_socio FROM ingreso)";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Socio s = new Socio();
                s.setIdSocio(rs.getInt("id_socio"));
                s.setDocumento(rs.getString("documento"));
                s.setNombres(rs.getString("nombres"));
                s.setApellidos(rs.getString("apellidos"));
                s.setTelefono(rs.getString("telefono"));
                s.setCorreo(rs.getString("correo"));
                s.setFechaNacimiento(rs.getDate("fecha_nacimiento").toLocalDate());
                s.setActivo(true);
                socios.add(s);
            }
        }
        return socios;
    }
}
package DAO;

import Modelo.Plan;
import Util.ConexionDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlanDAO {
    public boolean registrarPlan(Plan plan) throws SQLException {

        String sql = "INSERT INTO Planes (nombre, duracion_dias, valor, activo) VALUES (?, ?, ?, ?)";

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, plan.getNombre());
            ps.setInt(2, plan.getDuracionDias());
            ps.setBigDecimal(3, plan.getValor());
            ps.setBoolean(4, plan.getActivo());

            int filas = ps.executeUpdate();

            if (filas > 0) {

                try (ResultSet rs = ps.getGeneratedKeys()) {

                    if (rs.next()) {
                        plan.setIdPlan(rs.getInt(1));
                    }

                }

                return true;
            }

            return false;
        }
    }

    public List<Plan> listarPlanes() throws SQLException {

        List<Plan> planes = new ArrayList<>();

        String sql = """
                SELECT id_plan,
                       nombre,
                       duracion_dias,
                       valor,
                       activo
                FROM Planes
                ORDER BY nombre
                """;

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                planes.add(mapearPlan(rs));

            }

        }

        return planes;

    }

    public Plan buscarPorId(int idPlan) throws SQLException {

        String sql = """
                SELECT *
                FROM Planes
                WHERE id_plan = ?
                """;

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idPlan);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return mapearPlan(rs);

                }

            }

        }

        return null;

    }


    public Plan buscarPorNombre(String nombre) throws SQLException {

        String sql = """
                SELECT *
                FROM Planes
                WHERE nombre = ?
                """;

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nombre);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return mapearPlan(rs);

                }

            }

        }

        return null;

    }

    public boolean inactivarPlan(int idPlan) throws SQLException {

        String sql = """
                UPDATE Planes
                SET activo = false
                WHERE id_plan = ?
                """;

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idPlan);

            return ps.executeUpdate() > 0;

        }

    }

    public boolean editarPlan(Plan plan) throws SQLException {

        String sql = """
                UPDATE Planes
                SET nombre = ?,
                    duracion_dias = ?,
                    valor = ?,
                    activo = ?
                WHERE id_plan = ?
                """;

        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, plan.getNombre());
            ps.setInt(2, plan.getDuracionDias());
            ps.setBigDecimal(3, plan.getValor());
            ps.setBoolean(4, plan.getActivo());
            ps.setInt(5, plan.getIdPlan());

            return ps.executeUpdate() > 0;

        }

    }


    private Plan mapearPlan(ResultSet rs) throws SQLException {

        return new Plan(

                rs.getInt("id_plan"),
                rs.getString("nombre"),
                rs.getInt("duracion_dias"),
                rs.getBigDecimal("valor"),
                rs.getBoolean("activo")

        );

    }
}

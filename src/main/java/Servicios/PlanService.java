
package Servicios;

import DAO.PlanDAO;
import Modelo.Plan;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;


public class PlanService {

    private PlanDAO planDAO;

    public PlanService() {
        this.planDAO = new PlanDAO();
    }

    public boolean registrarPlan(Plan plan) throws Exception {

        if (plan.getNombre() == null || plan.getNombre().trim().isEmpty()) {
            throw new Exception("El nombre del plan es obligatorio.");
        }

        if (plan.getDuracionDias() < 1 || plan.getDuracionDias() > 365) {
            throw new Exception("La duración debe estar entre 1 y 365 días.");
        }

        if (plan.getValor().compareTo(BigDecimal.ZERO) <= 0) {
            throw new Exception("El valor del plan debe ser mayor que cero.");
        }

        Plan existente = planDAO.buscarPorNombre(plan.getNombre());

        if (existente != null) {
            throw new Exception("Ya existe un plan con ese nombre.");
        }

        return planDAO.registrarPlan(plan);
    }

    public List<Plan> listarPlanes() throws SQLException {

        return planDAO.listarPlanes();

    }

    public Plan buscarPorId(int id) throws SQLException {

        return planDAO.buscarPorId(id);

    }

    public boolean editarPlan(Plan plan) throws Exception {

        if (plan.getNombre() == null || plan.getNombre().trim().isEmpty()) {
            throw new Exception("El nombre del plan es obligatorio.");
        }

        if (plan.getDuracionDias() < 1 || plan.getDuracionDias() > 365) {
            throw new Exception("La duración debe estar entre 1 y 365 días.");
        }

        if (plan.getValor().compareTo(BigDecimal.ZERO) <= 0) {
            throw new Exception("El valor del plan debe ser mayor que cero.");
        }

        Plan existente = planDAO.buscarPorNombre(plan.getNombre());

        if (existente != null && existente.getIdPlan() != plan.getIdPlan()) {
            throw new Exception("Ya existe otro plan con ese nombre.");
        }

        return planDAO.editarPlan(plan);

    }

    public boolean inactivarPlan(int idPlan) throws Exception {

        Plan plan = planDAO.buscarPorId(idPlan);

        if (plan == null) {
            throw new Exception("El plan no existe.");
        }

        if (!plan.getActivo()) {
            throw new Exception("El plan ya está inactivo.");
        }

        return planDAO.inactivarPlan(idPlan);

    }

}


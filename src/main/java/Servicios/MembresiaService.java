package Servicios;

import DAO.MembresiaDAO;
import DAO.PlanDAO;
import Modelo.Membresia;
import Modelo.EstadoMembresia;
import Modelo.Plan;
import Util.FechaUtil;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class MembresiaService {
    private MembresiaDAO membresiaDao = new MembresiaDAO();
    private PlanDAO planDao = new PlanDAO();

    // RF-08: Vender una membresía a un socio seleccionando un plan; el sistema calcula automáticamente la fecha de fin.
    public void vender(int idSocio, int idPlan) throws Exception {
        Plan plan = planDao.buscarPorId(idPlan);
        if (plan == null) {
            throw new Exception("El plan seleccionado no existe.");
        }
        if (plan.getActivo() != null && !plan.getActivo()) {
            throw new Exception("El plan seleccionado se encuentra inactivo.");
        }

        LocalDate inicio = LocalDate.now();
        LocalDate fin = inicio.plusDays(plan.getDuracionDias()); // RN-02: Cálculo automático de fecha de fin

        Membresia m = new Membresia();
        m.setIdSocio(idSocio);
        m.setIdPlan(plan.getIdPlan());
        m.setFechaInicio(inicio);
        m.setFechaFin(fin);
        m.setValorPagado(plan.getValor());

        membresiaDao.InsertarMembresia(m);
    }

    // RF-10: Renovar la membresía de un socio, conservando el registro anterior en el historial.
    public void renovar(int idSocio, int idPlan) throws Exception {
        // Al renovar se realiza una nueva inserción registrando la venta del nuevo plan,
        // garantizando así la conservación de los registros históricos anteriores.
        vender(idSocio, idPlan);
    }

    // RF-09: Mostrar el estado calculado de la membresía: VIGENTE, POR VENCER o VENCIDA.
    public EstadoMembresia calcularEstado(Membresia m) {
        if (m == null || m.getFechaFin() == null) {
            return null;
        }

        LocalDate hoy = LocalDate.now();
        if (m.getFechaFin().isBefore(hoy)) {
            return EstadoMembresia.VENCIDA;
        }

        long dias = FechaUtil.diasRestantes(m.getFechaFin());
        if (dias <= 5) {
            return EstadoMembresia.POR_VENCER;
        }
        return EstadoMembresia.VIGENTE;
    }

    public Membresia obtenerUltimaPorSocio(int idSocio) throws SQLException {
        return membresiaDao.obtenerUltimaPorSocio(idSocio);
    }

    public List<Membresia> listarHistorialPorSocio(int idSocio) throws SQLException {
        return membresiaDao.listarHistorialPorSocio(idSocio);
    }
}
package Servicios;

import DAO.MembresiaDAO;
import Modelo.Membresia;
import Modelo.EstadoMembresia;
import Modelo.Plan;
import Util.*;

import java.time.LocalDate;

public class MembresiaService {
    private MembresiaDAO membresiaDao = new MembresiaDAO();

    // RN-02: La fecha fin se calcula, nunca se digita
    public void vender(int idSocio, Plan plan) throws Exception {
        if (plan == null) throw new Exception("Plan inválido.");

        LocalDate inicio = LocalDate.now();
        LocalDate fin = inicio.plusDays(plan.getDuracionDias()); // Cálculo automático de fecha de fin

        Membresia m = new Membresia();
        m.setIdSocio(idSocio);
        m.setIdPlan(plan.getIdPlan());
        m.setFechaInicio(inicio);
        m.setFechaFin(fin);
        m.setValorPagado(plan.getValor());

        membresiaDao.InsertarMembresia(m);
    }

    // RN-04: El estado es calculado y comparado con la fecha de fin y el día de hoy
    public EstadoMembresia calcularEstado(Membresia m) {
        if (m == null) return null;

        LocalDate hoy = LocalDate.now();
        // Si la fecha fin ya pasó del día de hoy
        if (m.getFechaFin().isBefore(hoy)) {
            return EstadoMembresia.VENCIDA;
        }

        // Calcula cuántos días faltan para vencerse
        long dias = FechaUtil.diasRestantes(m.getFechaFin());
        if (dias <= 5) {
            return EstadoMembresia.POR_VENCER;
        }
        return EstadoMembresia.VIGENTE;
    }
}

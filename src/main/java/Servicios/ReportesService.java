package Servicios;

import DAO.ReportesDAO;
import Modelo.*;
import java.time.LocalDate;
import java.util.List;

public class ReportesService {
    private final ReportesDAO dao = new ReportesDAO();

    public List<Socio> getSociosActivosVigentes() throws Exception {
        return dao.obtenerSociosActivosVigentes(LocalDate.now());
    }

    public List<ReporteRecaudacion> getRecaudacionPlanes(LocalDate inicio, LocalDate fin) throws Exception {
        if (inicio == null || fin == null) {
            throw new Exception("El rango de fechas de consulta es obligatorio.");
        }
        if (inicio.isAfter(fin)) {
            throw new Exception("La fecha de inicio no puede ser posterior a la fecha de fin.");
        }
        return dao.obtenerRecaudacionPorPlanes(inicio, fin);
    }

    public ReporteRecaudacion getPlanMasVendidoMes() throws Exception {
        LocalDate hoy = LocalDate.now();
        return dao.obtenerPlanMasVendidoMes(hoy.getMonthValue(), hoy.getYear());
    }

    public List<ReporteIngresoSemanal> getIngresosUltimaSemana() throws Exception {
        LocalDate hoy = LocalDate.now();
        LocalDate haceUnaSemana = hoy.minusDays(6);
        return dao.obtenerIngresosUltimaSemana(haceUnaSemana, hoy);
    }

    public List<Socio> getSociosSinIngresos() throws Exception {
        return dao.obtenerSociosSinIngresos();
    }
}
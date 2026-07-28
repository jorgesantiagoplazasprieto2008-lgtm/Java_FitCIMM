package Controladores;

import Modelo.*;
import Servicios.ReportesService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/reportes")
public class ReporteController extends HttpServlet {
    private final ReportesService service = new ReportesService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String fechaIniStr = req.getParameter("fechaInicio");
        String fechaFinStr = req.getParameter("fechaFin");

        // CORREGIDO: Buscamos 1 año atrás por defecto para que se listen los planes cargados anteriormente
        LocalDate fechaInicio = LocalDate.now().minusYears(1);
        LocalDate fechaFin = LocalDate.now(); // Hoy

        if (fechaIniStr != null && !fechaIniStr.isEmpty()) {
            try {
                fechaInicio = LocalDate.parse(fechaIniStr);
            } catch (DateTimeParseException e) {}
        }
        if (fechaFinStr != null && !fechaFinStr.isEmpty()) {
            try {
                fechaFin = LocalDate.parse(fechaFinStr);
            } catch (DateTimeParseException e) {}
        }

        try {
            List<Socio> vigentes = service.getSociosActivosVigentes();
            req.setAttribute("sociosVigentes", vigentes);

            List<ReporteRecaudacion> recaudaciones = service.getRecaudacionPlanes(fechaInicio, fechaFin);
            req.setAttribute("recaudaciones", recaudaciones);
            req.setAttribute("fechaInicio", fechaInicio);
            req.setAttribute("fechaFin", fechaFin);

            ReporteRecaudacion masVendido = service.getPlanMasVendidoMes();
            req.setAttribute("planMasVendido", masVendido);

            List<ReporteIngresoSemanal> ingresosSemana = service.getIngresosUltimaSemana();
            req.setAttribute("ingresosSemana", ingresosSemana);

            List<Socio> sinIngreso = service.getSociosSinIngresos();
            req.setAttribute("sociosSinIngreso", sinIngreso);

            req.getRequestDispatcher("/reportes-dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error al cargar reportes: " + e.getMessage());
            req.getRequestDispatcher("/reportes-dashboard.jsp").forward(req, resp);
        }
    }
}
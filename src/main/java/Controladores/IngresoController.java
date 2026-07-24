package Controladores;

import Modelo.Ingreso;
import Servicios.*;
import DAO.IngresoDAO;
import Util.SocioIngresoResultado;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/ingresos")
public class IngresoController extends HttpServlet {
    private final IngresoService service = new IngresoService();
    private final IngresoDAO ingresoDao = new IngresoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null || accion.trim().isEmpty()) {
            accion = "pantalla";
        }

        try {
            if ("pantalla".equals(accion)) {
                cargarPantallaAcceso(req, resp);
            } else if ("reporte".equals(accion)) {
                consultarReportePorFecha(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error en el sistema: " + e.getMessage());
            cargarPantallaAcceso(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");

        if ("registrar".equals(accion)) {
            String documento = req.getParameter("documento");
            try {
                // Registrar ingreso y obtener resultado
                SocioIngresoResultado resultado = service.registrarIngreso(documento);

                req.setAttribute("resultado", resultado);
                req.setAttribute("mensajeExito", "¡Acceso Autorizado!");
            } catch (Exception e) {
                // Atrapa errores de negocio (RN-05 o RN-06) y los envía como alert
                req.setAttribute("error", e.getMessage());
                req.setAttribute("documentoIngresado", documento);
            }
            cargarPantallaAcceso(req, resp);
        }
    }

    private void cargarPantallaAcceso(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Cargar el listado de ingresos del día de hoy en tiempo real en la misma vista
            List<Ingreso> ingresosHoy = ingresoDao.consultarPorFecha(LocalDate.now());
            req.setAttribute("ingresosHoy", ingresosHoy);
            req.getRequestDispatcher("/control-ingresos.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void consultarReportePorFecha(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fechaParam = req.getParameter("fecha");
        LocalDate fecha = LocalDate.now(); // Por defecto hoy

        if (fechaParam != null && !fechaParam.trim().isEmpty()) {
            try {
                fecha = LocalDate.parse(fechaParam.trim());
            } catch (DateTimeParseException e) {
                req.setAttribute("error", "Fecha inválida, mostrando el día de hoy.");
            }
        }

        try {
            List<Ingreso> ingresos = ingresoDao.consultarPorFecha(fecha);
            req.setAttribute("ingresos", ingresos);
            req.setAttribute("fechaSeleccionada", fecha);
            req.getRequestDispatcher("/ingresos-reporte.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error al cargar reporte: " + e.getMessage());
            req.getRequestDispatcher("/ingresos-reporte.jsp").forward(req, resp);
        }
    }
}
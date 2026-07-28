package Controladores;

import Modelo.Plan;
import Modelo.Socio;
import Servicios.MembresiaService;
import Servicios.PlanService;
import Servicios.SocioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/membresias")
public class MembresiaController extends HttpServlet {

    private MembresiaService membresiaService = new MembresiaService();
    private SocioService socioService = new SocioService();
    private PlanService planService = new PlanService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null || accion.trim().isEmpty()) {
            resp.sendRedirect("socios?accion=listar");
            return;
        }

        try {
            switch (accion) {
                case "vender":
                case "renovar":
                    mostrarFormularioVenta(req, resp);
                    break;
                default:
                    resp.sendRedirect("socios?accion=listar");
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error al cargar formulario de membresía: " + e.getMessage());
            req.getRequestDispatcher("/socios-lista.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");

        try {
            if ("guardarVenta".equals(accion) || "guardarRenovacion".equals(accion)) {
                procesarVenta(req, resp, "guardarRenovacion".equals(accion));
            } else {
                resp.sendRedirect("socios?accion=listar");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            try {
                mostrarFormularioVenta(req, resp);
            } catch (Exception ex) {
                resp.sendRedirect("socios?accion=listar");
            }
        }
    }

    private void mostrarFormularioVenta(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String idSocioParam = req.getParameter("idSocio");
        if (idSocioParam == null || idSocioParam.trim().isEmpty()) {
            throw new Exception("ID de socio es obligatorio.");
        }

        int idSocio = Integer.parseInt(idSocioParam.trim());
        Socio socio = socioService.buscarPorId(idSocio);

        List<Plan> planesActivos = planService.listarPlanes().stream()
                .filter(p -> p.getActivo() != null && p.getActivo())
                .collect(Collectors.toList());

        String modo = "renovar".equals(req.getParameter("accion")) ? "renovar" : "vender";

        req.setAttribute("socio", socio);
        req.setAttribute("planes", planesActivos);
        req.setAttribute("modo", modo);
        req.getRequestDispatcher("/membresia-formulario.jsp").forward(req, resp);
    }

    private void procesarVenta(HttpServletRequest req, HttpServletResponse resp, boolean esRenovacion) throws Exception {
        String idSocioParam = req.getParameter("idSocio");
        String idPlanParam = req.getParameter("idPlan");

        if (idSocioParam == null || idSocioParam.trim().isEmpty() || idPlanParam == null || idPlanParam.trim().isEmpty()) {
            throw new Exception("Debe seleccionar un plan válido.");
        }

        int idSocio = Integer.parseInt(idSocioParam.trim());
        int idPlan = Integer.parseInt(idPlanParam.trim());

        if (esRenovacion) {
            membresiaService.renovar(idSocio, idPlan);
            req.getSession().setAttribute("mensajeExito", "Membresía renovada exitosamente (historial conservado).");
        } else {
            membresiaService.vender(idSocio, idPlan);
            req.getSession().setAttribute("mensajeExito", "Membresía asignada exitosamente.");
        }

        resp.sendRedirect("socios?accion=ver&id=" + idSocio);
    }
}
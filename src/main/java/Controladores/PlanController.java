package Controladores;

import Modelo.Plan;
import Servicios.PlanService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/planes")
public class PlanController extends HttpServlet {

    private PlanService planService;

    @Override
    public void init() {
        planService = new PlanService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null || accion.trim().isEmpty()) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listar(request, response);
                break;
            case "editar":
                mostrarFormularioEditar(request, response);
                break;
            case "inactivar":
                inactivar(request, response);
                break;
            case "nuevo":
                mostrarFormularioNuevo(request, response);
                break;
            default:
                listar(request, response);
                break;
        }
    }

    private void listar(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Plan> listaPlanes = planService.listarPlanes();
            request.setAttribute("listaPlanes", listaPlanes);

            String mensajeExito = (String) request.getSession().getAttribute("mensajeExito");
            if (mensajeExito != null) {
                request.setAttribute("mensajeExito", mensajeExito);
                request.getSession().removeAttribute("mensajeExito");
            }

            request.getRequestDispatcher("/plan-listado.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al listar los planes: " + e.getMessage());
            request.getRequestDispatcher("/plan-listado.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null || accion.trim().isEmpty()) {
            response.sendRedirect("planes?accion=listar");
            return;
        }

        switch (accion) {
            case "registrar" -> registrar(request, response);
            case "actualizar" -> actualizar(request, response);
            default -> response.sendRedirect("planes?accion=listar");
        }
    }

    private void registrar(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException, ServletException {
        try {
            String nombre = request.getParameter("nombre");
            int duracionDias = Integer.parseInt(request.getParameter("duracionDias"));
            BigDecimal valor = new BigDecimal(request.getParameter("valor"));
            boolean activo = Boolean.parseBoolean(request.getParameter("activo"));

            Plan plan = new Plan();
            plan.setNombre(nombre);
            plan.setDuracionDias(duracionDias);
            plan.setValor(valor);
            plan.setActivo(activo);

            planService.registrarPlan(plan);
            request.getSession().setAttribute("mensajeExito", "Plan registrado correctamente");
            response.sendRedirect("planes?accion=listar");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("modo", "nuevo");
            request.getRequestDispatcher("/plan-formulario.jsp").forward(request, response);
        }
    }

    private void mostrarFormularioNuevo(HttpServletRequest request,
                                        HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("plan", new Plan());
        request.setAttribute("modo", "nuevo");
        request.getRequestDispatcher("/plan-formulario.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request,
                                         HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            request.setAttribute("error", "ID de plan no proporcionado");
            listar(request, response);
            return;
        }
        try {
            int id = Integer.parseInt(idParam.trim());
            Plan plan = planService.buscarPorId(id);
            if (plan == null) {
                request.setAttribute("error", "No se encontró el plan con ID: " + id);
                listar(request, response);
                return;
            }
            request.setAttribute("plan", plan);
            request.setAttribute("modo", "editar");
            request.getRequestDispatcher("/plan-formulario.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error al cargar el plan: " + e.getMessage());
            listar(request, response);
        }
    }

    private void actualizar(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idString = request.getParameter("idPlan");
            String nombre = request.getParameter("nombre");
            int duracionDias = Integer.parseInt(request.getParameter("duracionDias"));
            BigDecimal valor = new BigDecimal(request.getParameter("valor"));
            boolean activo = Boolean.parseBoolean(request.getParameter("activo"));

            Plan plan = new Plan();
            if (idString != null && !idString.trim().isEmpty()) {
                plan.setIdPlan(Integer.parseInt(idString.trim()));
            }
            plan.setNombre(nombre);
            plan.setDuracionDias(duracionDias);
            plan.setValor(valor);
            plan.setActivo(activo);

            planService.editarPlan(plan);
            request.getSession().setAttribute("mensajeExito", "Plan actualizado correctamente");
            response.sendRedirect("planes?accion=listar");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("modo", "editar");
            request.getRequestDispatcher("/plan-formulario.jsp").forward(request, response);
        }
    }

    private void inactivar(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            request.setAttribute("error", "ID de plan no proporcionado");
            listar(request, response);
            return;
        }
        try {
            int id = Integer.parseInt(idParam.trim());
            planService.inactivarPlan(id);
            request.getSession().setAttribute("mensajeExito", "Plan inactivado correctamente");
            response.sendRedirect("planes?accion=listar");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            listar(request, response);
        }
    }
}
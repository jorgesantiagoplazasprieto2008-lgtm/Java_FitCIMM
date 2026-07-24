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

        if (accion == null) {
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

            request.getRequestDispatcher("/jsp/planes/listarPlanes.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException("Error al listar los planes", e);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("planes");
            return;
        }

        switch (accion) {

            case "registrar" -> registrar(request, response);

            case "actualizar" -> actualizar(request, response);

            default -> response.sendRedirect("planes");
        }
    }

    private void registrar(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException, ServletException {

        try {

            String nombre = request.getParameter("nombre");

            int duracionDias =
                    Integer.parseInt(request.getParameter("duracionDias"));

            BigDecimal valor =
                    new BigDecimal(request.getParameter("valor"));

            boolean activo =
                    Boolean.parseBoolean(request.getParameter("activo"));

            Plan plan = new Plan();

            plan.setNombre(nombre);
            plan.setDuracionDias(duracionDias);
            plan.setValor(valor);
            plan.setActivo(activo);

            planService.registrarPlan(plan);

            response.sendRedirect("planes");

        } catch (Exception e) {

            throw new ServletException("Error al registrar el plan", e);

        }

    }

    private void mostrarFormularioNuevo(HttpServletRequest request,
                                        HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/jsp/planes/formularioPlan.jsp")
                .forward(request, response);

    }

    private void mostrarFormularioEditar(HttpServletRequest request,
                                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/jsp/planes/formularioPlan.jsp")
                .forward(request, response);

    }

    private void actualizar(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

    }

    private void inactivar(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

    }

}
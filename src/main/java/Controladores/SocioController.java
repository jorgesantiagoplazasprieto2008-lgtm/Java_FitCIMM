package Controladores;

import Modelo.*;
import Servicios.SocioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/socios")
public class SocioController extends HttpServlet {
    private final SocioService service = new SocioService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        if (accion == null || accion.trim().isEmpty()) {
            accion = "listar";
        }

        try {
            switch (accion) {
                case "listar":
                    listarSocios(req, resp);
                    break;
                case "nuevo":
                    mostrarFormularioNuevo(req, resp);
                    break;
                case "editar":
                    mostrarFormularioEditar(req, resp);
                    break;
                case "inactivar":
                    inactivarSocio(req, resp);
                    break;
                case "reactivar":
                    reactivarSocio(req, resp);
                    break;
                case "ver":
                    verDetalleSocio(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Acción no válida: " + accion);
                    break;
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "ID inválido. Verifique los datos de identificación.");
            listarSocios(req, resp);
        } catch (Exception e) {
            manejarError(req, resp, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String accion = req.getParameter("accion");

        if (accion == null || accion.trim().isEmpty()) {
            resp.sendRedirect("socios?accion=listar");
            return;
        }

        try {
            switch (accion) {
                case "guardar":
                    guardarSocio(req, resp);
                    break;
                case "actualizar":
                    actualizarSocio(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Acción no válida: " + accion);
                    break;
            }
        } catch (Exception e) {
            manejarError(req, resp, e);
        }
    }

    // ==================== MÉTODOS GET ====================

    private void listarSocios(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String criterio = req.getParameter("criterio");
        try {
            List<Socio> lista;
            if (criterio != null && !criterio.trim().isEmpty()) {
                lista = service.buscar(criterio.trim());
                req.setAttribute("criterio", criterio.trim());
            } else {
                lista = service.listarSocios();
            }

            req.setAttribute("socios", lista);
            req.setAttribute("totalSocios", lista != null ? lista.size() : 0);

            // Mensaje de éxito de redirecciones anteriores (si existen)
            String mensajeExito = (String) req.getSession().getAttribute("mensajeExito");
            if (mensajeExito != null) {
                req.setAttribute("mensajeExito", mensajeExito);
                req.getSession().removeAttribute("mensajeExito"); // Limpiar de la sesión
            }

            req.getRequestDispatcher("/socios-lista.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error al cargar la lista: " + e.getMessage());
            req.getRequestDispatcher("/socios-lista.jsp").forward(req, resp);
        }
    }

    private void mostrarFormularioNuevo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("socio", new Socio());
        req.setAttribute("modo", "nuevo");
        req.setAttribute("titulo", "Registrar Nuevo Socio");
        req.getRequestDispatcher("/socio-formulario.jsp").forward(req, resp);
    }

    private void mostrarFormularioEditar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            req.setAttribute("error", "ID de socio no proporcionado");
            listarSocios(req, resp);
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            Socio socio = service.buscarPorId(id);

            if (socio == null) {
                req.setAttribute("error", "No se encontró el socio con ID: " + id);
                listarSocios(req, resp);
                return;
            }

            req.setAttribute("socio", socio);
            req.setAttribute("modo", "editar");
            req.setAttribute("titulo", "Editar Socio");
            req.getRequestDispatcher("/socio-formulario.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error al cargar formulario de edición: " + e.getMessage());
            listarSocios(req, resp);
        }
    }

    private void inactivarSocio(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            req.setAttribute("error", "ID de socio no proporcionado");
            listarSocios(req, resp);
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            service.inactivar(id); // Lanza Exception interna si el socio no existe o ya está inactivo
            req.getSession().setAttribute("mensajeExito", "Socio inactivado correctamente (baja lógica)");
            resp.sendRedirect("socios?accion=listar");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            listarSocios(req, resp);
        }
    }

    private void reactivarSocio(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            req.setAttribute("error", "ID de socio no proporcionado");
            listarSocios(req, resp);
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            service.activar(id); // Llama a la lógica de activación
            req.getSession().setAttribute("mensajeExito", "Socio reactivado correctamente");
            resp.sendRedirect("socios?accion=listar");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            listarSocios(req, resp);
        }
    }

    private void verDetalleSocio(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            req.setAttribute("error", "ID de socio no proporcionado");
            listarSocios(req, resp);
            return;
        }
        try {
            int id = Integer.parseInt(idParam.trim());
            Socio socio = service.buscarPorId(id);

            if (socio == null) {
                req.setAttribute("error", "No se encontró el socio con ID: " + id);
                listarSocios(req, resp);
                return;
            }

            req.setAttribute("socio", socio);
            req.getRequestDispatcher("/socio-detalle.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error al ver el detalle: " + e.getMessage());
            listarSocios(req, resp);
        }
    }

    // ==================== MÉTODOS POST ====================

    private void guardarSocio(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Socio socio = construirSocioDesdeRequest(req);
        try {
            // Delega directamente la inserción y las validaciones al Service
            service.registrar(socio);
            req.getSession().setAttribute("mensajeExito", "Socio registrado correctamente");
            resp.sendRedirect("socios?accion=listar");
        } catch (Exception e) {
            // El service arrojó un error de negocio (RN-01 o RN-09). Devolvemos el error a la vista.
            req.setAttribute("error", e.getMessage());
            req.setAttribute("socio", socio);
            req.setAttribute("modo", "nuevo");
            req.setAttribute("titulo", "Registrar Nuevo Socio");
            req.getRequestDispatcher("/socio-formulario.jsp").forward(req, resp);
        }
    }

    private void actualizarSocio(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Socio socio = construirSocioDesdeRequest(req);
        try {
            String idString = req.getParameter("idSocio");
            if (idString == null || idString.trim().isEmpty()) {
                throw new Exception("El ID de socio es obligatorio para actualizar.");
            }

            socio.setIdSocio(Integer.parseInt(idString.trim()));

            // Llama a la lógica de actualización en el Service
            service.editar(socio);
            req.getSession().setAttribute("mensajeExito", "Socio actualizado correctamente");
            resp.sendRedirect("socios?accion=listar");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("socio", socio);
            req.setAttribute("modo", "editar");
            req.setAttribute("titulo", "Editar Socio");
            req.getRequestDispatcher("/socio-formulario.jsp").forward(req, resp);
        }
    }

    // ==================== MÉTODOS UTILITARIOS ====================

    private Socio construirSocioDesdeRequest(HttpServletRequest req) {
        Socio socio = new Socio();
        socio.setDocumento(req.getParameter("documento"));
        socio.setNombres(req.getParameter("nombres"));
        socio.setApellidos(req.getParameter("apellidos"));
        socio.setTelefono(req.getParameter("telefono"));
        socio.setCorreo(req.getParameter("correo"));

        // Se reemplaza java.util.Date y DATE_FORMAT por LocalDate nativo
        String fechaNacString = req.getParameter("fechaNacimiento");
        if (fechaNacString != null && !fechaNacString.trim().isEmpty()) {
            try {
                socio.setFechaNacimiento(LocalDate.parse(fechaNacString.trim()));
            } catch (DateTimeParseException e) {
                // Si la fecha tiene formato incorrecto, se deja nula.
                // El SocioService lanzará la excepción correspondiente al validarlo.
                socio.setFechaNacimiento(null);
            }
        }

        String activoParam = req.getParameter("activo");
        if (activoParam != null) {
            socio.setActivo(Boolean.parseBoolean(activoParam));
        } else {
            socio.setActivo(true); // Activo por defecto en inserciones
        }

        return socio;
    }

    private void manejarError(HttpServletRequest req, HttpServletResponse resp, Exception e) throws ServletException, IOException {
        req.setAttribute("error", "Error inesperado del sistema: " + e.getMessage());
        listarSocios(req, resp);
    }
}
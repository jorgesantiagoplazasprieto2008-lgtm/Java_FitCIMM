package Servicios;

import DAO.*;
import Modelo.*;
import Util.*;
import java.time.*;
public class IngresoService {
    private final IngresoDAO ingresoDao = new IngresoDAO();
    private final SocioDAO socioDao = new SocioDAO();
    private final MembresiaDAO membresiaDao = new MembresiaDAO();
    private final MembresiaService membresiaService = new MembresiaService();
    // Lógica para autorizar y registrar ingreso
    public SocioIngresoResultado registrarIngreso(String documento) throws Exception {
        if (Validador.esVacio(documento)) {
            throw new Exception("El número de documento es obligatorio para verificar el acceso.");
        }
        // Validar existencia del socio
        Socio socio = socioDao.buscarSocioPorDocumento(documento.trim());
        if (socio == null) {
            throw new Exception("Cédula/Documento no registrado.");
        }
        // RN-05: El socio inactivo no puede registrar ingreso
        if (!socio.getActivo()) {
            throw new Exception("Acceso Denegado: El socio se encuentra INACTIVO.");
        }
        // Validar que tenga membresías registradas
        Membresia ultimaMembresia = membresiaDao.obtenerUltimaPorSocio(socio.getIdSocio());
        if (ultimaMembresia == null) {
            throw new Exception("Acceso Denegado: El socio no cuenta con ninguna membresía.");
        }
        // RN-05: Membresía VENCIDA no puede registrar ingreso
        EstadoMembresia estado = membresiaService.calcularEstado(ultimaMembresia);
        if (estado == EstadoMembresia.VENCIDA) {
            throw new Exception("Acceso Denegado: Membresía VENCIDA el " + ultimaMembresia.getFechaFin() + ".");
        }
        // RN-06: Solo un ingreso por socio al día
        LocalDate hoy = LocalDate.now();
        if (ingresoDao.yaIngresoHoy(socio.getIdSocio(), hoy)) {
            throw new Exception("Acceso Denegado: El socio ya registró un ingreso el día de hoy.");
        }
        // Registro del ingreso exitoso
        Ingreso ingreso = new Ingreso();
        ingreso.setIdSocio(socio.getIdSocio());
        ingreso.setFechaIngreso(hoy);
        ingreso.setHoraIngreso(LocalTime.now());
        ingresoDao.RegistrarIngreso(ingreso);

        // Formar el resultado (RF-13)
        String nombreCompleto = socio.getNombres() + " " + socio.getApellidos();
        long diasRestantes = FechaUtil.diasRestantes(ultimaMembresia.getFechaFin());
        return new SocioIngresoResultado(nombreCompleto, diasRestantes, estado);
    }
}

package Servicios;

import DAO.*;
import Modelo.Membresia;
import Modelo.Socio;
import Util.*;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

public class SocioService {
    private SocioDAO socioDao = new SocioDAO();
    private MembresiaDAO membresiaDao = new MembresiaDAO();
    private MembresiaService membresiaService = new MembresiaService();

    // RF-01: Registrar con validación de RN-01 y RN-09
    public void registrar(Socio s) throws Exception {
        // Validaciones de entrada generales
        if (Validador.esVacio(s.getDocumento())) throw new Exception("El documento es obligatorio.");
        if (Validador.esVacio(s.getNombres())) throw new Exception("Los nombres son obligatorios.");
        if (Validador.esVacio(s.getApellidos())) throw new Exception("Los apellidos son obligatorios.");
        if (s.getFechaNacimiento() == null) throw new Exception("La fecha de nacimiento es obligatoria.");
        if (!Validador.esVacio(s.getCorreo()) && !Validador.esCorreoValido(s.getCorreo())) {
            throw new Exception("El formato del correo es inválido.");
        }

        // RN-01: El documento debe ser único
        if (socioDao.existeDocumento(s.getDocumento())) {
            throw new Exception("Ya existe un socio con ese documento.");
        }
        // RN-09: El socio debe ser mayor de 15 años
        if (FechaUtil.calcularEdad(s.getFechaNacimiento()) < 15) {
            throw new Exception("El socio debe ser mayor de 15 años.");
        }
        s.setActivo(true); // Activo por defecto
        socioDao.RegistrarSocios(s);
    }
    // RF-02: Listar socios con sus estados de membresía correspondientes
    public List<Socio> listarSocios() throws Exception {
        List<Socio> socios = socioDao.listarTodos();
        for (Socio s : socios) {
            // Buscamos la última membresía y le calculamos el estado actual dinámicamente
            Membresia ultima = membresiaDao.obtenerUltimaPorSocio(s.getIdSocio());
            if (ultima != null) {
                s.setEstadoMembresia(membresiaService.calcularEstado(ultima));
            } else {
                s.setEstadoMembresia(null); // Sin membresía
            }
        }
        return socios;
    }
    public Socio buscarPorId(int id) throws Exception {
        Socio s = socioDao.obtenerPorId(id);
        if (s == null) {
            throw new Exception("El socio no existe.");
        }
        return s;
    }
    // RF-04: Editar los datos de un socio existente
    public void editar(Socio s) throws Exception {
        if (Validador.esVacio(s.getNombres())) throw new Exception("Los nombres son obligatorios.");
        if (Validador.esVacio(s.getApellidos())) throw new Exception("Los apellidos son obligatorios.");
        if (s.getFechaNacimiento() == null) throw new Exception("La fecha de nacimiento es obligatoria.");

        // Validar que el documento sea único

        Socio existente = socioDao.obtenerPorId(s.getIdSocio());
        if (existente == null) throw new Exception("Socio no encontrado para editar.");
        if (!existente.getDocumento().equals(s.getDocumento())) {
            if (socioDao.existeDocumento(s.getDocumento())) {
                throw new Exception("Ya existe otro socio con ese documento.");
            }
        }
        int edad = Period.between(s.getFechaNacimiento(), LocalDate.now()).getYears();
        if (edad < 15) {
            throw new Exception("El socio debe ser mayor de 15 años.");
        }
        socioDao.actualizar(s);
    }
    // RF-05: Inactivar un socio (Borrado lógico)
    public void inactivar(int id) throws Exception {
        socioDao.inactivar(id);
    }
    public void activar(int id) throws Exception {
        socioDao.activar(id);
    }
    // RF-06: Buscar por documento o por apellido
    public List<Socio> buscar(String criterio) throws Exception {
        if (Validador.esVacio(criterio)) {
            return listarSocios();
        }
        List<Socio> socios = socioDao.buscar(criterio);
        for (Socio s : socios) {
            Membresia ultima = membresiaDao.obtenerUltimaPorSocio(s.getIdSocio());
            if (ultima != null) {
                s.setEstadoMembresia(membresiaService.calcularEstado(ultima));
            }
        }
        return socios;
    }
}
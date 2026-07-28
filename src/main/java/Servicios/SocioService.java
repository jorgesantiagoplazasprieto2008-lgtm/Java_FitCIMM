package Servicios;

import DAO.*;
import Modelo.Membresia;
import Modelo.EstadoMembresia;
import Modelo.Socio;
import Util.*;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

public class SocioService {
    private SocioDAO socioDao = new SocioDAO();
    private MembresiaDAO membresiaDao = new MembresiaDAO();
    private MembresiaService membresiaService = new MembresiaService();

    // RF-01: Registrar con validación de RN-01 y RN-09
    public void registrar(Socio s) throws Exception {
        if (Validador.esVacio(s.getDocumento())) throw new Exception("El documento es obligatorio.");
        if (Validador.esVacio(s.getNombres())) throw new Exception("Los nombres son obligatorios.");
        if (Validador.esVacio(s.getApellidos())) throw new Exception("Los apellidos son obligatorios.");
        if (s.getFechaNacimiento() == null) throw new Exception("La fecha de nacimiento es obligatoria.");
        if (!Validador.esVacio(s.getCorreo()) && !Validador.esCorreoValido(s.getCorreo())) {
            throw new Exception("El formato del correo es inválido.");
        }

        if (socioDao.existeDocumento(s.getDocumento())) {
            throw new Exception("Ya existe un socio con ese documento.");
        }
        if (FechaUtil.calcularEdad(s.getFechaNacimiento()) < 15) {
            throw new Exception("El socio debe ser mayor de 15 años.");
        }
        s.setActivo(true);
        socioDao.RegistrarSocios(s);
    }

    // RF-02: Listar socios con sus estados de membresía correspondientes
    public List<Socio> listarSocios() throws Exception {
        List<Socio> socios = socioDao.listarTodos();
        for (Socio s : socios) {
            Membresia ultima = membresiaDao.obtenerUltimaPorSocio(s.getIdSocio());
            if (ultima != null) {
                s.setEstadoMembresia(membresiaService.calcularEstado(ultima));
            } else {
                s.setEstadoMembresia(null);
            }
        }
        return socios;
    }

    // RF-11: Listar los socios cuya membresía vence en los próximos 5 días (Estado: POR_VENCER)
    public List<Socio> listarSociosPorVencer() throws Exception {
        List<Socio> todos = listarSocios();
        List<Socio> porVencer = new ArrayList<>();
        for (Socio s : todos) {
            if (s.getEstadoMembresia() == EstadoMembresia.POR_VENCER) {
                porVencer.add(s);
            }
        }
        return porVencer;
    }

    public Socio buscarPorId(int id) throws Exception {
        Socio s = socioDao.obtenerPorId(id);
        if (s == null) {
            throw new Exception("El socio no existe.");
        }
        Membresia ultima = membresiaDao.obtenerUltimaPorSocio(s.getIdSocio());
        if (ultima != null) {
            s.setEstadoMembresia(membresiaService.calcularEstado(ultima));
        }
        return s;
    }

    public void editar(Socio s) throws Exception {
        if (Validador.esVacio(s.getNombres())) throw new Exception("Los nombres son obligatorios.");
        if (Validador.esVacio(s.getApellidos())) throw new Exception("Los apellidos son obligatorios.");
        if (s.getFechaNacimiento() == null) throw new Exception("La fecha de nacimiento es obligatoria.");

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

    public void inactivar(int id) throws Exception {
        socioDao.inactivar(id);
    }

    public void activar(int id) throws Exception {
        socioDao.activar(id);
    }

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
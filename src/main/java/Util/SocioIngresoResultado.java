package Util;

import Modelo.EstadoMembresia;

public class SocioIngresoResultado {
    private final String nombreCompleto;
    private final long diasRestantes;
    private final EstadoMembresia estado;
    public SocioIngresoResultado(String nombreCompleto, long diasRestantes, EstadoMembresia estado) {
        this.nombreCompleto = nombreCompleto;
        this.diasRestantes = diasRestantes;
        this.estado = estado;
    }
    public String getNombreCompleto() { return nombreCompleto; }
    public long getDiasRestantes() { return diasRestantes; }
    public EstadoMembresia getEstado() { return estado; }
}

package Modelo;

import java.time.LocalDate;
import java.time.LocalTime;

public class Ingreso {
    private Integer idIngreso;
    private Integer idSocio;
    private LocalDate fechaIngreso;
    private LocalTime horaIngreso;
    private String documentoSocio;
    private String nombreCompletoSocio;

    public Ingreso() {}

    public Ingreso(Integer idIngreso, Integer idSocio, LocalDate fechaIngreso, LocalTime horaIngreso) {
        this.idIngreso = idIngreso;
        this.idSocio = idSocio;
        this.fechaIngreso = fechaIngreso;
        this.horaIngreso = horaIngreso;
    }

    public Integer getIdIngreso() {
        return idIngreso;
    }

    public void setIdIngreso(Integer idIngreso) {
        this.idIngreso = idIngreso;
    }

    public Integer getIdSocio() {
        return idSocio;
    }

    public void setIdSocio(Integer idSocio) {
        this.idSocio = idSocio;
    }

    public LocalDate getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(LocalDate fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public LocalTime getHoraIngreso() {
        return horaIngreso;
    }

    public void setHoraIngreso(LocalTime horaIngreso) {
        this.horaIngreso = horaIngreso;
    }

    public String getDocumentoSocio() {
        return documentoSocio;
    }

    public void setDocumentoSocio(String documentoSocio) {
        this.documentoSocio = documentoSocio;
    }

    public String getNombreCompletoSocio() {
        return nombreCompletoSocio;
    }

    public void setNombreCompletoSocio(String nombreCompletoSocio) {
        this.nombreCompletoSocio = nombreCompletoSocio;
    }
}

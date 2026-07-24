package Modelo;

import java.math.BigDecimal;
import java.time.LocalDate;

public class Membresia {
    private Integer idMembresia;
    private Integer idSocio;
    private Integer idPlan;
    private LocalDate fechaInicio;
    private LocalDate fechaFin;
    private BigDecimal valorPagado;

    // Atributos de conveniencia para reportes y listados
    private String nombrePlan;

    public Membresia() {}

    public Membresia(Integer idMembresia, Integer idSocio, Integer idPlan, LocalDate fechaInicio, LocalDate fechaFin, BigDecimal valorPagado) {
        this.idMembresia = idMembresia;
        this.idSocio = idSocio;
        this.idPlan = idPlan;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.valorPagado = valorPagado;
    }
    // Getters y Setters

    public Integer getIdMembresia() {
        return idMembresia;
    }

    public void setIdMembresia(Integer idMembresia) {
        this.idMembresia = idMembresia;
    }

    public Integer getIdSocio() {
        return idSocio;
    }

    public void setIdSocio(Integer idSocio) {
        this.idSocio = idSocio;
    }

    public Integer getIdPlan() {
        return idPlan;
    }

    public void setIdPlan(Integer idPlan) {
        this.idPlan = idPlan;
    }

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public BigDecimal getValorPagado() {
        return valorPagado;
    }

    public void setValorPagado(BigDecimal valorPagado) {
        this.valorPagado = valorPagado;
    }

    public String getNombrePlan() {
        return nombrePlan;
    }

    public void setNombrePlan(String nombrePlan) {
        this.nombrePlan = nombrePlan;
    }
}

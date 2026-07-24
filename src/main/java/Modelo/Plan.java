package Modelo;

import java.math.BigDecimal;

public class Plan {
    private Integer idPlan;
    private String nombre;
    private int duracionDias;
    private BigDecimal valor;
    private Boolean activo;

    public Plan() {}

    public Plan(Integer idPlan, String nombre, int duracionDias, BigDecimal valor, Boolean activo) {
        this.idPlan = idPlan;
        this.nombre = nombre;
        this.duracionDias = duracionDias;
        this.valor = valor;
        this.activo = activo;
    }

    // Getters y Setters

    public Integer getIdPlan() {
        return idPlan;
    }

    public void setIdPlan(Integer idPlan) {
        this.idPlan = idPlan;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getDuracionDias() {
        return duracionDias;
    }

    public void setDuracionDias(int duracionDias) {
        this.duracionDias = duracionDias;
    }

    public BigDecimal getValor() {
        return valor;
    }

    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    public Boolean getActivo() {
        return activo;
    }

    public void setActivo(Boolean activo) {
        this.activo = activo;
    }
}
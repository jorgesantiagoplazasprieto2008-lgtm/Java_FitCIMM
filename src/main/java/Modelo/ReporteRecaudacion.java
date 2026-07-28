package Modelo;

import java.math.BigDecimal;

public class ReporteRecaudacion {
    private String nombrePlan;
    private BigDecimal totalRecaudado;
    private Integer cantidadVentas;

    public ReporteRecaudacion(){}

    public ReporteRecaudacion(String nombrePlan, BigDecimal totalRecaudado, Integer cantidadVentas) {
        this.nombrePlan = nombrePlan;
        this.totalRecaudado = totalRecaudado;
        this.cantidadVentas = cantidadVentas;
    }

    public String getNombrePlan() {
        return nombrePlan;
    }

    public void setNombrePlan(String nombrePlan) {
        this.nombrePlan = nombrePlan;
    }

    public BigDecimal getTotalRecaudado() {
        return totalRecaudado;
    }

    public void setTotalRecaudado(BigDecimal totalRecaudado) {
        this.totalRecaudado = totalRecaudado;
    }

    public Integer getCantidadVentas() {
        return cantidadVentas;
    }

    public void setCantidadVentas(Integer cantidadVentas) {
        this.cantidadVentas = cantidadVentas;
    }
}

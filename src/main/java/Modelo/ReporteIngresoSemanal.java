package Modelo;

import java.time.LocalDate;

public class ReporteIngresoSemanal {
    private LocalDate fecha;
    private Integer totalIngresos;

    public ReporteIngresoSemanal(){}

    public ReporteIngresoSemanal(LocalDate fecha, Integer totalIngresos) {
        this.fecha = fecha;
        this.totalIngresos = totalIngresos;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public void setFecha(LocalDate fecha) {
        this.fecha = fecha;
    }

    public Integer getTotalIngresos() {
        return totalIngresos;
    }

    public void setTotalIngresos(Integer totalIngresos) {
        this.totalIngresos = totalIngresos;
    }
}

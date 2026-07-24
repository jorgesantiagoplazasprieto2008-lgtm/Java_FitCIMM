package Util;

import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;

public class FechaUtil {

    /**
     * Calcula los días de diferencia entre el día de hoy y una fecha límite dada.
     * Útil para calcular los días restantes de una membresía (RN-04).
     *
     * @param fin Fecha de finalización
     * @return long cantidad de días (puede ser negativo si ya venció)
     */
    public static long diasRestantes(LocalDate fin) {
        if (fin == null) {
            throw new IllegalArgumentException("La fecha de fin no puede ser nula.");
        }
        return ChronoUnit.DAYS.between(LocalDate.now(), fin);
    }

    /**
     * Calcula la edad exacta de una persona basándose en su fecha de nacimiento.
     * Útil para comprobar si el socio es mayor de 15 años (RN-09).
     *
     * @param fechaNacimiento Fecha de nacimiento
     * @return int edad en años
     */
    public static int calcularEdad(LocalDate fechaNacimiento) {
        if (fechaNacimiento == null) {
            return 0;
        }
        return Period.between(fechaNacimiento, LocalDate.now()).getYears();
    }
}
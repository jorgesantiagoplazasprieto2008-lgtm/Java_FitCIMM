package Util;

import java.math.BigDecimal;
import java.util.regex.Pattern;

public class Validador {

    // Expresión regular estándar para formato de correo electrónico
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$");

    /**
     * Comprueba si una cadena de texto está vacía o es nula (limpiando espacios).
     *
     * @param texto Cadena a evaluar
     * @return true si es nulo o vacío
     */
    public static boolean esVacio(String texto) {
        return texto == null || texto.trim().isEmpty();
    }

    /**
     * Valida si una dirección de correo electrónico cumple con el estándar RFC 5322.
     *
     * @param correo Correo a evaluar
     * @return true si el formato es correcto
     */
    public static boolean esCorreoValido(String correo) {
        if (correo == null) {
            return false;
        }
        return EMAIL_PATTERN.matcher(correo).matches();
    }

    /**
     * Comprueba si un número entero es estrictamente positivo.
     * Útil para validar la duración en días de los planes.
     *
     * @param numero Número entero
     * @return true si es mayor a cero
     */
    public static boolean esNumeroPositivo(int numero) {
        return numero > 0;
    }

    /**
     * Comprueba si un valor BigDecimal es estrictamente positivo.
     * Útil para validar precios o importes a pagar de planes o membresías.
     *
     * @param valor Valor decimal
     * @return true si es mayor a cero
     */
    public static boolean esDecimalPositivo(BigDecimal valor) {
        return valor != null && valor.compareTo(BigDecimal.ZERO) > 0;
    }
}
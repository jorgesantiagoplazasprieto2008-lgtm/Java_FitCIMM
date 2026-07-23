package Modelo;

import java.time.LocalDate;

public class Socio {
    private Integer idSocio;
    private String documento;
    private String nombres;
    private String apellidos;
    private String telefono;
    private String correo;
    private LocalDate fechaNacimiento;
    private Boolean activo;
    private String estadoMembresia;

    public Socio(){}

    public Socio(Integer idSocio,String documento, String nombres, String apellidos, String telefono, String correo, LocalDate fechaNacimiento, Boolean activo)
    {
        this.idSocio = idSocio;
        this.documento = documento;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.correo = correo;
        this.fechaNacimiento = fechaNacimiento;
        this.activo = activo;
    }

    public Integer getIdSocio() { return idSocio; }
    public void setIdSocio(Integer idSocio) { this.idSocio = idSocio; }
    public String getDocumento() { return documento; }
    public void setDocumento(String documento) { this.documento = documento; }
    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }
    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    public LocalDate getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(LocalDate fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }
    public Boolean getActivo() { return activo; }
    public void setActivo(Boolean activo) { this.activo = activo; }
    public String getEstadoMembresia() { return estadoMembresia; }
    public void setEstadoMembresia(String estadoMembresia) { this.estadoMembresia = estadoMembresia; }
    @Override
    public String toString() {
        return "Socio{" + "idSocio=" + idSocio + ", documento='" + documento + '\'' +
                ", nombres='" + nombres + '\'' + ", apellidos='" + apellidos + '\'' +
                ", estadoMembresia='" + estadoMembresia + '\'' + '}';
    }


}

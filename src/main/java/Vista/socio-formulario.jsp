<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - ${modo == 'editar' ? 'Editar Socio' : 'Registrar Socio'}</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Font: Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Animate.css -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 50%, #3730a3 100%);
            --card-shadow: 0 10px 40px rgba(79, 70, 229, 0.08);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
            min-height: 100vh;
            color: #1e293b;
        }

        /* Navbar idéntico al listado */
        .navbar {
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%) !important;
            box-shadow: 0 4px 20px rgba(30, 27, 75, 0.3);
            border-bottom: 3px solid #4f46e5;
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            letter-spacing: 0.5px;
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: 8px;
            transition: var(--transition-smooth);
        }

        .nav-link:hover {
            color: white !important;
            background: rgba(79, 70, 229, 0.3);
            transform: translateY(-2px);
        }

        /* Tarjeta de Formulario Premium */
        .form-card {
            border: none;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--card-shadow);
            padding: 2.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-top: 2rem;
            transition: var(--transition-smooth);
        }

        .form-card:hover {
            box-shadow: 0 20px 60px rgba(79, 70, 229, 0.12);
        }

        /* Encabezado */
        .header-section {
            padding-bottom: 1.5rem;
            border-bottom: 2px solid rgba(79, 70, 229, 0.1);
            margin-bottom: 2rem;
        }

        .header-section h2 {
            font-weight: 800;
            color: #1e1b4b;
        }

        .header-section .subtitle {
            color: #64748b;
            font-size: 0.95rem;
        }

        /* Etiquetas y Controles de formulario */
        .form-label {
            font-weight: 600;
            color: #334155;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
        }

        .form-label i {
            color: #4f46e5;
        }

        .input-group-custom {
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            transition: var(--transition-smooth);
            overflow: hidden;
        }

        .input-group-custom:focus-within {
            border-color: #4f46e5;
            box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.1);
            background: white;
        }

        .input-group-custom .form-control {
            border: none;
            background: transparent;
            padding: 0.75rem 1rem;
            font-weight: 400;
            color: #1e293b;
        }

        .input-group-custom .form-control:focus {
            box-shadow: none;
            background: transparent;
        }

        .input-group-custom .input-group-text {
            background: transparent;
            border: none;
            color: #94a3b8;
            padding-left: 1rem;
            padding-right: 0;
        }

        /* Botón Guardar */
        .btn-custom-primary {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            padding: 0.75rem 2.5rem;
            border-radius: 12px;
            transition: var(--transition-smooth);
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
        }

        .btn-custom-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
            color: white;
        }

        /* Botón Cancelar */
        .btn-custom-outline {
            border: 2px solid #cbd5e1;
            background: transparent;
            color: #64748b;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 12px;
            transition: var(--transition-smooth);
        }

        .btn-custom-outline:hover {
            background: #f1f5f9;
            color: #334155;
            border-color: #94a3b8;
            transform: translateY(-2px);
        }

        /* Alertas */
        .alert {
            border: none;
            border-radius: 16px;
            padding: 1rem 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            font-weight: 500;
        }

        .alert-danger {
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            color: #991b1b;
            border-left: 4px solid #dc2626;
        }

        /* Animación de entrada */
        .animate-enter {
            animation: fadeInUp 0.5s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <!-- Menú de Navegación Mejorado (Idéntico al listado) -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-lightning-charge-fill me-2"></i>FitCIMM
            </a>
            <button class="navbar-dark navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="socios?accion=listar">
                            <i class="bi bi-people-fill me-1"></i> Socios
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="bi bi-card-checklist me-1"></i> Planes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ingresos?accion=pantalla">
                            <i class="bi bi-door-open-fill me-1"></i> Control de Ingresos
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Contenedor del Formulario -->
    <div class="container mb-5 animate-enter">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8 col-12">

                <div class="card form-card">
                    <!-- Encabezado del Formulario -->
                    <div class="header-section">
                        <h2 class="fw-bold mb-0">
                            <c:choose>
                                <c:when test="${modo == 'editar'}">
                                    <i class="bi bi-pencil-square text-primary me-2"></i>Editar Socio
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-person-plus-fill text-primary me-2"></i>Registrar Socio
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="subtitle mt-1">
                            <c:choose>
                                <c:when test="${modo == 'editar'}">
                                    Edite los datos del deportista. El documento no puede ser alterado.
                                </c:when>
                                <c:otherwise>
                                    Ingrese la información del nuevo deportista para darlo de alta en FitCIMM.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>

                    <!-- Banner de Errores (Redirigido de Excepciones del SocioService) -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                <span>${error}</span>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <!-- Formulario con Action dinámica -->
                    <form action="socios?accion=${modo == 'editar' ? 'actualizar' : 'guardar'}" method="POST" autocomplete="off">
                        <!-- Inputs ocultos indispensables -->
                        <input type="hidden" name="idSocio" value="${socio.idSocio}">
                        <input type="hidden" name="activo" value="${socio.activo}">

                        <div class="row g-4">
                            <!-- Documento -->
                            <div class="col-md-6 col-12">
                                <label for="documento" class="form-label">
                                    <i class="bi bi-person-vcard"></i>Número de Documento *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                                    <input type="text" id="documento" name="documento" class="form-control"
                                           placeholder="Ej. 1020456789" required value="${socio.documento}"
                                           ${modo == 'editar' ? 'readonly' : ''}>
                                </div>
                                <c:if test="${modo == 'editar'}">
                                    <div class="form-text text-muted mt-1"><i class="bi bi-info-circle me-1"></i>El documento no es modificable.</div>
                                </c:if>
                            </div>

                            <!-- Fecha de Nacimiento -->
                            <div class="col-md-6 col-12">
                                <label for="fechaNacimiento" class="form-label">
                                    <i class="bi bi-calendar3"></i>Fecha de Nacimiento *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-calendar-event"></i></span>
                                    <input type="date" id="fechaNacimiento" name="fechaNacimiento" class="form-control"
                                           required value="${socio.fechaNacimiento}">
                                </div>
                                <div class="form-text text-muted mt-1"><i class="bi bi-info-circle me-1"></i>El socio debe ser mayor de 15 años.</div>
                            </div>

                            <!-- Nombres -->
                            <div class="col-md-6 col-12">
                                <label for="nombres" class="form-label">
                                    <i class="bi bi-person"></i>Nombres *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-pencil"></i></span>
                                    <input type="text" id="nombres" name="nombres" class="form-control"
                                           placeholder="Ej. Juan Carlos" required value="${socio.nombres}">
                                </div>
                            </div>

                            <!-- Apellidos -->
                            <div class="col-md-6 col-12">
                                <label for="apellidos" class="form-label">
                                    <i class="bi bi-person-fill"></i>Apellidos *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-pencil"></i></span>
                                    <input type="text" id="apellidos" name="apellidos" class="form-control"
                                           placeholder="Ej. Pérez Gómez" required value="${socio.apellidos}">
                                </div>
                            </div>

                            <!-- Teléfono -->
                            <div class="col-md-6 col-12">
                                <label for="telefono" class="form-label">
                                    <i class="bi bi-telephone"></i>Teléfono / Celular
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-phone"></i></span>
                                    <input type="tel" id="telefono" name="telefono" class="form-control"
                                           placeholder="Ej. 3123456789" value="${socio.telefono}">
                                </div>
                            </div>

                            <!-- Correo Electrónico -->
                            <div class="col-md-6 col-12">
                                <label for="correo" class="form-label">
                                    <i class="bi bi-envelope"></i>Correo Electrónico
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-envelope-at"></i></span>
                                    <input type="email" id="correo" name="correo" class="form-control"
                                           placeholder="Ej. juan.perez@email.com" value="${socio.correo}">
                                </div>
                            </div>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="d-flex justify-content-end gap-3 mt-5">
                            <a href="socios?accion=listar" class="btn btn-custom-outline">
                                <i class="bi bi-arrow-left-short fs-5 align-middle me-1"></i>Volver al listado
                            </a>
                            <button type="submit" class="btn btn-custom-primary">
                                <i class="bi bi-check-circle-fill me-2"></i>Guardar Cambios
                            </button>
                        </div>
                    </form>

                </div>

            </div>
        </div>
    </div>

    <!-- Script de temporizador de alerta (idéntico al listado) -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const closeButton = alert.querySelector('.btn-close');
                    if (closeButton) {
                        closeButton.click();
                    }
                }, 5000);
            });
        });
    </script>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
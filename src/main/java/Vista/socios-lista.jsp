<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - Listado de Socios</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Font: Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Animate.css para animaciones sutiles -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 50%, #3730a3 100%);
            --card-shadow: 0 10px 40px rgba(79, 70, 229, 0.08);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
            min-height: 100vh;
            color: #1e293b;
        }

        /* Navbar mejorado */
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
            transition: var(--transition-smooth);
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            -webkit-text-fill-color: #fbbf24;
        }

        .navbar-brand i {
            -webkit-text-fill-color: #fbbf24;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: 8px;
            transition: var(--transition-smooth);
            position: relative;
        }

        .nav-link:hover, .nav-link.active {
            color: white !important;
            background: rgba(79, 70, 229, 0.3);
            transform: translateY(-2px);
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 20px;
            height: 3px;
            background: #fbbf24;
            border-radius: 3px;
        }

        /* Tarjeta principal mejorada */
        .main-card {
            border: none;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            transition: var(--transition-smooth);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-top: -1rem;
        }

        .main-card:hover {
            box-shadow: 0 20px 60px rgba(79, 70, 229, 0.12);
        }

        /* Encabezado mejorado */
        .header-section {
            padding-bottom: 1.5rem;
            border-bottom: 2px solid rgba(79, 70, 229, 0.1);
            margin-bottom: 1.5rem;
        }

        .header-section h2 {
            font-weight: 800;
            color: #1e1b4b;
            font-size: 2rem;
        }

        .header-section .subtitle {
            color: #64748b;
            font-weight: 400;
            font-size: 0.95rem;
            margin-top: 0.25rem;
        }

        .header-section .subtitle i {
            color: #4f46e5;
            margin-right: 0.5rem;
        }

        /* Botón personalizado mejorado */
        .btn-custom-primary {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 12px;
            transition: var(--transition-smooth);
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-custom-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-custom-primary:hover::before {
            left: 100%;
        }

        .btn-custom-primary:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
            color: white;
        }

        .btn-custom-primary:active {
            transform: scale(0.98);
        }

        /* Buscador mejorado */
        .search-box {
            background: white;
            border-radius: 14px;
            padding: 0.25rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border: 2px solid rgba(79, 70, 229, 0.1);
            transition: var(--transition-smooth);
        }

        .search-box:focus-within {
            border-color: #4f46e5;
            box-shadow: 0 4px 20px rgba(79, 70, 229, 0.15);
        }

        .search-box .input-group-text {
            background: transparent;
            border: none;
            color: #94a3b8;
            padding-right: 0;
        }

        .search-box input {
            border: none;
            padding: 0.75rem 1rem;
            font-weight: 400;
            background: transparent;
        }

        .search-box input:focus {
            box-shadow: none;
        }

        .search-box .btn-dark {
            border-radius: 12px;
            padding: 0.75rem 2rem;
            background: var(--primary-gradient);
            border: none;
            font-weight: 600;
            transition: var(--transition-smooth);
        }

        .search-box .btn-dark:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
        }

        /* Tabla mejorada */
        .table-responsive {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            color: #475569;
            background: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
            padding: 1rem 0.75rem;
        }

        .table tbody tr {
            transition: var(--transition-smooth);
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .table tbody tr:hover {
            background: #f8fafc;
            transform: scale(1.005);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table tbody tr:last-child {
            border-bottom: none;
        }

        .table tbody td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
        }

        .table .documento-cell {
            font-weight: 700;
            color: #1e1b4b;
            font-size: 0.9rem;
        }

        .table .nombre-cell {
            font-weight: 500;
        }

        /* Badges mejorados */
        .badge {
            font-weight: 600;
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            font-size: 0.75rem;
            letter-spacing: 0.3px;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            transition: var(--transition-smooth);
        }

        .badge-vigente {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #065f46;
            border: 1px solid #6ee7b7;
        }

        .badge-porvencer {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
            border: 1px solid #fcd34d;
        }

        .badge-vencida {
            background: linear-gradient(135deg, #fee2e2, #fca5a5);
            color: #991b1b;
            border: 1px solid #f87171;
        }

        .badge-sin {
            background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
            color: #475569;
            border: 1px solid #94a3b8;
        }

        .badge-inactivo {
            background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
            color: #64748b;
            border: 1px solid #94a3b8;
        }

        .badge i {
            font-size: 0.85rem;
        }

        /* Botones de acción mejorados */
        .btn-group .btn {
            border-radius: 8px !important;
            padding: 0.4rem 0.8rem;
            transition: var(--transition-smooth);
            border-width: 1.5px;
        }

        .btn-group .btn-outline-primary {
            color: #4f46e5;
            border-color: #4f46e5;
        }

        .btn-group .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }

        .btn-group .btn-outline-danger {
            color: #dc2626;
            border-color: #dc2626;
        }

        .btn-group .btn-outline-danger:hover {
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
        }

        /* Alertas mejoradas */
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

        /* Estado vacío mejorado */
        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: #94a3b8;
            font-size: 1.1rem;
        }

        /* Fila inactiva */
        .table tbody tr.inactive-row {
            background: #f8fafc;
            opacity: 0.7;
        }

        .table tbody tr.inactive-row:hover {
            opacity: 0.9;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-card {
                padding: 1rem;
                border-radius: 16px;
            }

            .header-section h2 {
                font-size: 1.5rem;
            }

            .btn-custom-primary {
                padding: 0.5rem 1.5rem;
                font-size: 0.9rem;
            }

            .table thead th {
                font-size: 0.7rem;
                padding: 0.75rem 0.5rem;
            }

            .table tbody td {
                padding: 0.75rem 0.5rem;
                font-size: 0.85rem;
            }

            .badge {
                padding: 0.35rem 0.8rem;
                font-size: 0.7rem;
            }

            .search-box .btn-dark {
                padding: 0.5rem 1rem;
                font-size: 0.85rem;
            }
        }

        /* Animaciones de entrada */
        .animate-enter {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Scrollbar personalizado */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #4f46e5, #7c3aed);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #4338ca, #6d28d9);
        }
    </style>
</head>
<body>

    <!-- Menú de Navegación Mejorado -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-lightning-charge-fill me-2"></i>FitCIMM
            </a>
            <button class="navbar-dark navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
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

    <!-- Contenido Principal -->
    <div class="container mb-5 animate-enter">
        <div class="card main-card">
            <!-- Encabezado -->
            <div class="header-section">
                <div class="row align-items-center">
                    <div class="col-md-6 col-12">
                        <h2 class="fw-bold mb-0">
                            <i class="bi bi-person-arms-up text-primary me-2"></i>Gestión de Socios
                        </h2>
                        <p class="subtitle">
                            <i class="bi bi-database"></i>Listado general de deportistas del gimnasio
                        </p>
                    </div>
                    <div class="col-md-6 col-12 text-md-end mt-3 mt-md-0">
                        <a href="socios?accion=nuevo" class="btn btn-custom-primary px-4 py-2 rounded-3">
                            <i class="bi bi-person-plus-fill me-2"></i>Registrar Nuevo Socio
                        </a>
                    </div>
                </div>
            </div>

            <!-- Alerta informativa de éxito/error -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Buscador y Filtros Mejorado -->
            <form action="socios" method="GET" class="row g-3 mb-4">
                <input type="hidden" name="accion" value="listar">
                <div class="col-md-8">
                    <div class="search-box">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="bi bi-search"></i>
                            </span>
                            <input type="text" name="criterio" class="form-control" placeholder="Buscar por documento o apellido..." value="${criterio}">
                            <button type="submit" class="btn btn-dark">
                                <i class="bi bi-arrow-right me-1"></i>Buscar
                            </button>
                        </div>
                    </div>
                </div>
                <c:if test="${not empty criterio}">
                    <div class="col-md-2">
                        <a href="socios?accion=listar" class="btn btn-outline-secondary w-100 rounded-12">
                            <i class="bi bi-x-circle me-1"></i>Limpiar
                        </a>
                    </div>
                </c:if>
            </form>

            <!-- Tabla de Socios Mejorada -->
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th><i class="bi bi-person-vcard me-1"></i>Documento</th>
                            <th><i class="bi bi-person me-1"></i>Nombres y Apellidos</th>
                            <th><i class="bi bi-telephone me-1"></i>Teléfono</th>
                            <th><i class="bi bi-envelope me-1"></i>Correo Electrónico</th>
                            <th class="text-center"><i class="bi bi-shield-check me-1"></i>Estado Membresía</th>
                            <th class="text-center"><i class="bi bi-gear me-1"></i>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="socio" items="${socios}">
                            <tr class="${not socio.activo ? 'inactive-row' : ''}">
                                <td class="documento-cell">${socio.documento}</td>
                                <td class="nombre-cell">${socio.nombres} ${socio.apellidos}</td>
                                <td>${empty socio.telefono ? 'N/A' : socio.telefono}</td>
                                <td>${empty socio.correo ? 'N/A' : socio.correo}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not socio.activo}">
                                            <span class="badge badge-inactivo">
                                                <i class="bi bi-toggle-off"></i>INACTIVO
                                            </span>
                                        </c:when>
                                        <c:when test="${socio.estadoMembresia == 'VIGENTE'}">
                                            <span class="badge badge-vigente">
                                                <i class="bi bi-check-circle-fill"></i>VIGENTE
                                            </span>
                                        </c:when>
                                        <c:when test="${socio.estadoMembresia == 'POR_VENCER'}">
                                            <span class="badge badge-porvencer">
                                                <i class="bi bi-exclamation-circle-fill"></i>POR VENCER
                                            </span>
                                        </c:when>
                                        <c:when test="${socio.estadoMembresia == 'VENCIDA'}">
                                            <span class="badge badge-vencida">
                                                <i class="bi bi-x-circle-fill"></i>VENCIDA
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-sin">
                                                <i class="bi bi-dash-circle"></i>SIN PLAN
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <!-- Botón Editar (siempre visible) -->
                                        <a href="socios?accion=editar&id=${socio.idSocio}" class="btn btn-sm btn-outline-primary px-3" title="Editar socio">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>

                                        <!-- Botón de Inactivar (solo si está activo) -->
                                        <c:if test="${socio.activo}">
                                            <a href="javascript:void(0);"
                                               onclick="confirmarInactivacion(${socio.idSocio}, '${socio.nombres} ${socio.apellidos}')"
                                               class="btn btn-sm btn-outline-danger px-3"
                                               title="Dar de baja">
                                                <i class="bi bi-person-x-fill"></i>
                                            </a>
                                        </c:if>

                                        <!-- Botón de Reactivar (solo si está inactivo) -->
                                        <c:if test="${not socio.activo}">
                                            <a href="javascript:void(0);"
                                               onclick="confirmarReactivacion(${socio.idSocio}, '${socio.nombres} ${socio.apellidos}')"
                                               class="btn btn-sm btn-outline-success px-3"
                                               title="Reactivar socio">
                                                <i class="bi bi-person-check-fill"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty socios}">
                            <tr>
                                <td colspan="6" class="text-center">
                                    <div class="empty-state">
                                        <i class="bi bi-folder-x display-1"></i>
                                        <p class="mt-3">No se encontraron socios registrados.</p>
                                        <a href="socios?accion=nuevo" class="btn btn-custom-primary mt-2">
                                            <i class="bi bi-person-plus-fill me-2"></i>Registrar primer socio
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Script de confirmación -->
    <script>
           function confirmarInactivacion(id, nombre) {
               if (confirm("¿Está seguro de que desea inactivar al socio " + nombre + "? Esta acción realiza una baja lógica en el sistema.")) {
                   window.location.href = "socios?accion=inactivar&id=" + id;
               }
           }

           function confirmarReactivacion(id, nombre) {
               if (confirm("¿Está seguro de que desea reactivar al socio " + nombre + "? Esta acción restaurará su acceso al sistema.")) {
                   window.location.href = "socios?accion=reactivar&id=" + id;
               }
           }

           // Cerrar alertas automáticamente después de 5 segundos
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

    <!-- Bootstrap JS Bundle (Includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
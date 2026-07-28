<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - Detalle del Socio</title>
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
        }
        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: 8px;
            transition: var(--transition-smooth);
        }
        .nav-link:hover, .nav-link.active {
            color: white !important;
            background: rgba(79, 70, 229, 0.3);
            transform: translateY(-2px);
        }
        .main-card {
            border: none;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--card-shadow);
            padding: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-top: 2rem;
        }
        .header-section {
            padding-bottom: 1.5rem;
            border-bottom: 2px solid rgba(79, 70, 229, 0.1);
            margin-bottom: 1.5rem;
        }
        .header-section h2 {
            font-weight: 800;
            color: #1e1b4b;
        }
        .btn-custom-primary {
            background: var(--primary-gradient);
            color: white;
            border: none;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 12px;
            transition: var(--transition-smooth);
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
        }
        .btn-custom-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
            color: white;
        }
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
        }

        /* Badges de membresía dinámicos */
        .badge-vigente {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            color: #065f46;
            border: 1px solid #6ee7b7;
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-weight: 600;
        }
        .badge-porvencer {
            background: linear-gradient(135deg, #fef3c7, #fde68a);
            color: #92400e;
            border: 1px solid #fcd34d;
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-weight: 600;
        }
        .badge-vencida {
            background: linear-gradient(135deg, #fee2e2, #fca5a5);
            color: #991b1b;
            border: 1px solid #f87171;
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-weight: 600;
        }
        .badge-sin {
            background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
            color: #475569;
            border: 1px solid #94a3b8;
            padding: 0.4rem 1rem;
            border-radius: 50px;
            font-weight: 600;
        }

        /* Etiquetas y valores */
        .info-label {
            font-weight: 600;
            color: #64748b;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .info-value {
            font-weight: 700;
            color: #1e1b4b;
            font-size: 1.1rem;
        }
        .animate-enter {
            animation: fadeInUp 0.5s ease-out;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <!-- Menú de Navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="bi bi-lightning-charge-fill me-2"></i>FitCIMM</a>
            <button class="navbar-dark navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="socios?accion=listar"><i class="bi bi-people-fill me-1"></i> Socios</a></li>
                    <li class="nav-item"><a class="nav-link" href="planes?accion=listar"><i class="bi bi-card-checklist me-1"></i> Planes</a></li>
                    <li class="nav-item"><a class="nav-link" href="ingresos?accion=pantalla"><i class="bi bi-door-open-fill me-1"></i> Control de Ingresos</a></li>
                    <li class="nav-item"><a class="nav-link" href="reportes"><i class="bi bi-briefcase-fill me-1"></i> Reportes</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mb-5 animate-enter">

        <!-- Banner de éxito -->
        <c:if test="${not empty mensajeExito}">
            <div class="alert alert-success alert-dismissible fade show rounded-3 shadow-sm my-3" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${mensajeExito}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Tarjeta Principal: Ficha del Socio -->
        <div class="card main-card mb-4">
            <div class="header-section d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h2 class="fw-bold mb-0"><i class="bi bi-person-badge text-primary me-2"></i>Ficha del Socio</h2>
                    <p class="text-muted mb-0">Información detallada y estado de la membresía</p>
                </div>
                <div class="d-flex gap-2">
                    <a href="socios?accion=listar" class="btn btn-custom-outline d-flex align-items-center">
                        <i class="bi bi-arrow-left me-1"></i>Volver
                    </a>
                    <a href="membresias?accion=vender&idSocio=${socio.idSocio}" class="btn btn-custom-primary d-flex align-items-center">
                        <i class="bi bi-cart-plus-fill me-1"></i>Vender Plan
                    </a>
                    <a href="membresias?accion=renovar&idSocio=${socio.idSocio}" class="btn btn-warning fw-semibold px-3 text-dark rounded-3 d-flex align-items-center">
                        <i class="bi bi-arrow-repeat me-1"></i>Renovar
                    </a>
                </div>
            </div>

            <!-- Contenedor Reorganizado en Columnas Equilibradas y Estilizadas -->
            <div class="row g-3 mb-2">
                <!-- Nombres y Apellidos -->
                <div class="col-md-4 col-sm-12">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-person text-primary me-1"></i>Nombres y Apellidos</div>
                        <div class="info-value text-wrap">${socio.nombres} ${socio.apellidos}</div>
                    </div>
                </div>

                <!-- Documento -->
                <div class="col-md-3 col-sm-6 col-6">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-card-text text-primary me-1"></i>Documento</div>
                        <div class="info-value">${socio.documento}</div>
                    </div>
                </div>

                <!-- Fecha de Nacimiento -->
                <div class="col-md-3 col-sm-6 col-6">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-calendar-event text-primary me-1"></i>Fecha de Nacimiento</div>
                        <div class="info-value">${socio.fechaNacimiento}</div>
                    </div>
                </div>

                <!-- Estado de Cuenta -->
                <div class="col-md-2 col-sm-6 col-6">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-shield-check text-primary me-1"></i>Estado de Cuenta</div>
                        <div class="info-value mt-1">
                            <c:choose>
                                <c:when test="${socio.activo}">
                                    <span class="badge bg-success px-3 py-1 rounded-pill">Activo</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger px-3 py-1 rounded-pill">Inactivo</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Correo Electrónico -->
                <div class="col-md-4 col-sm-12">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-envelope text-primary me-1"></i>Correo Electrónico</div>
                        <div class="info-value text-truncate" title="${socio.correo}">${empty socio.correo ? 'N/A' : socio.correo}</div>
                    </div>
                </div>

                <!-- Teléfono -->
                <div class="col-md-3 col-sm-6 col-6">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-telephone text-primary me-1"></i>Teléfono</div>
                        <div class="info-value">${empty socio.telefono ? 'N/A' : socio.telefono}</div>
                    </div>
                </div>

                <!-- Membresía Actual -->
                <div class="col-md-5 col-sm-6 col-6">
                    <div class="p-3 bg-light rounded-3 h-100 border border-light-subtle">
                        <div class="info-label mb-1"><i class="bi bi-lightning-charge text-primary me-1"></i>Membresía Actual</div>
                        <div class="info-value mt-1">
                            <c:choose>
                                <c:when test="${socio.estadoMembresia == 'VIGENTE'}">
                                    <span class="badge badge-vigente"><i class="bi bi-check-circle-fill me-1"></i>VIGENTE</span>
                                </c:when>
                                <c:when test="${socio.estadoMembresia == 'POR_VENCER'}">
                                    <span class="badge badge-porvencer"><i class="bi bi-exclamation-circle-fill me-1"></i>POR VENCER</span>
                                </c:when>
                                <c:when test="${socio.estadoMembresia == 'VENCIDA'}">
                                    <span class="badge badge-vencida"><i class="bi bi-x-circle-fill me-1"></i>VENCIDA</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-sin"><i class="bi bi-dash-circle me-1"></i>SIN MEMBRESÍA</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tarjeta: Membresía Activa o más Reciente -->
        <c:if test="${not empty ultimaMembresia}">
            <div class="card main-card mb-4 border-primary border-2">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="fw-bold text-primary mb-0"><i class="bi bi-award-fill me-2"></i>Membresía Activa / Más Reciente</h4>
                    <span class="fs-5 fw-bold text-success">$ ${ultimaMembresia.valorPagado}</span>
                </div>
                <div class="row g-3">
                    <div class="col-md-4">
                        <span class="text-muted small d-block">Plan Contratado:</span>
                        <strong class="fs-5 text-dark">${ultimaMembresia.nombrePlan}</strong>
                    </div>
                    <div class="col-md-4">
                        <span class="text-muted small d-block">Fecha de Inicio:</span>
                        <strong class="fs-6">${ultimaMembresia.fechaInicio}</strong>
                    </div>
                    <div class="col-md-4">
                        <span class="text-muted small d-block">Fecha de Fin:</span>
                        <strong class="fs-6 text-primary">${ultimaMembresia.fechaFin}</strong>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Tarjeta: Tabla de Historial Cronológico -->
        <div class="card main-card">
            <div class="header-section">
                <h4 class="fw-bold mb-0"><i class="bi bi-clock-history me-2 text-primary"></i>Historial de Membresías</h4>
                <p class="text-muted small mb-0">Listado histórico de todas las compras y renovaciones asociadas a este socio</p>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th># ID</th>
                            <th>Plan</th>
                            <th class="text-center">Fecha Inicio</th>
                            <th class="text-center">Fecha Fin (Cálculo Auto)</th>
                            <th class="text-end">Valor Pagado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${historialMembresias}">
                            <tr>
                                <td class="fw-bold text-secondary"># ${item.idMembresia}</td>
                                <td class="fw-bold text-dark">${item.nombrePlan}</td>
                                <td class="text-center">${item.fechaInicio}</td>
                                <td class="text-center fw-semibold text-primary">${item.fechaFin}</td>
                                <td class="text-end fw-bold text-success">$ ${item.valorPagado}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty historialMembresias}">
                            <tr>
                                <td colspan="5" class="text-center py-4 text-muted">
                                    <i class="bi bi-folder-x display-5 d-block mb-2"></i>
                                    El socio aún no cuenta con membresías registradas en su historial.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
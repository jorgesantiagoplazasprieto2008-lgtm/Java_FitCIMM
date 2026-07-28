<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - Gestión de Planes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 50%, #3730a3 100%);
            --card-shadow: 0 10px 40px rgba(79, 70, 229, 0.08);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        body { font-family: 'Outfit', sans-serif; background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%); min-height: 100vh; color: #1e293b; }
        .navbar { background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%) !important; box-shadow: 0 4px 20px rgba(30, 27, 75, 0.3); border-bottom: 3px solid #4f46e5; padding: 1rem 0; }
        .navbar-brand { font-weight: 800; font-size: 1.5rem; letter-spacing: 0.5px; background: linear-gradient(135deg, #fbbf24, #f59e0b); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { color: rgba(255, 255, 255, 0.8) !important; font-weight: 500; padding: 0.5rem 1rem !important; border-radius: 8px; transition: var(--transition-smooth); }
        .nav-link:hover, .nav-link.active { color: white !important; background: rgba(79, 70, 229, 0.3); transform: translateY(-2px); }
        .main-card { border: none; border-radius: 24px; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); box-shadow: var(--card-shadow); padding: 2rem; border: 1px solid rgba(255, 255, 255, 0.2); margin-top: 2rem; }
        .header-section { padding-bottom: 1.5rem; border-bottom: 2px solid rgba(79, 70, 229, 0.1); margin-bottom: 1.5rem; }
        .header-section h2 { font-weight: 800; color: #1e1b4b; }
        .btn-custom-primary { background: var(--primary-gradient); color: white; border: none; font-weight: 600; padding: 0.75rem 2rem; border-radius: 12px; transition: var(--transition-smooth); box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3); }
        .btn-custom-primary:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4); color: white; }
        .table-responsive { border-radius: 16px; overflow: hidden; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); }
        .table thead th { font-weight: 600; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 0.5px; color: #475569; background: #f8fafc; border-bottom: 2px solid #e2e8f0; padding: 1rem 0.75rem; }
        .table tbody td { padding: 1rem 0.75rem; vertical-align: middle; }
        .badge-activo { background: linear-gradient(135deg, #d1fae5, #a7f3d0); color: #065f46; border: 1px solid #6ee7b7; padding: 0.4rem 1rem; border-radius: 50px; font-weight: 600; }
        .badge-inactivo { background: linear-gradient(135deg, #fee2e2, #fca5a5); color: #991b1b; border: 1px solid #f87171; padding: 0.4rem 1rem; border-radius: 50px; font-weight: 600; }
        .alert { border: none; border-radius: 16px; padding: 1rem 1.5rem; font-weight: 500; }
        .animate-enter { animation: fadeInUp 0.5s ease-out; }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

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
                        <a class="nav-link" href="socios?accion=listar">
                            <i class="bi bi-people-fill me-1"></i> Socios
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="planes?accion=listar">
                            <i class="bi bi-card-checklist me-1"></i> Planes
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ingresos?accion=pantalla">
                            <i class="bi bi-door-open-fill me-1"></i> Control de Ingresos
                        </a>
                    </li>
                    <li class="nav-item">
                                            <a class="nav-link" href="reportes">
                                                <i class="bi bi-briefcase-fill me-1"></i> Reportes
                                            </a>
                                         </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mb-5 animate-enter">
        <div class="card main-card">
            <div class="header-section">
                <div class="row align-items-center">
                    <div class="col-md-6 col-12">
                        <h2 class="fw-bold mb-0">
                            <i class="bi bi-card-checklist text-primary me-2"></i>Gestión de Planes
                        </h2>
                        <p class="text-muted mb-0 mt-1">
                            Listado general de planes y tarifas del gimnasio
                        </p>
                    </div>
                    <div class="col-md-6 col-12 text-md-end mt-3 mt-md-0">
                        <a href="planes?accion=nuevo" class="btn btn-custom-primary">
                            <i class="bi bi-plus-circle-fill me-2"></i>Nuevo Plan
                        </a>
                    </div>
                </div>
            </div>

            <c:if test="${not empty mensajeExito}">
                <div class="alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> ${mensajeExito}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th><i class="bi bi-tag-fill me-1"></i>Nombre del Plan</th>
                            <th class="text-center"><i class="bi bi-calendar-range me-1"></i>Duración</th>
                            <th class="text-center"><i class="bi bi-currency-dollar me-1"></i>Valor</th>
                            <th class="text-center"><i class="bi bi-toggle-on me-1"></i>Estado</th>
                            <th class="text-center"><i class="bi bi-gear me-1"></i>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="plan" items="${listaPlanes}">
                            <tr>
                                <td class="fw-bold text-dark">${plan.nombre}</td>
                                <td class="text-center"><span class="badge bg-light text-dark border px-3 py-2 fs-6">${plan.duracionDias} días</span></td>
                                <td class="text-center fw-semibold text-primary fs-6">$ ${plan.valor}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${plan.activo}">
                                            <span class="badge badge-activo"><i class="bi bi-check-circle-fill me-1"></i>Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactivo"><i class="bi bi-x-circle-fill me-1"></i>Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group" role="group">
                                        <a href="planes?accion=editar&id=${plan.idPlan}" class="btn btn-sm btn-outline-primary px-3" title="Editar plan">
                                            <i class="bi bi-pencil-square me-1"></i>Editar
                                        </a>
                                        <a href="planes?accion=inactivar&id=${plan.idPlan}"
                                           onclick="return confirm('¿Desea cambiar el estado del plan ${plan.nombre}?')"
                                           class="btn btn-sm btn-outline-danger px-3" title="Cambiar estado">
                                            <i class="bi bi-power me-1"></i>Inactivar
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listaPlanes}">
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="bi bi-folder-x display-3 text-secondary mb-3"></i>
                                        <p class="fs-5">No se encontraron planes registrados en la base de datos.</p>
                                        <a href="planes?accion=nuevo" class="btn btn-custom-primary mt-2">
                                            <i class="bi bi-plus-circle-fill me-2"></i>Registrar primer plan
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

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const closeButton = alert.querySelector('.btn-close');
                    if (closeButton) closeButton.click();
                }, 5000);
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
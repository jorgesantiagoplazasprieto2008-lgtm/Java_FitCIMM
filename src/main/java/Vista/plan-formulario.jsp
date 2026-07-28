<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - ${modo == 'editar' ? 'Editar Plan' : 'Registrar Plan'}</title>
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
        .form-card { border: none; border-radius: 24px; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); box-shadow: var(--card-shadow); padding: 2.5rem; border: 1px solid rgba(255, 255, 255, 0.2); margin-top: 2rem; }
        .header-section { padding-bottom: 1.5rem; border-bottom: 2px solid rgba(79, 70, 229, 0.1); margin-bottom: 2rem; }
        .header-section h2 { font-weight: 800; color: #1e1b4b; }
        .form-label { font-weight: 600; color: #334155; font-size: 0.9rem; margin-bottom: 0.5rem; }
        .input-group-custom { background: #f8fafc; border: 2px solid #e2e8f0; border-radius: 12px; transition: var(--transition-smooth); overflow: hidden; }
        .input-group-custom:focus-within { border-color: #4f46e5; box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.1); background: white; }
        .input-group-custom .form-control, .input-group-custom .form-select { border: none; background: transparent; padding: 0.75rem 1rem; font-weight: 400; color: #1e293b; }
        .input-group-custom .form-control:focus, .input-group-custom .form-select:focus { box-shadow: none; background: transparent; }
        .input-group-custom .input-group-text { background: transparent; border: none; color: #94a3b8; padding-left: 1rem; padding-right: 0; }
        .btn-custom-primary { background: var(--primary-gradient); color: white; border: none; font-weight: 600; padding: 0.75rem 2.5rem; border-radius: 12px; transition: var(--transition-smooth); box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3); }
        .btn-custom-primary:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4); color: white; }
        .btn-custom-outline { border: 2px solid #cbd5e1; background: transparent; color: #64748b; font-weight: 600; padding: 0.75rem 2rem; border-radius: 12px; transition: var(--transition-smooth); }
        .btn-custom-outline:hover { background: #f1f5f9; color: #334155; border-color: #94a3b8; }
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
        <div class="row justify-content-center">
            <div class="col-lg-8 col-12">
                <div class="card form-card">

                    <div class="header-section">
                        <h2 class="fw-bold mb-0">
                            <c:choose>
                                <c:when test="${modo == 'editar'}">
                                    <i class="bi bi-pencil-square text-primary me-2"></i>Editar Plan
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-plus-circle-fill text-primary me-2"></i>Registrar Nuevo Plan
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="text-muted mt-1 mb-0">
                            ${modo == 'editar' ? 'Modifique los parámetros del plan existente' : 'Ingrese los datos para la creación del nuevo plan'}
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form action="planes" method="POST" autocomplete="off">
                        <input type="hidden" name="accion" value="${modo == 'editar' ? 'actualizar' : 'registrar'}">
                        <c:if test="${modo == 'editar'}">
                            <input type="hidden" name="idPlan" value="${plan.idPlan}">
                        </c:if>

                        <div class="row g-4">
                            <!-- Nombre -->
                            <div class="col-12">
                                <label for="nombre" class="form-label">
                                    <i class="bi bi-tag me-1 text-primary"></i>Nombre del Plan *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-fonts"></i></span>
                                    <input type="text" id="nombre" name="nombre" class="form-control"
                                           placeholder="Ej. Plan Trimestral VIP" required value="${plan.nombre}">
                                </div>
                            </div>

                            <!-- Duración -->
                            <div class="col-md-6 col-12">
                                <label for="duracionDias" class="form-label">
                                    <i class="bi bi-calendar-range me-1 text-primary"></i>Duración (Días) *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-clock-history"></i></span>
                                    <input type="number" id="duracionDias" name="duracionDias" class="form-control"
                                           min="1" max="365" placeholder="30" required value="${plan.duracionDias}">
                                </div>
                            </div>

                            <!-- Valor -->
                            <div class="col-md-6 col-12">
                                <label for="valor" class="form-label">
                                    <i class="bi bi-currency-dollar me-1 text-primary"></i>Valor ($) *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-cash-stack"></i></span>
                                    <input type="number" step="0.01" id="valor" name="valor" class="form-control"
                                           placeholder="80000.00" required value="${plan.valor}">
                                </div>
                            </div>

                            <!-- Estado -->
                            <div class="col-12">
                                <label for="activo" class="form-label">
                                    <i class="bi bi-toggle-on me-1 text-primary"></i>Estado *
                                </label>
                                <div class="input-group-custom d-flex align-items-center">
                                    <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
                                    <select id="activo" name="activo" class="form-select">
                                        <option value="true" ${plan.activo == null || plan.activo ? 'selected' : ''}>Activo</option>
                                        <option value="false" ${plan.activo != null && !plan.activo ? 'selected' : ''}>Inactivo</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Botones -->
                        <div class="d-flex justify-content-end gap-3 mt-5">
                            <a href="planes?accion=listar" class="btn btn-custom-outline">
                                <i class="bi bi-arrow-left-short fs-5 align-middle me-1"></i>Volver al listado
                            </a>
                            <button type="submit" class="btn btn-custom-primary">
                                <i class="bi bi-check-circle-fill me-2"></i>Guardar Plan
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - ${modo == 'renovar' ? 'Renovar Membresía' : 'Vender Membresía'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 50%, #3730a3 100%);
            --card-shadow: 0 10px 40px rgba(79, 70, 229, 0.08);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        body { font-family: 'Outfit', sans-serif; background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%); min-height: 100vh; color: #1e293b; }
        .navbar { background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%) !important; box-shadow: 0 4px 20px rgba(30, 27, 75, 0.3); border-bottom: 3px solid #4f46e5; padding: 1rem 0; }
        .navbar-brand { font-weight: 800; font-size: 1.5rem; background: linear-gradient(135deg, #fbbf24, #f59e0b); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .nav-link { color: rgba(255, 255, 255, 0.8) !important; font-weight: 500; padding: 0.5rem 1rem !important; border-radius: 8px; transition: var(--transition-smooth); }
        .form-card { border: none; border-radius: 24px; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px); box-shadow: var(--card-shadow); padding: 2.5rem; border: 1px solid rgba(255, 255, 255, 0.2); margin-top: 2rem; }
        .header-section { padding-bottom: 1.5rem; border-bottom: 2px solid rgba(79, 70, 229, 0.1); margin-bottom: 2rem; }
        .btn-custom-primary { background: var(--primary-gradient); color: white; border: none; font-weight: 600; padding: 0.75rem 2.5rem; border-radius: 12px; transition: var(--transition-smooth); box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3); }
        .btn-custom-primary:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4); color: white; }
        .btn-custom-outline { border: 2px solid #cbd5e1; background: transparent; color: #64748b; font-weight: 600; padding: 0.75rem 2rem; border-radius: 12px; transition: var(--transition-smooth); }
        .preview-box { background: #f1f5f9; border-radius: 16px; padding: 1.5rem; border: 1px solid #cbd5e1; }
    </style>
</head>
<body>

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
                    <li class="nav-item">
                                            <a class="nav-link" href="reportes">
                                                <i class="bi bi-briefcase-fill me-1"></i> Reportes
                                            </a>
                                         </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-12">
                <div class="card form-card">

                    <div class="header-section">
                        <h2 class="fw-bold mb-0">
                            <c:choose>
                                <c:when test="${modo == 'renovar'}">
                                    <i class="bi bi-arrow-repeat text-warning me-2"></i>Renovar Membresía
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-cart-plus-fill text-primary me-2"></i>Vender Membresía
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <p class="text-muted mt-1 mb-0">
                            Asignación de un plan ofreciendo cálculo automático de la fecha de finalización
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="card bg-light border-0 p-3 mb-4 rounded-3">
                        <div class="row">
                            <div class="col-md-6">
                                <span class="text-muted small d-block">Socio Beneficiario:</span>
                                <strong class="fs-5 text-dark"><i class="bi bi-person-fill text-primary me-1"></i>${socio.nombres} ${socio.apellidos}</strong>
                            </div>
                            <div class="col-md-6">
                                <span class="text-muted small d-block">Documento de Identidad:</span>
                                <strong class="fs-5 text-dark">${socio.documento}</strong>
                            </div>
                        </div>
                    </div>

                    <form action="membresias" method="POST">
                        <input type="hidden" name="accion" value="${modo == 'renovar' ? 'guardarRenovacion' : 'guardarVenta'}">
                        <input type="hidden" name="idSocio" value="${socio.idSocio}">

                        <div class="mb-4">
                            <label for="idPlan" class="form-label fw-semibold fs-6">
                                <i class="bi bi-card-checklist text-primary me-1"></i>Seleccione el Plan a Contratar *
                            </label>
                            <select id="idPlan" name="idPlan" class="form-select form-select-lg" required onchange="actualizarVistaPrevia()">
                                <option value="" disabled selected>-- Elija un plan de la lista --</option>
                                <c:forEach var="p" items="${planes}">
                                    <option value="${p.idPlan}" data-dias="${p.duracionDias}" data-valor="${p.valor}">
                                        ${p.nombre} — (${p.duracionDias} días) — $ ${p.valor}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div id="boxPreview" class="preview-box mb-4 d-none">
                            <h5 class="fw-bold text-primary mb-3"><i class="bi bi-calculator me-2"></i>Resumen de la Transacción</h5>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <span class="text-muted small d-block">Fecha de Inicio (Hoy):</span>
                                    <strong id="lblFechaInicio" class="fs-6 text-dark">-</strong>
                                </div>
                                <div class="col-md-4">
                                    <span class="text-muted small d-block">Fecha Fin:</span>
                                    <strong id="lblFechaFin" class="fs-6 text-primary fw-bold">-</strong>
                                </div>
                                <div class="col-md-4">
                                    <span class="text-muted small d-block">Valor Total a Pagar:</span>
                                    <strong id="lblValor" class="fs-5 text-success fw-bold">-</strong>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-3 mt-4">
                            <a href="socios?accion=ver&id=${socio.idSocio}" class="btn btn-custom-outline">
                                Cancelar
                            </a>
                            <button type="submit" class="btn btn-custom-primary">
                                <i class="bi bi-check-circle-fill me-2"></i>Confirmar y Registrar Membresía
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function actualizarVistaPrevia() {
            const select = document.getElementById('idPlan');
            const selectedOption = select.options[select.selectedIndex];
            const boxPreview = document.getElementById('boxPreview');

            if (!selectedOption || !selectedOption.value) {
                boxPreview.classList.add('d-none');
                return;
            }

            const dias = parseInt(selectedOption.getAttribute('data-dias'));
            const valor = parseFloat(selectedOption.getAttribute('data-valor'));

            const hoy = new Date();
            const fechaFin = new Date();
            fechaFin.setDate(hoy.getDate() + dias);

            document.getElementById('lblFechaInicio').innerText = hoy.toLocaleDateString('es-CO');
            document.getElementById('lblFechaFin').innerText = fechaFin.toLocaleDateString('es-CO');
            document.getElementById('lblValor').innerText = '$ ' + valor.toLocaleString('es-CO', { minimumFractionDigits: 2 });

            boxPreview.classList.remove('d-none');
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
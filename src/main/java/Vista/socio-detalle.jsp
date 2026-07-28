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
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

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
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .detail-card {
            border: none;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--card-shadow);
            padding: 2.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .info-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
            font-weight: 600;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 500;
            color: #1e293b;
        }

        .table-responsive {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table thead th {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: #f8fafc;
            color: #475569;
            padding: 1rem;
        }

        .btn-custom-outline {
            border: 2px solid #cbd5e1;
            color: #64748b;
            font-weight: 600;
            padding: 0.75rem 2rem;
            border-radius: 12px;
            transition: var(--transition-smooth);
        }

        .btn-custom-outline:hover {
            background: #f1f5f9;
            color: #334155;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <!-- Menú de Navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-5">
        <div class="container">
            <a class="navbar-brand" href="socios?accion=listar"><i class="bi bi-lightning-charge-fill me-2"></i>FitCIMM</a>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="card detail-card">

            <!-- Cabecera del Detalle -->
            <div class="d-flex justify-content-between align-items-center border-bottom pb-4 mb-4">
                <div>
                    <h2 class="fw-bold mb-0 text-primary"><i class="bi bi-person-bounding-box me-2"></i>Ficha del Socio</h2>
                    <p class="text-muted mb-0">Detalles de registro e historial de contrataciones</p>
                </div>
                <span class="badge ${socio.activo ? 'bg-success' : 'bg-secondary'} px-3 py-2 rounded-pill fs-6">
                    ${socio.activo ? 'ACTIVO' : 'INACTIVO'}
                </span>
            </div>

            <!-- Información General -->
            <div class="row g-4 mb-5">
                <div class="col-md-4 col-sm-6">
                    <span class="info-label d-block"><i class="bi bi-card-text me-1"></i>Documento</span>
                    <span class="info-value">${socio.documento}</span>
                </div>
                <div class="col-md-4 col-sm-6">
                    <span class="info-label d-block"><i class="bi bi-person me-1"></i>Nombres</span>
                    <span class="info-value">${socio.nombres}</span>
                </div>
                <div class="col-md-4 col-sm-6">
                    <span class="info-label d-block"><i class="bi bi-person-fill me-1"></i>Apellidos</span>
                    <span class="info-value">${socio.apellidos}</span>
                </div>
                <div class="col-md-4 col-sm-6">
                    <span class="info-label d-block"><i class="bi bi-telephone me-1"></i>Teléfono</span>
                    <span class="info-value">${empty socio.telefono ? 'No registrado' : socio.telefono}</span>
                </div>
                <div class="col-md-4 col-sm-6">
                    <span class="info-label d-block"><i class="bi bi-envelope me-1"></i>Correo Electrónico</span>
                    <span class="info-value">${empty socio.correo ? 'No registrado' : socio.correo}</span>
                </div>
                <div class="col-md-4 col-sm-6">
                    <span class="info-label d-block"><i class="bi bi-cake2 me-1"></i>Fecha de Nacimiento</span>
                    <span class="info-value">${socio.fechaNacimiento}</span>
                </div>
            </div>

            <!-- Historial de Membresías (RF-03) -->
            <div class="mb-4">
                <h4 class="fw-bold mb-3 text-secondary"><i class="bi bi-clock-history me-2"></i>Historial de Membresías</h4>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>Plan</th>
                                <th>Fecha Inicio</th>
                                <th>Fecha Fin</th>
                                <th class="text-end">Valor Pagado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="membresia" items="${historial}">
                                <tr>
                                    <td class="fw-bold text-dark">${membresia.nombrePlan}</td>
                                    <td>${membresia.fechaInicio}</td>
                                    <td>${membresia.fechaFin}</td>
                                    <td class="text-end fw-bold text-success">$${membresia.valorPagado}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty historial}">
                                <tr>
                                    <td colspan="4" class="text-center py-4 text-muted">
                                        <i class="bi bi-credit-card-2-front display-6 d-block mb-2"></i>
                                        Este socio no registra membresías previas.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Botón Volver -->
            <div class="d-flex justify-content-start mt-4">
                <a href="socios?accion=listar" class="btn btn-custom-outline">
                    <i class="bi bi-arrow-left me-2"></i>Volver al listado
                </a>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
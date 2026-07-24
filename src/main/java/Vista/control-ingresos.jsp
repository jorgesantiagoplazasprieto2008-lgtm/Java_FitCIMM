<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - Control de Acceso</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Font: Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #7c3aed 50%, #3730a3 100%);
            --success-gradient: linear-gradient(135deg, #10b981, #059669);
            --danger-gradient: linear-gradient(135deg, #ef4444, #dc2626);
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

        .nav-link:hover {
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

        /* Input de acceso gigante */
        .access-input {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            padding: 1rem 1.5rem;
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
            letter-spacing: 2px;
            transition: var(--transition-smooth);
            background-color: #f8fafc;
        }

        .access-input:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.15);
            background-color: white;
        }

        /* Botón de acceso */
        .btn-access {
            background: var(--primary-gradient);
            color: white;
            font-size: 1.2rem;
            font-weight: 700;
            padding: 1rem;
            border-radius: 16px;
            border: none;
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.3);
            transition: var(--transition-smooth);
            width: 100%;
        }

        .btn-access:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4);
        }

        /* Tarjetas de Resultado */
        .result-card {
            border-radius: 20px;
            border: none;
            color: white;
            padding: 1.5rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            animation: bounceIn 0.6s;
        }

        .result-card-granted {
            background: var(--success-gradient);
        }

        .result-card-denied {
            background: var(--danger-gradient);
        }

        /* Scrollbar del listado */
        .scrollable-list {
            max-height: 480px;
            overflow-y: auto;
            border-radius: 16px;
            padding-right: 5px;
        }

        /* Animación */
        @keyframes bounceIn {
            from, 20%, 40%, 60%, 80%, to { animation-timing-function: cubic-bezier(0.215, 0.61, 0.355, 1); }
            0% { opacity: 0; transform: scale3d(0.3, 0.3, 0.3); }
            20% { transform: scale3d(1.1, 1.1, 1.1); }
            40% { transform: scale3d(0.9, 0.9, 0.9); }
            60% { opacity: 1; transform: scale3d(1.03, 1.03, 1.03); }
            80% { transform: scale3d(0.97, 0.97, 0.97); }
            to { opacity: 1; transform: scale3d(1, 1); }
        }

        .badge-vigente { background-color: #065f46; color: #a7f3d0; border: 1px solid #34d399; }
        .badge-porvencer { background-color: #92400e; color: #fef3c7; border: 1px solid #fbbf24; }
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
                    <li class="nav-item"><a class="nav-link" href="socios?accion=listar"><i class="bi bi-people-fill me-1"></i> Socios</a></li>
                    <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-card-checklist me-1"></i> Planes</a></li>
                    <li class="nav-item"><a class="nav-link active" href="ingresos?accion=pantalla"><i class="bi bi-door-open-fill me-1"></i> Control de Ingresos</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="row g-4">

            <!-- Columna Izquierda: Registro e Indicador -->
            <div class="col-lg-5 col-12">
                <div class="card main-card h-100">
                    <div class="header-section">
                        <h4 class="fw-bold mb-0 text-primary"><i class="bi bi-upc-scan me-2"></i>Escanear Acceso</h4>
                        <p class="text-muted small mb-0">Digite el documento para registrar el ingreso diario</p>
                    </div>

                    <form action="ingresos?accion=registrar" method="POST" class="mb-4">
                        <div class="mb-3">
                            <input type="text" id="documento" name="documento" class="form-control access-input"
                                   placeholder="DOCUMENTO" required autofocus value="${documentoIngresado}">
                        </div>
                        <button type="submit" class="btn btn-access"><i class="bi bi-door-closed me-2"></i>Registrar Entrada</button>
                    </form>

                    <!-- Resultados visuales de entrada -->
                    <c:if test="${not empty resultado}">
                        <div class="card result-card result-card-granted text-center">
                            <div class="card-body">
                                <i class="bi bi-check-circle-fill display-3 mb-2"></i>
                                <h3 class="fw-bold mb-1">${mensajeExito}</h3>
                                <h5 class="mb-3">${resultado.nombreCompleto}</h5>
                                <div class="bg-white bg-opacity-25 rounded-3 p-3 mb-3">
                                    <span class="small d-block text-white text-opacity-75">Días restantes de membresía:</span>
                                    <span class="fs-2 fw-bold">${resultado.diasRestantes}</span>
                                </div>
                                <span class="badge ${resultado.estado == 'VIGENTE' ? 'badge-vigente' : 'badge-porvencer'} px-3 py-2">
                                    <i class="bi bi-lightning-fill me-1"></i>Membresía ${resultado.estado}
                                </span>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="card result-card result-card-denied text-center">
                            <div class="card-body">
                                <i class="bi bi-slash-circle-fill display-3 mb-2"></i>
                                <h3 class="fw-bold mb-2">ACCESO DENEGADO</h3>
                                <p class="lead mb-0">${error}</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Columna Derecha: Ingresos del día de hoy en tiempo real (RF-14) -->
            <div class="col-lg-7 col-12">
                <div class="card main-card h-100">
                    <div class="header-section d-flex justify-content-between align-items-center">
                        <div>
                            <h4 class="fw-bold mb-0"><i class="bi bi-clock-history me-2"></i>Ingresos de Hoy</h4>
                            <p class="text-muted small mb-0">Entradas registradas en tiempo real</p>
                        </div>
                        <!-- Filtro/Link para reportes históricos -->
                        <a href="ingresos?accion=reporte" class="btn btn-sm btn-outline-primary px-3 rounded-pill">
                            <i class="bi bi-journal-text me-1"></i>Ver Historial Completo
                        </a>
                    </div>

                    <div class="scrollable-list">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Hora</th>
                                    <th>Documento</th>
                                    <th>Socio</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ingreso" items="${ingresosHoy}">
                                    <tr>
                                        <td class="fw-bold text-primary"><i class="bi bi-clock me-1 text-muted"></i>${ingreso.horaIngreso}</td>
                                        <td>${ingreso.documentoSocio}</td>
                                        <td>${ingreso.nombreCompletoSocio}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty ingresosHoy}">
                                    <tr>
                                        <td colspan="3" class="text-center py-5 text-muted">
                                            <i class="bi bi-door-closed display-4 mb-2"></i>
                                            <p class="mb-0">No se han registrado ingresos el día de hoy.</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enfocar el input de documento automáticamente al cargar o refrescar
        window.onload = function() {
            document.getElementById('documento').focus();
        };
    </script>
</body>
</html>
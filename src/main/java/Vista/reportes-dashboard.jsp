<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitCIMM - Dashboard de Reportes</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Font: Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Chart.js para gráficos -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            font-weight: 500;
            border-radius: 8px;
            transition: var(--transition-smooth);
        }

        .nav-link:hover, .nav-link.active {
            color: white !important;
            background: rgba(79, 70, 229, 0.3);
        }

        .dashboard-card {
            border: none;
            border-radius: 20px;
            background: white;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: var(--transition-smooth);
        }

        .dashboard-card:hover {
            transform: translateY(-2px);
        }

        .kpi-card {
            background: var(--primary-gradient);
            color: white;
        }

        .kpi-number {
            font-size: 2.5rem;
            font-weight: 800;
        }

        .table-responsive {
            border-radius: 12px;
            overflow: hidden;
        }
         .nav-link:hover, .nav-link.active {
                    color: white !important;
                    background: rgba(79, 70, 229, 0.3);
                    transform: translateY(-2px);
                }
    </style>
</head>
<body>

    <!-- Menú de Navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="bi bi-lightning-charge-fill me-2"></i>FitCIMM</a>
            <button class="navbar-dark navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="socios?accion=listar"><i class="bi bi-people-fill me-1"></i> Socios</a></li>
                    <li class="nav-item"><a class="nav-link" href="#"><i class="bi bi-card-checklist me-1"></i> Planes</a></li>
                    <li class="nav-item"><a class="nav-link" href="ingresos?accion=pantalla"><i class="bi bi-door-open-fill me-1"></i> Control de Ingresos</a></li>
                    <li class="nav-item"><a class="nav-link active" href="reportes-dashboard.jsp"><i class="bi bi-briefcase-fill me-1"></i> Reportes</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mb-5">
        <div class="row align-items-center mb-4">
            <div class="col-12">
                <h2 class="fw-bold mb-0 text-dark"><i class="bi bi-bar-chart-line-fill text-primary me-2"></i>Panel de Reportes</h2>
                <p class="text-muted mb-0">Métricas clave e histórico del gimnasio FitCIMM</p>
            </div>
        </div>

        <!-- Fila 1: KPIs y Gráfico -->
        <div class="row g-4 mb-4">
            <!-- KPI 1: Plan más vendido del mes -->
            <div class="col-md-4">
                <div class="card dashboard-card kpi-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <span class="text-white text-opacity-75 uppercase small fw-bold">Plan más vendido del mes (RF-17)</span>
                        <h4 class="fw-bold mt-2">${empty planMasVendido ? 'Sin ventas' : planMasVendido.nombrePlan}</h4>
                    </div>
                    <div class="mt-3">
                        <span class="d-block text-white text-opacity-75 small">Suscripciones vendidas:</span>
                        <span class="kpi-number">${empty planMasVendido ? 0 : planMasVendido.cantidadVentas}</span>
                    </div>
                </div>
            </div>

            <!-- KPI 2: Socios Activos Vigentes -->
            <div class="col-md-4">
                <div class="card dashboard-card h-100 d-flex flex-column justify-content-between">
                    <div>
                        <span class="text-muted uppercase small fw-bold">Socios Vigentes (RF-15)</span>
                        <h4 class="fw-bold text-dark mt-2">Membresía activa hoy</h4>
                    </div>
                    <div class="mt-3">
                        <span class="kpi-number text-primary">${sociosVigentes.size()}</span>
                    </div>
                </div>
            </div>

            <!-- Gráfico de Ingresos Semanales (6.1) -->
            <div class="col-md-4">
                <div class="card dashboard-card h-100">
                    <span class="text-muted uppercase small fw-bold mb-3 d-block">Ingresos últimos 7 días</span>
                    <canvas id="chartIngresos" style="max-height: 150px;"></canvas>
                </div>
            </div>
        </div>

        <!-- Fila 2: Filtros de Recaudación y Tablas -->
        <div class="row g-4">
            <!-- Izquierda: Recaudación por Rango de Fechas (RF-16) -->
            <div class="col-lg-6 col-12">
                <div class="card dashboard-card h-100">
                    <h5 class="fw-bold mb-3 text-secondary"><i class="bi bi-wallet2 me-2"></i>Recaudación por Planes</h5>

                    <!-- Formulario de filtro de fechas -->
                    <form action="reportes" method="GET" class="row g-2 mb-4">
                        <div class="col-5">
                            <input type="date" name="fechaInicio" class="form-control form-control-sm" value="${fechaInicio}">
                        </div>
                        <div class="col-5">
                            <input type="date" name="fechaFin" class="form-control form-control-sm" value="${fechaFin}">
                        </div>
                        <div class="col-2">
                            <button type="submit" class="btn btn-sm btn-primary w-100"><i class="bi bi-funnel"></i></button>
                        </div>
                    </form>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Plan</th>
                                    <th class="text-center">Suscripciones</th>
                                    <th class="text-end">Total Recaudado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${recaudaciones}">
                                    <tr>
                                        <td class="fw-bold">${item.nombrePlan}</td>
                                        <td class="text-center">${item.cantidadVentas}</td>
                                        <td class="text-end text-success fw-bold">$${item.totalRecaudado}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recaudaciones}">
                                    <tr>
                                        <td colspan="3" class="text-center py-4 text-muted">No se registran ventas en este periodo.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Derecha: Socios Activos Sin Ingresos Registrados -->
            <div class="col-lg-6 col-12">
                <div class="card dashboard-card h-100">
                    <h5 class="fw-bold mb-3 text-secondary"><i class="bi bi-person-exclamation me-2"></i>Socios sin asistencia</h5>
                    <p class="text-muted small">Socios activos que nunca han registrado un ingreso diario</p>

                    <div class="table-responsive" style="max-height: 250px; overflow-y: auto;">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Documento</th>
                                    <th>Nombre Completo</th>
                                    <th>Contacto</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="socio" items="${sociosSinIngreso}">
                                    <tr>
                                        <td class="fw-bold">${socio.documento}</td>
                                        <td>${socio.nombres} ${socio.apellidos}</td>
                                        <td>${empty socio.telefono ? socio.correo : socio.telefono}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty sociosSinIngreso}">
                                    <tr>
                                        <td colspan="3" class="text-center py-4 text-muted">Todos los socios han ingresado alguna vez.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Generación del Gráfico Semanal con Javascript -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Extraer datos inyectados por el servlet
            const labels = [];
            const data = [];

            <c:forEach var="reg" items="${ingresosSemana}">
                labels.push('${reg.fecha}');
                data.push(${reg.totalIngresos});
            </c:forEach>

            const ctx = document.getElementById('chartIngresos').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Ingresos diarios',
                        data: data,
                        borderColor: '#4f46e5',
                        backgroundColor: 'rgba(79, 70, 229, 0.1)',
                        borderWidth: 3,
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: { legend: { display: false } },
                    scales: {
                        y: { beginAtZero: true, ticks: { stepSize: 1 } },
                        x: { grid: { display: false } }
                    }
                }
            });
        });
    </script>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
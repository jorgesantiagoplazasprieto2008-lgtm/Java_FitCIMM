-- Inserts de la guía:

-- 1 Insertar 8 socios
INSERT INTO socio
(documento,nombres,apellidos,telefono,correo,fecha_nacimiento)
VALUES
('100001','Juan','Perez','3101111111','juan@gmail.com','1998-05-12'),
('100002','Maria','Gomez','3102222222','maria@gmail.com','1995-08-21'),
('100003','Carlos','Rodriguez','3103333333','carlos@gmail.com','1992-02-18'),
('100004','Laura','Martinez','3104444444','laura@gmail.com','2000-11-10'),
('100005','Andres','Lopez','3105555555','andres@gmail.com','1999-01-30'),
('100006','Sofia','Ramirez','3106666666','sofia@gmail.com','1997-07-25'),
('100007','Miguel','Torres','3107777777','miguel@gmail.com','1994-03-16'),
('100008','Valentina','Castro','3108888888','valentina@gmail.com','2001-09-08');


-- 2 Insertar 10 membresias
--  VIGENTES
INSERT INTO membresia
(id_socio,id_plan,fecha_inicio,fecha_fin,valor_pagado)
VALUES
(1,2,'2026-07-10','2026-08-09',75000),
(2,3,'2026-06-15','2026-09-13',195000),
(3,4,'2026-01-01','2026-12-31',650000),
(4,2,'2026-07-20','2026-08-19',75000);

-- POR VENCER
INSERT INTO membresia
(id_socio,id_plan,fecha_inicio,fecha_fin,valor_pagado)
VALUES
(5,2,'2026-06-25','2026-07-25',75000),
(6,2,'2026-06-27','2026-07-27',75000),
(7,1,'2026-07-21','2026-07-22',8000);

-- VENCIDAS
INSERT INTO membresia
(id_socio,id_plan,fecha_inicio,fecha_fin,valor_pagado)
VALUES
(8,2,'2026-05-01','2026-05-31',75000),
(1,1,'2026-06-01','2026-06-02',8000),
(2,1,'2026-07-10','2026-07-11',8000);

-- DATOS DE PRUEBA DE INGRESO

INSERT INTO ingreso
(id_socio,fecha_ingreso,hora_ingreso)
VALUES
(1,'2026-07-21','06:30:00'),
(2,'2026-07-21','07:10:00'),
(3,'2026-07-21','08:00:00'),
(4,'2026-07-21','09:15:00'),
(5,'2026-07-20','17:30:00'),
(6,'2026-07-20','18:10:00'),
(7,'2026-07-19','07:45:00'),
(8,'2026-07-18','16:50:00');









-- 1 Listar cada socio con la fecha de fin de su membresía más reciente y los días que le restan.
SELECT s.id_socio,s.documento,s.nombres,s.apellidos,m.fecha_fin, DATEDIFF(DAY, GETDATE(), m.fecha_fin) AS dias_restantes
FROM socio s INNER JOIN membresia m ON s.id_socio = m.id_socio
WHERE m.fecha_fin = (SELECT MAX(m2.fecha_fin) FROM membresia m2 WHERE m2.id_socio = s.id_socio)
ORDER BY s.apellidos, s.nombres;

-- 2 Obtener el total recaudado por plan en un rango de fechas, ordenado de mayor a menor.

SELECT p.nombre AS Planes,SUM(m.valor_pagado) AS total_recaudado 
FROM membresia m INNER JOIN Planes p ON m.id_plan = p.id_plan
WHERE m.fecha_inicio BETWEEN '2026-07-01' AND '2026-07-31'
GROUP BY p.nombre ORDER BY total_recaudado DESC;

-- 3 Identificar los socios cuya membresía vence dentro de los próximos 5 días.

SELECT s.documento,s.nombres,s.apellidos,m.fecha_fin,
DATEDIFF(DAY, GETDATE(), m.fecha_fin) AS dias_restantes
FROM socio s INNER JOIN membresia m ON s.id_socio = m.id_socio
WHERE m.fecha_fin BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY,5,CAST(GETDATE() AS DATE))
ORDER BY m.fecha_fin;
-- 4  Contar cuántos ingresos se registraron por día durante la última semana.

SELECT fecha_ingreso,COUNT(*) AS total_ingresos
FROM ingreso WHERE fecha_ingreso >= DATEADD(DAY,-7,CAST(GETDATE() AS DATE))
GROUP BY fecha_ingreso ORDER BY fecha_ingreso;
-- 5 Encontrar los socios activos que nunca han registrado un ingreso

SELECT s.id_socio,s.documento,s.nombres,s.apellidos
FROM socio s LEFT JOIN ingreso i ON s.id_socio = i.id_socio
WHERE s.activo = 1 AND i.id_ingreso IS NULL;





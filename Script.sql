USE [master]
GO
/****** Objeto: Database [fitcimm] Fecha de script: 21/07/2026 11:08:21 p. m. ******/
CREATE DATABASE [fitcimm]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'fitcimm', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\fitcimm.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'fitcimm_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\fitcimm_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [fitcimm] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [fitcimm].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [fitcimm] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [fitcimm] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [fitcimm] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [fitcimm] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [fitcimm] SET ARITHABORT OFF 
GO
ALTER DATABASE [fitcimm] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [fitcimm] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [fitcimm] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [fitcimm] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [fitcimm] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [fitcimm] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [fitcimm] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [fitcimm] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [fitcimm] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [fitcimm] SET  DISABLE_BROKER 
GO
ALTER DATABASE [fitcimm] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [fitcimm] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [fitcimm] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [fitcimm] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [fitcimm] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [fitcimm] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [fitcimm] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [fitcimm] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [fitcimm] SET  MULTI_USER 
GO
ALTER DATABASE [fitcimm] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [fitcimm] SET DB_CHAINING OFF 
GO
ALTER DATABASE [fitcimm] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [fitcimm] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [fitcimm] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [fitcimm] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [fitcimm] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [fitcimm] SET QUERY_STORE = ON
GO
ALTER DATABASE [fitcimm] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [fitcimm]
GO
/****** Objeto: User [IntelJ] Fecha de script: 21/07/2026 11:08:22 p. m. ******/
CREATE USER [IntelJ] FOR LOGIN [IntelJ] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [IntelJ]
GO
ALTER ROLE [db_datareader] ADD MEMBER [IntelJ]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [IntelJ]
GO
/****** Objeto: Table [dbo].[ingreso] Fecha de script: 21/07/2026 11:08:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ingreso](
	[id_ingreso] [int] IDENTITY(1,1) NOT NULL,
	[id_socio] [int] NOT NULL,
	[fecha_ingreso] [date] NOT NULL,
	[hora_ingreso] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_ingreso] UNIQUE NONCLUSTERED 
(
	[id_socio] ASC,
	[fecha_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[membresia] Fecha de script: 21/07/2026 11:08:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[membresia](
	[id_membresia] [int] IDENTITY(1,1) NOT NULL,
	[id_socio] [int] NOT NULL,
	[id_plan] [int] NOT NULL,
	[fecha_inicio] [date] NOT NULL,
	[fecha_fin] [date] NOT NULL,
	[valor_pagado] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_membresia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[Planes] Fecha de script: 21/07/2026 11:08:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Planes](
	[id_plan] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](40) NOT NULL,
	[duracion_dias] [int] NOT NULL,
	[valor] [decimal](10, 2) NOT NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_plan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[socio] Fecha de script: 21/07/2026 11:08:22 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[socio](
	[id_socio] [int] IDENTITY(1,1) NOT NULL,
	[documento] [varchar](15) NOT NULL,
	[nombres] [varchar](60) NOT NULL,
	[apellidos] [varchar](60) NOT NULL,
	[telefono] [varchar](15) NULL,
	[correo] [varchar](80) NULL,
	[fecha_nacimiento] [date] NOT NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_socio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Planes] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[socio] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD  CONSTRAINT [fk_ingreso_socio] FOREIGN KEY([id_socio])
REFERENCES [dbo].[socio] ([id_socio])
GO
ALTER TABLE [dbo].[ingreso] CHECK CONSTRAINT [fk_ingreso_socio]
GO
ALTER TABLE [dbo].[membresia]  WITH CHECK ADD  CONSTRAINT [fk_mem_plan] FOREIGN KEY([id_plan])
REFERENCES [dbo].[Planes] ([id_plan])
GO
ALTER TABLE [dbo].[membresia] CHECK CONSTRAINT [fk_mem_plan]
GO
ALTER TABLE [dbo].[membresia]  WITH CHECK ADD  CONSTRAINT [fk_mem_socio] FOREIGN KEY([id_socio])
REFERENCES [dbo].[socio] ([id_socio])
GO
ALTER TABLE [dbo].[membresia] CHECK CONSTRAINT [fk_mem_socio]
GO
ALTER TABLE [dbo].[Planes]  WITH CHECK ADD CHECK  (([duracion_dias]>(0)))
GO
ALTER TABLE [dbo].[Planes]  WITH CHECK ADD CHECK  (([valor]>(0)))
GO
USE [master]
GO
ALTER DATABASE [fitcimm] SET  READ_WRITE 
GO

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


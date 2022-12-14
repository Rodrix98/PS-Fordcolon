USE [master]
GO
/****** Object:  Database [DBCarritoFord]    Script Date: 1/12/2022 12:13:38 ******/
CREATE DATABASE [DBCarritoFord]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBCarritoFord', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DBCarritoFord.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBCarritoFord_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\DBCarritoFord_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DBCarritoFord] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBCarritoFord].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBCarritoFord] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBCarritoFord] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBCarritoFord] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBCarritoFord] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBCarritoFord] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBCarritoFord] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBCarritoFord] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBCarritoFord] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBCarritoFord] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBCarritoFord] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBCarritoFord] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBCarritoFord] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBCarritoFord] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBCarritoFord] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBCarritoFord] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBCarritoFord] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBCarritoFord] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBCarritoFord] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBCarritoFord] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBCarritoFord] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBCarritoFord] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBCarritoFord] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBCarritoFord] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBCarritoFord] SET  MULTI_USER 
GO
ALTER DATABASE [DBCarritoFord] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBCarritoFord] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBCarritoFord] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBCarritoFord] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBCarritoFord] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBCarritoFord] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DBCarritoFord] SET QUERY_STORE = OFF
GO
USE [DBCarritoFord]
GO
/****** Object:  UserDefinedTableType [dbo].[EDetalle_Venta]    Script Date: 1/12/2022 12:13:39 ******/
CREATE TYPE [dbo].[EDetalle_Venta] AS TABLE(
	[idProducto] [int] NULL,
	[Cantidad] [int] NULL,
	[Total] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](500) NULL,
	[descripcion] [varchar](500) NULL,
	[idMarca] [int] NULL,
	[idCategoria] [int] NULL,
	[precio] [decimal](10, 2) NULL,
	[stock] [int] NULL,
	[rutaImagen] [varchar](100) NULL,
	[nombreImagen] [varchar](100) NULL,
	[activo] [bit] NULL,
	[fechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[idVenta] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[totalProducto] [int] NULL,
	[montoTotal] [decimal](10, 2) NULL,
	[contacto] [varchar](50) NULL,
	[idPais] [varchar](10) NULL,
	[telefono] [varchar](50) NULL,
	[direccion] [varchar](500) NULL,
	[idTransaccion] [varchar](50) NULL,
	[fechaVenta] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalle_Venta]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalle_Venta](
	[idDetalle] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NULL,
	[idProducto] [int] NULL,
	[cantidad] [int] NULL,
	[total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[idDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ListarCompra]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[fn_ListarCompra](
@idCliente int
)
RETURNS TABLE
as
RETURN
(
select p.rutaImagen, p.nombreImagen, p.nombre, p.precio, dv.cantidad, dv.total, v.fechaVenta, v.idTransaccion, v.idVenta
from Venta v join Detalle_Venta dv on v.idVenta = dv.idVenta join Producto p on dv.idProducto = p.idProducto
where v.idCliente = @idCliente
)
GO
/****** Object:  Table [dbo].[Marca]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marca](
	[idMarca] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[activo] [bit] NULL,
	[fechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[idCarrito] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NULL,
	[idProducto] [int] NULL,
	[cantidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_obtenerCarritoCliente]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[fn_obtenerCarritoCliente](
@idCliente int
)
returns table
as
return(
	select p.idProducto, m.descripcion[DesMarca], p.nombre, p.precio, c.cantidad, p.rutaImagen, p.nombreImagen
	from Carrito c
	inner join Producto p on p.idProducto = c.idProducto
	inner join Marca m on m.idMarca = p.idMarca
	where c.idCliente = @idCliente
)
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[activo] [bit] NULL,
	[fechaRegistro] [datetime] NULL,
	[relacionMarca] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NULL,
	[apellido] [varchar](100) NULL,
	[correo] [varchar](100) NULL,
	[clave] [varchar](150) NULL,
	[reestrablecer] [bit] NULL,
	[fechaRegistro] [datetime] NULL,
	[aceptoCopy] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[idDepartamento] [varchar](2) NOT NULL,
	[descripcion] [varchar](45) NOT NULL,
	[idProvincia] [varchar](4) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[idPais] [varchar](6) NOT NULL,
	[descripcion] [varchar](45) NOT NULL,
	[idProvincia] [varchar](4) NOT NULL,
	[idDepartamento] [varchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedidos]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedidos](
	[idPedido] [int] IDENTITY(1,1) NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[nombreProducto] [varchar](500) NOT NULL,
	[fechaPedido] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[idPedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[idProvincia] [varchar](4) NOT NULL,
	[descripcion] [varchar](45) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NULL,
	[apellido] [varchar](100) NULL,
	[correo] [varchar](100) NULL,
	[clave] [varchar](150) NULL,
	[reestablecer] [bit] NULL,
	[activo] [bit] NULL,
	[fechaRegistro] [datetime] NULL,
	[aceptoCopy] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (1, N'Ford GT', 1, CAST(N'2022-06-14T14:45:38.480' AS DateTime), N'Ford')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (2, N'Ka 1999', 1, CAST(N'2022-06-14T14:45:38.480' AS DateTime), N'Ford')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (4, N'Gol Trend 2014', 1, CAST(N'2022-06-14T14:45:38.480' AS DateTime), N'Volkswagen')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (7, N'Falcon 1973', 1, CAST(N'2022-08-31T15:25:11.047' AS DateTime), N'Ford')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (8, N'Focus 1999', 1, CAST(N'2022-10-03T16:33:23.880' AS DateTime), N'Ford')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (11, N'EcoSport 2007', 1, CAST(N'2022-11-01T19:54:21.463' AS DateTime), N'Ford')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (12, N'Chevy SS 1970', 1, CAST(N'2022-11-01T20:15:24.330' AS DateTime), N'Chevrolet')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (13, N'Bora 1.9 TDI', 1, CAST(N'2022-11-01T20:27:42.510' AS DateTime), N'Volkswagen')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (14, N'Clio 2 Fase 3', 1, CAST(N'2022-11-01T20:36:01.773' AS DateTime), N'Renault')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (15, N'Chevy 400 C10', 1, CAST(N'2022-11-01T20:44:09.910' AS DateTime), N'Chevrolet')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (17, N'Peugeot 206', 1, CAST(N'2022-11-21T09:40:34.023' AS DateTime), N'Peugeot')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (18, N'Corsa Classic 1.4', 1, CAST(N'2022-11-21T10:40:42.837' AS DateTime), N'Chevrolet')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (19, N'Astra 2.0', 1, CAST(N'2022-11-21T10:52:50.657' AS DateTime), N'Chevrolet')
INSERT [dbo].[Categoria] ([idCategoria], [descripcion], [activo], [fechaRegistro], [relacionMarca]) VALUES (20, N'Fiat Punto 2010', 1, CAST(N'2022-11-24T17:28:56.000' AS DateTime), N'Fiat')
SET IDENTITY_INSERT [dbo].[Categoria] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([idCliente], [nombre], [apellido], [correo], [clave], [reestrablecer], [fechaRegistro], [aceptoCopy]) VALUES (1, N'Fernando', N'Imas', N'hupsudiltu@vusra.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, CAST(N'2022-07-19T21:02:59.853' AS DateTime), 1)
INSERT [dbo].[Cliente] ([idCliente], [nombre], [apellido], [correo], [clave], [reestrablecer], [fechaRegistro], [aceptoCopy]) VALUES (2, N'Julieta', N'Piqueras', N'liltocirza@vusra.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, CAST(N'2022-08-01T19:49:15.920' AS DateTime), 1)
INSERT [dbo].[Cliente] ([idCliente], [nombre], [apellido], [correo], [clave], [reestrablecer], [fechaRegistro], [aceptoCopy]) VALUES (3, N'Mateo', N'Padilla', N'afffkxk764@tmail3.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, CAST(N'2022-11-02T16:14:07.137' AS DateTime), 1)
INSERT [dbo].[Cliente] ([idCliente], [nombre], [apellido], [correo], [clave], [reestrablecer], [fechaRegistro], [aceptoCopy]) VALUES (4, N'Gaston', N'Ferrero', N'yogan37204@klblogs.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, CAST(N'2022-11-14T07:04:17.513' AS DateTime), 0)
INSERT [dbo].[Cliente] ([idCliente], [nombre], [apellido], [correo], [clave], [reestrablecer], [fechaRegistro], [aceptoCopy]) VALUES (5, N'Valentin', N'Gutierrez', N'dimlajafyu@gufum.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, CAST(N'2022-11-17T04:53:28.547' AS DateTime), 0)
INSERT [dbo].[Cliente] ([idCliente], [nombre], [apellido], [correo], [clave], [reestrablecer], [fechaRegistro], [aceptoCopy]) VALUES (6, N'Nicolas', N'Franco', N'pixir30921@rubeshi.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, CAST(N'2022-11-22T16:19:41.830' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
INSERT [dbo].[Departamento] ([idDepartamento], [descripcion], [idProvincia]) VALUES (N'1', N'Capital', N'1')
INSERT [dbo].[Departamento] ([idDepartamento], [descripcion], [idProvincia]) VALUES (N'2', N'Bahía Blanca', N'2')
INSERT [dbo].[Departamento] ([idDepartamento], [descripcion], [idProvincia]) VALUES (N'3', N'Godoy Cruz', N'3')
INSERT [dbo].[Departamento] ([idDepartamento], [descripcion], [idProvincia]) VALUES (N'4', N'Cruz del Eje', N'1')
INSERT [dbo].[Departamento] ([idDepartamento], [descripcion], [idProvincia]) VALUES (N'5', N'General Roca', N'1')
INSERT [dbo].[Departamento] ([idDepartamento], [descripcion], [idProvincia]) VALUES (N'6', N'General San Martin', N'1')
GO
SET IDENTITY_INSERT [dbo].[Detalle_Venta] ON 

INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (1, 1, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (2, 1, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (3, 2, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (4, 3, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (5, 4, 7, 2, CAST(934.68 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (6, 4, 6, 1, CAST(9000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (7, 5, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (8, 6, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (9, 7, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (10, 8, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (11, 9, 6, 1, CAST(9000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (12, 10, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (13, 11, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (14, 12, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (15, 13, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (16, 14, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (17, 15, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (18, 16, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (19, 17, 1, 2, CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (20, 18, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (21, 18, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (22, 19, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (23, 19, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (24, 20, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (25, 21, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (26, 21, 7, 2, CAST(934.68 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (27, 22, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (28, 22, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (29, 23, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (30, 23, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (31, 24, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (32, 24, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (33, 25, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (34, 26, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (35, 27, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (36, 28, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (37, 29, 5, 1, CAST(23.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (38, 30, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (39, 30, 6, 1, CAST(9000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (40, 31, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (41, 32, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (42, 33, 1, 2, CAST(50000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (43, 33, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (44, 34, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (45, 35, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (46, 36, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (47, 37, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (48, 38, 12, 1, CAST(1745.99 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (49, 39, 11, 1, CAST(2050.32 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (50, 40, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (51, 40, 14, 1, CAST(2640.50 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (52, 41, 5, 2, CAST(6134.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (53, 42, 12, 2, CAST(3491.98 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (54, 42, 10, 1, CAST(9945.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (55, 43, 11, 1, CAST(2050.32 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (56, 44, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (57, 45, 5, 1, CAST(3067.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (58, 46, 14, 1, CAST(2645.70 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (59, 47, 2, 1, CAST(5000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (60, 48, 13, 1, CAST(4122.45 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (61, 49, 7, 1, CAST(467.34 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (62, 50, 14, 1, CAST(2645.70 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (63, 51, 15, 1, CAST(4122.14 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (64, 52, 15, 1, CAST(4122.14 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (65, 53, 47, 1, CAST(7700.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (66, 54, 1, 1, CAST(25000.00 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (67, 55, 35, 1, CAST(5229.33 AS Decimal(10, 2)))
INSERT [dbo].[Detalle_Venta] ([idDetalle], [idVenta], [idProducto], [cantidad], [total]) VALUES (68, 55, 34, 2, CAST(10254.98 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Detalle_Venta] OFF
GO
SET IDENTITY_INSERT [dbo].[Marca] ON 

INSERT [dbo].[Marca] ([idMarca], [descripcion], [activo], [fechaRegistro]) VALUES (1, N'Ford', 1, CAST(N'2022-06-14T14:48:39.963' AS DateTime))
INSERT [dbo].[Marca] ([idMarca], [descripcion], [activo], [fechaRegistro]) VALUES (2, N'Chevrolet', 1, CAST(N'2022-06-14T14:48:39.963' AS DateTime))
INSERT [dbo].[Marca] ([idMarca], [descripcion], [activo], [fechaRegistro]) VALUES (3, N'Volkswagen', 1, CAST(N'2022-06-14T14:48:39.963' AS DateTime))
INSERT [dbo].[Marca] ([idMarca], [descripcion], [activo], [fechaRegistro]) VALUES (7, N'Renault', 1, CAST(N'2022-11-01T20:35:06.067' AS DateTime))
INSERT [dbo].[Marca] ([idMarca], [descripcion], [activo], [fechaRegistro]) VALUES (8, N'Peugeot', 1, CAST(N'2022-11-21T09:39:51.617' AS DateTime))
INSERT [dbo].[Marca] ([idMarca], [descripcion], [activo], [fechaRegistro]) VALUES (10, N'Fiat', 1, CAST(N'2022-11-24T17:05:46.313' AS DateTime))
SET IDENTITY_INSERT [dbo].[Marca] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedidos] ON 

INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (1, 5, 1, N'Bidon Recuperador de Agua EcoSport 2007', N'5/10/2022')
INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (2, 1, 1, N'Frenos de Disco Ford GT 2005', N'5/10/2022')
INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (3, 5, 1, N'Bidon Recuperador de Agua EcoSport 2007', N'5/10/2022')
INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (4, 7, 2, N'Carburador Ford Falcon', N'5/10/2022')
INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (8, 12, 3, N'Paletas de Ventilador Bora TDI', N'9/11/2022')
INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (10, 37, 2, N'Guia De Vidrio Trasero Falcon 73', N'22/11/2022')
INSERT [dbo].[Pedidos] ([idPedido], [idProducto], [cantidad], [nombreProducto], [fechaPedido]) VALUES (11, 2, 3, N'Escape Ford Ka', N'24/11/2022')
SET IDENTITY_INSERT [dbo].[Pedidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (1, N'Frenos de Disco Ford GT 2005', N'Frenos de Disco para Ford GT 2005 diseñados por empresa OEM ', 1, 1, CAST(25000.00 AS Decimal(10, 2)), 4, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'1.png', 1, CAST(N'2022-07-05T13:08:05.843' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (2, N'Escape Ford Ka', N'Escape Ford Ka modelo 1999 ', 1, 2, CAST(5000.00 AS Decimal(10, 2)), 16, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'2.png', 1, CAST(N'2022-07-07T09:38:54.803' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (5, N'Bidon Recuperador de Agua EcoSport 2007', N'3 Salidas', 1, 11, CAST(3067.00 AS Decimal(10, 2)), 7, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'5.jpg', 1, CAST(N'2022-07-07T10:08:07.127' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (6, N'Paragolpes Gol Trend 2014', N'Paragolpes Completo
Gol Trend 2014 
Color Negro', 3, 4, CAST(9000.00 AS Decimal(10, 2)), 0, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'6.jpg', 1, CAST(N'2022-08-31T12:19:11.130' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (7, N'Carburador Ford Falcon', N'Carburador de 1 Boca Distribuidor Autocor', 1, 7, CAST(467.34 AS Decimal(10, 2)), 8, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'7.jpg', 1, CAST(N'2022-08-31T15:30:55.310' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (10, N'Termostato Focus 1999', N'Termostato Completo Focus 1999.
Cuerpo de Plástico.', 1, 8, CAST(9945.00 AS Decimal(10, 2)), 6, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'10.png', 1, CAST(N'2022-11-01T20:12:21.457' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (11, N'Polea de Bomba de Agua Chevy 1970', N'Material de Acero.
Origen Nacional.', 2, 12, CAST(2050.32 AS Decimal(10, 2)), 7, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'11.jpg', 1, CAST(N'2022-11-01T20:20:47.747' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (12, N'Paletas de Ventilador Bora TDI', N'Paleta Electro Ventilador Volkswagen Bora.
Marca OMER', 3, 13, CAST(1745.99 AS Decimal(10, 2)), 5, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'12.jpg', 1, CAST(N'2022-11-01T20:32:24.770' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (13, N'Optica Delantera Derecha Clio 2', N'ORIENTACIÓN: DERECHA
Marca: LAM', 7, 14, CAST(4122.45 AS Decimal(10, 2)), 2, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'13.jpg', 1, CAST(N'2022-11-01T20:41:22.940' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (14, N'Tapa + Rotor Distribuidor Chevy 400', N'Tapa distribuidor con contactos de cobre.
Marca: Prestolite', 2, 15, CAST(2645.70 AS Decimal(10, 2)), 3, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'14.png', 1, CAST(N'2022-11-01T20:48:40.030' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (15, N'Optica Delantera Izquierda Clio 2', N'ORIENTACIÓN: DERECHA Marca: LAM', 7, 14, CAST(4122.14 AS Decimal(10, 2)), 24, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'15.jpg', 1, CAST(N'2022-11-02T18:18:09.460' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (33, N'Paragolpes Trasero Clio 2', N'Marca: Original
Material: Plástico
Código Interno: 39806', 7, 14, CAST(41290.50 AS Decimal(10, 2)), 3, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'33.png', 1, CAST(N'2022-11-21T09:07:25.427' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (34, N'Tubo Cilindro De Embrague Ford Ka 99', N'Marca: INDUSTRIA ARGENTINA
Número de pieza: 310206', 1, 2, CAST(5127.49 AS Decimal(10, 2)), 8, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'34.png', 1, CAST(N'2022-11-21T09:13:02.247' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (35, N'Palanca Selectora De Cambios Ford Ka 99', N'Marca: Industria Argentina
Material: Plástico', 1, 2, CAST(5229.33 AS Decimal(10, 2)), 3, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'35.png', 1, CAST(N'2022-11-21T09:20:08.007' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (36, N'Tapa De Entrada De Aceite Ford Ka 99', N'Marca: Neotek
Número de pieza: 1877', 1, 2, CAST(6000.00 AS Decimal(10, 2)), 7, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'36.png', 1, CAST(N'2022-11-21T09:23:51.237' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (37, N'Guia De Vidrio Trasero Falcon 73', N'Marca: OEM
Número de pieza: 8552/I', 1, 7, CAST(2649.43 AS Decimal(10, 2)), 8, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'37.png', 1, CAST(N'2022-11-21T09:28:57.510' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (38, N'Bomba De Agua Ford Falcon 73', N'Marca: Industria Argentina
Numero de serie: 014638', 1, 7, CAST(7540.00 AS Decimal(10, 2)), 2, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'38.png', 1, CAST(N'2022-11-21T09:36:08.340' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (39, N'Bomba De Combustible Peugeot 206', N'Marca: OEM
Numero de Pieza: 9643320780', 8, 17, CAST(12300.00 AS Decimal(10, 2)), 2, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'39.png', 1, CAST(N'2022-11-21T09:46:26.170' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (40, N'Termostato Peugeot 206', N'Marca: RoyalTek
Número de pieza: 1336AF', 8, 17, CAST(10500.00 AS Decimal(10, 2)), 4, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'40.png', 1, CAST(N'2022-11-21T09:48:48.743' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (41, N'Kit De Dirección 6 Piezas Ford Ecosport 2007', N'Marca_ LOCANE HNOS / APARICIO
Número de pieza: LOC 3600', 1, 11, CAST(15600.79 AS Decimal(10, 2)), 5, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'41.png', 1, CAST(N'2022-11-21T09:52:20.123' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (42, N'Kit de Bujes Suspensión Trasera Ford Focus 99', N'Marca: VTH
Unidades por envase: 14', 1, 8, CAST(17400.00 AS Decimal(10, 2)), 5, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'42.png', 1, CAST(N'2022-11-21T09:57:10.903' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (43, N'Faros traseros Izq. y Der. Gol Trend 14 ', N'Marca: FAL GENERICO
Número de pieza: FAL5031C', 3, 4, CAST(9500.00 AS Decimal(10, 2)), 3, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'43.png', 1, CAST(N'2022-11-21T10:03:12.567' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (44, N'Motor De Arranque Bora 1.9 TDI', N'Marca: Hellux
Número de pieza: 0986016980,', 3, 13, CAST(33467.69 AS Decimal(10, 2)), 1, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'44.png', 1, CAST(N'2022-11-21T10:06:39.367' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (45, N'Juego bujías Corsa Classic 1.4', N'Marca: NGK
Origen: Brasil
Cantidad: 4
Modelo/Pieza: BPR6EY', 2, 18, CAST(4400.34 AS Decimal(10, 2)), 5, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'45.png', 1, CAST(N'2022-11-21T10:46:58.827' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (46, N'Kit Tapas Correa De Distribución Corsa 1.4', N'Marca: SKP
Número de pieza: 93328876
Unidades por envase: 3', 2, 18, CAST(10450.00 AS Decimal(10, 2)), 2, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'46.png', 1, CAST(N'2022-11-21T10:51:22.093' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (47, N'Bobina de encendido Astra 2.0', N'Marca: Hellux
Número de pieza: F000ZS0203', 2, 19, CAST(7700.00 AS Decimal(10, 2)), 6, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'47.png', 1, CAST(N'2022-11-21T10:59:18.253' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (48, N'Caudalimetro Astra 2.0', N'Marca: PKW
Número de pieza: 0281002180', 2, 19, CAST(18500.00 AS Decimal(10, 2)), 2, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'48.png', 1, CAST(N'2022-11-21T11:02:19.067' AS DateTime))
INSERT [dbo].[Producto] ([idProducto], [nombre], [descripcion], [idMarca], [idCategoria], [precio], [stock], [rutaImagen], [nombreImagen], [activo], [fechaRegistro]) VALUES (51, N'Bomba de freno Punto 2010', N'Marca: BYR
Número de pieza: 061/37', 10, 20, CAST(14700.45 AS Decimal(10, 2)), 5, N'D:\FACULTAD\IMAGENES PAGINA FORDCOLON', N'51.jpg', 1, CAST(N'2022-11-24T18:07:13.680' AS DateTime))
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
INSERT [dbo].[Provincia] ([idProvincia], [descripcion]) VALUES (N'1', N'Cordoba')
INSERT [dbo].[Provincia] ([idProvincia], [descripcion]) VALUES (N'2', N'Buenos Aires')
INSERT [dbo].[Provincia] ([idProvincia], [descripcion]) VALUES (N'3', N'Mendoza')
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [clave], [reestablecer], [activo], [fechaRegistro], [aceptoCopy]) VALUES (3, N'Rodrigo', N'Garcia', N'rodrigo@gmail.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, 1, CAST(N'2022-06-23T21:02:10.133' AS DateTime), 1)
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [clave], [reestablecer], [activo], [fechaRegistro], [aceptoCopy]) VALUES (10, N'Fernando', N'Torrez', N'afffkxk764@tmail3.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, 0, CAST(N'2022-11-02T16:16:23.780' AS DateTime), 0)
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [clave], [reestablecer], [activo], [fechaRegistro], [aceptoCopy]) VALUES (11, N'Antonela', N'Gomez', N'doyab57390@fgvod.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, 1, CAST(N'2022-11-02T17:27:50.197' AS DateTime), 1)
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [clave], [reestablecer], [activo], [fechaRegistro], [aceptoCopy]) VALUES (17, N'Prueba', N'Prueba', N'sespatorta@gufum.com', N'ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae', 0, 1, CAST(N'2022-12-01T12:03:56.797' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (1, 2, 2, CAST(30000.00 AS Decimal(10, 2)), N'rodrigo', N'1', N'12321312', N'colon', N'code0001', CAST(N'2022-08-19T04:40:56.773' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (2, 1, 1, CAST(5000.00 AS Decimal(10, 2)), N'asdsad', N'1', N'132131', N'asdsadas', N'qugUaDbtptgT', CAST(N'2022-08-22T11:14:29.817' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (3, 1, 1, CAST(25000.00 AS Decimal(10, 2)), N'rrr', N'3', N'1321312', N'rrr', N'fNnmFb1VifGt', CAST(N'2022-08-22T11:15:52.520' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (4, 2, 2, CAST(9934.68 AS Decimal(10, 2)), N'Ramon Diaz', N'1', N'3512222222', N'av.Colon 2855', N'sqUm3ZZd1dDJ', CAST(N'2022-09-05T16:36:22.470' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (5, 2, 1, CAST(467.34 AS Decimal(10, 2)), N'Rodri', N'1', N'1231321321', N'av.colon 2855', N'CeoXYx68ISkc', CAST(N'2022-09-06T12:42:28.247' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (6, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'test', N'3', N'12321321', N'test', N'gN1a0oqGOTP3', CAST(N'2022-09-06T12:46:28.310' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (7, 2, 1, CAST(467.34 AS Decimal(10, 2)), N'asdsa', N'1', N'12312312', N'asdasda', N'wnBznzfVQQmO', CAST(N'2022-09-06T13:46:05.697' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (8, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'test2', N'1', N'12312', N'test2', N'85jksgBpUFDa', CAST(N'2022-09-06T15:50:51.033' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (9, 2, 1, CAST(9000.00 AS Decimal(10, 2)), N'test3', N'1', N'12321312', N'test3', N'UApQ6G7zdgZd', CAST(N'2022-09-06T16:42:18.570' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (10, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'TEST2022', N'1', N'2022', N'TEST2022', N'UtZNDo4jHCnO', CAST(N'2022-09-08T17:39:00.197' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (11, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'TEST123', N'1', N'12312', N'TEST123', N'djBGI05Nxfl9', CAST(N'2022-09-08T18:30:07.533' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (12, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'TEST123', N'2', N'123', N'TEST123', N'897UuLjpi6KI', CAST(N'2022-09-08T20:02:33.133' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (13, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'TEST1234', N'1', N'1234', N'TEST1234', N'vN48N5sSlHL5', CAST(N'2022-09-08T20:10:52.453' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (14, 2, 1, CAST(5000.00 AS Decimal(10, 2)), N'TEST12345', N'1', N'12345', N'TEST12345', N'oX2IfnNglEch', CAST(N'2022-09-08T20:19:16.053' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (15, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'test123456', N'1', N'123456', N'test123456', N'QSCxD9697Sgg', CAST(N'2022-09-08T20:21:10.587' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (16, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'TEST21132', N'2', N'12321', N'TEST123123', N'KdGk5zRrD4rs', CAST(N'2022-09-08T21:11:17.137' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (17, 2, 1, CAST(50000.00 AS Decimal(10, 2)), N'asdsa', N'1', N'13131', N'asdsada', N'J5WUZ13hwrJ7', CAST(N'2022-09-19T11:33:06.107' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (18, 2, 2, CAST(25023.33 AS Decimal(10, 2)), N'Rodrigo', N'1', N'3512295676', N'Av.Colon 2855', N'BxYULPiGA8gb', CAST(N'2022-09-30T17:42:14.940' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (19, 2, 2, CAST(25023.33 AS Decimal(10, 2)), N'rodrigo', N'1', N'1231231', N'asdsa', N'dClzLc9r3XtO', CAST(N'2022-09-30T17:50:05.873' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (20, 2, 1, CAST(25000.00 AS Decimal(10, 2)), N'asd', N'2', N'231', N'adsa', N'5wLT36T0irbA', CAST(N'2022-09-30T18:35:29.787' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (21, 2, 2, CAST(25934.68 AS Decimal(10, 2)), N'Rodrigo Garcia', N'1', N'3512222222', N'Av.Colon 2855', N'VsQBEQ8z0wI7', CAST(N'2022-10-03T14:24:21.783' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (22, 2, 2, CAST(25467.34 AS Decimal(10, 2)), N'asdas', N'1', N'12321', N'asdas', N'uP2Gdw3EBgow', CAST(N'2022-10-03T14:29:53.447' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (23, 2, 2, CAST(25467.34 AS Decimal(10, 2)), N'adasd', N'2', N'123123', N'asdsad', N'pKGjOUpuTv02', CAST(N'2022-10-03T14:34:13.003' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (24, 2, 2, CAST(25023.33 AS Decimal(10, 2)), N'asdsad', N'1', N'21321', N'asdsad', N'Y32CI5BETFOc', CAST(N'2022-10-03T14:41:55.970' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (25, 2, 1, CAST(23.33 AS Decimal(10, 2)), N'asdas', N'1', N'1231', N'adas', N'KSp2SdMOp8e7', CAST(N'2022-10-03T14:48:12.443' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (26, 2, 1, CAST(23.33 AS Decimal(10, 2)), N'asdas', N'2', N'1231', N'asdsad', N'Z5Q7uCXeTzcG', CAST(N'2022-10-03T15:05:50.847' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (27, 2, 1, CAST(23.33 AS Decimal(10, 2)), N'asdasd', N'1', N'1231', N'asdsa', N'XCKMbSgdyAL4', CAST(N'2022-10-03T15:07:06.817' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (28, 2, 1, CAST(23.33 AS Decimal(10, 2)), N'sadas', N'1', N'12321', N'adsas', N'IgwWVXly1ceD', CAST(N'2022-10-03T15:11:51.403' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (29, 2, 1, CAST(23.33 AS Decimal(10, 2)), N'asd', N'1', N'213', N'asd', N'rgHPoVJs8zNF', CAST(N'2022-10-03T15:32:52.337' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (30, 1, 2, CAST(34000.00 AS Decimal(10, 2)), N'rodrigo', N'1', N'12321321', N'avconololjnasd', N'B5b7h76OV0lR', CAST(N'2022-10-15T21:51:18.900' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (31, 1, 1, CAST(5000.00 AS Decimal(10, 2)), N'Rodrigo Garcia', N'1', N'3512222222', N'Av.Colon 2855', N'0HbTY8qMbbHw', CAST(N'2022-10-21T17:49:37.833' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (32, 1, 1, CAST(5000.00 AS Decimal(10, 2)), N'Rodrigo Garcia', N'1', N'3512222222', N'Pedro Chutro 345', N'a08Xwxj2hsA1', CAST(N'2022-10-21T18:41:27.103' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (33, 1, 2, CAST(55000.00 AS Decimal(10, 2)), N'Rodrigo Garcia', N'1', N'3512834938', N'chacabuco 2540', N'lu0zuH9xUctl', CAST(N'2022-10-26T17:48:13.717' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (34, 1, 1, CAST(467.34 AS Decimal(10, 2)), N'Rodrigo', N'1', N'3333333333', N'Colon 2855', N'jMYrc5gRfkFL', CAST(N'2022-11-01T17:25:55.750' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (35, 1, 1, CAST(5000.00 AS Decimal(10, 2)), N'fabian pons', N'2', N'5039848739', N'av.independencia 304', N'qMbPfxmJXElS', CAST(N'2022-11-01T18:02:46.910' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (36, 1, 1, CAST(25000.00 AS Decimal(10, 2)), N'ricardo imaz', N'3', N'4838091', N'San Miguel 1500', N'LCQTpNXDS8xI', CAST(N'2022-11-01T18:12:54.187' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (37, 1, 1, CAST(467.34 AS Decimal(10, 2)), N'Fabian martinez', N'1', N'12387127', N'dean funez 547', N'QcggiQGGFByN', CAST(N'2022-11-01T18:14:18.490' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (38, 1, 1, CAST(1745.99 AS Decimal(10, 2)), N'Sebastian Martin', N'1', N'2132131441', N'Chacabuco 963', N'nDVBAakcdrSz', CAST(N'2022-11-02T05:16:46.053' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (39, 1, 1, CAST(2050.32 AS Decimal(10, 2)), N'Nicolas Gutierrez', N'3', N'555333513', N'Pablo Pescara 190', N'6nGLoqkkxvez', CAST(N'2022-11-02T05:28:29.650' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (40, 1, 2, CAST(7640.50 AS Decimal(10, 2)), N'Alejo Martinez', N'1', N'3512999463', N'Chiquiraya 703', N'dXM9AsXIZjin', CAST(N'2022-11-02T05:30:33.433' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (41, 1, 1, CAST(6134.00 AS Decimal(10, 2)), N'rodrigo garcia', N'1', N'351228383', N'av colon 5000', N'Woo4Fu2uCAht', CAST(N'2022-11-02T18:27:52.643' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (42, 1, 2, CAST(13436.98 AS Decimal(10, 2)), N'Pedro Sanchez', N'1', N'3526940684', N'Av. Colon 3150', N'httpy3I1L7zE', CAST(N'2022-11-17T04:17:01.977' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (43, 1, 1, CAST(2050.32 AS Decimal(10, 2)), N'Julieta', N'2', N'44444', N'La Patria 500', N'0GMhDuHmBbTX', CAST(N'2022-11-17T04:30:14.170' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (44, 1, 1, CAST(25000.00 AS Decimal(10, 2)), N'felipe', N'3', N'333', N'dean funes 300', N'Yuy8MCaVlmw9', CAST(N'2022-11-17T04:32:00.280' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (45, 3, 1, CAST(3067.00 AS Decimal(10, 2)), N'dsada', N'3', N'123123321', N'dddddd', N'ukhbY4Z37caE', CAST(N'2022-11-17T04:41:09.757' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (46, 4, 1, CAST(2645.70 AS Decimal(10, 2)), N'Mateo', N'1', N'351020202', N'la paz 330', N'2PkcL6XIg1si', CAST(N'2022-11-17T04:48:27.143' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (47, 4, 1, CAST(5000.00 AS Decimal(10, 2)), N'afsadas', N'2', N'213213', N'asdsa', N'tfg2a0aDTstI', CAST(N'2022-11-17T04:49:56.150' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (48, 5, 1, CAST(4122.45 AS Decimal(10, 2)), N'Valentin', N'1', N'33333', N'asdsadsa', N'JYixGioELasJ', CAST(N'2022-11-17T04:54:12.047' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (49, 5, 1, CAST(467.34 AS Decimal(10, 2)), N'sdsadas', N'3', N'56666', N'asdsadas', N'Cn01Yl2cSN7o', CAST(N'2022-11-17T04:55:06.890' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (50, 3, 1, CAST(2645.70 AS Decimal(10, 2)), N'Emiliano Yudicello', N'1', N'1234142341', N'Ambrosio Taravella 6659', N'8teLMahFOh2v', CAST(N'2022-11-22T10:21:13.290' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (51, 1, 1, CAST(4122.14 AS Decimal(10, 2)), N'asdasd', N'1', N'43543534', N'asdasd', N'Yzcl0KIaYyD0', CAST(N'2022-11-22T15:35:54.840' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (52, 1, 1, CAST(4122.14 AS Decimal(10, 2)), N'Ricardo', N'3', N'Imas', N'Av. Santa Rita 3456', N'sY1UwL8u5RLy', CAST(N'2022-11-22T16:12:33.747' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (53, 1, 1, CAST(7700.00 AS Decimal(10, 2)), N'Rodrigo Garcia', N'1', N'3512222222', N'Av. General Paz 500', N'Fvntpm2SeBBW', CAST(N'2022-11-22T16:16:08.383' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (54, 1, 1, CAST(25000.00 AS Decimal(10, 2)), N'Rodrigo Garcia', N'1', N'352857305', N'Av. Colon 3000', N'jkhvxUFDqgSx', CAST(N'2022-11-22T18:50:34.950' AS DateTime))
INSERT [dbo].[Venta] ([idVenta], [idCliente], [totalProducto], [montoTotal], [contacto], [idPais], [telefono], [direccion], [idTransaccion], [fechaVenta]) VALUES (55, 1, 2, CAST(15484.31 AS Decimal(10, 2)), N'Federico Murua', N'1', N'3512858389', N'Av. Colon 2554', N'V0vLsAAdE59i', CAST(N'2022-11-25T17:26:59.617' AS DateTime))
SET IDENTITY_INSERT [dbo].[Venta] OFF
GO
ALTER TABLE [dbo].[Categoria] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[Categoria] ADD  DEFAULT (getdate()) FOR [fechaRegistro]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [reestrablecer]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (getdate()) FOR [fechaRegistro]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ((0)) FOR [aceptoCopy]
GO
ALTER TABLE [dbo].[Marca] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[Marca] ADD  DEFAULT (getdate()) FOR [fechaRegistro]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((0)) FOR [precio]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[Producto] ADD  DEFAULT (getdate()) FOR [fechaRegistro]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((1)) FOR [reestablecer]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((1)) FOR [activo]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (getdate()) FOR [fechaRegistro]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((0)) FOR [aceptoCopy]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT (getdate()) FOR [fechaVenta]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProducto])
GO
ALTER TABLE [dbo].[Detalle_Venta]  WITH CHECK ADD FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProducto])
GO
ALTER TABLE [dbo].[Detalle_Venta]  WITH CHECK ADD FOREIGN KEY([idVenta])
REFERENCES [dbo].[Venta] ([idVenta])
GO
ALTER TABLE [dbo].[Pedidos]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProducto])
GO
ALTER TABLE [dbo].[Pedidos] CHECK CONSTRAINT [FK_Pedidos_Producto]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([idMarca])
REFERENCES [dbo].[Marca] ([idMarca])
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([idCliente])
GO
/****** Object:  StoredProcedure [dbo].[sp_AceptarCopy]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_AceptarCopy](
@correo varchar(100)
)
as
begin
	update Usuario
	set aceptoCopy = 1
	where correo = @correo
end
GO
/****** Object:  StoredProcedure [dbo].[sp_AceptarCopyCliente]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_AceptarCopyCliente](
@correo varchar(100)
)
as
begin
	update Cliente
	set aceptoCopy = 1
	where correo = @correo
end
GO
/****** Object:  StoredProcedure [dbo].[sp_BuscarProducto]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_BuscarProducto]
(
@valor varchar(10)
)
as
begin

select p.idProducto, p.nombre, p.descripcion, m.idMarca, m.descripcion [desMarca], c.idCategoria, c.descripcion [desCategoria], p.precio, p.stock, p.rutaImagen, p.nombreImagen, p.activo
from Producto p inner join Marca m on m.idMarca = p.idMarca inner join Categoria c on c.idCategoria = p.idCategoria
where p.nombre like '%' + @valor + '%' or m.descripcion like '%' + @valor + '%' or c.descripcion like '%' + @valor + '%' or p.descripcion like '%' + @valor + '%' or m.descripcion + ' ' + p.nombre like '%' + @valor + '%'

end
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarCategoria]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EditarCategoria](
@idCategoria int,
@descripcion varchar(100),
@activo bit,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	SET @resultado = 0
	IF NOT EXISTS (SELECT * FROM Categoria WHERE descripcion = @descripcion AND idCategoria != @idCategoria)
	BEGIN
		UPDATE TOP (1) Categoria SET
		descripcion = @descripcion,
		activo = @activo
		WHERE idCategoria = @idCategoria

		SET @resultado = 1
	END
	ELSE
		SET @mensaje = 'la categoria ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarMarca]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EditarMarca](
@idMarca int,
@descripcion varchar(100),
@activo bit,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	set @resultado = 0
	if not exists (select * from Marca where descripcion = @descripcion and idMarca != @idMarca)
	begin
		update top (1) Marca set
		descripcion = @descripcion,
		activo = @activo
		where idMarca = @idMarca

		set @resultado = 1
	end
	else
		set @mensaje = 'La Marca ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarProducto]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_EditarProducto](
@idProducto int,
@nombre varchar(100),
@descripcion varchar(100),
@idCategoria varchar(100),
@precio decimal (10, 2),
@stock int,
@activo bit,
@mensaje varchar(500) output,
@resultado int output
)
as
begin
	set @resultado = 0
	if not exists (select * from Producto where nombre = @nombre and idProducto != @idProducto)
	begin

	declare @nombreMarca varchar(100)

	set @nombreMarca = (select relacionMarca from Categoria where idCategoria = @idCategoria)

	declare @idMarca int
	set @idMarca = (select idMarca from Marca where descripcion = @nombreMarca)

		update Producto set
		nombre = @nombre,
		descripcion = @descripcion,
		idMarca = @idMarca,
		idCategoria = @idCategoria,
		precio = @precio,
		stock = @stock,
		activo = @activo
		where idProducto = @idProducto

		set @resultado = 1
	end
	else
		set @mensaje = 'El producto ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EditarUsuario]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_EditarUsuario](
@idUsuario int,
@nombre varchar(100),
@apellido varchar(100),
@correo varchar(100),
@activo bit,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	SET @resultado = 0
	IF NOT EXISTS (SELECT * FROM Usuario WHERE correo = @correo AND idUsuario != @idUsuario)
	begin
		update top (1) Usuario set
		nombre = @nombre,
		apellido = @apellido,
		correo = @correo,
		activo = @activo
		WHERE idUsuario = @idUsuario

		SET @resultado = 1
	end
	else
		SET @mensaje = 'EL CORREO DEL USUARIO YA EXISTE'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarCarrito]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EliminarCarrito](
@idCliente int,
@idProducto int,
@resultado bit output
)
as
begin

	set @resultado = 1
	declare @cantidadProducto int = (select cantidad from Carrito where idCliente = @idCliente and idProducto = @idProducto)

	BEGIN TRY
		
		BEGIN TRANSACTION OPERACION

		update Producto set stock = stock + @cantidadProducto where idProducto = @idProducto
		delete top (1) from Carrito where idCliente = @idCliente and idProducto = @idProducto

		COMMIT TRANSACTION OPERACION

	END TRY
	BEGIN CATCH
		set @resultado = 0
		ROLLBACK TRANSACTION OPERACION
	END CATCH

end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarCategoria]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EliminarCategoria](
@idCategoria int,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	SET @resultado = 0
	IF NOT EXISTS (SELECT * FROM Producto p inner join Categoria c on c.idCategoria = p.idCategoria WHERE p.idCategoria = @idCategoria)
	BEGIN
		delete top (1) from Categoria where idCategoria = @idCategoria
		SET @resultado = 1
	END
	ELSE
		SET @mensaje = 'La categoria se encuentra relacionada a un producto'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarMarca]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_EliminarMarca](
@idMarca int,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	set @resultado = 0
	if not exists (select * from Producto p inner join Marca m on m.idMarca = p.idMarca where p.idMarca = @idMarca)
	begin
		delete top (1) from Marca where idMarca = @idMarca
		set @resultado = 1
	end
	else
	set @mensaje = 'La marca se encuentra relacionada a un producto'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarProducto]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_EliminarProducto](
@idProducto int,
@mensaje varchar(500) output,
@resultado int output
)
as
begin

	delete from Pedidos where idProducto = @idProducto

	set @resultado = 0
	if not exists (select * from Detalle_Venta dv inner join Producto p on p.idProducto = dv.idProducto where p.idProducto = @idProducto)
	begin
		delete top (1) from Producto where idProducto = @idProducto
		set @resultado = 1
	end
	else
	set @mensaje = 'El producto se encuentra relacionada a una venta'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ExisteCarrito]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ExisteCarrito](
@idCliente int,
@idProducto int,
@resultado bit output
)
as
begin
	if exists(select * from Carrito where idCliente = @idCliente and idProducto = @idProducto)
		set @resultado = 1
	else
		set @resultado = 0
end
GO
/****** Object:  StoredProcedure [dbo].[sp_MarcaParaProducto]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_MarcaParaProducto]
(
@idCategoria int
)
as
begin

	declare @relacionMarca varchar(100) 
	set @relacionMarca = (select relacionMarca from Categoria where idCategoria = @idCategoria)

end
begin

	select idMarca, descripcion from Marca where descripcion = @relacionMarca

end
GO
/****** Object:  StoredProcedure [dbo].[sp_OperacionCarrito]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_OperacionCarrito](
@idCliente int,
@idProducto int,
@sumar bit,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	set @resultado = 1
	set @mensaje = ''

	declare @existeCarrito bit = iif(exists(select * from Carrito where idCliente = @idCliente and idProducto = @idProducto),1,0)
	declare @stockProducto int = (select stock from Producto where idProducto = @idProducto)

	begin try 
		
		begin transaction Operacion

		if(@sumar = 1)
		begin
			
			if(@stockProducto > 0)
			begin

				if(@existeCarrito = 1)
					update Carrito set cantidad = cantidad + 1 where idCliente = @idCliente and idProducto = @idProducto
				else
					insert into Carrito(idCliente,idProducto,cantidad) values(@idCliente, @idProducto, 1)
					
				update Producto set stock = stock - 1 where idProducto = @idProducto
			end
			else
			begin
				set @resultado = 0
				set @mensaje = 'El producto no cuenta con stock disponible'
			end

		end
		else
		begin
			update Carrito set cantidad = cantidad - 1 where idCliente = @idCliente and idProducto = @idProducto
			update Producto set stock = stock + 1 where idProducto = @idProducto
		end

		commit transaction Operacion

	end try
	begin catch 
		set @resultado = 0
		set @mensaje = ERROR_MESSAGE()
		rollback transaction Operacion
	end catch

end
			
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistarProducto]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_RegistarProducto](
@nombre varchar(100),
@descripcion varchar(100),
@idCategoria varchar(100),
@precio decimal (10, 2),
@stock int,
@activo bit,
@mensaje varchar(500) output,
@resultado int output
)
as
begin

	declare @descripcionMarca varchar(50)

	set @descripcionMarca = (select relacionMarca from Categoria where idCategoria = @idCategoria)

	declare @idMarca int

	set @idMarca = (select idMarca from Marca where descripcion = @descripcionMarca)

end
begin

	SET @resultado = 0
	if not exists (select * from producto where nombre = @nombre)
	begin
		insert into Producto(nombre,descripcion,idMarca,idCategoria,precio,stock,activo)
		values (@nombre, @descripcion, @idMarca, @idCategoria, @precio, @stock, @activo)

		set @resultado = SCOPE_IDENTITY()
	end
	else
		set @mensaje = 'El producto ya existe'

end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarCategoria]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_RegistrarCategoria](
@descripcion varchar(100),
@activo bit,
@mensaje varchar(500) output,
@relacionMarca varchar(500),
@resultado int output
)
as
begin
	SET @resultado = 0
	IF NOT EXISTS (SELECT * FROM Categoria WHERE descripcion = @descripcion)
	begin
		INSERT INTO Categoria(descripcion,activo,relacionMarca)
		VALUES(@descripcion, @activo, @relacionMarca)
		SET @resultado = SCOPE_IDENTITY()
	end
	else
		set @mensaje = 'la categoria ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarCliente]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RegistrarCliente](
@nombre varchar(100),
@apellido varchar(100),
@correo varchar(100),
@clave varchar(100),
@mensaje varchar(500) output,
@resultado int output
)
as
begin
	set @resultado = 0
	if not exists (select * from Cliente where correo = @correo)
	begin
		insert into Cliente(nombre,apellido,correo,clave,reestrablecer) 
		values(@nombre,@apellido,@correo,@clave,0)

		set @resultado = SCOPE_IDENTITY()
	end
	else
		set @mensaje = 'El correo del usuario ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarMarca]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RegistrarMarca](
@descripcion varchar(100),
@activo bit,
@mensaje varchar(500) output,
@resultado bit output
)
as
begin
	set @resultado = 0
	if not exists (select * from Marca where descripcion = @descripcion)
	begin
		insert into Marca (descripcion,activo)
		values (@descripcion, @activo)
		set @resultado = SCOPE_IDENTITY()
	end
	else
	set @mensaje = 'La Marca ya existe'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarPedido]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_RegistrarPedido](
@cantidad int,
@nombre varchar(500),
@fechaPedido varchar(100)
)
as
begin
	
	declare @idProducto int

	set @idProducto = (select idProducto from Producto where nombre = @nombre)
	
	insert into Pedidos(idProducto, cantidad, nombreProducto, fechaPedido)
	values (@idProducto, @cantidad, @nombre, @fechaPedido)

end
begin

	update Producto
	set stock = stock + @cantidad
	where idProducto = (select top 1 idProducto From Pedidos order by idPedido desc)

end
GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarUsuario]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_RegistrarUsuario](
@nombre varchar(100),
@apellido varchar(100),
@correo varchar(100),
@clave varchar(100),
@activo bit,
@mensaje varchar(500) output,
@resultado int output
)
as
begin
	SET @resultado = 0
	IF NOT EXISTS (SELECT * FROM Usuario WHERE correo = @correo)
	begin
		insert into Usuario(nombre,apellido,correo,clave,activo)
		values (@nombre, @apellido,@correo,@clave,@activo)

		SET @resultado = scope_identity()
	end
	else
		set @mensaje = 'EL CORREO DEL USUARIO YA EXISTE'
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteCantidadProductosPorMes]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ReporteCantidadProductosPorMes](
@Mes int,
@Anio int
)
as
begin

set language spanish

select top 5 dv.idProducto, p.nombre, datename(MONTH, fechaVenta)[mes], sum(dv.cantidad) as CantidadProductos, ceiling(sum(dv.total)) as MontoTotal
from Producto p join Detalle_Venta dv on p.idProducto = dv.idProducto join Venta v on v.idVenta = dv.idVenta
where month(fechaVenta) = @Mes and year(fechaVenta) = @anio
group by p.nombre, datename(MONTH, fechaVenta), dv.idProducto
order by CantidadProductos desc

end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteDashboard]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_ReporteDashboard]
as
begin
select
(select count(*) from Cliente) [TotalCliente],
(select isnull(sum(cantidad),0) from Detalle_Venta) [TotalVenta],
(select count(*) from Producto) [TotalProducto]
end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteVentas]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ReporteVentas](
@fechaInicio varchar(10),
@fechaFin varchar(10),
@idTransaccion varchar(50)
)
as
begin

set dateformat dmy;

select convert(char(10), v.fechaVenta,103)[FechaVenta], CONCAT(c.nombre,' ',c.apellido)[Cliente], p.nombre[Producto], p.precio, dv.cantidad, dv.total, v.idTransaccion
from Detalle_Venta dv inner join Producto p on p.idProducto = dv.idProducto inner join Venta v on v.idVenta = dv.idVenta inner join Cliente c on c.idCliente = v.idCliente
where convert(date, v.fechaVenta) between @fechaInicio and @fechaFin
and v.idTransaccion = iif(@idTransaccion = '', v.idTransaccion, @idTransaccion)

end
GO
/****** Object:  StoredProcedure [dbo].[sp_ReporteVentasPorMes]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_ReporteVentasPorMes](
@fechaInicio varchar(10),
@fechaFin varchar(10)
)
as
begin

set language spanish

select year(fechaVenta)[anio], MONTH(fechaVenta)[mesValor], datename(MONTH, fechaVenta)[mes], count(*)[cantidad], ceiling(SUM(montoTotal))[TotalMontoPorMes] from Venta
where convert(date, fechaVenta) between convert(datetime, @fechaInicio,103) and convert(datetime, @fechaFin,103)
group by year(fechaVenta), MONTH(fechaVenta), datename(MONTH, fechaVenta)
order by year(fechaVenta), MONTH(fechaVenta) asc

end
GO
/****** Object:  StoredProcedure [dbo].[usp_RegistrarVenta]    Script Date: 1/12/2022 12:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_RegistrarVenta](
@idCliente int,
@totalProducto int,
@montoTotal decimal(18,2),
@contacto varchar(100),
@idPais varchar(6),
@telefono varchar(10),
@direccion varchar(100),
@idTransaccion varchar(50),
@detalleVenta [EDetalle_Venta] READONLY,
@resultado bit output,
@mensaje varchar(500) output
)
as
begin
	
	begin try
		
		declare @idVenta int = 0
		set @resultado = 1
		set @mensaje = ''

		begin transaction registro

		insert into Venta(idCliente,totalProducto,montoTotal,contacto,idPais,telefono,direccion,idTransaccion)
		values(@idCliente,@totalProducto,@montoTotal,@contacto,@idPais,@telefono,@direccion,@idTransaccion)

		set @idVenta = SCOPE_IDENTITY()

		insert into Detalle_Venta(idVenta,idProducto,cantidad,total)
		select @idVenta,idProducto,cantidad,total FROM @detalleVenta

		DELETE FROM Carrito WHERE idCliente = @idCliente

		commit transaction registro

	end try
	begin catch
		set @resultado = 0
		set @mensaje = ERROR_MESSAGE()
		rollback transaction registro
	end catch
end
GO
USE [master]
GO
ALTER DATABASE [DBCarritoFord] SET  READ_WRITE 
GO

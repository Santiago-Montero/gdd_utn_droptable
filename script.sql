USE GD2C2023; 

DECLARE @SchemaName NVARCHAR(128) = 'DROP_TABLE';
DECLARE @SQL NVARCHAR(MAX);

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = @SchemaName)
BEGIN
    SET @SQL = 'CREATE SCHEMA ' + QUOTENAME(@SchemaName);
    PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ha sido creado.';
    EXEC sp_executesql @SQL;
END
ELSE
BEGIN
    PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ya existía.';
END;


USE GD2C2023;

SELECT name
FROM sys.schemas;


USE [GD2C2023]
SET
ANSI_NULLS ON
SET
QUOTED_IDENTIFIER ON

CREATE TABLE [DROP_TABLE].[Disposicion](
	[id_disposicion] [int] IDENTITY(1,
1) primary key,
	[nombre] VARCHAR(100) NOT NULL,
) 
CREATE TABLE [DROP_TABLE].[Orientacion](
	[id_orientacion] [int] IDENTITY(1,
1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Tipo_inmueble](
	[id_tipo_inmueble] [int] IDENTITY(1,
1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Inmueble_estado](
	[id_inmueble_estado] [int] IDENTITY(1,
1) primary key,
	[nombre] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Inmueble](
    [id_inmueble] [int] IDENTITY(1,
1) PRIMARY KEY,
    [nombre] VARCHAR(100) NOT NULL,
    [descripcion] VARCHAR(100),
    [direccion] VARCHAR(100) NOT NULL,
    [expensas] int,
    [ambientes] int,
    [superficie] int,
    [antiguedad] int,
    [id_disposicion] [int],
    CONSTRAINT fk_disposicion FOREIGN KEY ([id_disposicion]) REFERENCES [DROP_TABLE].[Disposicion]([id_disposicion]),
     [id_orientacion] [int],
    CONSTRAINT fk_orientacion FOREIGN KEY ([id_orientacion]) REFERENCES [DROP_TABLE].[Orientacion]([id_orientacion]),
     [id_tipo_inmueble] [int],
    CONSTRAINT fk_tipo_inmueble FOREIGN KEY ([id_tipo_inmueble]) REFERENCES [DROP_TABLE].[Tipo_inmueble]([id_tipo_inmueble]),
     [id_inmueble_estado] [int],
    CONSTRAINT fk_inmueble_estado FOREIGN KEY ([id_inmueble_estado]) REFERENCES [DROP_TABLE].[Inmueble_estado]([id_inmueble_estado])
)
CREATE TABLE [DROP_TABLE].[Caracteristicas](
	[id_caracteristicas] [int] IDENTITY(1,
1) primary key,
	[caracteristica] VARCHAR(100) NOT NULL
) 
CREATE TABLE [DROP_TABLE].[Caracteristicas_por_inmueble](
	[id_caracteristicas_por_inmueble] [int] IDENTITY(1,
1) primary key,
[id_inmueble] [int],
    CONSTRAINT fk_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DROP_TABLE].[Inmueble]([id_inmueble]),
     [id_caracteristicas] [int],
    CONSTRAINT fk_caracteristicas FOREIGN KEY ([id_caracteristicas]) REFERENCES [DROP_TABLE].[Caracteristicas]([id_caracteristicas])
)


CREATE TABLE [DROP_TABLE].[Barrio](
	[id_barrio] [int] IDENTITY(1,1) PRIMARY KEY,
	[nombre] VARCHAR(100) NOT NULL
);

CREATE TABLE [DROP_TABLE].[Localidad](
	[id_localidad] [int] IDENTITY(1,1) PRIMARY KEY,
	[nombre] VARCHAR(100) NOT NULL,
	[id_barrio] [int],
	CONSTRAINT fk_localidad_barrio FOREIGN KEY ([id_barrio]) REFERENCES [DROP_TABLE].[Barrio]([id_barrio])
);

CREATE TABLE [DROP_TABLE].[Sucursal](
	[id_sucursal] [int] IDENTITY(1,1) PRIMARY KEY,
	[nombre] VARCHAR(100) NOT NULL,
	[codigo] VARCHAR(100) NOT NULL,
	[telefono] int,
	[direccion] VARCHAR(100) NOT NULL,
	[id_barrio] [int],
	CONSTRAINT fk_sucursal_barrio FOREIGN KEY ([id_barrio]) REFERENCES [DROP_TABLE].[Barrio]([id_barrio])
);


CREATE TABLE [DROP_TABLE].[Alquiler](
	[id_alquiler] [int] IDENTITY(1,1) NOT NULL,
	[fecha_inicio] [date] ,
	[fecha_fin] [date] ,
	[deposito] [int] ,
	[comision] [int] ,
	[gastos] [int] ,
	[codigo] [int] ,
	[id_estado_alquiler] [int] ,
	[id_anuncio] [int] ,
	CONSTRAINT fk_anuncio_alquiler FOREIGN KEY ([id_anuncio]) REFERENCES [DROP_TABLE].Anuncio([id_anuncio])
)

CREATE TABLE [DROP_TABLE].[Moneda](
	[id_moneda] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DROP_TABLE].[Tipo_Operacion](
	[id_tipo_operacion] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,


)

CREATE TABLE [DROP_TABLE].[Inquilino](
	[id_inquilino] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [int] ,
	CONSTRAINT fk_persona_inquilino FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
	[id_alquiler] [int] ,
	CONSTRAINT fk_alquiler_inquilino FOREIGN KEY ([id_alquiler]) REFERENCES [DROP_TABLE].[Alquiler]([id_alquiler])
)


CREATE TABLE [DROP_TABLE].[Persona](
	[id_persona] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[telefono] [int] ,
	[mail] [varchar](25) NOT NULL,
	[fecha_alta] [date] ,
	[fecha_nacimiento] [date] ,
)

	CREATE TABLE [DROP_TABLE].[Agente](
	[id_agente] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [int] ,
	CONSTRAINT fk_agente_persona FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
	[id_sucursal] [int] ,
	CONSTRAINT fk_agente_sucursal FOREIGN KEY ([id_sucursal]) REFERENCES [DROP_TABLE].[Sucursal]([id_sucursal])
	)

	CREATE TABLE [DROP_TABLE].[Anuncio](
	[id_anuncio] [int] IDENTITY(1,1) NOT NULL,
	[fecha_Aplicacion] [date] ,
	[tipo_operacion] [varchar](100) NOT NULL,
	[precio_anuncio] [int] ,
	[costoPublicacion] [int] ,
	[fecha_Finalizacion] [date] ,
	[id_agente] [int] ,
	CONSTRAINT fk_anuncio_agente FOREIGN KEY ([id_agente]) REFERENCES [DROP_TABLE].[Agente]([id_agente]),
	[id_inmueble] [int] ,
	CONSTRAINT fk_anuncio_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DROP_TABLE].Inmueble([id_inmueble]),
	[id_moneda] [int] ,
	CONSTRAINT fk_moneda_anuncio FOREIGN KEY ([id_moneda]) REFERENCES [DROP_TABLE].[Moneda]([id_moneda]),
	[id_tipo_operacion] [int] ,
	CONSTRAINT fk_tipo_operacion FOREIGN KEY ([id_tipo_operacion]) REFERENCES [DROP_TABLE].[Tipo_Operacion]([id_tipo_operacion]),
	[id_estado_anuncio] [int] ,
	CONSTRAINT fk_estado_anuncio FOREIGN KEY ([id_estado_anuncio]) REFERENCES [DROP_TABLE].[Estado_Anuncio]([id_estado_anuncio]),

)


	CREATE TABLE [DROP_TABLE].[Propietario](
	[id_propietario] [int] IDENTITY(1,1) NOT NULL,
	[id_persona] [int] NULL,
	CONSTRAINT fk_propietario_persona FOREIGN KEY ([id_persona]) REFERENCES [DROP_TABLE].[Persona]([id_persona]),
	[id_inmueble] [int] NULL,
	CONSTRAINT fk_propietario_inmueble FOREIGN KEY ([id_inmueble]) REFERENCES [DROP_TABLE].[Inmueble]([id_inmueble])
	)

	CREATE TABLE [DROP_TABLE].[Venta](
	[id_venta] [int] IDENTITY(1,1) NOT NULL,
	[fecha_venta] [date] ,
	[precio_venta] [int] ,
	[comision_inmobiliaria] [int] ,
	[codigo] [int] ,
	[id_moneda] [int],
	CONSTRAINT fk_moneda_venta FOREIGN KEY ([id_moneda]) REFERENCES [DROP_TABLE].Moneda([id_moneda])
	[id_anuncio] [int] ,
	CONSTRAINT fk_anuncio_alquiler FOREIGN KEY ([id_anuncio]) REFERENCES [DROP_TABLE].Anuncio([id_anuncio])
)
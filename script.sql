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
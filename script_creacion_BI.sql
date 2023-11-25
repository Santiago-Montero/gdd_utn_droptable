USE GD2C2023;
DECLARE @SchemaName NVARCHAR(128) = 'DropTable';
DECLARE @SQL NVARCHAR(MAX);

IF NOT EXISTS (
	SELECT
	1
	FROM
	sys.schemas
	WHERE
	name = @SchemaName)
	BEGIN
	SET
	@SQL = 'CREATE SCHEMA ' + QUOTENAME(@SchemaName);

	PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ha sido creado.';

EXEC sp_executesql @SQL;
	END
	ELSE
	BEGIN
		PRINT 'El esquema ' + QUOTENAME(@SchemaName) + ' ya existía.';
	END;
--Se crea el esquema a utilizar
USE GD2C2023;



USE [GD2C2023]
SET
ANSI_NULLS ON
SET
QUOTED_IDENTIFIER ON

CREATE TABLE [DropTable].[BI_Sucursal](
[id_sucursal] [int] IDENTITY(1,
1) PRIMARY KEY,
[nombre] VARCHAR(100) NOT NULL,
[codigo] VARCHAR(100) NOT NULL,
[telefono] int,
[direccion] VARCHAR(100) NOT NULL
)

CREATE TABLE [DropTable].[BI_Rango_etario](
[rango_id] [int] IDENTITY(1,
1) PRIMARY KEY,
[edad_minima] [int] NOT NULL,
[edad_maxima] [int] NOT NULL,
)

CREATE TABLE [DropTable].[BI_Rango_m2](
[rango_m2] [int] IDENTITY(1,
1) PRIMARY KEY,
[metros_minimos] [int] NOT NULL,
[metros_maximos] [int] NOT NULL,
)


CREATE TABLE [DropTable].[BI_Moneda](
[id_moneda] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DropTable].[BI_Tipo_Operacion](
[id_tipo_operacion] [int] IDENTITY(1,
1) PRIMARY KEY NOT NULL,
[nombre] [varchar](100) NOT NULL,
)

CREATE TABLE [DropTable].[BI_Tipo_inmueble](
[id_tipo_inmueble] [int] IDENTITY(1,
1) primary key,
[nombre] VARCHAR(100) NOT NULL
)

CREATE TABLE [DropTable].[BI_Tiempo](
[id_tiempo] [int] IDENTITY(1,
1) primary key,
[anio] date NOT NULL,
[cuatrimestre] date not null,
[mes] date not null

)
CREATE TABLE [DropTable].[BI_Ambiente](
[id_ambiente] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
[cantidad] [varchar](100) NOT NULL,
)

create table [DropTable].[BI_Ubicacion](
    [id_Ubicacion] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [provincia] varchar(255) not null,
    [localidad] varchar(255) not null,
    [barrio] varchar(255) not null
)



INSERT INTO DROP_TABLE.BI_Rango_etario([edad_minima], [edad_maxima]) values (0,25)
INSERT INTO DROP_TABLE.BI_Rango_etario([edad_minima], [edad_maxima]) values (26,35)
INSERT INTO DROP_TABLE.BI_Rango_etario([edad_minima], [edad_maxima]) values (36,50)
INSERT INTO DROP_TABLE.BI_Rango_etario([edad_minima], [edad_maxima]) values (51,null)


INSERT INTO DROP_TABLE.BI_Rango_m2([metros_minimos], [metros_maximos]) values (0,35)
INSERT INTO DROP_TABLE.BI_Rango_m2([metros_minimos], [metros_maximos]) values (36,55)
INSERT INTO DROP_TABLE.BI_Rango_m2([metros_minimos], [metros_maximos]) values (56,75)
INSERT INTO DROP_TABLE.BI_Rango_m2([metros_minimos], [metros_maximos]) values (76,100)
INSERT INTO DROP_TABLE.BI_Rango_m2([metros_minimos], [metros_maximos]) values (101,null)

INSERT
	INTO
	[DropTable].[BI_Moneda] (nombre)
select
	DISTINCT(nombre)
from
	[DropTable].[moneda] 
where
	nombre is not null


 Insert
	into [DropTable].[BI_Tipo_Operacion] (nombre)
	select distinct (nombre)
	from [DropTable].[Tipo_Operacion]  
	where nombre is not null


	Insert into [DropTable].[BI_Tipo_Inmueble] (nombre)
	select distinct (nombre)
	from [DropTable].[Tipo_Inmueble]
	where nombre is not null


INSERT INTO DropTable.BI_Ambiente (cantidad)
SELECT DISTINCT i.ambientes FROM DropTable.Inmueble i

INSERT INTO DropTable.BI_Sucursal(id_sucursal,nombre,codigo,telefono,direccion)
SELECT S.id_sucursal ,S.nombre, S.codigo, S.telefono, S.direccion
FROM DropTable.Sucursal S

INSERT INTO DropTable.BI_Ubicacion (provincia, localidad, barrio)
SELECT p.nombre, l.nombre, b.nombre  FROM DropTable.Barrio b
INNER JOIN DropTable.Localidad l ON l.id_localidad  = b.id_localidad  
INNER JOIN DropTable.Provincia p ON p.id_provincia  = l.id_provincia  